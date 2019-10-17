
@isTest()
public with sharing class ClassEnrollmentTriggerTests {
   
    @TestSetup
    static void setup(){
        SchoolDataCreator.createData();

        ClassEnrollment__c mockCE  = new ClassEnrollment__c();

        Student__c studentList = [SELECT Id FROM Student__c];
        Class__c classList = [SELECT Id FROM Class__c];
        mockCE.Student__C = studentList.Id;
        mockCE.Class__c = classList.Id;
        mockCE.Status__c = 'Enrolled';
        mockCE.Credits__c = 4;


        for (Integer i = 0; i <5; i++){

            mockCE.add(mockCE.Student__c,mockCE.Class__c, mockCE.Status__c, mockCE.Credits__c);
            
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
