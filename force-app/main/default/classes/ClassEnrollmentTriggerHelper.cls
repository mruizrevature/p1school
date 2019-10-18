public with sharing class ClassEnrollmentTriggerHelper {

    //Duplicate Enrollment
    //check if student tries to enroll in a class twice , throws exception
    public static void checkDuplicateEnrollment(ClassEnrollment__c ce)
    {
        if([SELECT ID FROM ClassEnrollment__c WHERE Student__c=:ce.Student__c AND Class__c=:ce.Class__c].size()!=0)
        {
            //throw exception
            Exception e= new DuplicateEnrollmentException('A Class Enrollment for this Student and Class already exists');
            ce.addError(e.getMessage());
            throw e;
        }

    }

    //bulk check
    public static void checkDuplicateEnrollment(List<ClassEnrollment__c> ces)
    {
        Map<Id,Set<Id>> CEmap = new Map<Id,Set<Id>>();
        List<ClassEnrollment__c> data =[SELECT Id,Student__c,Class__c FROM ClassEnrollment__c];
        //fill the map with existing values
        for(ClassEnrollment__c ce: data)
        {
            Id stud = ce.Student__c;
            Id clas = ce.Class__c;
            if(CEMap.get(stud)==null)
                CEMap.put(stud, new Set<Id>{clas});
            else
                CEMap.get(stud).add(clas);
        }
        //take input and check if they can be added to the map
        for(ClassEnrollment__c ce: ces){
            Id stud = ce.Student__c;
            Id clas = ce.Class__c;
            if(CEmap.get(stud)!=null)
            {
                if(!CEmap.get(stud).add(clas))
                {
                    Exception e= new DuplicateEnrollmentException('A Class Enrollment for this Student and Class already exists');
                    ce.addError(e.getMessage());
                    throw e;
                }
            }
            else
                CEMap.put(stud, new Set<Id>{clas});
            
        }

    }


}
