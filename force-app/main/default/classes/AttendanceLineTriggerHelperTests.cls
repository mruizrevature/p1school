@isTest
public with sharing class AttendanceLineTriggerHelperTests {
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testCheckDuplicateEnrollment() {
        //
    }
}