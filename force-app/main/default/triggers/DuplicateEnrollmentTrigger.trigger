trigger DuplicateEnrollmentTrigger on ClassEnrollment__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            if (Schema.SObjectType.ClassEnrollment__c.isCreateable()) {
                DuplicateEnrollmentTriggerHelper.preventDoubleEnrollment(Trigger.New);
            } else {
                if (Trigger.New.size() > 0) {
                    Trigger.New[0].addError(UserPermissionErrors.CANNOT_CREATE_CLASS_ENROLLMENTS);
                }
            }
        }
    }
}