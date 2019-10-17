trigger NewEnrollmentTrigger on classEnrollment__c (before insert) {

    if(Trigger.isBefore){

        if(Trigger.isInsert){
            try{
            NewEnrollmentTriggerHelper.checkDegree(Trigger.new);
            } 
            catch (EnrollmentDepartmentException e){

            }
            
        }

    }

}