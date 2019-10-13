public with sharing class GPAController {
    /** 
        Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
    */
    @AuraEnabled
    public static void calculateGPA(Id student){
        // GPA is calculated by dividing the total amount of
        // grade points earned by the total amount of credit hours attempted
    }
}