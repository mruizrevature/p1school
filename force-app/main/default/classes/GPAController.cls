public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){
        List<ClassEnrollment__c> classEnrollmentList = [
            SELECT 
                Id
                ,Class__c
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

        for (ClassEnrollment__c classEnrollment : classEnrollmentList) {
            Grade__c[] grades = classEnrollment.Grades__r;
        }
        
        switch on expression {
            when value1 {		// when block 1
                // code block 1
            }	
            when value2 {		// when block 2
                // code block 2
            }
            when value3 {		// when block 3
                // code block 3
            }
            when else {		  // default block, optional
                // code block 4
            }
        }
    }
}