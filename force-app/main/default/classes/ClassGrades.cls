/**
 * Created by gamedevmadeeasy on 10/13/19.
 */

public with sharing class ClassGrades {
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        Map<Id, Map<Id, Double>> studentGrades = new Map<Id, Map<Id, Double>>();
        Map<Id, Double> classGrades = new Map<Id, Double>();

        List<Student__c> studentList = [SELECT Id, (SELECT Id, Class__c FROM ClassEnrollments__r) FROM Student__c];
        List<AggregateResult> grade =
        [SELECT Class_Enrollment__r.Class__c, AVG(Grade__c) averageGrade
        FROM Grade__c WHERE Class_Enrollment__r.Student__c =: StudentList
        GROUP BY Class_Enrollment__r.Class__c];
        for (Student__c students : studentList) {
            for (AggregateResult aggregateResult : grade) {
                classGrades.put((Id)aggregateResult.get('Id'), (Double)aggregateResult.get('averageGrade'));
            }
            studentGrades.put(students.Id, classGrades);
        }
        return studentGrades;
    }
}