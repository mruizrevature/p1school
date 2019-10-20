@isTest
public with sharing class ClassEnrollmentTest {
    @TestSetup
    static void makeData(){
        DepartmentCreator.createDepartment();
        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
        AssessmentCreator.createAssessment();
        AdvisorCreator.createAdvisor();
        StudentCreator.createStudent();
        ClassEnrollmentCreator.createClassEnrollment();
        GradeCreator.createGrades();
    }

    @isTest public static void checkDuplicateEnrollment(){
        ClassEnrollment__c newEnrollment = new ClassEnrollment__c();
        Class__c existingClass = [SELECT Id FROM Class__c LIMIT 1];
        Student__c existingStudent = [SELECT Id FROM Student__c LIMIT 1];
        newEnrollment.Class__c = existingClass.Id;
        newEnrollment.Student__c = existingStudent.Id;
        newEnrollment.Credits__c = 3.0;
        Database.SaveResult saveResult= Database.insert(newEnrollment, false);
        System.Assert(saveResult.getErrors()[0].getMessage().contains('Student is already enrolled in the class'));
    }
    @isTest public static void checkAttendanceLineMethods() {
        Student__c newStudent = new Student__c();
        List<Employee__c> testAdvisor = [SELECT Id FROM Employee__c LIMIT 1];
        newStudent.Advisor__c = testAdvisor[0].Id;
        newStudent.Name = 'Jerry Rivera';
        newStudent.Email__c = 'JRivera@gmail.com';
        insert newStudent;

        ClassEnrollment__c newEnrollment = new ClassEnrollment__c();
        Class__c existingClass = [SELECT Id FROM Class__c LIMIT 1];
        newEnrollment.Class__c = existingClass.Id;
        newEnrollment.Student__c = newStudent.Id;
        newEnrollment.Credits__c = 3.0;
        insert newEnrollment;
        
        List<AttendanceLineItem__c> attendanceLineList = [SELECT Id FROM AttendanceLineItem__c WHERE ClassEnrollment__c=:newEnrollment.Id];
        System.assertEquals(1, attendanceLineList.size(), 'The attendance line list is not populating correctly.');

        delete newEnrollment;
        List<AttendanceLineItem__c> lineListAfterDelete = [SELECT Id FROM AttendanceLineItem__c WHERE ClassEnrollment__c=:newEnrollment.Id];
        System.assertEquals(0, lineListAfterDelete.size(), 'The attendance line list is not deleting correctly.');
    }
}
