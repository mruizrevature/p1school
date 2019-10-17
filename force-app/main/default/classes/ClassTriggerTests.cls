@isTest
public with sharing class ClassTriggerTests {
    @TestSetup
    static void setup(){
        DepartmentCreator.createDepartment();
        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
        AssessmentCreator.createAssessment();
    }

    /**
        Class being created and an Assessment using the room
     */
    @isTest static void testDoubleBookingClassWithExistingAssessment() {
        Class__c mockNewClass = new Class__c();

        Department__c existingDepartment = [SELECT Id FROM Department__c LIMIT 1];
        mockNewClass.Department__c = existingDepartment.Id;
        mockNewClass.daysPerWeek__c = 1;
        mockNewClass.StartDate__c = Date.newInstance(2075,9,15);
        mockNewClass.EndDate__c = Date.newInstance(2075,9, 17);
        mockNewClass.ScheduledTime__c = Time.newInstance(9,0,0,0);

        Room__c existingRoom = [SELECT Id FROM Room__c LIMIT 1];
        mockNewClass.Room__c = existingRoom.Id;
        Topic__c existingTopic = [SELECT Id FROM Topic__c LIMIT 1];
        mockNewClass.Topic__c = existingTopic.Id;

        checkThatDoubleBookingIsPrevented(mockNewClass);
    }

    /**
        Assessment being created and an Assessment using the room
     */
    @isTest static void testDoubleBookingClassWithExistingClass() {
        Class__c mockNewClass = new Class__c();

        Department__c existingDepartment = [SELECT Id FROM Department__c LIMIT 1];
        mockNewClass.Department__c = existingDepartment.Id;
        mockNewClass.daysPerWeek__c = 1;
        mockNewClass.StartDate__c = Date.newInstance(2050,1,7);
        mockNewClass.EndDate__c = Date.newInstance(2050,1, 11);
        mockNewClass.ScheduledTime__c = Time.newInstance(9,0,0,0);

        Room__c existingRoom = [SELECT Id FROM Room__c LIMIT 1];
        mockNewClass.Room__c = existingRoom.Id;
        Topic__c existingTopic = [SELECT Id FROM Topic__c LIMIT 1];
        mockNewClass.Topic__c = existingTopic.Id;

        checkThatDoubleBookingIsPrevented(mockNewClass);
    }

    static void checkThatDoubleBookingIsPrevented(sObject classOrAssessment) {
        //Test.startTest();
        Database.SaveResult insertResult = Database.insert(classOrAssessment, false);
        //Test.stopTest();

        // Insertion should have been stopped by the user.
        System.assert(!insertResult.isSuccess());
        // If it's stopped correctly, we should also receive an error
        System.assert(insertResult.getErrors().size() > 0);
        // This error should say `This room will be occupied during that time. Please choose another.`
        System.assertEquals('This room will be occupied during that time. Please choose another.',
                             insertResult.getErrors()[0].getMessage());
    }
}