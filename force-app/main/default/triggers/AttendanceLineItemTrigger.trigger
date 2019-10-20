trigger AttendanceLineItemTrigger on ClassEnrollment__c (before delete, after insert) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            if(Schema.sObjectType.AttendanceLineItem__c.isDeletable()){
                AttendanceLineItemTriggerHelper.deleteAttendaceLineItem(Trigger.old);
                AttendanceLineItemTriggerHelper.deleteGrades(Trigger.old);
            }else{
                for(AttendanceLineItem__c ali : Trigger.new){
                    ali.addError(UserPermissionErrors.CANNOT_DELETE_ALI);
                }
            }
        }

        
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            if(Schema.sObjectType.AttendanceLineItem__c.isDeletable()){
                AttendanceLineItemTriggerHelper.deleteAttendaceLineItem(Trigger.new);
            }else{
                for(AttendanceLineItem__c ali : Trigger.new){
                    ali.addError(UserPermissionErrors.CANNOT_DELETE_ALI);
                }
            }
        }
    }
}