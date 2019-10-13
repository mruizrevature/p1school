/**
 * Created by gamedevmadeeasy on 10/13/19.
 */

public with sharing class DegreeAndClassEvaluation {
    public ClassEnrollment__c checkStudentDegreeVsClass(Degree__c degree, Class__c classType) {
        // In order for a Student to be enrolled in a class, their degree must be related to the class.
        //    - i.e., the same department
        //    - If successfully enrolled, the CE status should be set to `Enrolled`
        //    - If it was not successful, the CE status should be set to `Denied`
        //    - If enrolled, email the teacher.
        //    - If denied, email the student that an UnrelatedDegreeException exception was thrown.
    }
}