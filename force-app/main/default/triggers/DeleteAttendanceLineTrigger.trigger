trigger DeleteAttendanceLineTrigger on ClassEnrollment__c (before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
            if (Schema.sObjectType.AttendanceLineItem__c.isDeletable()) {
                DeleteAttendanceLineHelper.deleteAttendanceLineItems(Trigger.old);
            } else {
                for (ClassEnrollment__c ce : Trigger.old) {
                    ce.addError(UserPermissionErrors.CANNOT_DELETE_ATTENDANCE_LINE_ITEMS);
                }
            }
            DeleteAttendanceLineHelper.deleteAttendanceLineItems(Trigger.old);
        }
    }
}
