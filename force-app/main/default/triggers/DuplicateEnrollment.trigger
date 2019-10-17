/**
 * Created by gamedevmadeeasy on 10/16/19.
 */

trigger DuplicateEnrollment on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
            DuplicateEnrollment.checkForDuplicateEnrollment(Trigger.new);
        } else {
            for (ClassEnrollment__c a : Trigger.new) {
                a.addError(new DuplicateEnrollmentException('This student is already enrolled in this class'));
            }
        }
    }
}