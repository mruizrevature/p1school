public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student) {
        List<ClassEnrollment__c> classEnrollmentList = [
            SELECT 
                Id
                ,Class__c
                ,Credits__c
                ,Student__c
                ,Student__r.CumulativeGPA__c
                ,Student__r.MajorGPA__c
                ,
                (
                    SELECT 
                        Grade__c 
                    FROM Grades__r
                ) 
                FROM ClassEnrollment__c
                WHERE Student__c =: student
        ];

        // Get a list of grades to calculate the GPA
        List<Double> gradeList = new List<Double>();

        for (ClassEnrollment__c classEnrollment : classEnrollmentList) {
            // Get the sublist of grades for each ClassEnrollment
            Grade__c[] grades = classEnrollment.Grades__r;

            Double gradeSum = 0.0;
            Integer count = 0;
            for (Grade__c grade : grades) {
                gradeSum += grade.Grade__c;
                ++count;
            }
            gradeList.add(gradeSum / count);
        }
        // Now gradeList[0] is for class 1's average, gradeList[1] is for class 2's average, etc. 
        
        List<Integer> creditsEarned = new List<Integer>();
        for (Integer i = 0; i < classEnrollmentList.size(); ++i) {
            if (gradeList[i] >= 90) {
                creditsEarned[i] = 4;
            } else if (gradeList[i] >= 80) {
                creditsEarned[i] = 3;
            } else if (gradeList[i] >= 70) {
                creditsEarned[i] = 2;
            } else if (gradeList[i] >= 60) {
                creditsEarned[i] = 1;
            } else {
                creditsEarned[i] = 0;
            }
        }
        /*
            average grade per class gradeList[89.34, 45.33, 67.34] <-- 3 classes
            credits per class       creditsEarned[3, 0, 1] <-- credits line up with classes
            how to check if 
        */
        // creditsEarned * classEnrollmentList.get('Credits__c') == GPA for class
        // Add all those up and divide by SUM(Credits__c) and we'll have the cumulative GPA
    }
}