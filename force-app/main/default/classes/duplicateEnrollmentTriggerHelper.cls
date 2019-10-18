public with sharing class duplicateEnrollmentTriggerHelper 
{
    public static final String DUPLICATE_ENROLLMENT = 'That student is already enrolled in the class.';

    // checks a list of enrollments against the existing enrollments to make sure none have the same student in the same class    
    public static void preventDuplicateEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted)
    {
        // query the database for all class enrollments
        List<ClassEnrollment__c> enrollments = [SELECT Student__c, Class__c FROM ClassEnrollment__c];

        List<ClassEnrollment__c> duplicateEnrollments = new List<ClassEnrollment__c>();

        // loop through every enrollment that already exists and compare them to all the new enrollments
        // a duplicate enrollment is when both the new and existing enrollment have the class and student fields set to the same value
        for(ClassEnrollment__C existingEnrollment: enrollments)
        {
            for(ClassEnrollment__C newEnrollment: enrollmentsBeingInserted)
            {
                if(existingEnrollment.Student__c == newEnrollment.Student__c && existingEnrollment.Class__c == newEnrollment.Class__c)
                {
                    // duplicate enrollments are all added to a single list
                    duplicateEnrollments.add(newEnrollment);
                }
            }
        }
        // adds the error messages and exception for the list of duplicate enrollments
        duplicateEnrollmentErrors(duplicateEnrollments);
    }


    // adds error messages and exception for all duplicate enrollments
    private static void duplicateEnrollmentErrors(List<ClassEnrollment__c> duplicateEnrollments)
    {
        for(ClassEnrollment__c enrollment: duplicateEnrollments)
        {
            enrollment.addError(DUPLICATE_ENROLLMENT);
            throw new DuplicateEnrollmentException(DUPLICATE_ENROLLMENT);
        }
        
    }
}