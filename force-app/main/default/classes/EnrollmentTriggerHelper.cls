public with sharing class EnrollmentTriggerHelper {
	public static void preventDoubleEnrollment(ClassEnrollment__c EnrollmentBeingInserted) {
		checkIfEnrollmentIsAlreadyCreated(EnrollmentBeingInserted);
	}
	public static void preventDoubleEnrollment(List<ClassEnrollment__c> EnrollmentsBeingInserted) {
		checkIfEnrollmentIsAlreadyCreated(EnrollmentsBeingInserted);
	}
	static void checkIfEnrollmentIsAlreadyCreated(ClassEnrollment__c newEnrollment) {
		List<ClassEnrollment__c> existingEnrollments;

		// Make sure the user has read access for exising Class Enrollment records.
		if(Schema.sObjectType.ClassEnrollment__c.isAccessible()) {
			existingEnrollments = [SELECT Id, Class__c, Student__c FROM ClassEnrollment__c WHERE Class__c = :newEnrollment.Class__c AND Student__c = :newEnrollment.Student__c];
		}
		if(existingEnrollments != null) {
			// User has at least read access
			if(existingEnrollments.size() > 0) {
				// Double Enrollments
				DuplicateEnrollment.denyRecordTryingToDoubleEnrollAClass(newEnrollment);
				//add error
				newEnrollment.addError(UserPermissionErrors.CANNOT_DUPLICATE_ENROLLMENTS);
				throw new DuplicateEnrollmentException('This student has already been enrolled in this class');

			}
		} else {
			// User cannot read Class Enrollment
			newEnrollment.addError(UserPermissionErrors.CANNOT_READ_ENROLLMENTS);
		}

	}
	static void checkIfEnrollmentIsAlreadyCreated(List<ClassEnrollment__c> newEnrollments) {

		List<ClassEnrollment__c> existingEnrollments;
		List<Id> listOfClasses = new List<Id>();
		List<Id> listOfStudents = new List<Id>();
		List<ClassEnrollment__c> enrollmentToBeDenied = new List<ClassEnrollment__c>();

		for(ClassEnrollment__c ce : newEnrollments) {
			listOfClasses.add(ce.Class__c);
			listOfStudents.add(ce.Student__c);
		}

		// User has at least read access to class Enrollment records.
		if(Schema.sObjectType.ClassEnrollment__c.isAccessible()) {
			existingEnrollments = [SELECT Id, Class__c, Student__c FROM ClassEnrollment__c WHERE(Class__c IN :listOfClasses) AND(Student__c IN :listOfStudents)];
		}
		for (ClassEnrollment__c newCe :newEnrollments) {
			for(ClassEnrollment__c ceexist :existingEnrollments) {
				if(ceexist.Class__c == newCe.Class__c) {
					if(ceexist.Student__c == newCe.Student__c) {
						//double enrollment
						enrollmentToBeDenied.add(newCe);
						newCe.addError(UserPermissionErrors.CANNOT_DUPLICATE_ENROLLMENTS);
						break;
					}

				}
			}
		}
		DuplicateEnrollment.denyRecordsTryingToDoubleEnrollAClass(enrollmentToBeDenied);


		// if(existingEnrollments != null) {
		//     if(enrollmentToBeDenied.size() > 1) {
		//         DuplicateEnrollment.denyRecordsTryingToDoubleEnrollAClass(enrollmentToBeDenied);
		//     }
		// }

	}

}