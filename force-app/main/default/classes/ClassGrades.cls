/**
 * Created by gamedevmadeeasy on 10/13/19.
 */

public with sharing class ClassGrades {
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        return new Map<Id, Map<Id, Double>>();
    }
}