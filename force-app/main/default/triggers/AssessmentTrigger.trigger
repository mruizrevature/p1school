trigger AssessmentTrigger on SOBJECT (before insert, before update) {

    if (Trigger.isBefore){

        if(Trigger.isInsert){

        }

        else if (Trigger.isUpdate){

        }


    }

    

}