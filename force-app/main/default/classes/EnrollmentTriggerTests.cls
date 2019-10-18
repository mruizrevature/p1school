@isTest
public with sharing class EnrollmentTriggerTests {
    @TestSetup
    static void setup() {
        SchoolDataCreator.createData();
        EnrollmentCreator.createClassEnrollment();
    }
    /**A Double enrollment is being created for a particular student  */
    @isTest static void testDoubleBookingClassWithExistingClass(){
        Test.startTest();
        ClassEnrollment__c existingEnrollment = [SELECT Id, Student__c, Class__c FROM ClassEnrollment__c LIMIT 1];
        ClassEnrollment__c mockenrollment = new ClassEnrollment__c();
        mockenrollment.Class__c = existingEnrollment.Class__c;
        mockenrollment.Student__c = existingEnrollment.Student__c;
        mockenrollment.Credits__c = 4;

        try{
            insert mockenrollment;
        }
        catch(Exception e){
            System.assertEquals(1,[SELECT Id FROM ClassEnrollment__c].size());
            System.assertNotEquals(1,[SELECT Id FROM ClassEnrollment__c].size());
            System.assertNotEquals(3, [SELECT Id FROM ClassEnrollment__c].size());
            System.assert(e.getMessage().contains('This class enrollment for said student has already been created. Please choose another.'));
        }
        Test.stopTest();
       
    }
    
    @isTest static void testDoubleBookingWithMultipleClasses(){
        Test.startTest();
        ClassEnrollment__c existingEnrollment = [SELECT Id, Student__c, Class__c FROM ClassEnrollment__c LIMIT 1];
        List<Student__c> students = [SELECT Id FROM Student__c LIMIT 4];
        List<Class__c> classes = [SELECT Id FROM Class__c LIMIT 4];
        ClassEnrollment__c exEn1 = new ClassEnrollment__c();
        ClassEnrollment__c exEn2 = new ClassEnrollment__c();
        ClassEnrollment__c exEn3 = new ClassEnrollment__c();
        ClassEnrollment__c exEn4 = new ClassEnrollment__c();
        List<ClassEnrollment__c> testEnrollments = new List<ClassEnrollment__c>();

        exEn1.Student__c = existingEnrollment.Student__c;
        exEn1.Class__c = existingEnrollment.Class__c;
        exEn1.Credits__c = 4;
        testEnrollments.add(exEn1);

        exEn2.Student__c = students[0].Id;
        exEn2.Class__c = classes[0].Id;
        exEn2.Credits__c = 5;
        testEnrollments.add(exEn2);

        exEn3.Student__c = students[1].Id;
        exEn3.Class__c = classes[1].Id;
        exEn3.Credits__c = 2;
        testEnrollments.add(exEn3);

        exEn4.Student__c = students[2].Id;
        exEn4.Class__c = classes[2].Id;
        exEn4.Credits__c = 3;
        testEnrollments.add(exEn4);

        List<Database.SaveResult> insertResults = Database.insert(testEnrollments, false);
        System.assertEquals(5, [SELECT Id FROM ClassEnrollment__c].size());
        System.assertNotEquals(5, [SELECT Id FROM ClassEnrollment__c].size());
        System.assertNotEquals(3,[SELECT Id FROM ClassEnrollment__c].size());
        Test.stopTest();
    }
  
}
