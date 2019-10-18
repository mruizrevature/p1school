@isTest
public with sharing class GPAControllerTests {

    @TestSetup
    static void makeData(){
        //inserts random Grade Data
        SchoolDataCreator.createData();
    }

    @isTest
    public static void calculateGPATester() {

        Test.startTest();

        Student__c aStudent = [SELECT Id FROM Student__c LIMIT 1 OFFSET 2];
        List<Grade__c> theirGrades = [SELECT Id,Grade__c FROM Grade__c WHERE Class_Enrollment__r.Student__c=:astudent.id];

        Id degree = [SELECT Degree__c FROM Major__c WHERE Student__c =:astudent.Id LIMIT 1].Degree__c;
        List<Grade__c> theirMGrades = 
            [SELECT Id,Grade__c FROM Grade__c WHERE Class_Enrollment__r.Student__c=:astudent.id AND Class_Enrollment__r.Class__r.Topic__r.Degree__c=:degree];

        //calculate gpa manually
        Double gradeAvg = 0;
        Double total = 0;
        for(Grade__c g:theirGrades )
        {
            total += Double.valueOf(g.Grade__c);
        }
        if(theirGrades.size()!=0)
            gradeAvg = total/theirGrades.size();

        Double mgradeAvg = 0;
        total = 0;
        for(Grade__c g:theirMGrades)
        {
            total += Double.valueOf(g.Grade__c);
        }
        if(theirMGrades.size()!=0)
            mgradeAvg = total/theirMGrades.size();

        
        Double expGPA = GPAController.getGPAFromAvg(gradeAvg);
        Double expmGPA = GPAController.getGPAFromAvg(mgradeAvg);


        //testing the method
        GPAController.calculateGPA(aStudent.Id);

        Student__c student = [SELECT Id,CumulativeGPA__c,MajorGPA__c FROM Student__c WHERE Id =:aStudent.Id LIMIT 1];

        //check
        System.assertEquals(student.CumulativeGPA__c,expGPA,'GPA does not match');
        System.assertEquals(student.MajorGPA__c,expmGPA,'GPA does not match');

        Test.stopTest();

    }
}
