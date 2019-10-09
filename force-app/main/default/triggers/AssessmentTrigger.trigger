trigger AssessmentTrigger on SOBJECT (before insert, before update) {

    if (Trigger.isBefore){

        if(Trigger.isInsert){
            Assessment a = Trigger.new[0];

        }

        else if (Trigger.isUpdate){

        }


    }

    

}