/**
 * Created by gamedevmadeeasy on 10/13/19.
 */

@IsTest
private class GetClassGradesTest {

    @TestSetup
    static void testData() {
        // Insert some Student Data
        SchoolDataCreator.createData();
        // Create new Enrollment
        List<Class__c> classData = [SELECT Id FROM Class__c];
        List<Student__c> studentData = [SELECT Id FROM Student__c];
        ClassEnrollment__c classEnrollment = new ClassEnrollment__c(
                Class__c = classData[0].Id,
                Student__c = studentData[0].Id,
                Credits__c = 1,
                Status__c = 'Enrolled'
        );

        insert classEnrollment;
        // Create Some Grades
        for (Integer i = 0; i < 3; i++) {
            Grade__c grade = new Grade__c(
                    Assessment__c = [SELECT Id FROM Assessment__c][i].Id,
                    Class_Enrollment__c = [SELECT Id FROM ClassEnrollment__c][0].Id,
                    Grade__c = 33.33 * i
            );

        insert grade;
        }
    }

    @isTest static void testStudentClassGrades() {
        Map<Id, Map<Id, Double>> classGrades = ClassGrades.getClassGrades();
        for (Map<Id, Double> gradeTest : classGrades.values()) {
            for (Double d : gradeTest.values()) {
                System.assertEquals(33.33,d);
            }
        }
    }

    @isTest static void negativeTestStudentClassGrades() {
        Map<Id, Map<Id, Double>> classGrades = ClassGrades.getClassGrades();
        for (Map<Id, Double> gradeTest : classGrades.values()) {
            for (Double d : gradeTest.values()) {
                System.assertNotEquals(30, d);
            }
        }

        for (Integer i = 0; i < classGrades.size(); i++) {

        }
    }

    @isTest static void negativeValueTestStudentClassGrades() {
        Map<Id, Map<Id, Double>> classGrades = ClassGrades.getClassGrades();
        for (Map<Id, Double> gradeTest : classGrades.values()) {
            for (Double d : gradeTest.values()) {
                System.assertNotEquals(-d, 50);
            }
        }
    }
}