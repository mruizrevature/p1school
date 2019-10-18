trigger DegreeTrigger on ClassEnrollment__c (before insert) {
    //In order for a Student to be enrolled in a class, their degree must be related to the class.
    //  Check if same department class.subject == student.major
    //	If successfully enrolled, the CE status should be set to `Enrolled`
	//  If it was not successful, the CE status should be set to `Denied`
	//  If enrolled, email the teacher.
	//  If denied, email the student that an UnrelatedDegreeException exception was thrown.

    // List<ClassEnrollment__c> newEnrollments = [SELECT Student__c, Class__c from ClassEnrollment__c];
    // SELECT Class__r.Department__r.Name FROM ClassEnrollment__c
    // SELECT Student__r.Department__r.Name FROM ClassEnrollment__c
    for (ClassEnrollment__c a: Trigger.new) {
        if (a.Student__r.Major__. != a.Class__c)
            a.addError('Department does not match degree');
            [SELECT [SELECT [SELECT Degree__r.Department__r.Name FROM Major__r] FROM Student__c] FROM ClassEnrollment__c];
    }
}