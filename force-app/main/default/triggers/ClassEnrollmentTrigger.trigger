trigger ClassEnrollmentTrigger on ClassEnrollment__c (after insert, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                ClassEnrollmentTriggerHelper.addAttendanceLines(Trigger.new);
            } else {
                for (ClassEnrollment__c c: Trigger.new) {
                    c.addError(UserPermissionErrors.CANNOT_CREATE_CE);
                }
            }
        } else if (Trigger.isDelete) {
            // error checking
            ClassEnrollmentTriggerHelper.removeAttendanceLines(Trigger.new);
        }
    }
}