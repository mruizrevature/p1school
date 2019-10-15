public with sharing class EmployeeCreator {
    public static void createEmployee() {
        Employee__c mockEmployee = new Employee__c();

        mockEmployee.Name = 'Jeff Jefferson';
        Department__c mockDepartment = [SELECT Id FROM Department__c LIMIT 1];
        mockEmployee.Department__c = mockDepartment.Id;

        insert mockEmployee;
    }
}