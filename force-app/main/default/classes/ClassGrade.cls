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
        List<Student__c> students = [ SELECT Id, (SELECT Id, Class__c FROM ClassEnrollments__r)  FROM Student__c];
        List<Grade__c> grades = [SELECT Id, Class_Enrollment__c FROM Grade__c]; // also SELECT Grade__c
        Map<Id, Map<Id, Double>> classGrades = new Map<Id, Map<Id, Double>>();

        List<Student__c> students2 = [SELECT Id, (SELECT Id, Class__c FROM ClassEnrollments__r) FROM Student__c WHERE Grade__c IN Student__c];
        return new Map<Id, Map<Id, Double>>();
    }
}