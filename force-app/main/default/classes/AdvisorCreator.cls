@isTest
public with sharing class AdvisorCreator {
    
    public static void createAdvisor() {
        
        Employee__c newAdvisor = new Employee__c();
        List<Department__c> mockDepartment = [SELECT Id, Name FROM Department__c LIMIT 1];
        newAdvisor.Name = 'Janet Williams';
        newAdvisor.Department__c = mockDepartment[0].Id;
        insert newAdvisor;
        
    }

}
