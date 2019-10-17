trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            if(Schema.SObjectType.ClassEnrollment__c.isCreateable()){
            ClassEnrollmentTriggerHelper.stopDoubleEnroll(Trigger.new);
        }else for (ClassEnrollment__C ce: Trigger.new) {
                    ce.addError(UserPermissionErrors.CANNOT_CREATE_ENROLL);
                }
            }

        }
    }