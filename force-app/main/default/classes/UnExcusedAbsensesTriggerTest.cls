@isTest() public with sharing class UnExcusedAbsensesTriggerTest {

	@TestSetup
	static void setup() {
		TestDataCreator.createDataForEnrollment();
	}


	@isTest
	static void testDeniedEnrollment() {

		List<Student__c> students = [SELECT Id FROM Student__c];
		List<Class__c> classes = [SELECT Id FROM Class__c];
		// 1 student
		System.assert(students.size() == 1);
		// 4 classes
		System.assert(classes.size() == 5);

		// enroll student to 3 different classes
		ClassEnrollment__c ce1 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(0).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce2 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(1).Id, Credits__c = 4, Status__c = 'Enrolled');
		ClassEnrollment__c ce3 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(2).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce4 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(3).Id, Credits__c = 3, Status__c = 'Enrolled');
		List<ClassEnrollment__c> ClassEnrollments = new List<ClassEnrollment__c>{ ce1, ce2, ce3 };
		insert ClassEnrollments;

		// update attendance line items
		// need three absences in different classes
		List<Id> ceIds = new List<Id>{ ce1.Id, ce2.Id, ce3.Id};

		ClassEnrollments = 
        [
            SELECT 
                Class__c, Student__c, 
                (SELECT Id 
                FROM AttendanceLineItems__r) 
            FROM 
                ClassEnrollment__c WHERE Id IN :ceIds
        ];
        // update the first attendance line item
        // of each enrollment
		List<AttendanceLineItem__c> atts = new List<AttendanceLineItem__c>();
		for(ClassEnrollment__c cenr :ClassEnrollments) {
			cenr.AttendanceLineItems__r.get(0).Present__c = false;
			// update atts
			atts.add(cenr.AttendanceLineItems__r.get(0));
		}
		update atts;
		update ClassEnrollments;
		// check whether attendance is correctly updated
		ClassEnrollments = [SELECT Id, (SELECT Id, Present__c, Excused__c FROM AttendanceLineItems__r) FROM ClassEnrollment__c WHERE Id IN :ceIds];
		for(ClassEnrollment__c cenr :ClassEnrollments) {
			System.assert(cenr.AttendanceLineItems__r.get(0).Present__c == false);
		}

		// 3 enrollments and 3 distinct absenses
		//try to insert fourth enrollment
		Database.SaveResult insertResult;
		try{
			insertResult = Database.insert(ce4, false);
		}
		catch(DmlException de){
			System.debug(de.getMessage());
		}
        // insert should fail
        System.assert(!insertResult.isSuccess());
		// one error during insert
        System.assert(insertResult.getErrors().size() > 0);
		// error message matches
        System.assertEquals('Student is absent in 3 different classes', insertResult.getErrors()[0].getMessage());
		ClassEnrollments = [SELECT Class__c, Student__c, (SELECT Id FROM AttendanceLineItems__r) FROM ClassEnrollment__c WHERE Id = :ceIds];
		// this should still be 3 because 4th enrollment was denied
		System.assert(ClassEnrollments.size() == 3);

		

	}
}