@isTest
public with sharing class EnrollmentTriggerTests {
    @TestSetup
    static void setup() {
        DepartmentCreator.createDepartment();
        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
        AssessmentCreator.createAssessment();
        StudentCreator.createStudent();
    }
    /**A Double enrollment is being created for a particular student  */
    @isTest static void testDoubleBookingClassWithExistingClass(){
        ClassEnrollment__c mockenrollment = new ClassEnrollment__c();
        

        checkThatDoubleEnrollmentIsPrevented(mockenrollment);
    }

    static void checkThatDoubleEnrollmentIsPrevented(ClassEnrollment__c enrollment){
        Test.startTest();
        Database.SaveResult insertResult = Database.insert(enrollment, false);
        Test.stopTest();

        // Insertion should have been stopped by the user.
        System.assert(!insertResult.isSuccess());
        // If it's stopped correctly, we should also receive an error
        System.assert(insertResult.getErrors().size() > 0);
        System.assertEquals('You do cannot create duplicate Class Enrollments. Please contact System Administrator for more details.',
                             insertResult.getErrors()[0].getMessage());
    }
}
