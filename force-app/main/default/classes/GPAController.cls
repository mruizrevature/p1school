public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student) {
        try {
            Double cumulativeGPA = getCumulativeGPA(student);
            Double majorGPA = getMajorGPA(student);
            //throw new UnableToCalculateGPAException('Unable to calculate GPA.');
        } catch (UnableToCalculateGPAException e) {
            System.debug(e.getMessage());
        }
    }

    public static Double getCumulativeGPA(Id student) {

        List<ClassEnrollment__c> classEnrollmentList = getClassEnrollments(student);
        List<Double> averageGradeList = getAverageGradeForEachClass(classEnrollmentList); 
        List<Double> creditsEarned = creditsEarnedPerClass(classEnrollmentList, averageGradeList);
        List<Double> totalCreditsEarnedPerClass = totalCreditsEarnedPerClass(classEnrollmentList, creditsEarned);

        return GPA(classEnrollmentList, totalCreditsEarnedPerClass);
    }

    /**
        Given the Student Id, find the Student's major(s). 

        If the Department matches the department of the major,
        calculate the grade as part of the major GPA
    */
    public static Double getMajorGPA(Id student) {

        List<ClassEnrollment__c> classEnrollmentList = getClassEnrollments(student);
        List<Major__c> studentDepartmentList = getStudentDepartments(student);
        List<Double> averageGradeList = averageMajorGrade(classEnrollmentList, studentDepartmentList);    
        List<Double> creditsEarned = creditsEarnedPerClass(classEnrollmentList, averageGradeList);       
        List<Double> totalCreditsEarnedPerClass = totalCreditsEarnedPerClass(classEnrollmentList, creditsEarned);

        return GPA(classEnrollmentList, totalCreditsEarnedPerClass);
        
    }

    /**
        Query to get credits, departments, and grades associated with a 
        ClassEnrollment__c object
     */
    private static List<ClassEnrollment__c> getClassEnrollments(Id student) {
        return [
            SELECT 
                Credits__c
                ,Class__r.Department__c
                ,
                (
                    SELECT 
                        Grade__c 
                    FROM Grades__r
                ) 
            FROM ClassEnrollment__c
            WHERE Student__c =: student
        ];
    }

    /**
        Query to get a departments and students associated with a 
        Major__c object
     */
    private static List<Major__c> getStudentDepartments(Id student) {
        return [
            SELECT 
                Degree__r.Department__c
                ,Student__c 
            FROM Major__c
            WHERE Student__c =: student
        ];
    }   

    /**
        For each class a student is enrolled in, sum up the grades and 
        divide by the number of grades. 

        This will determine the credits earned for each class. 
     */
    private static List<Double> getAverageGradeForEachClass(List<ClassEnrollment__c> classEnrollments) {

        List<Double> gradeList = new List<Double>();

        for (ClassEnrollment__c classEnrollment : classEnrollments) {
            // Get the sublist of grades for each ClassEnrollment
            Grade__c[] grades = classEnrollment.Grades__r;

            Double gradeSum = 0.0;
            Double count = 0.0;
            for (Grade__c grade : grades) {
                gradeSum += grade.Grade__c;
                ++count;
            }
            gradeList.add(gradeSum / count);
        }
        // Now gradeList[0] is for class 1's average, gradeList[1] is for class 2's average, etc. 
        return gradeList;
    }

    /**
        Using the average grade for each class, assign credits earned. 
        90 and above is a 4.0 
        85 and above is a 3.5
        80 and above is a 3.0 
        etc. 
     */
    private static List<Double> creditsEarnedPerClass(List<ClassEnrollment__c> classEnrollments,
        List<Double> gradesPerClass) {

        List<Double> creditsEarned = new List<Double>();
        for (Integer i = 0; i < classEnrollments.size(); ++i) {
            if (gradesPerClass[i] >= 90) {
                creditsEarned.add(4);
            } else if (gradesPerClass[i] >= 85) {
                creditsEarned.add(3.5);
            } else if (gradesPerClass[i] >= 80) {
                creditsEarned.add(3);
            } else if (gradesPerClass[i] >= 75) {
                creditsEarned.add(2.5);
            } else if (gradesPerClass[i] >= 70) {
                creditsEarned.add(2);
            } else if (gradesPerClass[i] >= 65) {
                creditsEarned.add(1.5);
            } else if (gradesPerClass[i] >= 60) {
                creditsEarned.add(1);
            } else {
                creditsEarned.add(0);
            }
        }
        return creditsEarned;
    }

    /**
        creditsEarned * classEnrollments.get('Credits__c') == GPA for each class
     */
    private static List<Double> totalCreditsEarnedPerClass(List<ClassEnrollment__c> classEnrollments,
        List<Double> creditsEarned) {
        
        List<Double> totalCreditsEarned = new List<Double>();

         for (Integer i = 0; i < classEnrollments.size(); ++i) {
            totalCreditsEarned.add(creditsEarned[i] * (Double)classEnrollments[i].get('Credits__c'));
        }
        return totalCreditsEarned;
    }

    /**
        GPA is the sum of all the earned credits for each class 
        divided by the sum of possible credits. 

        e.g.
        creditsEarned = [3, 2] (two classes; B average and C average)
              credits = [4, 4] (two classes worth 4 credits each)

        3*4 + 2*4 = 20
        4+4 = 8

        20/8 = 2.5
     */
    private static Double GPA(List<ClassEnrollment__c> classEnrollments, 
        List<Double> totalCreditsEarnedPerClass) {

        // SUM(totalCreditsEarnedPerClass) and divide by SUM(Credits__c) and we'll have the cumulative GPA
        Double sumEarnedCredits = 0;
        Double sumCredits = 0;
        for (Integer i = 0; i < classEnrollments.size(); ++i) {
            sumEarnedCredits += totalCreditsEarnedPerClass[i];
            sumCredits += (Double)classEnrollments[i].get('Credits__c');
        }
        return sumEarnedCredits / sumCredits;
    }

    /**
        The average grade per class for any classes that are part of the 
        student's major
     */
    private static List<Double> averageMajorGrade(List<ClassEnrollment__c> classEnrollments, 
        List<Major__c> majors) {

        List<Double> averageGradeList = new List<Double>();

        for (ClassEnrollment__c classEnrollment : classEnrollments) {
            for (Major__c studentDepartment : majors) {
                if ((Id)studentDepartment.Degree__r.Department__c == ((Id)classEnrollment.Class__r.Department__c)) {
                    
                    Grade__c[] grades = classEnrollment.Grades__r;

                    Double gradeSum = 0.0;
                    Double count = 0.0;
                    for (Grade__c grade : grades) {
                        gradeSum += grade.Grade__c;
                        ++count;
                    }
                    averageGradeList.add(gradeSum / count);
                }
            }
        }
        return averageGradeList;
    }
}





