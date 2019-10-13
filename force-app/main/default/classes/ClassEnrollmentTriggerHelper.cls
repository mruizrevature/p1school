public with sharing class ClassEnrollmentTriggerHelper {
    public static void addAttendanceLines(ClassEnrollment__c enteringCE) {
        Class__c c = [
            SELECT Id, DaysPerWeek__c 
            FROM Class__c 
            WHERE Id = :enteringCE.Class__c
        ][0];
        // System.debug('days per week: ' + c.DaysPerWeek__c);
        for (Integer i = 0; i < c.DaysPerWeek__c; i++) {
            AttendanceLineItem__c a = new AttendanceLineItem__c(
                Class__c = enteringCE.Class__c,
                ClassEnrollment__c = enteringCE.Id,
                Student__c = enteringCE.Student__c
            ); 
            try {
                insert a;
            } catch(DmlException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
            // System.debug('line item: ' + a);
        }
    }
    public static void addAttendanceLines(List<ClassEnrollment__c> enteringCE) {
        for (ClassEnrollment__c c : enteringCE) {
            addAttendanceLines(c);
        }
    }

    public static void removeAttendanceLines(ClassEnrollment__c exitingCE) {
        AttendanceLineItem__c[] exitingALI = [
            SELECT Name, ClassEnrollment__c
            FROM AttendanceLineItem__c 
            WHERE ClassEnrollment__c = :exitingCE.Id
        ];
        try {
            delete exitingALI;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    public static void removeAttendanceLines(List<ClassEnrollment__c> exitingCE) {
        for (ClassEnrollment__c c : exitingCE) {
            removeAttendanceLines(c);
        }
    }
}
