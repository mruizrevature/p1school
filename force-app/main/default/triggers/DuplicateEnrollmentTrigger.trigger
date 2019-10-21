trigger DuplicateEnrollmentTrigger on CLassEnrollment__c (before insert) 
{
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            try 
            {
                DuplicateEnrollmentTriggerHelper.preventDuplicateEnrollment(Trigger.new);
            } 
            catch(DuplicateEnrollmentException dee)
            {

            }
            catch (Exception e) 
            {
                
            }
        }
    }
}