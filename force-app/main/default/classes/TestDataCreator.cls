public with sharing class TestDataCreator {
    public static void createDataForEnrollment(){
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
        Class__c class3 = new Class__c(Name = 'MMM000', 
									   Capacity__c= 10, 
									   DaysPerWeek__c= 3, 
									   Department__c= d1.Id, 
									   StartDate__c=(Date.newInstance(2019, 8, 12)), 
									   EndDate__c=(Date.newInstance(2019, 12, 15)), 
									   Room__c = new Room__c().Id, 
									   ScheduledTime__c=(Time.newInstance(9, 0, 0, 0)), 
									   Status__c= 'In Progress', 
									   Topic__c= topic1.Id);

		Class__c class4 = new Class__c(Name = 'PPP000', 
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
        classes.add(class3);
        classes.add(class4);

		insert classes;
		System.debug('Classes Created');

    }
}
