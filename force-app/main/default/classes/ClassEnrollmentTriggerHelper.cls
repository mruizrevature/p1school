public with sharing class ClassEnrollmentTriggerHelper {
    public static void preventDuplicateEnrollment(ClassEnrollment__c ce){
        if(checkReadAccess(ce)){
            try{
              list<ClassEnrollment__c> alreadyExisting = [SELECT Id FROM ClassEnrollment__c WHERE Class__c = :ce.Class__c AND Student__c = :ce.Student__c];
              if (alreadyExisting.size() > 0) throw new RoomOccupiedException('Class Enrollment already exists');
            }catch(Exception e){
            }
        }
    }

    public static boolean checkReadAccess(ClassEnrollment__c ce){
        if(Schema.sObjectType.Class__c.isAccessible() && Schema.sObjectType.Student__c.isAccessible()){
            return true;
        }
        else if(!Schema.sObjectType.Class__c.isAccessible()){
            ce.addError(UserPermissionErrors.CANNOT_READ_CLASSES);
            return false;
        }
        else if(!Schema.sObjectType.Student__c.isAccessible()){
            ce.addError(UserPermissionErrors.CANNOT_READ_STUDENTS);
            return false;
        }
        else{
            ce.addError(UserPermissionErrors.CANNOT_READ_CLASSES);
            ce.addError(UserPermissionErrors.CANNOT_READ_STUDENTS);
            return false;
        }
    }
}
