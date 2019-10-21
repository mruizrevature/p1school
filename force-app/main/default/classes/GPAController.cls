global class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){
        boolean notFoundStudent = true;
        Student__c studentToUpdate = new Student__c();
        //this makes sure the student actually exists and throws an exception if they dont
        try{
            studentToUpdate = [SELECT Id, Name, CumulativeGPA__c, Status__c FROM Student__c WHERE Id = :student][0];
            notFoundStudent = false;
            if(String.isEmpty(studentToUpdate.Id)) throw new UnableToCalculateGPAException('Student doesnt exist');
        }catch(UnableToCalculateGPAException e){
        
        }catch(ListException le) {

        }

        //it's also important to make sure that it's relevant for the student to have a GPA
        if(!(notFoundStudent ||
            studentToUpdate.Status__c.equals('Denied') ||
            studentToUpdate.Status__c.equals('Prospect'))){   
            studentToUpdate.CumulativeGPA__c = getClassGradePoints(student);
            update studentToUpdate;
        }

    }

    //actually gets the grade point average, it would be unfitting
    public static Double getClassGradePoints(Id student){
        Double gradeSum = 0.0;
        Double gradeNum = 0.0;
        Double classGPA = 0.0;
        List<List<Double>> runningTotal = new List<List<Double>>();
        //looks for all the classes the student has an enrollment for
        for(ClassEnrollment__c ce : [SELECT Id, Credits__c FROM ClassEnrollment__c WHERE Student__c = :student AND Status__c = 'Enrolled']){
            //only counts grades for classes is enrolled in
            for(Grade__c g : [SELECT Grade__c FROM Grade__c WHERE Class_Enrollment__c = :ce.Id]){
                gradeSum += g.Grade__c;
                gradeNum += 1.0;
            }
            
            //makes sure there are grades to be calculated
            if(gradenum > 0.0){
                //puts both the calculated grade and the credits in a list for later use
                classGPA = getMultiplier((gradeSum/gradeNum)) * ce.Credits__c;
                runningTotal.add(new List<Double>{classGPA, ce.Credits__c});
            }
            gradeSum = 0.0;
            gradeNum = 0.0;            
        }

        //
        for(List<Double> cgpa : runningTotal){
            gradeSum += cgpa[0];
            gradenum += cgpa[1];
        }

        //assigns a 4.0 if no grades exist
        if(gradeNum > 0.0){
            classGPA = (gradeSum/gradeNum) * 4.0;
        } else{
            classGPA = 4.0;
        }
        return classGPA;  
    }

    //get the multiplier thats supposed to be applied, students do not get the raw percentage, only the letter grade matters
    public static Double getMultiplier(Double average){
        //A
        if(average > 89.90){
            return 1.0;
        //B
        }else if(average > 79.90){
            return 0.75;
        //C
        }else if(average > 69.90){
            return 0.50;
        //D
        }else if(average > 59.90){
            return 0.25;
        }else{
            return 0.00;
        }
    }

}