@isTest
public with sharing class StudentCreator {
    public static void createStudent() {
        Student__C newStudent = new Student__C();

        Employee__c advisor = [SELECT Id FROM Employee__c LIMIT 1];
        newStudent.Advisor__c = advisor.Id;
        newStudent.Name = 'Greg Maddox';
        newStudent.Age__c = 25;
        newStudent.Email__c = 'gmaddox@gmail.com';
        newStudent.PhoneNumber__c = '0000000000';

        insert newStudent;
    }
}