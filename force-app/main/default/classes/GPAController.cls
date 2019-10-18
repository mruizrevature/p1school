public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){
        Double gPA = 0.0;
        AggregateResult[] gr = [SELECT  AVG(Grade__c)avgGrade, Class_Enrollment__r.Student__r.Name, Class_Enrollment__r.Student__r.Id 
                                FROM Grade__c 
                                GROUP BY Class_Enrollment__r.Student__r.Name, Class_Enrollment__r.Student__r.Id];
        for(AggregateResult gradePA : gr){
            if((Double)gradePA.get('avgGrade') < 0.0){
                throw new UnableToCalculateGPAException('Cannot calculate the GPA for this student: ' + (Id)gradePA.get('Student__r.Id'));
            }
            else if((Double)gradePA.get('avgGrade') > 0.0 && (Double)gradePA.get('avgGrade') < 65.0){
                gPA = 0.0;
            }
            else if((Double)gradePA.get('avgGrade') >= 65.0 && (Double)gradePA.get('avgGrade') < 67.0){
                gPA = 1.0;
            }
            else if((Double)gradePA.get('avgGrade') >= 67.0 && (Double)gradePA.get('avgGrade') < 70.0){
                gPA = 1.3;
            }
            else if((Double)gradePA.get('avgGrade') >= 70.0 && (Double)gradePA.get('avgGrade') < 73.0){
                gPA = 1.7;
            }
            else if((Double)gradePA.get('avgGrade') >= 73 && (Double)gradePA.get('avgGrade') < 77.0){
                gPA = 2.0;
            }
            else if((Double)gradePA.get('avgGrade') >= 77.0 && (Double)gradePA.get('avgGrade') < 80.0){
                gPA = 2.3;
            }
            else if((Double)gradePA.get('avgGrade') >= 80.0 && (Double)gradePA.get('avgGrade') < 83.0){
                gPA = 2.7;
            }
            else if((Double)gradePA.get('avgGrade') >= 83.0 && (Double)gradePA.get('avgGrade') < 87.0){
                gPA = 3.0;
            }
            else if((Double)gradePA.get('avgGrade') >= 87.0 && (Double)gradePA.get('avgGrade') < 90.0){
                gPA = 3.3;
            }
            else if((Double)gradePA.get('avgGrade') >= 90.0 && (Double)gradePA.get('avgGrade') < 93.0){
                gPA = 3.7;
            }
            else if((Double)gradePA.get('avgGrade') >=93.0){
                gPA = 4.0;
            }
            update (Id)gradePA.get('Class_Enrollment__r.Student__r.Id');
        }
    }
}
//attendance line items do Delete [select ___ from ___ where ___ = ______]
