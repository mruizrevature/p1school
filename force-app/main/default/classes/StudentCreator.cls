public with sharing class StudentCreator {
    public static void createStudent(){
        Student__c newstudent = new Student__c();
        newstudent.Age__c = 21;
        newstudent.CumulativeGPA__c = 3.45;
        newstudent.Email__c = 'mockStudent@project1.com';
        newstudent.MajorGPA__c = 3.1;
        newstudent.PhoneNumber__c = '0000000000';
        newstudent.Status__c = 'Enrolled';
        newstudent.Name = 'John Wayne';
        newstudent.Advisor__c = [SELECT Name FROM Employee__c LIMIT 1];
        insert newstudent;
    }
}
