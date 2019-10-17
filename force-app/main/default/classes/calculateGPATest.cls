/**
 * Created by gamedevmadeeasy on 10/15/19.
 */

@IsTest
private class calculateGPATest {
    @TestSetup static void Init() {
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

    @IsTest static void testCalculateGPA() {
        Decimal value = 1.0;
        Student__c student = [SELECT Id FROM Student__c LIMIT 1];
        Decimal actualGPA = GPAController.calculate(student.Id);
        System.assertEquals(value,actualGPA);
    }

    @IsTest static void negativeCalculateGPA() {
        Decimal value = 4.0;
        Student__c student = [SELECT Id FROM Student__c LIMIT 1];
        Decimal actualGPA = GPAController.calculate(student.Id);
        System.assertNotEquals(value, actualGPA);
    }
}