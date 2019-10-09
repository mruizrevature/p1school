trigger AssessmentTrigger on Assessment__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            Assessment__c newA = Trigger.new[0];
            AssessmentTriggerHelper.preventDoubleBooking(newA);
        } else if (Trigger.isUpdate) {
            //
        }
    } else if (Trigger.isAfter) {
        //
    }
}