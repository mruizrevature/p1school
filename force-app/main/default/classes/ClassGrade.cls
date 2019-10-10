/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class ClassGrade {
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        // Get a list of all students, make sure to grab the IDs that match the student in the ClassEnrollments
        List<Student__c> allStudents = [ SELECT Id,
        (SELECT Id, Class__c FROM ClassEnrollments__r)
        FROM Student__c];
        // Grab a list of all grades, match them to the ID of the Class Enrollments
        List<Grade__c> allGrades = [SELECT Id, Class_Enrollment__c FROM Grade__c];
        // Create an empty map, we will need this later.
        Map<Id, Map<Id, Double>> classGrades = new Map<Id, Map<Id, Double>>();
        // Loop through all the students and add them to the map.
        for (Student__c student : allStudents) {
            // Create another empty map for the class grade.
            Map<Id, Double> classGrade = new Map<Id, Double>();
            // loop through the Class enrollments by the students that are enrolled.
            for (ClassEnrollment__c classEnrollment : student.ClassEnrollments__r) {
                // create a double value, which we will need for doing the final calculations
                Double sumOfAllGrades = 0;
                // we also need a way to track the count of the grades within the enrollment.
                Integer count = 0;
                // loop through all the grades.
                for (Grade__c grade : allGrades) {
                    // if the class enrollment ID matches the grade's class enrollment
                    if(classEnrollment.Id == grade.Class_Enrollment__c) {
                        sumOfAllGrades += grade.Grade__c;
                        // increment the count
                        count ++;
                    }
                }

                // if the count is greater than zero
                if (count > 0) {
                    // Associate the classEnrollment's ID with the value from the sum of all the grades
                    // divided by the count in the map.
                    classGrade.put(classEnrollment.Id, sumOfAllGrades / count);
                }
            }
            // Associate the student Id with the value of the class grade in the map.
            classGrades.put(student.Id, classGrade);
        }
        // return the full results.
        return classGrades;
    }
}