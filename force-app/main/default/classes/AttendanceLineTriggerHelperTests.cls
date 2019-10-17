@isTest
public with sharing class AttendanceLineTriggerHelperTests {
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testCountAbsences() {
        // check student status, assert
        List<Student__c> studentList = [
            SELECT Id
            FROM Student__c
            WHERE Status__c = 'Suspended'
        ];
        System.assert(studentList.size() == 0, 'Not yet suspended');

        // grab some attendance line items of student
        studentList = [
            SELECT Id, Status__c, (
                SELECT Id, Absent__c, Student__c
                FROM AttendanceLineItems__r
                LIMIT 3
            )
            FROM Student__c
            LIMIT 3
        ];

        // set absent to true, excused to false (default)
        List<AttendanceLineItem__c> attendanceList = new List<AttendanceLineItem__c>();
        for (Student__c s : studentList) {
            for (AttendanceLineItem__c a : s.AttendanceLineItems__r) {
                a.Absent__c = true;
                attendanceList.add(a);
            }
        }

        // update list of attendance line items
        try {update attendanceList;} catch (DmlException e) {
            System.debug('Error: ' + e.getMessage());
        }    

        // check student status, assert
        studentList = [
            SELECT Id
            FROM Student__c
            WHERE Status__c = 'Suspended'
        ];
        System.assert(studentList.size() == 3, 'Now suspended');
    }
}