public with sharing class SpecificDataCreator {

        //retrieve a student record by name
    public static Student__c getStudent(String name){
        Student__c studentObject = [SELECT Id, Name, CumulativeGPA__c, Status__c FROM Student__c WHERE Name = :name][0];
        return studentObject;
    }

    //retrieve a class record by name
    public static Class__c getClass(String name){
        Class__C classObject = [SELECT Id, ScheduledTime__c, Room__c, StartDate__c FROM Class__c WHERE Name = :Name][0];
        return classObject;
    }
    
    /*
     creates an enrollment from a student and a class method is overloaded to prevent
     method is overloaded
    */
    public static ClassEnrollment__c createEnrollment(Decimal credits, String status, Student__c student, Class__c ceClass){
        return new ClassEnrollment__c(Class__c = ceClass.Id, Student__c = student.id, Credits__c = credits, Status__c = status);
    }

    public static ClassEnrollment__c createEnrollment(Double credits, String status, Student__c student, Class__c ceClass){
        return new ClassEnrollment__c(Class__c = ceClass.Id, Student__c = student.id, Credits__c = credits, Status__c = status);
    }

    //creates an assessment
    public static Assessment__c createAssessment(String assessmentName, Class__c assessmentClass, String assessmentType){
        Id type = Schema.SObjectType.Assessment__c.getRecordTypeInfosByName().get(assessmentType).getRecordTypeId();
        Assessment__c createdAssesssment = new Assessment__c(RecordTypeId = type,
                                            Name = assessmentName,
                                            Class__c = assessmentClass.Id,
                                            Time__c = assessmentClass.ScheduledTime__c,
                                            Room__c = assessmentClass.Room__c,
                                            Graded__c = true,
                                            Date__c = assessmentClass.StartDate__c);
        return createdAssesssment;
    }

    /*
     creates a grade
     method is overloaded
    */
    public static Grade__c createGrade(Assessment__c assessment, ClassEnrollment__c ce, Double grade){
        return new Grade__c(Assessment__c = assessment.id, Class_Enrollment__c = ce.id, Grade__c = grade);
    }

    public static Grade__c createGrade(Assessment__c assessment, ClassEnrollment__c ce, Decimal grade){
        return new Grade__c(Assessment__c = assessment.id, Class_Enrollment__c = ce.id, Grade__c = grade);
    }
}
