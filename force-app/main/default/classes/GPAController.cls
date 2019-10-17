public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student) {
        // GPA is calculated by dividing the total amount of
        // grade points earned by the total amount of credit hours attempted
        calculate(student);
    }

    private static List<Grade__c> getStudentData(Id student) {
        List<Grade__c> grades = [
                SELECT Id, Grade__c, Class_Enrollment__c, Class_Enrollment__r.Credits__c
                FROM Grade__c
                WHERE Class_Enrollment__r.Student__r.Id = :student
        ];

        return grades;
    }

    private static Decimal getCreditCount(Id student) {
        Decimal credit = 0;
        for(Grade__c creditCount : getStudentData(student)) {
            credit = creditCount.Class_Enrollment__r.Credits__c;
        }

        return credit;
    }

    private static Decimal gradeToGPA(Id student) {
        Decimal gradePointValue = 0;
        Decimal gradeCount = 0;
        Decimal gradePoint = 0;
        for (Integer i = 0; i < getStudentData(student).size(); i++) {
            gradePoint = getStudentData(student)[i].Grade__c;

            if (gradePoint > 90 && gradePoint < 100) {
                gradePointValue += 4.0;
            }
            if (gradePoint > 80 && gradePoint < 89) {
                gradePointValue += 3.0;
            }
            if (gradePoint > 70 && gradePoint < 79) {
                gradePointValue += 2.0;
            }
            if (gradePoint > 65 && gradePoint < 69) {
                gradePointValue += 1.0;
            }
            if (gradePoint < 64) {
                gradePointValue += 0.0;
            }

            gradeCount += gradePointValue;
        }
        return gradeCount;
    }

    public static Decimal calculate(Id student) {
        Decimal GPA = 0;
        Decimal credits = getCreditCount(student);
        Decimal grades = gradeToGPA(student);

        // GPA Formula
        // (grades * credits) / credits = gpa
        credits = credits / 45;
        GPA = (grades * credits) / credits;
        return GPA;
    }
}