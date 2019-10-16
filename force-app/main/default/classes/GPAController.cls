public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student) {
        // GPA is calculated by dividing the total amount of
        // grade points earned by the total amount of credit hours attempted
        gpaCalculation(student);
    }

    public static Double gpaCalculation(Id student) {
        try {
            Double GPA = 0;
            List<Grade__c> grades = [
                    SELECT Id, Grade__c, Class_Enrollment__c, Class_Enrollment__r.Credits__c
                    FROM Grade__c
                    WHERE Class_Enrollment__r.Student__r.Id = :student
            ];
            for (Grade__c grade : grades) {
                GPA = (grade.Grade__c / grade.Class_Enrollment__r.Credits__c) / grades.size() + 1;
            }
            return GPA;
        }
        catch (UnableToCalculateGPAException unableToCalculateGPAException) {
            throw new UnableToCalculateGPAException('Unable to calculate the GPA, possible reasons: Using Decimal instead of Double.');
        }
    }
}