trigger DuplicateClassEnrollmentTrigger on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                DuplicateClassEnrollmentTriggerHelper.preventDuplicateClassEnrollment(Trigger.new[0]);
            } else {
                for (ClassEnrollment__c ce : Trigger.new) {
                    ce.addError(UserPermissionErrors.CANNOT_CREATE_CLASS_ENROLLMENT);
                }
            }
        }
    }
}