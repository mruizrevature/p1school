public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){

        Double gradeAvg;
        Double majorAvg;

        try{
            //Use aggregate avg of grade decimal values where the class enrollment includes the student
           	AggregateResult[] r = [SELECT AVG(Grade__c) FROM Grade__c
                                     WHERE Class_Enrollment__r.Student__c=:student];
            
            gradeAvg = Double.valueOf(r[0].get('expr0'));

            //get id of the student's associated degree to their major
            Id degree = [SELECT Degree__c FROM Major__c WHERE Student__c =:student LIMIT 1].Degree__c;
            //use aggregate again for major GPA, uses that enrolled classes where topic matches student's degree
            r = [SELECT AVG(Grade__c) FROM Grade__c 
                                        WHERE Class_Enrollment__r.Student__c=:student 
                                        AND Class_Enrollment__r.Class__r.Topic__r.Degree__c=:degree];
            
            majorAvg = Double.valueOf(r[0].get('expr0'));

        }
        catch(Exception e){
            throw new UnableToCalculateGPAException('Something in the calculation went wrong');
        }

        
        //update gpa fields on student id record
        Student__c s = new Student__c(Id=student);
        s.CumulativeGPA__c = getGPAFromAvg(gradeAvg);
        s.MajorGPA__c =  getGPAFromAvg(majorAvg);
        update s;
    }


    //Returns GPA average corresponding an average overall grade in percent
    public static Double getGPAFromAvg(Double gradeAvg)
    {
        //being at or above the grade scale matches to the GPA on 4.0 scale: Ex gradeavg=81 , first index >= is 80 , so 2.7 GPA
        List<Double> GPAScale = new List<Double>{4.0, 3.7, 3.3, 3.0, 2.7, 2.3, 2.0, 1.7, 1.3, 1.0, 0};
        List<Integer> GradeScale=new List<Integer>{93,  90,  87,  83,  80,  77,  73,  70, 67,  65};
        Integer index=0;
        while(index!=gradeScale.size()&&gradeAvg<gradeScale[index]){
            index++;
        }
        return GPAScale[index];
    }
}