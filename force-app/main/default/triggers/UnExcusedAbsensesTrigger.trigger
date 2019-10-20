// 3.
// A Student who has three unexcused absences
// from three different classes should be suspended and
// unable to enroll in another class during that time

// If this happens for a fourth class, they should be expelled.
trigger UnExcusedAbsensesTrigger on ClassEnrollment__c(before insert) {
	List<ClassEnrollment__c> enrollments = Trigger.new;
	if(Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
		// collect student ids
		Set<Id> studIds = new Set<Id>();
		for (ClassEnrollment__c cenr :enrollments) {
			studIds.add(cenr.Student__c);
		}
		// a method that uses single query to find out
		// whether each student can enroll, must be expelled or can not enroll
		UnExcusedAbsensesTriggerHelper.canStudentsEnrollToClasses(studIds);
		// a map which has the decision for each student
		// can_enroll, cannot_enroll, or expelled
		Map<Id, String> canEnroll = UnExcusedAbsensesTriggerHelper.canEnroll;
                // deny or allow students
                for (ClassEnrollment__c cenr :enrollments) {
                    if(canEnroll.get(cenr.Student__c).equals('cannot_enroll')) {
                        cenr.addError('Student is absent in 3 different classes');
                    } 
                    else if(canEnroll.get(cenr.Student__c).equals('expelled')) {
                        cenr.addError('Student is absent in 4 different classes');
                        // update student status to Expelled
                        Student__c stud = [SELECT Id FROM Student__c WHERE Id = :cenr.Student__r.Id];
                        stud.Status__c = 'Expelled';
                        update stud;
                    }
                }
        }
	// user don't have create permission
	else {

	for (ClassEnrollment__c cenr :Trigger.new) {
	cenr.addError(String.format(UserPermissionErrors.CE_ERROR, new List<Object>{' create ', ' ' }));
}

}
}