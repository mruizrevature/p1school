trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert, after insert, before delete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            ClassEnrollmentTriggerHelper.addAttendanceLineItems(Trigger.new);
        }
    }else{
        if(Trigger.isDelete){
            ClassEnrollmentTriggerHelper.checkForGrades(Trigger.old);
        }
        if(Trigger.isInsert){
            ClassEnrollmentTriggerHelper.checkForDoubleEnrollment(Trigger.new);
        }
    }
}