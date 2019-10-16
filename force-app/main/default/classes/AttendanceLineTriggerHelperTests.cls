@isTest
public with sharing class AttendanceLineTriggerHelperTests {
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testCountAbsences() {
        // check student status, assert
        // grab some attendance line items of student
        // set absent to true, excused to false (default)
        // update list of attendance line items
        // check student status, assert
    }
}