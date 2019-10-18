@isTest
public with sharing class DuplicateClassEnrollmentTests {
    @TestSetup
    static void makeData(){
        DepartmentCreator.createDepartment();
        EmployeeCreator.createEmployee();
        StudentCreator.createStudent();

        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
    }

    @isTest static void testPreventDuplicateClassEnrollment() {
        Student__c mockStudent = [SELECT Id FROM Student__c];
        Class__c mockClass = [SELECT Id FROM Class__c];
        ClassEnrollment__c mockClassEnrollment = new ClassEnrollment__c();
        mockClassEnrollment.Class__c = mockClass.Id;
        mockClassEnrollment.Student__c = mockStudent.Id;
        mockClassEnrollment.Credits__c = 50;

        insert(mockClassEnrollment);

        Test.startTest();
        Database.SaveResult insertResult = Database.insert(mockClassEnrollment, false);
        Test.stopTest();

        List<ClassEnrollment__c> testExistingClassEnrollments = [SELECT Id FROM ClassEnrollment__c WHERE Student__c =: mockStudent.Id AND Class__c =: mockClass.Id];

        System.assertEquals(1, testExistingClassEnrollments.size());
    }
}