public with sharing class AttendanceLineTriggerHelper {
    public static void createAttendanceLine(ClassEnrollment__c classEnrollmentBeingInserted) {
        Class__c classAttendance = new Class__c();
        List<AttendanceLineItem__c> attendanceLineItemToInsert = new List<AttendanceLineItem__c>();

        if (Schema.sObjectType.AttendanceLineItem__c.isAccessible()) {
            classAttendance = [SELECT DaysPerWeek__c, DurationInWeeks__c FROM Class__c WHERE Id =: classEnrollmentBeingInserted.Class__c];
        }

        if (classAttendance != null) {
            for (Integer i=0; i<classAttendance.DurationInWeeks__c; i++) {
                for (Integer j=0; j<classAttendance.DaysPerWeek__c; j++) {
                    attendanceLineItemToInsert.add(new AttendanceLineItem__c(ClassEnrollment__c = classEnrollmentBeingInserted.Id, Class__c = classEnrollmentBeingInserted.Class__c, Student__c = classEnrollmentBeingInserted.Student__c));
                }
            }

            insert attendanceLineItemToInsert;
        } else {
            classAttendance.addError(UserPermissionErrors.CANNOT_CREATE_ATTENDANCE_LINE_ITEMS);
        }
    }
}