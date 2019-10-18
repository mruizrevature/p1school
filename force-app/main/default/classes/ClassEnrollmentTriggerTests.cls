
@isTest(seeAllData=true)
public with sharing class ClassEnrollmentTriggerTests {
   

        @isTest static void teststopDoubleEnroll(){

        ClassEnrollment__c newCE = [SELECT Student__c, Class__c, Status__c, Credits__c
        FROM ClassEnrollment__c
        LIMIT 1
        ];

        Database.SaveResult insertResult = Database.insert(newCE, false);
        System.assert(!insertResult.isSuccess());
    }
}
