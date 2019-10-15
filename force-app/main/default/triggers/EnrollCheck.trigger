/** 
In order for a Student to be enrolled in aclass, their degree must be related to the class.
	- i.e., the same department
	- If successfully enrolled, the CE status should be set to `Enrolled`
	- If it was not successfull, the CE status should be set to `Denied`
	- If enrolled, email the teacher.
	- If denied, email the student that a UnrelatedDegreeException exception was thrown.
*/


trigger EnrollCheck on SOBJECT (before insert) {

public static void enrollCheck(){
    //after insert
    //check if same department
    //if true set CE to Enrolled and email teacher
    //else email student and throw exception
}




}