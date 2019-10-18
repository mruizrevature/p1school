@isTest
public with sharing class StudentGradeTests {
   @TestSetup
   static void setup(){
        ClassCreator.createClass();
        AssessmentCreator.createAssessment();
    }

    @isTest static void testgetClassGrades(){
        
    }
}
