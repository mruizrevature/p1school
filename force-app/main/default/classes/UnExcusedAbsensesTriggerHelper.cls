public with sharing class UnExcusedAbsensesTriggerHelper {

	// a mapping of student id and
	// whether a student can enroll to more classes or not
	public static Map<Id, String> canEnroll = new Map<Id, String>();

	public static void canStudentsEnrollToClasses(Set<Id> studIds) {
		// class enrollments of the students with their corresponding
		// attendance line item
		List<ClassEnrollment__c> enrollments =
		   [SELECT
		   Student__c, Class__c, (SELECT
		   Excused__c, Present__c
		   FROM
		   AttendanceLineItems__r)FROM
		   ClassEnrollment__c 
           WHERE Student__c IN: studIds
		];
        // if student doesn't have any enrollments put 'can_enroll' in the map
        boolean match = false;
        for(Id thisId : studIds){
            match = false;
            for (ClassEnrollment__c cenr : enrollments){
                if(cenr.Student__c.equals(thisId)){
                    match = true;
                    break;
                }
            }
            if(match == false){
                canEnroll.put(thisId, 'can_enroll');
            }
        }
		// a map containing student id and corresponding list of enrollments
		Map<Id, List<ClassEnrollment__c>> studentEnrollments = new
		Map<Id, List<ClassEnrollment__c>>();

		for (ClassEnrollment__c cenr :enrollments) {
			if(studentEnrollments.containsKey(cenr.Student__c)) {
				studentEnrollments.get(cenr.Student__c).add(cenr);
			} else {
				studentEnrollments.put(cenr.Student__c, new List<ClassEnrollment__c>{cenr});
			}
		}
		for(Id thisId :studentEnrollments.keySet()) {
			canEnroll.put(thisId, 
					      canStudentEnrollToClasses(studentEnrollments.get(thisId)));
		}
	}

	public static String canStudentEnrollToClasses(List<ClassEnrollment__c> enrollments) {
		Integer absentCount = 0;
		for(ClassEnrollment__c cenr : enrollments) {
			if(cenr.AttendanceLineItems__r.size() > 0) {
				for (AttendanceLineItem__c att :cenr.AttendanceLineItems__r) {
					if(!(att.Present__c || att.Excused__c)) {
						// if one absense is found, break out of loop
						// because we are concerned about distinct class
						// absenses
						absentCount += 1;
						break;
					}
				}
			}
		}      
		// if student is absent from four or more different classes
		if(absentCount >= 4) {
			return 'expelled';
		} 
        // if student is absent from 3 classes
		else if(absentCount >= 3) {
			return 'cannot_enroll';
		} else {
			return 'can_enroll';
		}

	}
}