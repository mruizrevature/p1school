public with sharing class GradeCreator {
    
    public static void createGrades() {
        List<ClassEnrollment__c> mockEnrollment= [SELECT Id FROM ClassEnrollment__c LIMIT 1];
        List<Assessment__c> mockAssessment = [SELECT Id FROM Assessment__c LIMIT 1];
        System.debug('Mock assessment: ' + mockAssessment);
        List<Grade__c> gradeList = new List<Grade__c>();
        Grade__c testGrade = new Grade__c();
        testGrade.Class_Enrollment__c = mockEnrollment[0].Id;
        testGrade.Assessment__c = mockAssessment[0].Id;
        testGrade.Grade__c = 80.0;
        gradeList.add(testGrade);

        Grade__c testGradeTwo = new Grade__c();
        testGradeTwo = new Grade__c();
        testGradeTwo.Assessment__c = mockAssessment[0].Id;
        testGradeTwo.Class_Enrollment__c = mockEnrollment[0].Id;
        testGradeTwo.Grade__c = 90.0;
        gradeList.add(testGradeTwo);
        insert gradeList;
    }
}
