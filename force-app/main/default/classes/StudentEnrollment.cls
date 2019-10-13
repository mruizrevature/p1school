/**
 * Created by gamedevmadeeasy on 10/13/19.
 */

public with sharing class StudentEnrollment {
    public Class__c GetDaysPerWeekForClass(Class__c daysPerWeek) {
        // When a Student is enrolled in a class, there should be Attendance Line Items created for each week for the amount of time the class meets.
        //    - The amount of times a class meets is stored in the daysPerWeek field
        //    - Delete the Assessment Line Items if the Student withdraws from the class.
    }
}