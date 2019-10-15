trigger StudentWithdrawAttendanceTrigger on ClassEnrollment__c (before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
            if (Schema.sObjectType.AttendanceLineItem__c.isDeletable()) {
                StudentWithdrawAttendanceTriggerHelper.deleteAttendanceItems(Trigger.old[0]);
            } else {
                for (ClassEnrollment__c ce : Trigger.old) {
                    ce.addError(UserPermissionErrors.CANNOT_DELETE_ATTENDANCE_LINE_ITEMS);
                }
            }
        }
    }
}