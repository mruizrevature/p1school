@ isTest()public with sharing class UnExcusedAbsensesTriggerTest {

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

		TestDataCreator.ClassEnrollments = new List<ClassEnrollment__c>();
		// enroll student to 3 different classes
		ClassEnrollment__c ce1 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(0).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce2 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(1).Id, Credits__c = 4, Status__c = 'Enrolled');
		ClassEnrollment__c ce3 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(2).Id, Credits__c = 3, Status__c = 'Enrolled');
		TestDataCreator.ClassEnrollments.add(ce1);
		TestDataCreator.ClassEnrollments.add(ce2);
		TestDataCreator.ClassEnrollments.add(ce3);
		insert ClassEnrollments;
		// update attendance line items
		// need three absences in different classes
		System.debug('look here1000' + ClassEnrollments.get(0).AttendanceLineItems__r.size());



		// ClassEnrollment__c ce4 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(3).Id, Credits__c = 4, Status__c = 'Enrolled');

		// //TestDataCreator.ClassEnrollments.add(ce4);

		// // 2 class enrollments
		// System.assert(ClassEnrollments.size() == 2);

		// ClassEnrollments = [SELECT Class__c, Student__c, Class__r.DaysPerWeek__c, (SELECT Id FROM AttendanceLineItems__r) FROM ClassEnrollment__c];
		// for(ClassEnrollment__c en :ClassEnrollments) {
		// 	// System.debug('look here1=>' + en.AttendanceLineItems__r.size());
		// 	// System.debug('look here2=>' + en.Class__r.DaysPerWeek__c);

		// 	// number of attendance line items = number of times class meets per week
		// 	System.assert(en.AttendanceLineItems__r.size() == en.Class__r.DaysPerWeek__c);
		}

		// enroll student in 6 classes

		// change 3 distinct class attendances to excused=false, present=false

		// student can't enroll to another class

		}
}