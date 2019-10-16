public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){

        getGpa(student);
        //CumulativeGPA__c

    }
    //Get credit of class enrollment
    public static Double getGPA (Id Student){
   
    //Returns grade of a specific student
    AggregateResult[] gpaGrade =[SELECT AVG(Grade__c) averageName, Class_Enrollment__c, Class_Enrollment__r.Student__c, Class_Enrollment__r.Credits__c testName
    FROM Grade__c
    GROUP BY Class_Enrollment__c, Class_Enrollment__r.Student__c, Class_Enrollment__r.Credits__c
    HAVING Class_Enrollment__r.Student__c =: student
    ];
        Double gradePoint= 0.0;
        Double gpaForStudent = 0.0;

        for (AggregateResult results : gpaGrade) {
           //Object gradePoint = results.get('averageName');
         //If Statement to convert grade to gradepoint 
        if((Double) results.get('averageName') < 60){
            gradePoint = 0;
        }else if((Double) results.get('averageName') > 60 && (Double) results.get('averageName') < 65) {
            gradePoint =.7;
        }else if((Double) results.get('averageName') == 65){
            gradePoint = 1;
        }else if((Double) results.get('averageName')> 65 && (Double) results.get('averageName') < 70){
            gradePoint = 1.3;
        }else if((Double) results.get('averageName') > 70 && (Double) results.get('averageName') < 75){
            gradePoint = 1.7;
        }else if((Double) results.get('averageName') == 75){
            gradePoint = 2;
        }else if((Double) results.get('averageName') > 75 && (Double) results.get('averageName') < 80){
            gradePoint = 2.3;
        }else if((Double) results.get('averageName') > 80 && (Double) results.get('averageName')< 85){
            gradePoint = 2.7;
        }else if((Double) results.get('averageName') == 85){
            gradePoint = 3;
        }else if((Double) results.get('averageName') > 85 && (Double) results.get('averageName') < 90){
            gradePoint = 3.33;
        }else if((Double) results.get('averageName') > 90 && (Double) results.get('averageName') < 93){
            gradePoint = 3.70;
        }else if((Double) results.get('averageName') >= 93){
            gradePoint=4;
        }

        gpaForStudent = (gradePoint * (Double) results.get('testName')) / gradePoint;
    }

    //get the GPA by taking gradepoint and multiplying it by credit and then divide it by credit


        return gpaForStudent;
       
        }
    }

