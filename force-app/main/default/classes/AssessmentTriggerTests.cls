@isTest()
public with sharing class AssessmentTriggerTests {
    @TestSetup
    static void setup(){
        DepartmentCreator.createDepartment();
        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
        AssessmentCreator.createAssessment();
    }

    /**
        Assessment being created and an Assessment using the room
     */
    @isTest static void testDoubleBookingAssessmentWithExistingAssessment() {
        Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
        Assessment__c mockNewAssessment = new Assessment__c();
        mockNewAssessment.Name = 'MockAssessment';
        mockNewAssessment.Class__c = mockExistingClass.Id;
        mockNewAssessment.Date__c = Date.newInstance(2075,9,16);
        mockNewAssessment.Time__c = Time.newInstance(9,0,0,0);

        checkDoubleBooking(mockNewAssessment);
    }

    /**
        Assessment being created and an Assessment using the room
     */
    @isTest static void testDoubleBookingAssessmentWithExistingClass() {
        Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
        Assessment__c mockNewAssessment = new Assessment__c();
        mockNewAssessment.Name = 'MockAssessment';
        mockNewAssessment.Class__c = mockExistingClass.Id;
        mockNewAssessment.Date__c = Date.newInstance(2050,1,4);
        mockNewAssessment.Time__c = Time.newInstance(9,0,0,0);

        checkDoubleBooking(mockNewAssessment);
    }

    // @isTest static void testDoubleBookingClass() {
    //     Class__c newClass = new Class__c();

    //     Department__c existingDepartment = [SELECT Id FROM Department__c LIMIT 1];
    //     newClass.Department__c = existingDepartment.Id;
    //     newClass.daysPerWeek__c = 1;
    //     newClass.StartDate__c = Date.newInstance(2050,1,1);
    //     newClass.EndDate__c = Date.newInstance(2050,1, 10);
    //     newClass.ScheduledTime__c = Time.newInstance(9,0,0,0);

    //     Room__c existingRoom = [SELECT Id FROM Room__c LIMIT 1];
    //     newClass.Room__c = existingRoom.Id;
    //     Topic__c existingTopic = [SELECT Id FROM Topic__c LIMIT 1];
    //     newClass.Topic__c = existingTopic.Id;

    //     checkDoubleBooking(newClass);
    // }

    static void checkDoubleBooking(sObject classOrAssessment) {
        Test.startTest();
        Database.SaveResult insertResult = Database.insert(classOrAssessment, false);
        Test.stopTest();

        // Insertion should have been stopped by the user.
        System.assert(!insertResult.isSuccess());
        // If it's stopped correctly, we should also receive an error
        System.assert(insertResult.getErrors().size() > 0);
        // This error should say `This room will be occupied during that time. Please choose another.`
        System.assertEquals('This room will be occupied during that time. Please choose another.',
                             insertResult.getErrors()[0].getMessage());
    }
}