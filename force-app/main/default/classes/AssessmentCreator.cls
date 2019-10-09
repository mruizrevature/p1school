@isTest
public with sharing class AssessmentCreator {
    public static void createAssessment() {
        Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
        Assessment__c mockExistingAssessment = new Assessment__c();
        mockExistingAssessment.Name = 'MockExistingAssessment';
        mockExistingAssessment.Class__c = mockExistingClass.Id;
        mockExistingAssessment.Date__c = Date.newInstance(2075,9,16);
        mockExistingAssessment.Time__c = Time.newInstance(9,0,0,0);

        insert mockExistingAssessment;
        System.debug('mockExistingAssessment: ' + mockExistingAssessment);
    }
}