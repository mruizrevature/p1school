public with sharing class ClassEnrollmentTriggerHelper {
    public static void addAttendanceLines(List<ClassEnrollment__c> enteringCE) {
        List<Id> enteringClasses = new List<Id>();
        List<AttendanceLineItem__c> enteringALI = new List<AttendanceLineItem__c>();
        for (ClassEnrollment__c ce : enteringCE) {
            enteringClasses.add(ce.Class__c);
        }
        List<Class__c> classList = [
            SELECT Id, DaysPerWeek__c 
            FROM Class__c 
            WHERE Id IN :enteringClasses
        ];
        for (ClassEnrollment__c ce : enteringCE) {
            Class__c current = new Class__c();
            for (Class__c c : classList) {
                if (c.Id == ce.Class__c) current = c;
            }
            for (Integer i = 0; i < current.DaysPerWeek__c; i++) {
                AttendanceLineItem__c a = new AttendanceLineItem__c(
                    Class__c = current.id,
                    ClassEnrollment__c = ce.Id,
                    Student__c = ce.Student__c
                );
                enteringALI.add(a);
            }
        }
        try { insert enteringALI; } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    public static void removeAttendanceLines(List<ClassEnrollment__c> exitingCE) {
        List<AttendanceLineItem__c> exitingALI = [
            SELECT Id, ClassEnrollment__c
            FROM AttendanceLineItem__c 
            WHERE ClassEnrollment__c IN :exitingCE
        ];
        try {
            delete exitingALI;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    public static void removeGrades(List<ClassEnrollment__c> exitingCE) {
        List<Grade__c> exitingGrade = [
            SELECT Id, Class_Enrollment__c
            FROM Grade__c
            WHERE Class_Enrollment__c IN :exitingCE
        ];
        try {
            delete exitingGrade;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
}
