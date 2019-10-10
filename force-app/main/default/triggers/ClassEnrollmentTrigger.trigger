trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                ClassEnrollmentTriggerHelper.addAttendanceLines(Trigger.new);
            } else {
                for (ClassEnrollment__c c: Trigger.new) {
                    c.addError(UserPermissionErrors.CANNOT_CREATE_CE);
                }
            }
        }
    }
}