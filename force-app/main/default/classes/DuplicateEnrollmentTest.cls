/**
 * Created by gamedevmadeeasy on 10/16/19.
 */

@IsTest
private class DuplicateEnrollmentTest {

    @TestSetup static void Init() {
        // Insert some Student Data
        SchoolDataCreator.createData();
        // Create new Enrollment
        List<Class__c> classData = [SELECT Id FROM Class__c];
        List<Student__c> studentData = [SELECT Id FROM Student__c];
        ClassEnrollment__c classEnrollment = new ClassEnrollment__c(
                Class__c = classData[0].Id,
                Student__c = studentData[0].Id,
                Credits__c = 10,
                Status__c = 'Enrolled'
        );

        insert classEnrollment;
        // Create Some Grades
        for (Integer i = 0; i < 5; i++) {
            Grade__c grade = new Grade__c(
                    Assessment__c = [SELECT Id FROM Assessment__c][0].Id,
                    Class_Enrollment__c = [SELECT Id FROM ClassEnrollment__c][0].Id,
                    Grade__c = 60
            );

            insert grade;
        }
    }

    @IsTest static void duplicatedEnrollment() {

        List<ClassEnrollment__c> classEnrollments =
        [SELECT Id, Student__c, Class__c FROM ClassEnrollment__c];

        System.assert(true, DuplicateEnrollment.checkForDuplicateEnrollment(classEnrollments));
    }
}