trigger lineItems on SOBJECT (before insert) {

/** 
When a Student is enrolled in a class, there should be Attendance Line Items created for each week for the amount of time the class meets.
	- The amount of times a class meets is stored in the daysPerWeek field
	- Delete the Assessment Line Items if the Student withdraws from the class.
*/
public static void lineItems(){
    //after when status changes to enrolled
    //get class__c and student__c from current class enrollment
    //get days per week from class__c
    //count = 15*days per week
    //for each in count insert attendence line items

    //after when status changes to denied
    //delete all line items where class__c and student__c in record
}



}