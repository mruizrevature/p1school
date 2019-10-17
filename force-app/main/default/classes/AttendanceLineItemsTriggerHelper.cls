public with sharing class AttendanceLineItemsTriggerHelper 
{
    public static void addAttendanceLineItems(List<ClassEnrollment__c> enrollments)
    {
        List<ClassEnrollment__c> ClassEnrollments = [SELECT Id, Status__c, Class__c, Student__c, Class__r.DaysPerWeek__c, Class__r.DurationInWeeks__c FROM ClassEnrollment__c WHERE Id IN :enrollments];
        List<AttendanceLineItem__c> attendanceLineItems = new List<AttendanceLineItem__c>();
        AttendanceLineItem__c newAttendanceLineItem;
        Decimal daysOfCLass;

        for(ClassEnrollment__c ce: classEnrollments)
        {
            if(ce.Status__c == 'Enrolled')
            {
                daysOfClass = ce.Class__r.DaysPerWeek__c * ce.Class__r.DurationInWeeks__c;
                for(Integer i=0;i<daysOfCLass;i++)
                {
                    newAttendanceLineItem = new AttendanceLineItem__c();
                    newAttendanceLineItem.ClassEnrollment__c = ce.Id;
                    newAttendanceLineItem.Student__c = ce.Student__c;
                    newAttendanceLineItem.CLass__c = ce.Class__c;
                    attendanceLineItems.add(newAttendanceLineItem);
                }
            }
        }

        insert attendanceLineItems;
        
    }

    public static void deleteAttendanceLineItems(List<ClassEnrollment__c> enrollments)
    {
        List<AttendanceLineItem__c> existingLineItems = [SELECT Id, ClassEnrollment__r.Id FROM AttendanceLineItem__c WHERE ClassEnrollment__r.Id IN :enrollments];
        
        delete existingLineItems;
    }
}