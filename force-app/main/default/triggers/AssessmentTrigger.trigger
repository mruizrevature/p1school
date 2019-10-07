trigger AssessmentTrigger on Assessment__c (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.Assessment__c.isCreateable()) {
                AssessmentTriggerHelper.preventDoubleRoomBooking(Trigger.new);

                // for (Assessment__c a: Trigger.new) {
                //     AssessmentTriggerHelper.preventDoubleRoomBooking(a);
                // }
            } else {
                for (Assessment__c a: Trigger.new) {
                    a.addError('You do not have permission to create Assessments. Please contact System Administrator if this is unexpected.');
                }
            }
        }
    }
}