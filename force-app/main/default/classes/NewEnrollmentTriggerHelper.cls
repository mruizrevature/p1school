public with sharing class NewEnrollmentTriggerHelper extends Exception {

    public static void checkDegree( classEnrollment__c ceBeingInserted){
         
        //  AggregateResult students = [SELECT Student__r.Name  From ClassEnrollment__c Group By Student__r.Name];

        Id ceDepartment = ceBeingInserted.Class__r.Department__r.Id;
        Id studentId = ceBeingInserted.Student__r.Id;

        // List <Major__c> Majors = [SELECT Id, Name, Degree__r.Department__c From Major__c Where Student__c =:studentId ];
        Student__c studentMajor =[SELECT Id , Name , (Select Name, Degree__r.Department__c From Majors__r) From Student__c Where Id =: studentID ];
        Student__c studentMinor =[SELECT Id , Name , (Select Name, Degree__r.Department__c From Minors__r) From Student__c Where Id =: studentID ];


        If(ceDepartment == studentMajor.get('Degree__r.Department__c')){
            ceBeingInserted.status__c = 'Enrolled';

        }

        else If(ceDepartment == studentMajor.get('Degree__r.Department__c')){
            ceBeingInserted.status__c = 'Enrolled';

        }

        else {
            throw new EnrollmentDepartmentException('This class is not available for your department');
        }





    }
}
