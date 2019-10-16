public with sharing class ClassEnrollmentTriggerHelper {





    public static void stopDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){
        
        List<ClassEnrollment__c> checkIdStudentEnroll = [SELECT id,Class__c, Student__c
        FROM ClassEnrollment__c
        WHERE Status__c =: 'Enrolled'
        ];

        







    }
}
