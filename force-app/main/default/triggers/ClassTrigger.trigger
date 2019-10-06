trigger ClassTrigger on Class__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.Class__c.isCreateable()) {
                for (Class__c a: Trigger.new) {
                    ClassTriggerHelper.preventDoubleRoomBooking(a);
                }
            } else {
                for (Class__c a: Trigger.new) {
                    a.addError('You do not have permission to create Assessments. Please contact System Administrator if this is unexpected.');
                }
            }
        }
    }
}