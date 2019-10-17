trigger ClassEnrollmentTrigger on ClassEnrollment__c(after insert, before delete) {
	// When a Student is enrolled in a class,
	// there should be Attendance Line Items created

	// after insert
	if(Trigger.isAfter) {
		if(Trigger.isInsert) {
			if(Schema.sObjectType.ClassEnrollment__c.isCreateable()) {
				ClassEnrollmentHelper.createAttendanceLines(Trigger.new);
			}
			// user don't have create permission
			else {
			for (ClassEnrollment__c ce :Trigger.new) {
			ce.addError(String.format(UserPermissionErrors.CE_ERROR, new List<Object>{' create ', ' ' }));
	}
}
}
}
// Delete the Assessment Line Items if the Student withdraws
// from the class.

// before delete
else if(Trigger.isDelete) {
if(Schema.sObjectType.ClassEnrollment__c.isDeletable()) {
ClassEnrollmentHelper.deleteAttendanceLinesForEnrollments(Trigger.old);
} else {
for (ClassEnrollment__c ce :Trigger.new) {
	ce.addError(String.format(UserPermissionErrors.CE_ERROR, new List<Object>{ 'delete', '' }));
}
}
}

}