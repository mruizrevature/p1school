public with sharing class AttendanceLineHelper {

    public static void createAttendanceLine(List<ClassEnrollment__c> classEnrollmentBeingInserted) {
        ClassEnrollment__c classDetails = new ClassEnrollment__c();
        List<AttendanceLineItem__c> attendanceLineItems = new List<AttendanceLineItem__c>();

        if (Schema.sObjectType.AttendanceLineItem__c.isAccessible()) {
            //classDetails = [SELECT DaysPerWeek__c, DurationInWeeks__c FROM Class__c WHERE Id =: classEnrollmentBeingInserted.Class__c];
            classDetails = [SELECT ClassEnrollment__c.Id, ClassEnrollment__c.Class__r.DaysPerWeek__c, ClassEnrollment__c.Class__r.DurationInWeeks__c, ClassEnrollment__c.Class__r.Id, ClassEnrollment__c.Student__r.Id FROM ClassEnrollment__c WHERE Id =: classEnrollmentBeingInserted];
        }

        if (classDetails != null) {
            for (Integer i=0; i<classDetails.Class__r.DurationInWeeks__c; i++){ 
                for (Integer j=0; j<classDetails.Class__r.DaysPerWeek__c; j++) {
                    AttendanceLineItem__c at = new AttendanceLineItem__c();
                    at.ClassEnrollment__c = classDetails.Id;
                    at.Class__c = classDetails.Class__c;
                    at.Student__c = classDetails.Student__c;
                    attendanceLineItems.add(at);
                }
            }
            insert attendanceLineItems;
        }else {
            classDetails.addError(UserPermissionErrors.CANNOT_CREATE_ATTENDANCE_LINE_ITEMS);
        }
    }
}
