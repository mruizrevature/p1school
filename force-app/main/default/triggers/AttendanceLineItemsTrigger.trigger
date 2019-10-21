trigger AttendanceLineItemsTrigger on CLassEnrollment__c (after insert, before delete) 
{
    if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        {
            attendanceLineItemsTriggerHelper.deleteAttendanceLineItems(Trigger.old);
        }
    }
    else 
    {
        if(Trigger.isInsert)
        {
            attendanceLineItemsTriggerHelper.addAttendanceLineItems(Trigger.new);
        }    
    }
    
}