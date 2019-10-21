trigger AttendanceLineTrigger on ClassEnrollment__c (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.AttendanceLineItem__c.isCreateable()) {
                //AttendanceLineTriggerHelper.createAttendanceLine(Trigger.new);
                ClassEnrollment__c newClassEnrollment = Trigger.new[0];
                AttendanceLineTriggerHelper.createAttendanceLine(newClassEnrollment);
            } else {
                for (ClassEnrollment__c ce: Trigger.new) {
                    ce.addError(UserPermissionErrors.CANNOT_CREATE_ATTENDANCE_LINE_ITEMS);
                }
            }
        }
    }
}