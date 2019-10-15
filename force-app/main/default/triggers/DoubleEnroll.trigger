/** 
A Student shouldn't be enrolled in the same class twice.
	- If this happens, throw a DuplicateEnrollmentException exception.
*/
trigger DoubleEnroll on ClassEnrollment__c (before insert) {
    List<ClassEnrollment__c> currentEnrolls = [SELECT Class__c,Student__c FROM ClassEnrollment__c];
    for(ClassEnrollment__c currentEnrolls : currentEnrolls){
        for(ClassEnrollment__c newEnroll : Trigger.new){
            if ((Class__c.currentEnrolls == Class__c.newEnroll) && (Student__c.currentEnrolls == Student__c.currentEnrolls)){
                //throw exception
            }
            else{
                //insert new enroll
            }
        }
    }
}
