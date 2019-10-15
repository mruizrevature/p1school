public with sharing class StudentWithdrawAttendanceTriggerHelper {
    public static void deleteAttendanceItems (ClassEnrollment__c classEnrollmentBeingDeleted) {
        if (Schema.sObjectType.AttendanceLineItem__c.isAccessible()) {
            delete [SELECT Id FROM AttendanceLineItem__c WHERE ClassEnrollment__c =: classEnrollmentBeingDeleted.Id];
        } else {
            classEnrollmentBeingDeleted.addError(UserPermissionErrors.CANNOT_DELETE_ATTENDANCE_LINE_ITEMS);
        }
    }
}