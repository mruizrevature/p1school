@ isTest
public with sharing class ClassEnrollmentTriggerTest {

	@TestSetup
	static void setup() {
		TestDataCreator.createDataForEnrollment();
	}

	@isTest 
	static void testCreateAttendanceLineItems() {
		List<Student__c> students = [SELECT Id FROM Student__c];
		List<Class__c> classes = [SELECT Id FROM Class__c];
		// 1 student
		System.assert(students.size() == 1);
		// 4 classes
		System.assert(classes.size() == 4);

		List<ClassEnrollment__c> ClassEnrollments = new List<ClassEnrollment__c>();
		ClassEnrollment__c ce1 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(0).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce2 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(1).Id, Credits__c = 4, Status__c = 'Enrolled');
		ClassEnrollments.add(ce1);
		ClassEnrollments.add(ce2);
		insert ClassEnrollments;
		// 2 class enrollments
		System.assert(ClassEnrollments.size() == 2);

		ClassEnrollments = [SELECT Class__c, Student__c, Class__r.DaysPerWeek__c, (SELECT Id FROM AttendanceLineItems__r) FROM ClassEnrollment__c];
		for(ClassEnrollment__c en : ClassEnrollments) {
			// number of attendance line items = number of times class meets per week
			System.assert(en.AttendanceLineItems__r.size() == en.Class__r.DaysPerWeek__c);
		}
	}
	@isTest
	public static void testDeleteClassEnrollment() {

		List<Student__c> students = [SELECT Id FROM Student__c];
		List<Class__c> classes = [SELECT Id FROM Class__c];
		ClassEnrollment__c ce1 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(0).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce2 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(1).Id, Credits__c = 4, Status__c = 'Enrolled');
		List<ClassEnrollment__c> ClassEnrollments = new List<ClassEnrollment__c>{ce1, ce2};
		insert ClassEnrollments;
		// 2 class enrollments
		System.assert(ClassEnrollments.size() == 2);

		// save ids of attendance line items for each class enrollment
		List<List<Id>> attendanceIds = new List<List<Id>>();
		List<Id> idsForEnrollment;
		for(ClassEnrollment__c en :ClassEnrollments) {
			idsForEnrollment = new List<Id>();
			for(AttendanceLineItem__c item :en.AttendanceLineItems__r) {
				idsForEnrollment.add(item.Id);
			}
			attendanceIds.add(idsForEnrollment);
		}
		// delete only one class enrollment
		delete ClassEnrollments.get(0);
		ClassEnrollments = [SELECT Class__c, Student__c, Class__r.DaysPerWeek__c, (SELECT Id FROM AttendanceLineItems__r) FROM ClassEnrollment__c];
		// size of class enrollments is 1
		System.assert(ClassEnrollments.size() == 1);
		// all attendance line  items for the deleted class enrollment
		// should be deleted as well.
		List<AttendanceLineItem__c> attLineItems = [SELECT Id FROM AttendanceLineItem__c WHERE Id IN :attendanceIds.get(0)];
		System.assert(attLineItems.size() == 0);
		// delete the second enrollment
		// index is zero because only 1 enrollemnt is remaining in list
		delete ClassEnrollments.get(0);
		attLineItems = [SELECT Id FROM AttendanceLineItem__c];
		// System.debug('see me=>' + attLineItems.size());
		// all attendance line items are deleted
		System.assert(attLineItems.size() == 0);
	}
}