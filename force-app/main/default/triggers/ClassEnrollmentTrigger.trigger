trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert, after insert, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            for(ClassEnrollment__c ce: Trigger.new)
                ClassEnrollmentTriggerHelper.checkDuplicateEnrollment(ce);

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