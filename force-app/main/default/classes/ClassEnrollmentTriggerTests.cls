
@isTest()
public with sharing class ClassEnrollmentTriggerTests {
   
    @TestSetup
    static void setup(){
        SchoolDataCreator.createData();

        ClassEnrollment__c mockCE  = new ClassEnrollment__c();

        Student__c studentList = [SELECT Id FROM Student__c LIMIT 1];
        Class__c classList = [SELECT Id FROM Class__c LIMIT 1];
        mockCE.Student__C = studentList.Id;
        mockCE.Class__c = classList.Id;

        for (Integer i = 0; i <5; i++){

            mockCE.Student__c = studentList.id;
            mockCE.Class__c = classList.Id;
            mockCE.Status__c = 'Enrolled';
            mockCE.Credits__c = 4;
        }
        insert mockCE;
    }


        @isTest static void teststopDoubleEnroll(){
        List<ClassEnrollment__c> newCE  = [SELECT student__c, Class__c
                                        FROM ClassEnrollment__c
                                        LIMIT 1
                                    ];
        


    }



}
