<<<<<<< HEAD
trigger AssessmentTrigger on Assessment__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        Assessment__c newAssessment = Trigger.new[0];
        AssessmentTriggerHelper.preventDoubleBooking(newAssessment);
        
        
        
            }else if(Trigger.isUpdate){


            }
    } else {//after trigger
    
=======
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
>>>>>>> f1e3d832311dbcd30065346f02090dc4218fab13
    }
}