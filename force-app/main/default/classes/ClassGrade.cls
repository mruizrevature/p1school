/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class ClassGrade {
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        // To Do: SOQL queries required.
        //[SELECT Id, Name FROM Account WHERE grade=???]
        return new Map<Id, Map<Id, Double>>();
    }
}