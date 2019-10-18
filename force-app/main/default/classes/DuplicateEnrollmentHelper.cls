/**
 * Created by gamedevmadeeasy on 10/17/19.
 */

public class DuplicateEnrollmentHelper {
    public static void DuplicateCheckHelper(List<ClassEnrollment__c> classes){
        try {
            Set <String> classEnrollmentSet = new Set<String>();
            Set <String> studentSet = new Set<String>();

            for (ClassEnrollment__c classEnrollment : classes) {
                classEnrollmentSet.add(classEnrollment.Id);
                studentSet.add(classEnrollment.Student__r.Id);
            }

            List <ClassEnrollment__c> classEnrollments = new List<ClassEnrollment__c>();

            classEnrollments = [SELECT Id FROM ClassEnrollment__c WHERE Id IN :classEnrollmentSet OR Student__c IN :studentSet];

            for (ClassEnrollment__c ce : classes) {
                If (classEnrollments.size() > 0) {
                    // Displaying the error
                    ce.addError( 'Duplicate Student Found in this Class Enrollment.' );
                }
            }
        }
        catch (DuplicateEnrollmentException duplicateEnrollmentException) {
            duplicateEnrollmentException.getMessage();
        }
    }
}