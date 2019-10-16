public with sharing class AttendanceLineTriggerHelper {
    public static void countAbsences(List<AttendanceLineItem__c> enteringALI) {
        List<Id> studentList = new List<Id>();
        List<Student__c> suspendList = new List<Student__c>();
        for (AttendanceLineItem__c line : enteringALI) {
            studentList.add(line.Student__c);
        }
        AggregateResult[] absenteeList = [
            SELECT COUNT(Id)absences, Student__c
            FROM AttendanceLineItem__c 
            WHERE (Student__c IN :studentList) 
            AND (Absent__c = true) AND (Excused__c = false)
            GROUP BY Student__c
        ];
        suspendStudent(suspendList);
    }
    public static void suspendStudent(List<Student__c> studentList) {
        //
    }
}