@isTest
public with sharing class AttendanceLineTests {
    @TestSetup
    static void makeData(){
        DepartmentCreator.createDepartment();
        EmployeeCreator.createEmployee();
        StudentCreator.createStudent();

        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
    }

    @isTest static void testCreateAttendanceLine() {
        Class__c mockExistingClass = [SELECT Id, DurationInWeeks__c, DaysPerWeek__c FROM Class__c LIMIT 1];
        Student__c mockExistingStudent = [SELECT Id FROM Student__c LIMIT 1];
        ClassEnrollment__c mockNewClassEnrollment = new ClassEnrollment__c();
        mockNewClassEnrollment.Class__c = mockExistingClass.Id;
        mockNewClassEnrollment.Student__c = mockExistingStudent.Id;
        mockNewClassEnrollment.Credits__c = 50;

        Integer mockAttendanceLineNumber = mockExistingClass.DurationInWeeks__c.intValue() * mockExistingClass.DaysPerWeek__c.intValue();

        Test.startTest();
        Database.SaveResult insertResult = Database.insert(mockNewClassEnrollment, false);
        Test.stopTest();

        List<AttendanceLineItem__c> attendanceLineItems = [SELECT Id, Student__c, Class__c FROM AttendanceLineItem__c];

        System.assertEquals(mockAttendanceLineNumber, attendanceLineItems.size());
    }

    @isTest static void testStudentWithdrawFromClass() {
        Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
        Student__c mockExistingStudent = [SELECT Id FROM Student__c LIMIT 1];
        ClassEnrollment__c mockNewClassEnrollment = new ClassEnrollment__c();
        mockNewClassEnrollment.Class__c = mockExistingClass.Id;
        mockNewClassEnrollment.Student__c = mockExistingStudent.Id;
        mockNewClassEnrollment.Credits__c = 50;

        Test.startTest();
        Database.insert(mockNewClassEnrollment, false);
        Database.DeleteResult deleteResult = Database.delete(mockNewClassEnrollment, false);
        Test.stopTest();

        List<AttendanceLineItem__c> attendanceLineItems = [SELECT Id, Student__c, Class__c FROM AttendanceLineItem__c];

        System.assertEquals(0, attendanceLineItems.size());
    }
}