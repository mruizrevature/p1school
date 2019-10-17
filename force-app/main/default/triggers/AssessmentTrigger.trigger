trigger AssessmentTrigger on Assessment__c (before insert) {
    /*
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.Assessment__c.isCreateable()) {
                AssessmentTriggerHelper.preventDoubleRoomBooking(Trigger.new);
                // Assessment__c a = Trigger.new[0];
                // AssessmentTriggerHelper.preventDoubleRoomBooking(a);
            } else {
                for (Assessment__c a: Trigger.new) {
                    a.addError(UserPermissionErrors.CANNOT_CREATE_ASSESSMENTS);
                }
            }
        }
    }
    */
}