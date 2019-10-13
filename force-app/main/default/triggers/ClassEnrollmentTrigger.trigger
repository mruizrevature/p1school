trigger ClassEnrollmentTrigger on ClassEnrollment__c (after insert, before delete) {
    if (Trigger.isAfter && Trigger.isInsert) {
        if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
            ClassEnrollmentTriggerHelper.addAttendanceLines(Trigger.new);
        } else {
            for (ClassEnrollment__c c: Trigger.new) {
                c.addError(UserPermissionErrors.CANNOT_CREATE_CE);
            }
        }
    }
    if (Trigger.isBefore && Trigger.isDelete) {
        System.debug(Trigger.old);
        ClassEnrollmentTriggerHelper.removeAttendanceLines(Trigger.old);
    }
}