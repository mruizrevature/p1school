public with sharing class AssessmentTriggerHelper {
    public static void preventDoubleBooking(Assessment__c newA) {
        oldAssessmentinRoom(newA);
        oldClassinRoom(newA);
    }

    static void oldAssessmentinRoom(Assessment__c newA) {
        List<Assessment__c> oldA = [SELECT Name, Date__c, Room__c, Time__c FROM Assessment__c];
        for (Assessment__c a : oldA) {
            if (newA.Date__c == a.Date__c &&
                newA.Room__c == a.Room__c &&
                newA.Time__c == a.Time__c) {
                // reject
            }
        }
    }
    static void oldClassinRoom(Assessment__c newA) {
        List<Class__c> oldC = [SELECT Name, EndDate__c, ScheduledTime__c, StartDate__c FROM Class__c];
        for (Class__c c : oldC) {
            if (newA.Date__c >= c.StartDate__c &&
                newA.Date__c <= c.EndDate__c &&
                newA.Room__c == c.Room__c &&
                newA.Time__c == c.Time__c) {
                // reject
            }
        }
    }
    
    static void oldAssessmentinRoom(Class__c newC) {
        List<Assessment__c> oldA = [SELECT Name, Date__c, Room__c, Time__c FROM Assessment__c];
        for (Assessment__c a : oldA) {
            if (newC.StartDate__c <= a.Date__c &&
                newC.EndDate__c >= a.Date__c &&
                newC.Room__c == a.Room__c &&
                newC.Time__c == a.Time__c) {
                // reject
            }
        }
    }
    static void oldClassinRoom(Class__c newC) {
        List<Class__c> oldC = [SELECT Name, EndDate__c, ScheduledTime__c, StartDate__c FROM Class__c];
        for (Class__c c : oldC) {
            if (!(newC.EndDate__c <= c.StartDate__c ||
                newC.StartDate__c >= c.EndDate__c) &&
                newC.Room__c == c.Room__c &&
                newC.Time__c == c.Time__c) {
                // reject
            }
        }
    }
}
