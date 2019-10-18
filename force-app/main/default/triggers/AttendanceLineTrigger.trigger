
trigger AttendanceLineTrigger on ClassEnrollment__c (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.AttendanceLineItem__c.isCreateable()) {
                AttendanceLineHelper.createAttendanceLine(Trigger.new);
            } else {
                for (ClassEnrollment__c a: Trigger.new) {
                    a.addError(UserPermissionErrors.CANNOT_CREATE_ATTENDANCE_LINE_ITEMS);
                }
            }
        }
    }
}