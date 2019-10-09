public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){
        
        for(Class__c clas: [SELECT Class__c FROM ClassEnrollment__c WHERE Student__c=:student])
        {
            if(Class)
        }
        List<Grade> grades = 
            [SELECT Grade FROM Grade__c WHERE Class_Enrollment__c=
                [SELECT ID FROM ClassEnrollment__c WHERE Student__c=:student] //class e
            ];
        List<Decimal> gpa = new Deciaml[classes.size()];
        List<Grade>
        
    }
}