trigger DuplicateEnrollmentTrigger on ClassEnrollment__c (before insert, before update) {

    List<ClassEnrollment__c> currentEnrollments = [SELECT Student__c, Class__c from ClassEnrollment__c];

    for (ClassEnrollment__c currentEnrollment: currentEnrollments){

    	for (ClassEnrollment__c a: Trigger.new) {
            if (currentEnrollment.Student__c == a.Student__c && currentEnrollment.Class__c == a.Class__c)
                throw new DuplicateEnrollmentException('Student is already enrolled in this class');
        }
    }


}