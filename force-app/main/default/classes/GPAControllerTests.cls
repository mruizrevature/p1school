@isTest
public with sharing class GPAControllerTests  {

    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testCumulativeGPA() {
        Student__c student = [
            SELECT 
                Id 
            FROM Student__c
            LIMIT 1
        ];
        // SchoolDataCreator creates random grades, so System.assertEquals(expected, actual)
        // wouldn't be good to use here. 
        System.assert(GPAController.getCumulativeGPA(student.Id) != null);
        System.assert(GPAController.getMajorGPA(student.Id) != null);
    }
}


