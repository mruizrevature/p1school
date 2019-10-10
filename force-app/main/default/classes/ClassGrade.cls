/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class ClassGrade {
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        Map<Id, Map<Id, Double>> studentGrades = new Map<Id, Map<Id, Double>>();
        Map<Id, Double> classGrades = new Map<Id, Double>();

        for (Student__c students : [SELECT Id, (SELECT Id, Class__c FROM ClassEnrollments__r) FROM Student__c]) {
            System.debug('Students: ' + students.Id);
            // Why can I not access Grade__c?
            List<AggregateResult> grade = [SELECT Class_Enrollment__r.Class__c, AVG(Grade__c) averageGrade
            FROM Grade__c WHERE Class_Enrollment__r.Student__c =: students.Id
            GROUP BY Class_Enrollment__r.Class__c];
            for (AggregateResult aggregateResult : grade) {
                classGrades.put((Id)aggregateResult.get('Id'), (Double)aggregateResult.get('averageGrade'));
            }
            studentGrades.put(students.Id, classGrades);
        }
        return studentGrades;
    }
}