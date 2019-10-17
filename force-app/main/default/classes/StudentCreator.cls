public with sharing class StudentCreator {
    public static void createStudent(){
        Student__c stu = new Student__c();
        stu.Age__c = 21;
        stu.CumulativeGPA__c = 3.45;
        stu.Email__c = 'mockStudent@project1.com';
        stu.MajorGPA__c = 3.1;
        stu.PhoneNumber__c = '0000000000';
        stu.Status__c = 'Enrolled';
        stu.Name = 'John Wayne';
        insert stu;
    }
}
