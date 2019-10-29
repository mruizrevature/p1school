public with sharing class MyTestClass {
    public MyTestClass() {
   // Student__c majors = [SELECT (SELECT Degree__r.Department__r.Name FROM Majors__r) FROM Student__c WHERE Name = 'Jake Pitsel'];
   // System.debug('\n \n \n The value is: ' + majors);
    // SELECT (SELECT Degree__r.Department__r.Name FROM Majors__c) FROM ClassEnrollment__c WHERE (SELECT ClassEnrollment__c from Student__c)
   // ClassEnrollment__c jake = [SELECT Student__r.Name from ClassEnrollment__c WHERE Name LIKE : majors];

    ClassEnrollment__c ceForStudent = [SELECT Student__r.Id FROM ClassEnrollment__c WHERE Name = 'CE-0002'];

    Major__c studentMajor = [SELECT Degree__r.Department__r.Name FROM Major__c WHERE Student__r.ID =: ceForStudent.ID];
    System.debug('\n \n \n The value is: ' + studentMajor);
    
    ClassEnrollment__c ce = [SELECT Class__r.Department__r.Name FROM ClassEnrollment__c WHERE Name = 'CE-0002'];
    System.debug('\n \n \n The value is: ' + ce);
//
    }
}
