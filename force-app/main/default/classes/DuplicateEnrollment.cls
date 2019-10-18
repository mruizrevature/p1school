// Helper class
public with sharing class DuplicateEnrollment {

    public static void preventDuplicateEnrollment(List<ClassEnrollment__c> classenrollmentBeingInserted){
        List<ClassEnrollment__c> classenrollments = [ SELECT ClassEnrollment__c.Id, ClassEnrollment__c.Class__r.Id, ClassEnrollment__c.Student__r.Id FROM ClassEnrollment__c];
        List<ClassEnrollment__c> classenrollmentsToBeDenied = new List<ClassEnrollment__c>();
            
        for (ClassEnrollment__c ceNew : classenrollmentBeingInserted)
        {
            for (ClassEnrollment__c ce : classenrollments) {
                   // System.debug('Existing class: ' + ce.Class__r.Id);
                    //System.debug('Class being inserted: ' + classenrollmentBeingInserted.Class__c);
                if((ce.Class__r.Id == ceNew.Class__c)&&(ce.Student__r.Id == ceNew.Student__c)) {
                    classenrollmentsToBeDenied.add(ceNew);
                    break;
                }
            }
        }
        ClassEnrollmentUtilityClass.denyRecordsCreatingDuplicateEnrollment(classenrollmentsToBeDenied);   
    }
}
