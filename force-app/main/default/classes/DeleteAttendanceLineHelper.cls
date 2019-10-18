public with sharing class DeleteAttendanceLineHelper {
   public static void deleteAttendanceLineItem (ClassEnrollment__c classEnrollmentBeingDeleted) {
       AttendanceLineItem__c[] attendanceLineItemToBeDeleted = [SELECT Name, ClassEnrollment__c FROM AttendanceLineItem__c WHERE ClassEnrollment__c = :classEnrollmentBeingDeleted.Id];
       try{
           delete attendanceLineItemToBeDeleted;
       }catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
       }
    }

    public static void deleteAttendanceLineItems (List<ClassEnrollment__c> classEnrollmentBeingDeleted) {
        for (ClassEnrollment__c ce : classEnrollmentBeingDeleted) {
            deleteAttendanceLineItem(ce);
        }
    }
}


