trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert, after insert, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            
            ClassEnrollmentTriggerHelper.checkDuplicateEnrollment(Trigger.new);

           
        }
        else if(Trigger.isDelete)
        {
            
        }
    }
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {

        }
    }
}