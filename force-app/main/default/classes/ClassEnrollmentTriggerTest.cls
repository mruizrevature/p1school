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
        checkEnrollmentSuccess(ceMikeInMath, true, '', 'System failed to insert multiple records when no records were present', false);  
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
        checkEnrollmentSuccess(enrollments, true, '', 'System failed to insert multiple records when no records were present', false);
    }

    //ensures that no false negatives are brought up when a student already has a class enrollment
    @isTest static void studentHasExistingEnrollments(){
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classMath = SpecificDataCreator.getClass('MAT100');
        ClassEnrollment__C ceMikeInMath = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classMath);
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C ceMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        Test.startTest();
        insert ceMikeInMath;
        checkEnrollmentSuccess(ceMikeInBio, true, '', 'System failed to insert when student had an existing enrollment', true);
    }

    //ensures that no false negatives are brought up when a class already has a class enrollment
    @isTest static void classHasExistingEnrollments(){
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C ceMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        Student__c PeteJ = SpecificDataCreator.getStudent('Pete Jacobs');
        ClassEnrollment__C cePeteInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', PeteJ, classBio);
        Test.startTest();
        insert ceMikeInBio;
        checkEnrollmentSuccess(cePeteInBio, true, '', 'System failed to insert when class had an existing enrollment', true);
    }

    //ensures that a single dual enrollment is prevented
    @isTest static void preventDualSingleEnrollment(){
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C ceMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        ClassEnrollment__C dupeMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        Test.startTest();
        insert ceMikeInBio;
        checkEnrollmentSuccess(dupeMikeInBio, false, 'Class Enrollment already exists', 'System allowed a single duplicate insertion', true);
    }

    //ensures that multiple dual enrollments are prevented
    @isTest static void preventDualMultipleEnrollment(){
        List<ClassEnrollment__C> taintedEnrollments = new  List<ClassEnrollment__C>();
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classMath = SpecificDataCreator.getClass('MAT100');
        ClassEnrollment__C ceMikeInMath = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classMath);
        ClassEnrollment__C dupeMikeInMath = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classMath);
        taintedEnrollments.add(dupeMikeInMath);
        Student__c PeteJ = SpecificDataCreator.getStudent('Pete Jacobs');
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C cePeteInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', PeteJ, classBio);
        taintedEnrollments.add(cePeteInBio);
        Test.startTest();
        insert ceMikeInMath;
        checkEnrollmentSuccess(taintedEnrollments, false, 'Class Enrollment already exists', 'System allowed a duplicate insertion as part of a batch', true);
    }

    /**
        makes sure the process fails when the user doesn`t have access. interestingly theres no way to have a profile
        that ONLY has access to a class Enrollment, checking read/create on that checks read on both student AND class
        (must be a feature as a result of master detail relationships) thankfully salesforce provides a read only profile 
     */  
    @isTest static void checkAccess(){
        //we have to create a fake user for this test
        Profile readOnly = [SELECT Id FROM Profile WHERE Name='Read Only'];
        User testUser = new User(Alias = 'Access'
        ,Country='United States',
        Email='demo1@randomdemodomain.com',
        EmailEncodingKey='UTF-8',
        LastName='Denied',
        LanguageLocaleKey='en_US',
        LocaleSidKey='en_US',
        ProfileId = readOnly.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName='adeny@projectone.ninjs');
        Student__c mikeW = SpecificDataCreator.getStudent('Mike Williams');
        Class__c classBio = SpecificDataCreator.getClass('BIO100');
        ClassEnrollment__C ceMikeInBio = SpecificDataCreator.createEnrollment(4.0, 'Enrolled', mikeW, classBio);
        insert testUser;
        
        System.runAs(testUser){
            checkEnrollmentSuccess(ceMikeInBio, false, UserPermissionErrors.CANNOT_CREATE_CLASS_ENROLLMENTS, 'System allowed someone who didn`t have access to create an enrollment', false);
        }
    }

    /**
        Check the status of the enrollment
        a boolean is provided because sometimes we want it to succeed, others fail
        method is overloaded
     */
    static void checkEnrollmentSuccess(ClassEnrollment__c classEnroll, Boolean desiredOutcome, String soughtError, String message, Boolean startedTest){
        Boolean succeeded = true;
        String failMessage = '';
        Database.SaveResult insertResult = null;
        if(!startedTest){
            Test.startTest();
        }
        //we need a try/catch because otherwise the test will quit even when we ask for the result
        try{
            insertResult = Database.insert(classEnroll);
        }catch(Exception e){
            //have to let the tester know why it failed
            succeeded = false;
            failMessage = e.getMessage();   
        }
        Test.stopTest();
        if(desiredOutcome){
            System.assertEquals(true, insertResult.isSuccess(), message);
        }else{
            //when we want something to fail, we want it to fail for a specific reason
            System.assert(!succeeded, message);
            System.assert(failMessage.contains(soughtError), ('Denied for the wrong reason, reason wanted: ' + soughtError + ' reason recieved: ' + failMessage));
        }
        
    }

    static void checkEnrollmentSuccess(List<ClassEnrollment__c> classEnroll, Boolean desiredOutcome, String soughtError, String message, Boolean startedTest){
        Boolean succeeded = true;
        String failMessage = '';
        Database.SaveResult[] insertResults = null;
        if(!startedTest){
            Test.startTest();
        }
        try{
            insertResults = Database.insert(classEnroll, true);
        }catch(Exception e){
            succeeded = false;
            failMessage = e.getMessage();   
        }
        Test.stopTest();
        //check each result
        if(desiredOutcome){
            for(Database.SaveResult r : insertResults){
                System.assertEquals(true, r.isSuccess(), message);
            }
        }else{
            System.assert(!succeeded, message);
            System.assert(failMessage.contains(soughtError), ('Denied for the wrong reason, reason wanted: ' + soughtError + ' reason recieved: ' + failMessage));
        }
        
    }

}
