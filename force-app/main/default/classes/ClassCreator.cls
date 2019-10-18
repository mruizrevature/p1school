@isTest
public with sharing class ClassCreator {
    public static void createClass() {
        Class__c newClass = new Class__c();

        Department__c existingDepartment = [SELECT Id FROM Department__c LIMIT 1];
        newClass.Department__c = existingDepartment.Id;
        newClass.daysPerWeek__c = 1;
        newClass.StartDate__c = Date.newInstance(2050,1,1);
        newClass.EndDate__c = Date.newInstance(2050,1, 10);
        newClass.ScheduledTime__c = Time.newInstance(9,0,0,0);

        Room__c existingRoom = [SELECT Id FROM Room__c LIMIT 1];
        newClass.Room__c = existingRoom.Id;
        Topic__c existingTopic = [SELECT Id FROM Topic__c LIMIT 1];
        newClass.Topic__c = existingTopic.Id;

        insert newClass;
    }
}