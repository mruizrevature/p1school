trigger ClassTrigger on Class__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.Class__c.isCreateable()) {
                for (Class__c c: Trigger.new) {
                    //ClassTriggerHelper.preventDoubleRoomBooking(c);
                }
            } else {
                for (Class__c a: Trigger.new) {
                    a.addError('You do not have permission to create Assessments. Please contact System Administrator if this is unexpected.');
                }
            }
        }
    }
}