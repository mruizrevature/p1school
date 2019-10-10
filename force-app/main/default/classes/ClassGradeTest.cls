/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

@IsTest
private class ClassGradeTest {
    @TestSetup static void makeData() {
        Account acc = new Account(
                Name = 'Luke Durback',
                BillingState = 'PA');
        insert acc;
        Contact cc = new Contact(
                LastName = 'Donnovan',
                MailingState = 'VA',
                AccountId = acc.id);
        insert cc;
        Account acc2 = new Account(Name = 'Timothy Hosey');
        insert acc2;

        SchoolDataCreator.createData();
        // Class Enrollment creator
        ClassEnrollment__c ce = new ClassEnrollment__c(
                Class__c = [SELECT Id FROM Class__c][0].Id,
                Student__c = [SELECT Id FROM Student__c][0].Id,
                Credits__c = 1,
                Status__c = 'Enrolled'
        ); insert ce;
        // Grade creator
        for (Integer i = 0; i < 3; i++) {
            Grade__c g = new Grade__c(
                    Assessment__c =
                    [SELECT Id
                    FROM Assessment__c][0].Id,
                    Class_Enrollment__c =
                        [SELECT Id
                        FROM ClassEnrollment__c][0].Id,
                    Grade__c = 20 + 10 * i);
            insert g;
        }
    }

    @IsTest static void getClassGradeTest() {
        Map<Id, Map<Id, Double>> classGrades = ClassGrade.getClassGrades();
        for (Map<Id, Double> mapValue : classGrades.values()) {
            for (Double data : mapValue.values()) {
                System.assertEquals(data, 80);
            }
        }
    }

    @IsTest static void getNegativeClassGradeTest() {
        Map<Id, Map<Id, Double>> classGrades = ClassGrade.getClassGrades();
        for (Map<Id, Double> mapValue : classGrades.values()) {
            for (Double data : mapValue.values()) {
                System.assertNotEquals(data, 20);
            }
        }
    }
}