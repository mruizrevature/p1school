@ isTest() public with sharing class UnExcusedAbsensesTriggerTest {

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
		System.assert(classes.size() == 4);

		// enroll student to 3 different classes
		ClassEnrollment__c ce1 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(0).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce2 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(1).Id, Credits__c = 4, Status__c = 'Enrolled');
		ClassEnrollment__c ce3 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(2).Id, Credits__c = 3, Status__c = 'Enrolled');
		List<ClassEnrollment__c> ClassEnrollments = new List<ClassEnrollment__c>{ ce1, ce2, ce3 };
		insert ClassEnrollments;

		// update attendance line items
		// need three absences in different classes
		List<Id> ceIds = new List<Id>{ ce1.Id, ce2.Id, ce3.Id };

		ClassEnrollments = 
        [
            SELECT 
                Class__c, Student__c, 
                (SELECT Id 
                FROM AttendanceLineItems__r) 
            FROM 
                ClassEnrollment__c WHERE Id = :ceIds
        ];
        // update the first attendance line item
        // of each enrollment
		for(ClassEnrollment__c cenr :ClassEnrollments) {
			cenr.AttendanceLineItems__r.get(0).Present__c = false;
		}
		// check whether attendance is correctly updated
		ClassEnrollments = [SELECT Id, (SELECT Id, Present__c, Excused__c FROM AttendanceLineItems__r) FROM ClassEnrollment__c WHERE Id = :ceIds];
		for(ClassEnrollment__c cenr :ClassEnrollments) {
			System.assert(cenr.AttendanceLineItems__r.get(0).Present__c == true);
		}
		// // 3 enrollments
		// try to insert fourth enrollment
		ClassEnrollment__c ce4 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(3).Id, Credits__c = 4, Status__c = 'Enrolled');
		insert ce4;
		// this should still be 3
		ClassEnrollments = [SELECT Class__c, Student__c, (SELECT Id FROM AttendanceLineItems__r) FROM ClassEnrollment__c WHERE Id = :ceIds];
		System.assert(ClassEnrollments.size() == 3);

	}
}