
@isTest()
public with sharing class ClassEnrollmentTriggerTests {
   
    @TestSetup
    static void setup(){
        SchoolDataCreator.createData();
        
    }

        @isTest static void teststopDoubleEnroll(){

        List<ClassEnrollment__c> newCE = [SELECT Student__c, Class__c, Status__c, Credits__c
        FROM ClassEnrollment__c
        LIMIT 1
        ];

        List<Database.SaveResult> insertResult = Database.insert(newCE, false);
        System.assert(!insertResult.isSuccess());

    }
}
