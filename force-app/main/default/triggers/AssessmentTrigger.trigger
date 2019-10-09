trigger AssessmentTrigger on Assessment__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        Assessment__c newAssessment = Trigger.new[0];
        AssessmentTriggerHelper.preventDoubleBooking(newAssessment);
        
        
        
            }else if(Trigger.isUpdate){


            }
    } else {//after trigger
    
    }
}