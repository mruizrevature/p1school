trigger DuplicateEnrollmentTrigger on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            DuplicateEnrollmentTriggerHelper.preventDoubleEnrollment(Trigger.New[0]);
        }
    }
}