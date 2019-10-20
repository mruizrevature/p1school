@isTest()
public with sharing class ClassEnrollmentTriggerTest {
    @TestSetup
    static void setup(){
        SchoolDataCreator.createData();
    }

    //make sure it doesnt invalidate a valid insertion when there are no enrollments
    @isTest static void noEnrollmentsSingleeInsert(){       
        List<ClassEnrollment__C> enrollments = new  List<ClassEnrollment__C>();
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classMath = SpecificDataCreator.getClass('MAT100');
        ClassEnrollment__C ceMikeInMath = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classMath);
        checkEnrollmentSuccess(ceMikeInMath, true, 'System failed to insert multiple records when no records were present');  
    }
    
    //make sure it doesnt invalidate valid insertions when there are no enrollments
    @isTest static void noEnrollmentsMultipleInsert(){   
        List<ClassEnrollment__C> enrollments = new  List<ClassEnrollment__C>();
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classMath = SpecificDataCreator.getClass('MAT100');
        ClassEnrollment__C ceMikeInMath = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classMath);
        enrollments.add(ceMikeInMath);
        Student__c PeteJ = SpecificDataCreator.getStudent('Pete Jacobs');
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C cePeteInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', PeteJ, classBio);
        enrollments.add(cePeteInBio);
        checkEnrollmentSuccess(enrollments, true, 'System failed to insert multiple records when no records were present');
    }

    //ensures that no false negatives are brought up when a student already has a class enrollment
    @isTest static void studentHasExistingEnrollments(){
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classMath = SpecificDataCreator.getClass('MAT100');
        ClassEnrollment__C ceMikeInMath = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classMath);
        insert ceMikeInMath;
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C ceMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        checkEnrollmentSuccess(ceMikeInBio, true, 'System failed to insert when student had an existing enrollment');
    }

    //ensures that no false negatives are brought up when a class already has a class enrollment
    @isTest static void classHasExistingEnrollments(){
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C ceMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        insert ceMikeInBio;
        Student__c PeteJ = SpecificDataCreator.getStudent('Pete Jacobs');
        ClassEnrollment__C cePeteInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', PeteJ, classBio);
        checkEnrollmentSuccess(cePeteInBio, true, 'System failed to insert when class had an existing enrollment');
    }
    /**
        makes sure the process fails when the user doesn`t have access. interestingly theres no way to have a profile
        that ONLY has access to a class Enrollment, checking read/create on that checks read on both student AND class
        (must be a feature as a result of master detail relationships) thankfully salesforce provides a read only profile 
     */  
    @isTest static void checkAccess(){

    }

    /**
        Check the status of the enrollment
        a boolean is provided because sometimes we want it to succeed, others fail
        method is overloaded
     */
    static void checkEnrollmentSuccess(ClassEnrollment__c classEnroll, Boolean desiredOutcome, String message){
        Test.startTest();
        Database.SaveResult insertResult = Database.insert(classEnroll);
        Test.stopTest();
        System.assertEquals(desiredOutcome, insertResult.isSuccess(), message);
    }

    static void checkEnrollmentSuccess(List<ClassEnrollment__c> classEnroll, Boolean desiredOutcome, String message){
        Test.startTest();
        Database.SaveResult[] insertResults = Database.insert(classEnroll, false);
        Test.stopTest();
        //check each result
        for(Database.SaveResult r : insertResults){
             System.assertEquals(desiredOutcome, r.isSuccess(), message);
        }
    }

}
