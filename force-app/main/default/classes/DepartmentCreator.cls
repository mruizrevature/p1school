@isTest
public with sharing class DepartmentCreator {
    public static void createDepartment() {
        Department__c newDepartment = new Department__c();
        newDepartment.Name = 'MockExistingDepartment';
        insert newDepartment;
    }
}