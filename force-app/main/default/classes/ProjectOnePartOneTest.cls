@istest
public with sharing class ProjectOnePartOneTest {
    
    @istest static void fibonacciTest(){
        System.assertEquals(3, ProjectOnePartOne.fibonacci(4), 'Value is wrong');
        System.assertEquals(5, ProjectOnePartOne.fibonacci(5), 'Value is wrong');
    }

    @istest static void reverseStringTest(){
        System.assertEquals('god', ProjectOnePartOne.reverseString('dog'), 'method didnt reverse');
        System.assertEquals('now', ProjectOnePartOne.reverseString('won'), 'method didnt reverse');
    }

    @istest static void factorialTest(){
        System.assertEquals(1, ProjectOnePartOne.factorial(1), 'factorial didnt factorize');
        System.assertEquals(2, ProjectOnePartOne.factorial(2), 'factorial didnt factorize');
        System.assertEquals(6, ProjectOnePartOne.factorial(3), 'factorial didnt factorize');
        System.assertEquals(120, ProjectOnePartOne.factorial(5), 'factorial didnt factorize');
    }
    
    @istest static void isPalindromeTest(){
        System.assertEquals(false, ProjectOnePartOne.isPalindrome('dog'), 'palindrome false positive');
        System.assertEquals(true, ProjectOnePartOne.isPalindrome('mom'), 'palindrome false negative');
    }

    @istest static void getAccountsForAGivenStateTest(){
        //case for no matching state
        Account a1 = new Account();
        a1.Name = 'Stateless inc';
        a1.BillingState = 'MD';
        insert a1;
        System.assertEquals(0,ProjectOnePartOne.getAccountsForAGivenState(State.VA).size(), 'false positive for account');
        //case for matching state for accounts but not contacts
        Contact c1 = new Contact();
        c1.LastName = 'Beck';
        c1.MailingState = 'VA';
        c1.AccountId = a1.Id;
        insert c1;
        System.assertEquals(0, ProjectOnePartOne.getAccountsForAGivenState(State.MD).size(), 'false positive for matching account + unmatching contact');
        //case for matching state for contacts but not not accounts
        System.assertEquals(0, ProjectOnePartOne.getAccountsForAGivenState(State.VA).size(), 'false positive for unmatching account + matching contact');
        //case for matching state for accounts + SOME contacts
        Contact c2 = new Contact();
        c2.LastName = 'Jith';
        c2.MailingState = 'MD';
        c2.AccountId = a1.Id;
        insert c2;
        System.assertEquals(1, ProjectOnePartOne.getAccountsForAGivenState(State.MD).size(), 'false negative for matching account + SOME matching contacts');
        //case for matching state for accounts + ALL contacts
        c1.MailingState = 'MD';
        update c1;
        System.assertEquals(1, ProjectOnePartOne.getAccountsForAGivenState(State.MD).size(), 'false negative for matching account + ALL matching contacts');
    }

    @istest static void getClassGradesTest(){
        //test for students but nothing else
        SchoolDataCreator.createData();
        System.assertEquals(0, ProjectOnePartOne.getClassGrades().size(), 'False positive for just students');
        //test for  class enrollments but nothing else
        Student__c studentMikeW = [SELECT Id FROM Student__c WHERE Name = 'Mike Williams'][0];
        Class__C classMath = [SELECT Id, ScheduledTime__c, Room__c, StartDate__c FROM Class__c WHERE Name = 'MAT100'][0];
        ClassEnrollment__C ceMikeInMath = new ClassEnrollment__c(Student__c=studentMikeW.Id, Class__c=classMath.Id);
        insert ceMikeInMath;
        System.assertEquals(0, ProjectOnePartOne.getClassGrades().size(), 'False positive for just Class Enrollments');
        //test for one student with 1 grade in one class
        Id quizTypeId = Schema.SObjectType.Assesment__c.getRecordTypeInfosByName().get('Quiz').getRecordTypeId();
        Assesment__c mathQuizOne = new Assessment__c(RecordTypeId = quizTypeId,
                                            Name = ('Math Quiz One'),
                                            Class__c = classMath.Id,
                                            Time__c = classMath.ScheduledTime__c,
                                            Room__c = classMath.Room__c,
                                            Graded__c = true,
                                            Date__c = classMath.StartDate__c));
        insert mathQuizOne;
        Grade__c gradeMikeMathOne = new Grade__c(Assessment__c = mathQuizOne.Id, ClassEnrollment__c = ceMikeInMath.Id, 50.00);
        insert gradeMikeMathOne;

        System.assertEquals(1, ProjectOnePartOne.getClassGrades().size(), 'Did not detect the class that had one grade in it');
        //test to make sure the average for one class can be calculated
        Assesment__c mathQuizTwo = new Assessment__c(RecordTypeId = quizTypeId,
                                            Name = ('Math Quiz Two'),
                                            Class__c = classMath.Id,
                                            Time__c = classMath.ScheduledTime__c,
                                            Room__c = classMath.Room__c,
                                            Graded__c = true,
                                            Date__c = classMath.StartDate__c));
        insert mathQuizTwo;
        Grade__c gradeMikeMathTwo = new Grade__c(Assessment__c = mathQuizTwo.Id, ClassEnrollment__c = ceMikeInMath.Id, 75.00);
        insert gradeMikeMathTwo;
        Assesment__c mathQuizThree = new Assessment__c(RecordTypeId = quizTypeId,
                                            Name = ('Math Quiz Three'),
                                            Class__c = classMath.Id,
                                            Time__c = classMath.ScheduledTime__c,
                                            Room__c = classMath.Room__c,
                                            Graded__c = true,
                                            Date__c = classMath.StartDate__c));
        insert mathQuizThree;
        Grade__c gradeMikeMathThree = new Grade__c(Assessment__c = mathQuizThree.Id, ClassEnrollment__c = ceMikeInMath.Id, 100.00);
        insert gradeMikeMathThree;
        System.assertEquals(75.00, ProjectOnePartOne.getClassGrades().get(studentMikeW.Id).get(classMath.Id), 'Average Function did not function');
        
        //test for 1 student with multiple class enrollments, but grades only in one
        Class__C classBiology = [SELECT Id, ScheduledTime__c, Room__c, StartDate__c FROM Class__c WHERE Name = 'BIO100'][0];
        ClassEnrollment__C ceMikeInBio = new ClassEnrollment__c(Student__c = studentMikeW.Id, Class__c = classBiology.Id);
        insert ceMikeInBio;
        System.assertEquals(1, ProjectOnePartOne.getClassGrades().get(studentMikeW).size(), 'False Positive for multiple classes for one student when only 1 has grades');
        
        //test for 1 student with multiple classes with grades
        Assesment__c bioQuizOne = new Assessment__c(RecordTypeId = quizTypeId,
                                            Name = ('Biology Quiz One'),
                                            Class__c = classBiology.Id,
                                            Time__c = classBiology.ScheduledTime__c,
                                            Room__c = classBiology.Room__c,
                                            Graded__c = true,
                                            Date__c = classBiology.StartDate__c));
        insert bioQuizOne;
        Grade__c gradeMikeBioOne = new Grade__c(Assessment__c = bioQuizOne.Id, ClassEnrollment__c = ceMikeInBio.Id, 100.00);
        insert gradeMikeBioOne;
        //using a variable means we wont have to call the method every time
        Map<Id, Map<Id, Double>> testMap = ProjectOnePartOne.getClassGrades();
        //using this variable cuts down on the editing when copying/pasting
        String scenario = '1 student with multiple classes with grades'
        System.assertEquals(2, testMap.get(studentMikeW.Id).size(), 'All classes for 1 student not being recognized in the presence of' + scenario);
        System.assertEquals(75.00, testMap.get(studentMikeW.Id).get(classMath.Id), 'Average Function did not function in the presence of ' + scenario);
        System.assertEquals(100.00, testMap.get(studentMikeW.Id).get(classBiology.Id), 'Average Function did not clear Properly in the presence of' + scenario);

        //test for multiple enrollments for multiple students, only one student has grades, students do not share any classes
        Student studentPeteJ = [SELECT Id FROM Student__c WHERE Name = 'Pete Jacobs'][0];
        Class__C classChemistry = [SELECT Id, ScheduledTime__c, Room__c, StartDate__c FROM Class__c WHERE Name = 'CHE200'][0];
        ClassEnrollment__C cePeteInChem = new ClassEnrollment__c(Student__c=studentPeteJ.Id, Class__c=classChemistry.Id);
        insert cePeteInChem;
        System.assertEquals(1, ProjectOnePartOne.getClassGrades().size(), 'false positive for a student with grades and a student with class enrollment but no grades');

        //test for multiple students with multiple classes with multiple grades, none share any classes, also that grades can accept a zero value
        Assessment__c chemQuizOne = createAssessment('Chemistry Quiz One', classChemistry, quizTypeId);
        insert chemQuizOne;
        Grade__c gradePeteChemOne = new Grade__c(Assessment__c = chemQuizOne.Id, ClassEnrollment__c = cePeteInChem.Id, 0.00);
        insert gradePeteChemOne;
        testMap = ProjectOnePartOne.getClassGrades();
        scenario = 'multiple students with grades, one of which was zero, no overlapping classes';
        System.assertEquals(2, testMap.size(), 'did not show ' + scenario);
        System.assertEquals(2, testMap.get(studentMikeW.Id).size(), 'All classes for 1 student not being recognized when there are ' + scenario);
        System.assertEquals(1, testMap.get(studentPeteJ.Id).size(), 'Class for 1 student not being recognized when there are ' + scenario);
        System.assertEquals(75.00, testMap.get(studentMikeW.Id).get(classMath.Id), 'Average Function did not function in the presence of ' + scenario);
        System.assertEquals(100.00, testMap.get(studentMikeW.Id).get(classBiology.Id), 'Average Function did not clear Properly in the presence of ' + scenario);
        System.assertEquals(0.00, testMap.get(studentPeteJ.Id).get(classChemistry.Id), 'Average Function did function properly with multiple students, one of which has a grade of 0.0');

        //test for multiple students with multiple classes with multiple grades, none share any classes
        Assessment__c chemQuizTwo = createAssessment('Chemistry Quiz Two', classChemistry, quizTypeId);
        insert chemQuizTwo;
        Grade__c gradePeteChemTwo = new Grade__c(Assessment__c = chemQuizTwo.Id, ClassEnrollment__c = cePeteInChem.Id, 100.00);
        insert gradePeteChemTwo;
        testMap = ProjectOnePartOne.getClassGrades();
        scenario = 'multiple students with multiple classes with multiple grades, none share any classes';
        System.assertEquals(2, testMap.size(), 'did not show ' + scenario);
        System.assertEquals(2, testMap.get(studentMikeW.Id).size(), 'All classes for 1 student not being recognized when there are ' + scenario);
        System.assertEquals(1, testMap.get(studentPeteJ.Id).size(), 'class for 1 student not being recognized when there are ' + scenario);
        System.assertEquals(75.00, testMap.get(studentMikeW.Id).get(classMath.Id), 'Average Function did not function in the presence of ' + scenario);
        System.assertEquals(100.00, testMap.get(studentMikeW.Id).get(classBiology.Id), 'Average Function did not clear Properly in the presence of ' + scenario);
        System.assertEquals(50.00, testMap.get(studentPeteJ.Id).get(classChemistry.Id), 'Average Function did function properly with multiple students, one of which has a grade of 0.0');

        //test for multiple students with at least 2 classes with multiple grades, one class is shared
        ClassEnrollment__c cePeteInBio = new ClassEnrollment__c(Student__c = studentPeteJ.Id, Class__c = classBiology.Id);
        insert cePeteInBio;
        Grade__c gradePeteBioOne = new Grade__c((Assessment__c = bioQuizOne.Id, ClassEnrollment__c = cePeteInBio.Id, 85.00);
        insert gradePeteBioOne;
        testMap = ProjectOnePartOne.getClassGrades();
        scenario = 'multiple students with multiple classes with multiple grades, none share any classes';
        System.assertEquals(2, testMap.size(), 'did not show ' + scenario);
        System.assertEquals(2, testMap.get(studentMikeW.Id).size(), 'All classes for 1 student not being recognized when there are ' + scenario);
        System.assertEquals(2, testMap.get(studentPeteJ.Id).size(), 'All classes for 1 student not being recognized when there are ' + scenario);
        System.assertEquals(75.00, testMap.get(studentMikeW.Id).get(classMath.Id), 'Average Function did not function in the presence of ' + scenario);
        System.assertEquals(100.00, testMap.get(studentMikeW.Id).get(classBiology.Id), 'Average Function did not clear Properly in the presence of ' + scenario);
        System.assertEquals(50.00, testMap.get(studentPeteJ.Id).get(classChemistry.Id), 'Average Function did function properly with multiple students, one of which has a grade of 0.0');
        System.assertEquals(50.00, testMap.get(studentPeteJ.Id).get(classBiology.Id), 'Average Function did function properly with multiple students, one of which has a grade of 0.0');
    }

    static Assessment__c createAssessment(String assessmentName, Class__c assessmentClass, Id assessmentType){
        Assesment__c createdAssesssment = new Assessment__c(RecordTypeId = type,
                                            Name = assessmentName,
                                            Class__c = assessmentClass.Id,
                                            Time__c = assessmentClass.ScheduledTime__c,
                                            Room__c = assessmentClass.Room__c,
                                            Graded__c = true,
                                            Date__c = assessmentClass.StartDate__c));
        return createdAssesssment;
    }



}


