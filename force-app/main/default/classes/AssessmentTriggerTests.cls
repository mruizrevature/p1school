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

        checkThatDoubleBookingWasPrevented(mockNewAssessment);
    }

    /**
        Assessment being created and an Assessment Class the room
     */
    // @isTest static void testDoubleBookingAssessmentWithExistingClass() {
    //     Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
    //     Assessment__c mockNewAssessment = new Assessment__c();
    //     mockNewAssessment.Name = 'MockAssessment';
    //     mockNewAssessment.Class__c = mockExistingClass.Id;
    //     mockNewAssessment.Date__c = Date.newInstance(2050,1,4);
    //     mockNewAssessment.Time__c = Time.newInstance(9,0,0,0);

    //     checkThatDoubleBookingWasPrevented(mockNewAssessment);
    // }

    static void checkThatDoubleBookingWasPrevented(sObject classOrAssessment) {
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