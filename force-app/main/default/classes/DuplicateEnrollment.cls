/**
 * Created by gamedevmadeeasy on 10/13/19.
 */

public with sharing class DuplicateEnrollment {

    public static List<ClassEnrollment__c> checkForDuplicateEnrollment (List<ClassEnrollment__c> enrolledStudents) {
        // Empty list of classEnrollments
        List<ClassEnrollment__c> classEnrollments = new List<ClassEnrollment__c>();
        // Create an empty list of DuplicateResults
        List<Datacloud.FindDuplicatesResult> results;

        try {
            // Search through all of the records to find any duplicates
            results = Datacloud.FindDuplicates.findDuplicates(enrolledStudents);
        }
        catch(DuplicateEnrollmentException duplicateEnrollment) {
            // if there are duplicates that exist, throw the exception.
            throw new DuplicateEnrollmentException(duplicateEnrollment.getMessage());
        }

        // Find the first duplicate result with a match result, then use the first match record.
        for (Integer i = 0; i < enrolledStudents.size(); i++) {
            // empty class enrollment item.
            ClassEnrollment__c classEnrollment = null;
            // foreach duplicate result from the results list
            for (Datacloud.DuplicateResult dr : results[i].getDuplicateResults()) {
                // if there are duplicates, then add them to the class enrollment item.
                if (dr.matchResults.size() > 0 && dr.getMatchResults()[0].matchRecords.size() > 0) {
                    classEnrollment = (ClassEnrollment__c) dr.getMatchResults()[0].getMatchRecords()[0].getRecord();
                    break;
                }
            }
            // add the duplicate items to the list.
            classEnrollments.add(classEnrollment);
        }
        return classEnrollments;
    }
}