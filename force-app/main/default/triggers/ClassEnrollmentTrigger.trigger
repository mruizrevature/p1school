trigger ClassEnrollmentTrigger on SOBJECT (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            if (Schema.sObjectType.Assessment__c.isCreateable()) {
                for (ClassEnrollment__c ce: Trigger.new) {
                    ClassTriggerHelper.preventDoubleRoomBooking(ce);
                }
            } else {
                for (ClassEnrollment__c ce: Trigger.new) {
                    ce.addError(UserPermissionErrors.CANNOT_CREATE_CLASS_ENROLLMENTS);
                }
            }
        }
    }
}