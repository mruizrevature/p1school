public with sharing class DegreeTriggerHelper {
  //  public static void preventUnrelatedClassSubject(List<ClassEnrollment__c> enrollmentBeingInserted) {
  //      checkIfClassSubjectMatchesStudentMajor(enrollmentBeingInserted);
  //  }

    public static void preventUnrelatedClassSubject(ClassEnrollment__c enrollmentBeingInserted) {
        checkIfClassSubjectMatchesStudentMajor(enrollmentBeingInserted);
    }

    static void checkIfClassSubjectMatchesStudentMajor(ClassEnrollment__c newEnrollment){
        Id studentId = newEnrollment.Student__c;
        Id classId = newEnrollment.Class__c;

        Class__c classDept = [SELECT Department__r.Name FROM Class__c WHERE Id =: classId];
        Student__c studentDept = [SELECT (SELECT Degree__r.Department__r.Name FROM Majors__r) FROM Student__c WHERE Id =: studentId];

        if (studentDept.get('Name') != classDept.get('Name')){
            newEnrollment.Status__c = 'Denied';
            emailStudent();
            System.debug('Wrong class subject');
        }
        else {
            newEnrollment.Status__c = 'Enrolled';
            emailTeacher();
        }
    }

    // Taken from the Apex Developer Guide
    static void emailTeacher(){
        // First, reserve email capacity for the current Apex transaction to ensure
        // that we won't exceed our daily email limits when sending email after
        // the current transaction is committed.
        Messaging.reserveSingleEmailCapacity(2);

        // Processes and actions involved in the Apex transaction occur next,
        // which conclude with sending a single email.

        // Now create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'mossah19@gmail.com'}; 
        //String[] ccAddresses = new String[] {'smith@gmail.com'};
        

        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        //mail.setCcAddresses(ccAddresses);

        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('mossah19@gmail.com');

        // Specify the name used as the display name.
        mail.setSenderDisplayName('College Admin');

        // Specify the subject line for your email address.
        mail.setSubject('New Student has been enrolled into your class');

        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);

        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);

        // Specify the text content of the email.
        mail.setPlainTextBody('You have a new student in your class');

        mail.setHtmlBody('You have a new student in your class');

        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    // Taken from the Apex Developer Guide
    static void emailStudent(){
        // First, reserve email capacity for the current Apex transaction to ensure
        // that we won't exceed our daily email limits when sending email after
        // the current transaction is committed.
        Messaging.reserveSingleEmailCapacity(2);

        // Processes and actions involved in the Apex transaction occur next,
        // which conclude with sending a single email.

        // Now create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'mossah19@gmail.com'}; 
        //String[] ccAddresses = new String[] {'smith@gmail.com'};
        

        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        //mail.setCcAddresses(ccAddresses);

        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('mossah19@gmail.com');

        // Specify the name used as the display name.
        mail.setSenderDisplayName('College Admin');

        // Specify the subject line for your email address.
        mail.setSubject('Class Enrollment Denied');

        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);

        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);

        // Specify the text content of the email.
        mail.setPlainTextBody('Your class enrollment was rejected due to the class subject not matching your major');

        mail.setHtmlBody('Your class enrollment was rejected due to the class subject not matching your major');

        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}
