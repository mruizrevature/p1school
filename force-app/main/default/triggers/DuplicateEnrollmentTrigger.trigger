trigger DuplicateEnrollmentTrigger on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                DuplicateEnrollment.preventDuplicateEnrollment(Trigger.new);
            }else {
                for (ClassEnrollment__c a: Trigger.new) {
                    a.addError(UserPermissionErrors.CANNOT_CREATE_CLASSENROLLMENT);
                }
            }
        }
    }
}