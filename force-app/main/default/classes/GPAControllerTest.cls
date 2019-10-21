@isTest()
public with sharing class GPAControllerTest {
    @TestSetup
    static void setup(){
        SchoolDataCreator.createData();
    }

    @isTest static void testMultiplier(){
        //test values for people who got As or even got more than 100% in the class
        Double testValue = 101.00;
        Double compareValue = 1.00;
        for(Integer i = 0; i < 11; i++){
             System.assertEquals(compareValue, GPAController.getMultiplier(testValue), 'system isnt giving the proper value for As');
             testValue -= 1.0;
        }
        //its important to show that even losing 0.10 will cause a grade to drop if its at the cusp
        testValue -= 0.10;
        compareValue = 0.75;
        System.assertEquals(compareValue, GPAController.getMultiplier(testValue), 'system isnt giving the proper value for Bs');
        for(Integer i = 0; i < 10; i++){
             System.assertEquals(compareValue, GPAController.getMultiplier(testValue), 'system isnt giving the proper value for Bs');
             testValue -= 1.0;
        }
        //test for cs
        compareValue = 0.50;
        for(Integer i = 0; i < 10; i++){
             System.assertEquals(compareValue, GPAController.getMultiplier(testValue), 'system isnt giving the proper value for Cs');
             testValue -= 1.0;
        }
        //test for ds
        compareValue = 0.25;
        for(Integer i = 0; i < 10; i++){
             System.assertEquals(compareValue, GPAController.getMultiplier(testValue), 'system isnt giving the proper value for Ds');
             testValue -= 1.0;
        }
        //test for 0 credit
        compareValue = 0.00;
        System.assertEquals(compareValue, GPAController.getMultiplier(testValue), 'system isnt giving the proper value for nothing');
    }

    //makes sure that the process fails for students that shouldnt have a GPA
    @isTest static void testNonValidStudents(){
         /*
          test for a non Existent student, we can accomplish this by using a soql query to populate
          (or rather, not populate) a list, taking the size of that list, running the gpa and calling the 
          same query to ensure that the student remains non-existant
         */
         Id fakeID = SpecificDataCreator.getClass('MAT100').Id;
         List<Student__c> lookForFakeStudent = [SELECT Id FROM Student__c WHERE Id = :fakeID];
         Integer firstsizePass = lookForFakeStudent.size();
         GPAController.calculateGPA(fakeID);
         lookForFakeStudent = [SELECT Id FROM Student__c WHERE Id = :fakeID];
         System.assertEquals(firstSizePass, lookForFakeStudent.size(), 'failed non - existent test');
         
         /*
          test for prospect and denied students, we can set some students to denied/prospect, change their 
          status, set them with a fake GPA, call the update GPA and see if anything changes
         */
         Student__c tempStudent = SpecificDataCreator.getStudent('Mike Williams');
         tempStudent.Status__c = 'Prospect';
         tempStudent.CumulativeGPA__c = 2.0;
         update tempStudent;
         GPAController.calculateGPA(tempStudent.Id);
         System.assertNotEquals(4.0, tempStudent.CumulativeGPA__c, 'System is updating prospect student`s GPAs');
         //we can reuse the same student
         tempStudent.Status__c = 'Denied';
         update tempStudent;
         GPAController.calculateGPA(tempStudent.Id);
         System.assertNotEquals(4.0, tempStudent.CumulativeGPA__c, 'System is updating denied student`s GPAs');
    }

    //tests situations that mostly result in an automatic 4.0, and when that automatic 4.0 shouldn't occur
     @isTest static void testPerfectAssignmet(){
          //student has just been accepted but has yet to try for classes, we need to ensure it doesnt start as a 4.0 so that we can see that a change has occured
          Student__c testStudent = SpecificDataCreator.getStudent('Pete Jacobs');
          testStudent.Status__c = 'Enrolled';
          //we could also use the getClassGradePoints() mathod as we already know he will pass the criteria, but first we first need to ensure it will update the record
          testStudent.CumulativeGPA__c = 2.0;
          update testStudent;
          GPAController.calculateGPA(testStudent.Id);
          testStudent = SpecificDataCreator.getStudent('Pete Jacobs');
          System.assertEquals(4.0, testStudent.CumulativeGPA__c, 'System is failing to update just enrolled students');

          //test for a class with no assignments that a student wants to enroll in, and now we use the getClassGradePoints() method, because we know inertion is a success
          Class__c classAdvBio = SpecificDataCreator.getClass('BIO200');
          ClassEnrollment__c testInAdvBio = SpecificDataCreator.createEnrollment(3.00, 'Pending', testStudent, classAdvBio);
          insert testInAdvBio;
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students that are trying to enroll in a class with no assignments a 4.0');

          //test for a class with assignments that a student wants to enroll in
          Assessment__c quizOneAdvBio = SpecificDataCreator.createAssessment('Biology 200 Quiz One', classAdvBio, 'Quiz');
          insert quizOneAdvBio;
          Assessment__c quizTwoAdvBio = SpecificDataCreator.createAssessment('Biology 200 Quiz Two', classAdvBio, 'Quiz');
          insert quizTwoAdvBio;
          Assessment__c quizThreeAdvBio = SpecificDataCreator.createAssessment('Biology 200 Quiz Three', classAdvBio, 'Quiz');
          insert quizThreeAdvBio;
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students that are trying to enroll in a class with assignments a 4.0');

          //test for a class with (accidentally, maybe the enterer got the student confused with Mark Peter) graded assignments that a studen wants to enroll in
          insert SpecificDataCreator.createGrade(quizOneAdvBio, testInAdvBio, 75.00);
          insert SpecificDataCreator.createGrade(quizTwoAdvBio, testInAdvBio, 50.00);
          insert SpecificDataCreator.createGrade(quizThreeAdvBio, testInAdvBio, 100.00);
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students that are trying to enroll in a class with grades a 4.0');

          //test that the same process works even when students are denied and he would be denied because he deosnt have the prerequisite
          testInAdvBio.Status__c = 'Denied';
          update testInAdvBio;
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students that are denied enrollment in a class with grades a 4.0');

          //tests how the system reacts to multiple non enrolled classes
          Class__c classBio = SpecificDataCreator.getClass('BIO100');
          ClassEnrollment__c testInBio = SpecificDataCreator.createEnrollment(4.00, 'Pending', testStudent, classBio);
          insert testInBio;
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students with multiple invalid enrollments a 4.0');

          //tests how the system reacts to students with valid enrollments, but no assessments
          testInBio.Status__c = 'Enrolled';
          update testInBio;
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students with one invalid and one valid (but without assessments) enrollments a 4.0');

          //tests how the system reacts to students with valid enrollments, but no grades
          Assessment__c quizOneBio = SpecificDataCreator.createAssessment('Biology 100 Quiz One', classBio, 'Quiz');
          insert quizOneBio;
          Assessment__c quizTwoBio = SpecificDataCreator.createAssessment('Biology 100 Quiz Two', classBio, 'Quiz');
          insert quizTwoBio;
          Assessment__c quizThreeBio = SpecificDataCreator.createAssessment('Biology 100 Quiz Three', classBio, 'Quiz');
          insert quizThreeBio;
          System.assertEquals(4.0, GPAController.getClassGradePoints(testStudent.Id), 'System is not giving students with one invalid and one valid (but ungraded) enrollments a 4.0');

          //Makes sure that once the student actually has enrollments with grades that the system disregards their invalid classes
          insert SpecificDataCreator.createGrade(quizOneBio, testInBio, 75.00);
          insert SpecificDataCreator.createGrade(quizTwoBio, testInBio, 50.00);
          insert SpecificDataCreator.createGrade(quizThreeBio, testInBio, 100.00);
          System.assertEquals(2.0, GPAController.getClassGradePoints(testStudent.Id), 'System is erroneously considering invalid classes in it`s calculations');

     }

     //tests the math behind the calculation
     @isTest static void testCalculation(){
          //tests partial completion (not all assignments graded) of one class
          Student__c testStudent = SpecificDataCreator.getStudent('Bill Brunson');
          testStudent.Status__c = 'Enrolled';
          Class__c classMath = SpecificDataCreator.getClass('MAT100');
          ClassEnrollment__c testInMath = SpecificDataCreator.createEnrollment(4.00, 'Enrolled', testStudent, classMath);
          insert testInMath;

           Assessment__c quizOneMath = SpecificDataCreator.createAssessment('Math 100 Quiz One', classMath, 'Quiz');
          insert quizOneMath;
          Assessment__c quizTwoMath = SpecificDataCreator.createAssessment('Math 100 Quiz Two', classMath, 'Quiz');
          insert quizTwoMath;
          Assessment__c quizThreeMath = SpecificDataCreator.createAssessment('Math 100 Quiz Three', classMath, 'Quiz');
          insert quizThreeMath;

          insert SpecificDataCreator.createGrade(quizOneMath, testInMath, 76.50);
          insert SpecificDataCreator.createGrade(quizTwoMath, testInMath, 55.00);

          //we can still use the getClassGradePoints() because we're not testing for record insertion
          System.assertEquals(1.0, GPAController.getClassGradePoints(testStudent.Id), 'The class gpa isn`t accurate when a class is partially completed');

          //test for multiple partially completed classes, this is more like what you'd see in a yearlong progrogession
          Class__c classHistory = SpecificDataCreator.getClass('HIS200');
          ClassEnrollment__c testInHistory = SpecificDataCreator.createEnrollment(4.00, 'Enrolled', testStudent, classHistory);
          insert testInHistory;

          Assessment__c quizOneHistory = SpecificDataCreator.createAssessment('History 200 Quiz One', classHistory, 'Quiz');
          insert quizOneHistory;
          Assessment__c quizTwoHistory = SpecificDataCreator.createAssessment('History 200 Quiz Two', classHistory, 'Quiz');
          insert quizTwoHistory;
          Assessment__c quizThreeHistory = SpecificDataCreator.createAssessment('History 200 Quiz Three', classHistory, 'Quiz');
          insert quizThreeHistory;

          insert SpecificDataCreator.createGrade(quizOneHistory, testInHistory, 86.75);
          insert SpecificDataCreator.createGrade(quizTwoHistory, testInHistory, 78.25);
          System.assertEquals(2.0, GPAController.getClassGradePoints(testStudent.Id), 'The class gpa isn`t accurate when multiple classes are partially completed');

          //test when one class is fully completed and the other only partially, sometimes one class updates its finals before others
          insert SpecificDataCreator.createGrade(quizThreeMath, testInMath, 87.00);
          System.assertEquals(2.5, GPAController.getClassGradePoints(testStudent.Id), 'The class gpa isn`t accurate when one class of multiple is partially completed');
          
          //test when multiple classes are completed
          insert SpecificDataCreator.createGrade(quizThreeHistory, testInHistory, 105.00);
          System.assertEquals(3.0, GPAController.getClassGradePoints(testStudent.Id), 'The class gpa isn`t accurate when one class of multiple is partially completed');

          //test the weighting of classes based on credit
          Class__c classEducation = SpecificDataCreator.getClass('EDU200');
          ClassEnrollment__c testInEducation = SpecificDataCreator.createEnrollment(2.00, 'Enrolled', testStudent, classEducation);
          insert testInEducation;

          Assessment__c quizOneEducation = SpecificDataCreator.createAssessment('Education 200 Quiz One', classEducation, 'Quiz');
          insert quizOneEducation;

          insert SpecificDataCreator.createGrade(quizOneEducation, testInEducation, 76.00);
          System.assertEquals(2.8, GPAController.getClassGradePoints(testStudent.Id), 'The class gpa isn`t accurate when multiple classes have different credits');

     }

    

}
