public with sharing class ClassEnrollmentTriggerHelper {
    
    /*
        addAttendanceLineItems(List<ClassEnrollment__c>) takes in the new trigger context of 
        List<ClassEnrollment__c> and finds the number of total classes in that course for the
        semester, adding that amount in line items to the database.
    
     */
    public static void addAttendanceLineItems(List<ClassEnrollment__c> newEnrollments){
        
        
        // In order to accept multiple class enrollments, must create a list of classIds
        // so that each class being enrolled in has it's total amount of lectures calculated.
        List<Id> classIds = new List<Id>();
        for(ClassEnrollment__c enrollment : newEnrollments) {
            classIds.add(enrollment.Class__c);
        }

        Class__c[] classesBeingEnrolledIn = [SELECT Id, DaysPerWeek__c, DurationInWeeks__c FROM Class__c WHERE Id IN :classIds];
        List<AttendanceLineItem__c> attendanceLineItemsToBeInserted = new List<AttendanceLineItem__c>();
        Double numAttendanceLines;
        for (ClassEnrollment__c ce : newEnrollments) {//for every new enrollment...
            for(Class__c cl : classesBeingEnrolledIn){//for each class sObject detail...
                if (ce.Class__c == cl.Id) {//If the class being enrolled in has the same Id as the class sObject
                    Double daysPerWeek = cl.DaysPerWeek__c;
                    Double durationInWeeks = cl.DurationInWeeks__c;
                    Double totalLectures = daysPerWeek*durationInWeeks;
                    numAttendanceLines = totalLectures;
                    for(Integer i = 0; i < (Integer) numAttendanceLines; i++) {//iterate until # attendance line items reached
                        attendanceLineItemsToBeInserted.add(
                            new AttendanceLineItem__c(
                                Class__c=ce.Class__c, ClassEnrollment__c=ce.Id, Student__c=ce.Student__c));
                    }
                }
            }
        }
        if (attendanceLineItemsToBeInserted != null) {
            insert attendanceLineItemsToBeInserted;
        }else {
            newEnrollments[0].addError('There are no lecture dates and times scheduled for this class. '
            + 'please choose another class.');
        }
    }

    /*
        The course and it's attendance line items cannot be deleted if there are grades associated 
        with the course. checkForGrades() ensures that any grades associated with the course 
        will get deleted.
     */
    public static void checkForGrades(List<ClassEnrollment__c> enrollmentsToDelete) {
        System.debug('check for grades: ' + enrollmentsToDelete);
        List<Id> enrollmentIds = new List<Id>();
        for(ClassEnrollment__c ce : enrollmentsToDelete){
            enrollmentIds.add(ce.Id);
        }
        List<Grade__c> gradesToDelete = [SELECT Id, Class_Enrollment__r.Id FROM Grade__c WHERE Class_Enrollment__r.Id IN :enrollmentIds];
        delete gradesToDelete;
        deleteAttendanceLineItems(enrollmentsToDelete);
    }

    /*  
        method finds attendance line items associated with the class enrollments that are to be deleted. 
        Once the attendance line items are gathered into one list, all attendance line items are deleted 
        at once.
    */
    public static void deleteAttendanceLineItems(List<ClassEnrollment__c> enrollmentsToDelete) {
        System.debug('Enrollments To Delete: ' + enrollmentsToDelete);
        List<Id> doomedEnrollmentIds = new List<Id>();
        for (ClassEnrollment__c doomedEnrollment : enrollmentsToDelete) {
            doomedEnrollmentIds.add(doomedEnrollment.Id);
        }

        List<AttendanceLineItem__c> attendanceLineItemsToBeDeleted = [SELECT Id, Name, ClassEnrollment__c FROM AttendanceLineItem__c WHERE ClassEnrollment__c IN :doomedEnrollmentIds];
        if(attendanceLineItemsToBeDeleted != null) {
            delete attendanceLineItemsToBeDeleted;
        }
    }

    /*
        method checks the list of enrollments being added against already existing enrollments. 
        If a potential enrollment is associated with the same student AND class as an existing 
        enrollment, then put into a list of duplicate enrollments to throw an error.
    
    */
    public static void checkForDoubleEnrollment(List<ClassEnrollment__c> enrollmentsToInsert) {
        List<Id> studentsEnrolling = new List<Id>();
        for(ClassEnrollment__c newEnrollment : enrollmentsToInsert) {
            studentsEnrolling.add(newEnrollment.Student__c);
        }
        List<ClassEnrollment__c> existingEnrollments = [SELECT Student__c, Class__c FROM ClassEnrollment__c WHERE Student__c IN :studentsEnrolling];
        List<ClassEnrollment__c> duplicateEnrollments = new List<ClassEnrollment__c>();
        for(ClassEnrollment__c newEnrollment : enrollmentsToInsert) {
            for(ClassEnrollment__c oldEnrollment : existingEnrollments) {
                if(newEnrollment.Student__c == oldEnrollment.Student__c && newEnrollment.Class__c == oldEnrollment.Class__c){
                    //deny the enrollment
                    duplicateEnrollments.add(newEnrollment);
                }
            }
        }
        denyDoubleEnrollment(duplicateEnrollments);
    }

    /*
        Takes a list of duplicate enrollments and throws an exception for each enrollment.
     */
    public static void denyDoubleEnrollment(List<ClassEnrollment__c> duplicateEnrollments){
        for(ClassEnrollment__c duplicateEnrollment : duplicateEnrollments){
            duplicateEnrollment.addError('Student is already enrolled in the class');
            throw new DuplicateEnrollmentException('Student is already enrolled in the class');  
        } 
    }
}