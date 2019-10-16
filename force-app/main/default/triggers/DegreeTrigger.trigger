trigger DegreeTrigger on ClassEnrollment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
                DegreeTriggerHelper.preventDoubleRoomBooking(Trigger.new);
 
            } else {
                for (ClassEnrollment__c a: Trigger.new) {
                    a.addError("Class Subject does not match major");
                }
            }
        }
    }
}