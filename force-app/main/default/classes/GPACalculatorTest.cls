@isTest(SeeAllData=true)
public with sharing class GPACalculatorTest {
    //Test for taking in a student's Id and calculating their gpa
    @isTest static void testGPACalculatorGivenStudent(){
        Test.startTest();
        Student__c stu = [SELECT Id FROM Student__c WHERE Name = 'Joe McFlusters'];
        Double gpA = 0.0;
        try{
            gpA =  GPAController.getGPA(stu.Id);
        }catch(UnableToCalculateGPAException failToCalc){
            failToCalc.getMessage();
        }
        //Joe McFlusters has an avg. grade of 58.33, so he has a GPA of 0.0
        //The System.assertEquals() below tests that
        System.assertEquals(0.0,GPAController.getGPA(stu.id));
        Test.stopTest();
    }
}
