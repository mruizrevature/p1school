trigger DuplicateEnrollmentTrigger on ClassEnrollment__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {

            // Check to see if user has create access
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                DuplicateEnrollmentTriggerHelper.preventDoubleEnrollment(Trigger.New);
            }
        }
    }
}