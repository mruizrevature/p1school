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

        List<Assessment__c> mockAssessments = new List<Assessment__c>();

        mockAssessments.add(AssessmentCreator.createAssessment(Date.newInstance(2076,9,16), Time.newInstance(9,0,0,0)));
        mockAssessments.add(AssessmentCreator.createAssessment(Date.newInstance(2076,10,16), Time.newInstance(9,0,0,0)));
        mockAssessments.add(AssessmentCreator.createAssessment(Date.newInstance(2075,9,16), Time.newInstance(9,0,0,0)));
        mockAssessments.add(AssessmentCreator.createAssessment(Date.newInstance(2076,9,16), Time.newInstance(9,0,0,0)));
        mockAssessments.add(AssessmentCreator.createAssessment(Date.newInstance(2075,9,16), Time.newInstance(9,0,0,0)));

        List<Database.SaveResult> saveResults = Database.insert(mockAssessments, false);

        checkThatInsertionFailed(saveResults[2], RoomUtilityClass.ROOM_BOOKED);
        checkThatInsertionFailed(saveResults[4], RoomUtilityClass.ROOM_BOOKED);
        // checkThatDoubleBookingWasPrevented(newAssessments);
    }

    /**
        Assessment being created and an Assessment Class the room
     */
    // @isTest static void testDoubleBookingAssessmentWithExistingClass() {
    //     Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
    //     Room__c room = [SELECT Id FROM Room__c LIMIT 1];
    //     Assessment__c mockNewAssessment = new Assessment__c();
    //     mockNewAssessment.Name = 'MockAssessment';
    //     mockNewAssessment.Room__c = room.Id;
    //     mockNewAssessment.Class__c = mockExistingClass.Id;
    //     mockNewAssessment.Date__c = Date.newInstance(2050,1,4);
    //     mockNewAssessment.Time__c = Time.newInstance(9,0,0,0);

    //     checkThatDoubleBookingWasPrevented(mockNewAssessment);
    // }

    static void checkThatDoubleBookingWasPrevented(sObject classOrAssessment) {
        Test.startTest();
        Database.SaveResult insertResult = Database.insert(classOrAssessment, false);
        Test.stopTest();

        checkThatInsertionFailed(insertResult, RoomUtilityClass.ROOM_BOOKED);
    }

    static void checkThatInsertionFailed(Database.SaveResult dmlResult, String message) {
        // Insertion should have been stopped by the user.
        System.assert(!dmlResult.isSuccess());
        // If it's stopped correctly, we should also receive an error
        System.assert(dmlResult.getErrors().size() > 0);
        // This error should say `This room will be occupied during that time. Please choose another.`
        System.assertEquals(message, dmlResult.getErrors()[0].getMessage());
    }
}