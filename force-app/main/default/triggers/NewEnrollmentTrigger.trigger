trigger NewEnrollmentTrigger on classEnrollment__c (before insert) {

    if(Trigger.isBefore){

        if(Trigger.isInsert){
            NewEnrollmentTriggerHelper.checkDegree(Trigger.new[0]); 
        }

        if (Trigger.isUpdate){
            NewEnrollmentTriggerHelper.checkDegree(Trigger.new[0]);
        }

    }

}