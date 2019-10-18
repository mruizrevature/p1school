public class SchoolDataCreator {
    public static void createData() {
        deleteExistingSchoolData();

        createDepartments();
        createRooms();
        createDegrees();
        createTopics();
        createClasses();
        createEmployees();
        createStudents();
        createMajors();
        // create minors
        createAssessments();
        createClassEnrollments();
        // createGrades();
    }
    
    private static void deleteExistingSchoolData() {
        deleteExistingGrades();
        deleteExistingAssessments();
        deleteExistingClassEnrollments();
        deleteExistingAttendanceLineItems();
        deleteExistingMinors();
        deleteExistingMajors();
        deleteExistingClasses();
        deleteExistingRooms();
        deleteExistingTopics();
        deleteExistingDegrees();
        deleteExistingStudents();
        deleteExistingEmployees();
        deleteExistingDepartments();
    }
    
    private static void deleteExistingGrades() { delete [SELECT Id FROM Grade__c]; }
    private static void deleteExistingAssessments() { delete [SELECT Id FROM Assessment__c]; }
    private static void deleteExistingClassEnrollments() { delete [SELECT Id FROM ClassEnrollment__c]; }
    private static void deleteExistingAttendanceLineItems() { delete [SELECT Id FROM AttendanceLineItem__c]; }
    private static void deleteExistingMinors() { delete [SELECT Id FROM Minor__c]; }
    private static void deleteExistingMajors() { delete [SELECT Id FROM Major__c]; }
    private static void deleteExistingClasses() { delete [SELECT Id FROM Class__C]; }
    private static void deleteExistingRooms() { delete [SELECT Id FROM Room__C]; }
    private static void deleteExistingTopics() { delete [SELECT Id FROM Topic__C]; }
    private static void deleteExistingDegrees() { delete [SELECT Id FROM Degree__C]; }
    private static void deleteExistingStudents() { delete [SELECT Id FROM Student__c]; }
    private static void deleteExistingEmployees() { delete [SELECT Id FROM Employee__C]; }
    private static void deleteExistingDepartments() { delete [SELECT Id FROM Department__C]; }
    
    private static void createDepartments() {
        List<String> departmentNames = new List<String> {'Math', 'Science', 'Education', 'History'};
        List<Department__c> departmentsToInsert = new List<Department__c>();
        for (Integer i= 0; i < departmentNames.size(); i++) {
            departmentsToInsert.add(new Department__c(Name=departmentNames[i]));
        }
        insert departmentsToInsert;
    }

    private static void createRooms() {
        List<Room__c> roomsToInsert = new List<Room__c>();
        for (Integer i= 0; i < 10; i++) {
            roomsToInsert.add(new Room__c());
        }
        insert roomsToInsert;
    }

    private static void createDegrees() {
        List<Department__c> departments = [SELECT Id, Name FROM Department__c];
        Map<String, Id> departmentNameToId = new Map<String, Id>();

        for (Department__c dept: departments) {
            departmentNameToId.put(dept.Name, dept.Id);
        }
        
        List<String> degreeNames = new List<String> {'Mathematics', 'Applied Statistics', 'Biology', 'Chemistry', 'Education', 'Educational Reading', 'Geology', 'Anthropology'};
        List<Degree__c> degreesToInsert = new List<Degree__c>();

        degreesToInsert.add(new Degree__c(Name=degreeNames[0], Department__c=departmentNameToId.get('Math')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[1], Department__c=departmentNameToId.get('Math')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[2], Department__c=departmentNameToId.get('Science')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[3], Department__c=departmentNameToId.get('Science')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[4], Department__c=departmentNameToId.get('Education')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[5], Department__c=departmentNameToId.get('Education')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[6], Department__c=departmentNameToId.get('History')));
        degreesToInsert.add(new Degree__c(Name=degreeNames[7], Department__c=departmentNameToId.get('History')));

        insert degreesToInsert;
    }

    private static void createTopics() {
        List<Degree__c> degrees = [SELECT Id, Name FROM Degree__c];
        Map<String, Id> degreeNameToId = new Map<String, Id>();

        for (Degree__c degree: degrees) {
            degreeNameToId.put(degree.Name, degree.Id);
        }

        List<String> topicNames = new List<String> {'Algebra', 'Pre-Calculus', 'Probability', 'Sport Analytics', 'General Biology', 'Genetics', 'Concepts of Chemistry', 'Chemistry of Beer', 'Democracy and Education', 'Evolution of Schooling' ,'College Reading and Study Skills', 'Teaching Language Arts', 'Other Worlds', 'Humans and the Environment', 'Introduction to Archaeology', 'Artifacts and Culture'};
        List<Topic__c> topicsToInsert = new List<Topic__c>();

        topicsToInsert.add(new Topic__c(Name=topicNames[0], Degree__c=degreeNameToId.get('General Mathematics')));
        topicsToInsert.add(new Topic__c(Name=topicNames[1], Degree__c=degreeNameToId.get('General Mathematics')));
        topicsToInsert.add(new Topic__c(Name=topicNames[2], Degree__c=degreeNameToId.get('Applied Statistics')));
        topicsToInsert.add(new Topic__c(Name=topicNames[3], Degree__c=degreeNameToId.get('Applied Statistics')));
        topicsToInsert.add(new Topic__c(Name=topicNames[4], Degree__c=degreeNameToId.get('Biology')));
        topicsToInsert.add(new Topic__c(Name=topicNames[5], Degree__c=degreeNameToId.get('Biology')));
        topicsToInsert.add(new Topic__c(Name=topicNames[6], Degree__c=degreeNameToId.get('Chemistry')));
        topicsToInsert.add(new Topic__c(Name=topicNames[7], Degree__c=degreeNameToId.get('Chemistry')));
        topicsToInsert.add(new Topic__c(Name=topicNames[8], Degree__c=degreeNameToId.get('Education')));
        topicsToInsert.add(new Topic__c(Name=topicNames[9], Degree__c=degreeNameToId.get('Education')));
        topicsToInsert.add(new Topic__c(Name=topicNames[10], Degree__c=degreeNameToId.get('Educational Reading')));
        topicsToInsert.add(new Topic__c(Name=topicNames[11], Degree__c=degreeNameToId.get('Educational Reading')));
        topicsToInsert.add(new Topic__c(Name=topicNames[12], Degree__c=degreeNameToId.get('Geology')));
        topicsToInsert.add(new Topic__c(Name=topicNames[13], Degree__c=degreeNameToId.get('Geology')));
        topicsToInsert.add(new Topic__c(Name=topicNames[14], Degree__c=degreeNameToId.get('Anthropology')));
        topicsToInsert.add(new Topic__c(Name=topicNames[15], Degree__c=degreeNameToId.get('Anthropology')));
        
        insert topicsToInsert;
    }

    private static void createEmployees() {
        List<String> employeeNames = new List<String> {'Mark Jackson', 'Pete Maravich', 'Serena Williams', 'Megan Rapinoe', 'Jesse Gillis', 'Phillip Mack', 'Janet Williams', 'Mike Jones'};
        List<Employee__c> employeesToInsert = new List<Employee__c>();

        List<Department__c> departments = [SELECT Id, Name FROM Department__c];
        Map<String, Id> departmentNameToId = new Map<String, Id>();
        for (Department__c dept: departments) {
            departmentNameToId.put(dept.Name, dept.Id);
        }

        employeesToInsert.add(new Employee__c(Name=employeeNames[0], Department__c=departmentNameToId.get('Math')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[1], Department__c=departmentNameToId.get('Math')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[2], Department__c=departmentNameToId.get('Science')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[3], Department__c=departmentNameToId.get('Science')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[4], Department__c=departmentNameToId.get('Education')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[5], Department__c=departmentNameToId.get('Education')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[6], Department__c=departmentNameToId.get('History')));
        employeesToInsert.add(new Employee__c(Name=employeeNames[6], Department__c=departmentNameToId.get('History')));
    
        insert employeesToInsert;
    }

    private static void createStudents() {
        List<Employee__c> advisors = [SELECT Id FROM Employee__c];
        List<Student__c> studentsToInsert = new List<Student__c>();
        
        studentsToInsert.add(new Student__c(Name='Mike Williams',PhoneNumber__c='0000000000',Age__c=18,Email__c='mwilliams@gmail.com',Status__c='Prospect',Advisor__c=advisors[0].Id));
        studentsToInsert.add(new Student__c(Name='Pete Jacobs',PhoneNumber__c='0000000000',Age__c=28,Email__c='pjacobs@gmail.com',Status__c='Prospect',Advisor__c=advisors[0].Id));
        studentsToInsert.add(new Student__c(Name='Carly Jones',PhoneNumber__c='0000000000',Age__c=22,Email__c='cjones@gmail.com',Status__c='Prospect',Advisor__c=advisors[1].Id));
        studentsToInsert.add(new Student__c(Name='Andy Young',PhoneNumber__c='0000000000',Age__c=35,Email__c='ayoung@gmail.com',Status__c='Prospect',Advisor__c=advisors[1].Id));
        studentsToInsert.add(new Student__c(Name='Janice Keenan',PhoneNumber__c='0000000000',Age__c=24,Email__c='jkeenan@gmail.com',Status__c='Prospect',Advisor__c=advisors[2].Id));
        studentsToInsert.add(new Student__c(Name='Bill Brunson',PhoneNumber__c='0000000000',Age__c=19,Email__c='bbrunson@gmail.com',Status__c='Prospect',Advisor__c=advisors[2].Id));
        studentsToInsert.add(new Student__c(Name='Jake Pitsel',PhoneNumber__c='0000000000',Age__c=18,Email__c='jpitsel@gmail.com',Status__c='Prospect',Advisor__c=advisors[3].Id));
        studentsToInsert.add(new Student__c(Name='Susan Jetse',PhoneNumber__c='0000000000',Age__c=31,Email__c='sjetse@gmail.com',Status__c='Prospect',Advisor__c=advisors[3].Id));
        studentsToInsert.add(new Student__c(Name='Joe McFlusters',PhoneNumber__c='0000000000',Age__c=22,Email__c='jmcflusters@gmail.com',Status__c='Prospect',Advisor__c=advisors[4].Id));
        studentsToInsert.add(new Student__c(Name='Alec Baldwin',PhoneNumber__c='0000000000',Age__c=26,Email__c='abaldwin@gmail.com',Status__c='Prospect',Advisor__c=advisors[4].Id));
        studentsToInsert.add(new Student__c(Name='Bill Russell',PhoneNumber__c='0000000000',Age__c=45,Email__c='brussell@gmail.com',Status__c='Prospect',Advisor__c=advisors[5].Id));
        studentsToInsert.add(new Student__c(Name='Joe Rogan',PhoneNumber__c='0000000000',Age__c=35,Email__c='jrogan@gmail.com',Status__c='Prospect',Advisor__c=advisors[5].Id));
        studentsToInsert.add(new Student__c(Name='Oprah Winfrey',PhoneNumber__c='0000000000',Age__c=27,Email__c='owinfrey@gmail.com',Status__c='Prospect',Advisor__c=advisors[6].Id));
        studentsToInsert.add(new Student__c(Name='Randy Moss',PhoneNumber__c='0000000000',Age__c=22,Email__c='rmoss@gmail.com',Status__c='Prospect',Advisor__c=advisors[6].Id));
        studentsToInsert.add(new Student__c(Name='Allen Iverson',PhoneNumber__c='0000000000',Age__c=25,Email__c='ai@gmail.com',Status__c='Prospect',Advisor__c=advisors[7].Id));
        studentsToInsert.add(new Student__c(Name='Lebron James',PhoneNumber__c='0000000000',Age__c=21,Email__c='goat@gmail.com',Status__c='Prospect',Advisor__c=advisors[7].Id));
        studentsToInsert.add(new Student__c(Name='Jenny Peterson',PhoneNumber__c='0000000000',Age__c=29,Email__c='jpeterson@gmail.com',Status__c='Prospect',Advisor__c=advisors[7].Id));
        studentsToInsert.add(new Student__c(Name='Peter Jetson',PhoneNumber__c='0000000000',Age__c=31,Email__c='pjetson@gmail.com',Status__c='Prospect',Advisor__c=advisors[7].Id));
        studentsToInsert.add(new Student__c(Name='Greg Maddox',PhoneNumber__c='0000000000',Age__c=27,Email__c='gmaddox@gmail.com',Status__c='Prospect',Advisor__c=advisors[7].Id));
        
        insert studentsToInsert; 
    }

    private static void createMajors() {
        List<Major__c> majorsToInsert = new List<Major__c>();
        List<Degree__c> degrees = [SELECT Id FROM Degree__c];
        List<Student__c> students = [SELECT Id FROM Student__c];
        // {'Mathematics', 'Applied Statistics', 'Biology', 'Chemistry', 'Education', 'Educational Reading', 'Geology', 'Anthropology'};
        majorsToInsert.add(new Major__c(Degree__c=degrees[0].Id,Student__c=students[0].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[0].Id,Student__c=students[1].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[1].Id,Student__c=students[2].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[1].Id,Student__c=students[3].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[2].Id,Student__c=students[4].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[2].Id,Student__c=students[5].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[3].Id,Student__c=students[6].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[3].Id,Student__c=students[7].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[4].Id,Student__c=students[8].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[4].Id,Student__c=students[9].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[5].Id,Student__c=students[10].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[5].Id,Student__c=students[11].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[6].Id,Student__c=students[12].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[6].Id,Student__c=students[13].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[7].Id,Student__c=students[14].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[7].Id,Student__c=students[15].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[1].Id,Student__c=students[16].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[2].Id,Student__c=students[17].Id));
        majorsToInsert.add(new Major__c(Degree__c=degrees[3].Id,Student__c=students[18].Id));

        insert majorsToInsert;
    }
    
    private static void createClasses() {
        List<Class__c> classesToInsert = new List<Class__c>();
        List<Department__c> departments = [SELECT Id, Name FROM Department__c];
        Map<String, Id> departmentNameToId = new Map<String, Id>();
        for (Department__c dept: departments) {
            departmentNameToId.put(dept.Name, dept.Id);
        }

        List<Room__c> rooms = [SELECT Id FROM Room__c];
        List<Topic__c> topics = [SELECT Id, Name FROM Topic__c];
                                                                                                                                                                                                                                                
        Map<String, Id> topicNamesToId = new Map<String, Id>();
        for (Topic__c topic : topics) {
            topicNamesToId.put(topic.Name, topic.Id);
        }
        
        classesToInsert.add(new Class__c(Name='MAT100',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Math'),StartDate__c=(Date.newInstance(2019, 8, 12)),EndDate__c=(Date.newInstance(2019, 12, 15)),Room__c=rooms[0].Id,ScheduledTime__c=(Time.newInstance(9,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Algebra')));
        classesToInsert.add(new Class__c(Name='MAT150',Capacity__c=10,DaysPerWeek__c=1,Department__c=departmentNameToId.get('Math'),StartDate__c=(Date.newInstance(2019, 8, 12)),EndDate__c=(Date.newInstance(2019, 12, 15)),Room__c=rooms[1].Id,ScheduledTime__c=(Time.newInstance(9,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Pre-Calculus')));
        classesToInsert.add(new Class__c(Name='MAT175',Capacity__c=10,DaysPerWeek__c=1,Department__c=departmentNameToId.get('Math'),StartDate__c=(Date.newInstance(2020, 1, 5)),EndDate__c=(Date.newInstance(2020, 5, 4)),Room__c=rooms[2].Id,ScheduledTime__c=(Time.newInstance(8,0,0,0)),Status__c='Confirmed',Topic__c=topicNamesToId.get('Probability')));
        classesToInsert.add(new Class__c(Name='MAT200',Capacity__c=10,DaysPerWeek__c=3,Department__c=departmentNameToId.get('Math'),StartDate__c=(Date.newInstance(2020, 1, 5)),EndDate__c=(Date.newInstance(2020, 5, 4)),Room__c=rooms[2].Id,ScheduledTime__c=(Time.newInstance(11,15,0,0)),Status__c='Confirmed',Topic__c=topicNamesToId.get('Sport Analytics')));
        classesToInsert.add(new Class__c(Name='BIO100',Capacity__c=10,DaysPerWeek__c=1,Department__c=departmentNameToId.get('Science'),StartDate__c=(Date.newInstance(2020, 1, 15)),EndDate__c=(Date.newInstance(2020, 5, 14)),Room__c=rooms[3].Id,ScheduledTime__c=(Time.newInstance(8,0,0,0)),Status__c='Confirmed',Topic__c=topicNamesToId.get('General Biology')));
        classesToInsert.add(new Class__c(Name='BIO200',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Science'),StartDate__c=(Date.newInstance(2020, 1, 15)),EndDate__c=(Date.newInstance(2020, 5, 14)),Room__c=rooms[4].Id,ScheduledTime__c=(Time.newInstance(7,0,0,0)),Status__c='Confirmed',Topic__c=topicNamesToId.get('Genetics')));
        classesToInsert.add(new Class__c(Name='CHE200',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Science'),StartDate__c=(Date.newInstance(2020, 1, 15)),EndDate__c=(Date.newInstance(2020, 5, 14)),Room__c=rooms[4].Id,ScheduledTime__c=(Time.newInstance(8,30,0,0)),Status__c='Confirmed',Topic__c=topicNamesToId.get('Concepts of Chemistry')));
        classesToInsert.add(new Class__c(Name='CHE250',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Science'),StartDate__c=(Date.newInstance(2020, 1, 11)),EndDate__c=(Date.newInstance(2020, 5, 10)),Room__c=rooms[5].Id,ScheduledTime__c=(Time.newInstance(13,0,0,0)),Status__c='Confirmed',Topic__c=topicNamesToId.get('Chemistry of Beer')));
        classesToInsert.add(new Class__c(Name='EDU200',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Education'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[6].Id,ScheduledTime__c=(Time.newInstance(15,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Democracy and Education')));
        classesToInsert.add(new Class__c(Name='EDU350',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Education'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[7].Id,ScheduledTime__c=(Time.newInstance(15,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Evolution of Schooling')));
        classesToInsert.add(new Class__c(Name='EDU220',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Education'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[8].Id,ScheduledTime__c=(Time.newInstance(9,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('College Reading and Study Skills')));
        classesToInsert.add(new Class__c(Name='EDU300',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('Education'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[8].Id,ScheduledTime__c=(Time.newInstance(15,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Teaching Language Arts')));
        classesToInsert.add(new Class__c(Name='HIS200',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('History'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[8].Id,ScheduledTime__c=(Time.newInstance(15,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Other Worlds')));
        classesToInsert.add(new Class__c(Name='HIS300',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('History'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[9].Id,ScheduledTime__c=(Time.newInstance(11,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Humans and the Environment')));
        classesToInsert.add(new Class__c(Name='HIS350',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('History'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[2].Id,ScheduledTime__c=(Time.newInstance(9,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Introduction to Archaeology')));
        classesToInsert.add(new Class__c(Name='HIS400',Capacity__c=10,DaysPerWeek__c=2,Department__c=departmentNameToId.get('History'),StartDate__c=(Date.newInstance(2019, 9, 12)),EndDate__c=(Date.newInstance(2019, 12, 10)),Room__c=rooms[1].Id,ScheduledTime__c=(Time.newInstance(8,0,0,0)),Status__c='In Progress',Topic__c=topicNamesToId.get('Artifacts and Culture')));
        
        insert classesToInsert;
    }
    
    private static void createClassEnrollments() {
        List<Student__c> students = [SELECT Id, Status__c FROM Student__c];
        List<Class__c> classes = [SELECT Id FROM Class__c];
        
        List<ClassEnrollment__c> classEnrollmentsToInsert = new List<ClassEnrollment__c>();
        
        for (Class__c c: classes) {
            for (Student__c student: students) {
                if (student.Status__c == 'Enrolled') {
                    classEnrollmentsToInsert.add(new ClassEnrollment__c(Student__c=student.Id,Class__c=c.Id));
                }
            }	
        }
        
        insert classEnrollmentsToInsert;
    }

    private static void createAssessments() {
        List<Class__c> classes = [SELECT Id, ScheduledTime__c, Room__c, StartDate__c FROM Class__c];
        List<Assessment__c> assessmentsToInsert = new List<Assessment__c>();

        Schema.DescribeSObjectResult assessmentInfo = Assessment__c.SObjectType.getDescribe();
        List<Schema.RecordTypeInfo> assessmentRecordTypeInfos = assessmentInfo.getRecordTypeInfos();

        for(Schema.RecordTypeInfo recordTypeInfo: assessmentRecordTypeInfos) {
            if (recordTypeInfo.getDeveloperName() != 'Master') {
                for (Class__c c: classes) {
                    assessmentsToInsert.add(new Assessment__c(RecordTypeId=recordTypeInfo.getRecordTypeId(),
                                                              Name=(recordTypeInfo.getDeveloperName()),
                                                              Class__c=c.Id,
                                                              Time__c=c.ScheduledTime__c,
                                                              Room__c=c.Room__c,
                                                              Graded__c=false,
                                                              Date__c=c.StartDate__c));
                }
            }
        }
        
        insert assessmentsToInsert;
    }
    
    // private static void createGrades() {
    //     List<Class__c> classes = [SELECT Id FROM Class__c];
        
    //     List<Class_Enrollment__c> classEnrollments = [SELECT Id, Class__c FROM Class_Enrollment__c];
        
    //     List<Assessment__c> assessments = [SELECT Id, Class__c FROM Assessment__c];
    //     List<Grade__c> gradesToInsert = new List<Grade__c>();
        
    //     Integer countClassEnrollments = 0;
        
    //     for (Assessment__c assessment: assessments) {
    //         for (Class__c c: classes) {
    //             if (assessment.Class__c == c.Id) {
    //                 for (Class_Enrollment__c ce: classEnrollments) {
    //                     if (ce.Class__c == assessment.Class__c) {
    //                         countClassEnrollments++;
    //                         gradesToInsert.add(new Grade__c(Assessment__c=assessment.Id,
    //                                                         ClassEnrollment__c=ce.Id,
    //                                                         Grade__c=getRandomNumber()));
    //                     }
    //                 }
    //             }
    //         }
    //     }
    //     insert gradesToInsert;
    // }
    
    private static double getRandomNumber() {
        Double randomNumber = Math.random();
        while (randomNumber < 0.5) {
            randomNumber = Math.random();
        }
        
        return randomNumber * 100;
    }    
}