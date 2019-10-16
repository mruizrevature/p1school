public with sharing class duplicateEnrollmentTriggerHelper 
{
    public static final String DUPLICATE_ENROLLMENT = 'That student is already enrolled in the class.';

    
    public static void preventDuplicateEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted)
    {
        List<ClassEnrollment__c> enrollments = [SELECT Student__c, Class__c FROM ClassEnrollment__c];
        List<ClassEnrollment__c> deniedEnrollments = new List<ClassEnrollment__c>();

        for(ClassEnrollment__C existingEnrollment: enrollments)
        {
            for(ClassEnrollment__C newEnrollment: enrollmentsBeingInserted)
            {
                if(existingEnrollment.Student__c == newEnrollment.Student__c && existingEnrollment.Class__c == newEnrollment.Class__c)
                {
                    deniedEnrollments.add(newEnrollment);
                }
            }
        }
        duplicateEnrollmentErrors(deniedEnrollments);
    }



    private static void duplicateEnrollmentErrors(List<ClassEnrollment__c> deniedEnrollments)
    {
        for(ClassEnrollment__c enrollment: deniedEnrollments)
        {
            enrollment.addError(DUPLICATE_ENROLLMENT);
            throw new DuplicateEnrollmentException(DUPLICATE_ENROLLMENT);
        }
        
    }
}