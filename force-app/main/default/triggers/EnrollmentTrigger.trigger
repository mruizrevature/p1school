trigger EnrollmentTrigger on ClassEnrollment__c (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            if(Schema.sObjectType.ClassEnrollment__c.isCreateable()){
                EnrollmentTriggerHelper.preventDoubleEnrollment(Trigger.new);
            }else{
                for(ClassEnrollment__c ce : Trigger.new){
                    ce.addError(UserPermissionErrors.CANNOT_CREATE_ENROLLMENTS);
                }
            }
        }
    }
}