public with sharing class AttendanceLineItemsTriggerHelper 
{

    // when a new class enrollment is created add attendance line items for every day that class meets
    public static void addAttendanceLineItems(List<ClassEnrollment__c> enrollments)
    {
        // query for the required information to create an attendance line item from the class enrollments in the given list
        List<ClassEnrollment__c> ClassEnrollments = [SELECT Id, Status__c, Class__c, Student__c, 
                                                        Class__r.DaysPerWeek__c, Class__r.DurationInWeeks__c 
                                                        FROM ClassEnrollment__c WHERE Id IN :enrollments];
        
        List<AttendanceLineItem__c> attendanceLineItems = new List<AttendanceLineItem__c>();
        AttendanceLineItem__c newAttendanceLineItem;
        // total number of days a class meets
        // calculated by multiplying number of days a week a class meets by the number of weeks the class meets
        Decimal daysOfCLass;

        // for all the class enrollments create the attendance line items if the student was successfully enrolled in the class
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


    // when a student withdraws from the class(class enrollment deleted) 
    // all the attendance line items relating to that class should be deleted
    public static void deleteAttendanceLineItems(List<ClassEnrollment__c> enrollments)
    {
        // get the attendance line items relating to the enrollments that are going to be deleted
        List<AttendanceLineItem__c> existingLineItems = [SELECT Id, ClassEnrollment__r.Id 
                                                            FROM AttendanceLineItem__c 
                                                            WHERE ClassEnrollment__r.Id IN :enrollments];
        
        // delete them all
        delete existingLineItems;
    }
}