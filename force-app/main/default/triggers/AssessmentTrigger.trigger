trigger AssessmentTrigger on SOBJECT (before insert, before update) {

    if (Trigger.isBefore){

        if(Trigger.isInsert){
            Assessment__C a = Trigger.new[0];

        }

        else if (Trigger.isUpdate){

        }


    }

    

}