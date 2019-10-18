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

    @IsTest static void duplicatedEnrollment() {

        List<ClassEnrollment__c> classEnrollments =
        [SELECT Id, Student__c, Class__c FROM ClassEnrollment__c];

        List<ClassEnrollment__c> duplicate = classEnrollments;

        insert duplicate;
        for (Integer i = 0; i < classEnrollments.size(); i++) {
            System.assert(duplicate.contains(classEnrollments[i]));
        }
    }
}