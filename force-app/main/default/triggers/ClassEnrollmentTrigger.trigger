trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                for (ClassEnrollment__c ce: Trigger.new) {
                    ClassEnrollmentTriggerHelper.preventDuplicateEnrollment(ce);
                }
            } else {
                for (ClassEnrollment__c ce: Trigger.new) {
                    ce.addError(UserPermissionErrors.CANNOT_CREATE_CLASS_ENROLLMENTS);
                }
            }
        }
    }
}