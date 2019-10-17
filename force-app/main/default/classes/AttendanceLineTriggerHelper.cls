public with sharing class AttendanceLineTriggerHelper {
    public static AggregateResult[] countAbsences(List<AttendanceLineItem__c> enteringALI) {
        List<Id> studentList = new List<Id>();
        List<Student__c> suspendList = new List<Student__c>();
        for (AttendanceLineItem__c line : enteringALI) {
            studentList.add(line.Student__c);
        }
        System.debug('student list: ' + studentList);
        AggregateResult[] absenteeList = [
            SELECT COUNT(Id)absences, Student__c
            FROM AttendanceLineItem__c 
            WHERE (Student__c IN :studentList) 
            AND (Absent__c = true) AND (Excused__c = false)
            GROUP BY Student__c
        ];
        System.debug('absentees: ' + absenteeList.size());
        return absenteeList;
    }
    public static void suspendStudent(AggregateResult[] studentList) {
        List<Id > newList = new List<Id>();
        for (AggregateResult ar : studentList) {
            ar.get('Student__c');
            ar.get('absences');
        }
        List<Student__c> suspendList = [
            SELECT Id, Status__c
            FROM Student__c
            WHERE Id IN :studentList
        ];
        for (Student__c s : suspendList) {
            s.Status__c = suspend;
        }
        try {update suspendList;} catch (DmlException e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}