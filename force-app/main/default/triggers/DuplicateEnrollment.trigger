/**
 * Created by gamedevmadeeasy on 10/16/19.
 */

trigger DuplicateEnrollment on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            DuplicateEnrollmentHelper.DuplicateCheckHelper(Trigger.new);
        }
    }
}