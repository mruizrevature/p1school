trigger AttendanceLineTrigger on AttendanceLineItem__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        // AttendanceLineTriggerHelper.countAbsences(Trigger.old);             
    }
}