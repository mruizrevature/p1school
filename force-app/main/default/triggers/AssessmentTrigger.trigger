<<<<<<< HEAD
trigger AssessmentTrigger on Assessment__c (before insert) {
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
=======
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
>>>>>>> 2936ab50e73a91dcc6c160d619280731cc9ab13a
    }
}