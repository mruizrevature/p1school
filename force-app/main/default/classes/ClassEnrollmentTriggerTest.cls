@isTest
public with sharing class ClassEnrollmentTriggerTest {
	@TestSetup
	static void setup() {

		// Create Two Departments
		List<Department__c> departments = new List<Department__c>();
		Department__c d1 = new Department__c(Name = 'Math');
		Department__c d2 = new Department__c(Name = 'History');
		departments.add(d1);
		departments.add(d2);
		insert departments;
		System.debug('Departments Created');

		// Create Two Advisors
		List<Employee__c> advisors = new List<Employee__c>();
		Employee__c emp1 = new Employee__c(Name = 'Advisor 1', Department__c = d1.Id);
		Employee__c emp2 = new Employee__c(Name = 'Advisor 2', Department__c = d2.Id);
		advisors.add(emp1);
		advisors.add(emp2);
		insert advisors;
		System.debug('Advisors Created');

		// Create Student
		Student__c student = new Student__c(Name = 'TestStudent', Email__c = 'whocares@neglect.com', Advisor__c = emp1.Id, Status__c = 'Enrolled');
		insert student;
		System.debug('Student Created');

		// Create Degrees
		List<Degree__c> degrees = new List<Degree__c>();
		Degree__c deg1 = new Degree__c(Name = 'Mathematics', Department__c = d1.Id);
		Degree__c deg2 = new Degree__c(Name = 'History', Department__c = d2.Id);
		degrees.add(deg1);
		degrees.add(deg2);
		insert degrees;
		System.debug('Degrees Created');

		// Create Topics
		List<Topic__c> topics = new List<Topic__c>();
		Topic__c topic1 = new Topic__c(Name = 'Statistics', Degree__c = deg1.Id);
		Topic__c topic2 = new Topic__c(Name = 'American History', Degree__c = deg1.Id);
		topics.add(topic1);
		topics.add(topic2);
		insert topics;
		System.debug('Topics Created');

		// Create Classes
		List<Class__c> classes = new List<Class__c>();
		Class__c class1 = new Class__c(Name = 'TTT000', 
									   Capacity__c= 10, 
									   DaysPerWeek__c= 3, 
									   Department__c= d1.Id, 
									   StartDate__c=(Date.newInstance(2019, 8, 12)), 
									   EndDate__c=(Date.newInstance(2019, 12, 15)), 
									   Room__c = new Room__c().Id, 
									   ScheduledTime__c=(Time.newInstance(9, 0, 0, 0)), 
									   Status__c= 'In Progress', 
									   Topic__c= topic1.Id);

		Class__c class2 = new Class__c(Name = 'RRR000', 
									   Capacity__c= 10, 
									   DaysPerWeek__c= 5, 
									   Department__c= d2.Id, 
									   StartDate__c=(Date.newInstance(2019, 7, 12)), 
									   EndDate__c=(Date.newInstance(2019, 11, 13)), 
									   Room__c= new Room__c().Id, 
									   ScheduledTime__c=(Time.newInstance(8, 0, 0, 0)), 
									   Status__c= 'In Progress', 
									   Topic__c= topic2.Id);
		classes.add(class1);
		classes.add(class2);
		insert classes;
		System.debug('Classes Created');

	}

	@isTest static void testClassEnrollment() {

		List<Student__c> students = [SELECT Id FROM Student__c];
		List<Class__c> classes = [SELECT Id FROM Class__c];
		// 1 student
		System.assert(students.size() == 1);
		// 2 classes
		System.assert(classes.size() == 2);

		List<ClassEnrollment__c> ClassEnrollments = new List<ClassEnrollment__c>();
		ClassEnrollment__c ce1 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(0).Id, Credits__c = 3, Status__c = 'Enrolled');
		ClassEnrollment__c ce2 = new ClassEnrollment__c(Student__c = students.get(0).Id, Class__c = classes.get(1).Id, Credits__c = 4, Status__c = 'Enrolled');
		ClassEnrollments.add(ce1);
		ClassEnrollments.add(ce2);
		insert ClassEnrollments;
		// 2 class enrollments
		System.assert(ClassEnrollments.size() == 2);

		ClassEnrollments = [SELECT Class__c, Student__c, Class__r.DaysPerWeek__c, (SELECT Id FROM AttendanceLineItems__r) FROM ClassEnrollment__c];
		for(ClassEnrollment__c en :ClassEnrollments) {
			System.debug('look here1=>' + en.AttendanceLineItems__r.size());
            System.debug('look here2=>' + en.Class__r.DaysPerWeek__c);

            // number of attendance line items = number of times class meets per week
			System.assert(en.AttendanceLineItems__r.size() == en.Class__r.DaysPerWeek__c);
		}

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
		System.debug('see me=>' + attLineItems.size());
		// all attendance line items are deleted
		System.assert(attLineItems.size() == 0);
	}


}