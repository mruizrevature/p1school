

@isTest
public with sharing class ClassEnrollmentTriggerTests {

    @TestSetup
    public static void makeData(){
        //insert random school data without class enrollments
        SchoolDataCreator.createDepartments();
        SchoolDataCreator.createRooms();
        SchoolDataCreator.createDegrees();
        SchoolDataCreator.createTopics();
        SchoolDataCreator.createClasses();
        SchoolDataCreator.createEmployees();
        SchoolDataCreator.createStudents();
        SchoolDataCreator.createMajors();
    }

    @isTest
    public static void duplicateEnrollmentTriggerTest()
    {
        Test.startTest();

        List<Class__c> classes = new  List<Class__c> ();
        classes = [SELECT Id FROM Class__c];
        List<Student__c> students = new  List<Student__c> ();
        students = [SELECT Id FROM Student__c];

        List<ClassEnrollment__c> toInsert = new List<ClassEnrollment__c>();
        //make first 5 students enroll in all first 5 classes
        for(integer n = 0; n<5; n++)
        {
            for(integer m=0; m<5; m++)
            {
                //add student n class m
                toInsert.add(
                    new ClassEnrollment__c(Student__c=students[n].Id,Class__c=classes[m].Id,Credits__c = 4, Status__c = 'Enrolled'));
            }
            
        }

        //insert list of new enrollments
        try{
            insert toInsert;

        }catch(DuplicateEnrollmentException e)
        {
            System.assert(false,'Inserting new class enrollments failed for list');
        }
        
        //attempt to insert again
        toInsert.clear();
        for(integer n = 0; n<2; n++)
        {
            for(integer m=0; m<2; m++)
            {
                //add student n class m
                toInsert.add(
                    new ClassEnrollment__c(Student__c=students[n].Id,Class__c=classes[m].Id,Credits__c = 4, Status__c = 'Enrolled'));
            }
        }
        
        Boolean failedInsert=false;
        try{
            insert toInsert;
        }catch(DuplicateEnrollmentException e)
        {
            failedInsert = true;
        }finally{
            System.assert(failedInsert,'Duplicate Enrollment Exception not thrown for list');
        }

        //insert an individual record with matching info
        failedInsert=false;
        try{
            insert new ClassEnrollment__c(Student__c=students[0].Id,Class__c=classes[0].Id,Credits__c = 4, Status__c = 'Enrolled');
        }catch(DuplicateEnrollmentException e)
        {
            failedInsert = true;
        }finally{
            System.assert(failedInsert,'Duplicate Enrollment Exception not thrown for individual');
        }

        //insert one more
        try{
            insert new ClassEnrollment__c(Student__c=students[0].Id,Class__c=classes[6].Id,Credits__c = 4, Status__c = 'Enrolled');

        }catch(DuplicateEnrollmentException e)
        {
            System.assert(false,'Inserting new class enrollment failed');
        }

        Test.stopTest();

    }

}
