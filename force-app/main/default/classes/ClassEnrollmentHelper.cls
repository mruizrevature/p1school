public with sharing class ClassEnrollmentHelper {
   
   public static void createAttendanceLine(ClassEnrollment__c theEnrollment) {
		Class__c theClass = [
            SELECT
                DaysPerWeek__c
			FROM
            
				Class__c
			WHERE
				Id = :theEnrollment.Class__c
		].get(0);
		// create attendance line item for each day a class meets
		List<AttendanceLineItem__c> attLineItems = new List<AttendanceLineItem__c>();
		for (Integer i = 0; i < theClass.DaysPerWeek__c; i ++) {
			attLineItems.add(new AttendanceLineItem__c(Class__c = theEnrollment.Class__c, 
						     ClassEnrollment__c = theEnrollment.Id, 
						     Student__c = theEnrollment.Student__c));
		}
		try {
			// no partial insertion
			insert attLineItems;
		} catch(DmlException de) {
			System.debug(String.format(UserPermissionErrors.ATT_ERROR, new List<Object>{'create', de.getMessage()}));
		}
	}
	public static void createAttendanceLines(List<ClassEnrollment__c> theEnrollment) {
		for (ClassEnrollment__c c :theEnrollment) {
			createAttendanceLine(c);
		}
	}

	public static void deleteAttendanceLinesForEnrollment(ClassEnrollment__c theEnrollment) {
		AttendanceLineItem__c[] attLineItems = [
            SELECT 
                ClassEnrollment__c
			FROM 
                AttendanceLineItem__c
			WHERE 
				ClassEnrollment__c = :theEnrollment.Id
		];
		try {
			delete attLineItems;
		} catch(DmlException de) {
			System.debug(String.format(UserPermissionErrors.ATT_ERROR, new List<Object>{'delete', de.getMessage()}));
		}
	}
	// used by a trigger
	public static void deleteAttendanceLinesForEnrollments(List<ClassEnrollment__c> theEnrollments) {
		for (ClassEnrollment__c ce :theEnrollments) {
			deleteAttendanceLinesForEnrollment(ce);
		}
	}



}