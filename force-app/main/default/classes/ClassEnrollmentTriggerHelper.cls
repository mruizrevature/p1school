public with sharing class ClassEnrollmentTriggerHelper {
    public static void addAttendanceLines(ClassEnrollment__c enteringCE) {
        for (Integer i = 0; i < enteringCE.Class__r.DaysPerWeek__c; i++) {
            AttendanceLineItem__c a = new AttendanceLineItem__c(
                Class__c = enteringCE.Class__c,
                ClassEnrollment__c = enteringCE.Id,
                Student__c = enteringCE.Student__c
            ); insert a;
        }
    }
    public static void addAttendanceLines(List<ClassEnrollment__c> enteringCE) {
        for (ClassEnrollment__c c : enteringCE) {
            addAttendanceLines(c);
        }
    }
    public static void removeAttendanceLines(ClassEnrollment__c exitingCE) {
        //
    }
}
