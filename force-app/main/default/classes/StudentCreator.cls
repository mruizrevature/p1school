@isTest
public with sharing class StudentCreator {
    public static void createStudent() {
        Student__c newStudent = new Student__c();
        List<Employee__c> testAdvisor = [SELECT Id FROM Employee__c LIMIT 1];
        newStudent.Advisor__c = testAdvisor[0].Id;
        newStudent.Name = 'Allan Sharpe';
        newStudent.Email__c = 'ASharpe@gmail.com';
        insert newStudent;
    }
}
