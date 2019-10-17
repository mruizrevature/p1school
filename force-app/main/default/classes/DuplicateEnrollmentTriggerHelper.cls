public with sharing class DuplicateEnrollmentTriggerHelper {
   
    public static void preventDoubleEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted) {
        checkForDoubleEnrollment(enrollmentsBeingInserted);
    }

    public static void checkForDoubleEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted) {
        try {
            for (Integer i = 0; i < enrollmentsBeingInserted.size(); ++i) {
                ClassEnrollment__c duplicateClassEnrollment = enrollmentsBeingInserted[i];
                for (Integer j = 0; j < enrollmentsBeingInserted.size(); ++j) {
                    if (i != j) {
                        // if class and student match, addError
                        if ((Id)duplicateClassEnrollment.get('Class__c') == (Id)enrollmentsBeingInserted[j].get('Class__c') &&
                            (Id)duplicateClassEnrollment.get('Student__c') == (Id)enrollmentsBeingInserted[j].get('Student__c')) {
                            enrollmentsBeingInserted[i].addError(DuplicateEnrollmentTriggerTests.DUPLICATE_ENROLLMENT);
                        }
                    }
                }
            }
            // for (ClassEnrollment__c classEnrollment : enrollmentsBeingInserted) {        
            //     // Grab the student and class from the current class enrollment
            //     Object currentStudent = classEnrollment.get('Student__c');
            //     Object currentClass = classEnrollment.get('Class__c');

            //     // Check for duplicate enrollments. 
            //     // If one exists, throw an exception and don't insert the record
            //     Integer count = 0;
            //     ClassEnrollment__c duplicateClassEnrollment = new ClassEnrollment__c();
            //     for (ClassEnrollment__c ce : enrollmentsBeingInserted) {

            //         if ((Id)currentStudent == (Id)ce.get('Student__c') &&
            //             (Id)currentClass == (Id)ce.get('Class__c')) {
            //             count++;
            //             if (count > 1) {
            //                 duplicateClassEnrollment.addError(DuplicateEnrollmentTriggerTests.DUPLICATE_ENROLLMENT);
            //                 //throw new DuplicateEnrollmentException(DuplicateEnrollmentTriggerTests.DUPLICATE_ENROLLMENT);
            //             }
            //         }
            //     }
            // }
        } catch (DuplicateEnrollmentException e) {
            //System.debug(dee.getMessage());
            System.debug(e.getMessage());
        }
    }
}
