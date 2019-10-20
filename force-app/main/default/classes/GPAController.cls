public with sharing class GPAController {
	/**
	 Use me to change the GPA fields on the Student record when the Calculate GPA button is pressed.
	 */
	@AuraEnabled
	public static void calculateGPA(Id student) {
		
		 getGPA(student);
	}
	public static Double getGPA(Id student) {
		AggregateResult gr = [SELECT AVG(Grade__c) avgGrade, Class_Enrollment__r.Student__r.Name, Class_Enrollment__r.Student__r.Id
						    FROM Grade__c
						    GROUP BY Class_Enrollment__r.Student__r.Name, Class_Enrollment__r.Student__r.Id HAVING Class_Enrollment__r.Student__r.Id = :student];
			if((Double) gr.get('avgGrade') < 0.0) {
				throw new UnableToCalculateGPAException('Cannot calculate the GPA for this student: ' +(Id) gr.get('Student__r.Id'));
			} 
			else if((Double) gr.get('avgGrade') >= 0.0 &&(Double) gr.get('avgGrade') < 65.0) {
				Double gPA = 0.0;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 65.0 &&(Double) gr.get('avgGrade') < 67.0) {
				Double gPA = 1.0;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 67.0 &&(Double) gr.get('avgGrade') < 70.0) {
				Double gPA = 1.3;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 70.0 &&(Double) gr.get('avgGrade') < 73.0) {
				Double gPA = 1.7;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 73 &&(Double) gr.get('avgGrade') < 77.0) {
				Double gPA = 2.0;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 77.0 &&(Double) gr.get('avgGrade') < 80.0) {
				Double gPA = 2.3;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 80.0 &&(Double) gr.get('avgGrade') < 83.0) {
				Double gPA = 2.7;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 83.0 &&(Double) gr.get('avgGrade') < 87.0) {
				Double gPA = 3.0;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 87.0 &&(Double) gr.get('avgGrade') < 90.0) {
				Double gPA = 3.3;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 90.0 &&(Double) gr.get('avgGrade') < 93.0) {
				Double gPA = 3.7;
                return gPA;
			} 
			else if((Double) gr.get('avgGrade') >= 93.0) {
				Double gPA = 4.0;
                return gPA;
			}
		
        return 0.0;
	}
}