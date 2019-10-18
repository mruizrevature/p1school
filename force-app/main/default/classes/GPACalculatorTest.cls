@isTest public with sharing class GPACalculatorTest {
    @TestSetup
    static void setup(){
        SchoolDataCreator.CreateData();
        EnrollmentCreator.createClassEnrollment();
    }

    //Test for taking in a student's Id and calculating their gpa
    @isTest static void testGPACalculatorGivenStudent(){
        Test.startTest();
        
        Test.stopTest();
    }
}
