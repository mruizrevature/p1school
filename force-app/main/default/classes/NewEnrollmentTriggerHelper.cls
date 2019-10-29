public with sharing class NewEnrollmentTriggerHelper  {

    public static void checkDegree( classEnrollment__c ceBeingInserted){
         
        Id classId = ceBeingInserted.Class__c;

        List<Class__c> dID=  [SELECT Department__c From Class__c Where Id=:classId];
        Id departmentId = dId[0].Department__c;

        Id studentId = ceBeingInserted.Student__c;


        System.debug('CE Being INserted '+ ceBeingInserted);


        Student__c studentMajor =[SELECT Id , Name , (Select Name, Degree__r.Department__c From Majors__r) From Student__c Where Id =:studentID ];
        Student__c studentMinor =[SELECT Id , Name , (Select Name, Degree__r.Department__c From Minors__r) From Student__c Where Id =:studentID ];

        System.debug('Student Id: '+ studentId);
        System.debug('CE Department: '+ departmentID);
        System.debug('Student DEPARTMENT: '+ studentMajor.Majors__r[0].Degree__r.Department__c);

        If(DepartmentID == studentMajor.Majors__r[0].Degree__r.Department__c){
            ceBeingInserted.status__c = 'Enrolled';

            DepartmentApporveEmail(classId);

        }

        else If(!studentMajor.Minors__r.isEmpty()){

            if(DepartmentID == studentMajor.Minors__r[0].Degree__r.Department__c){
                ceBeingInserted.status__c = 'Enrolled';

             DepartmentApporveEmail(classId);
            }

        }
        else {
            ceBeingInserted.status__c = 'Denied';
            ceBeingInserted.addError('This class is not available for your Major');
        }

    }


    public static void DepartmentApporveEmail(id classID){
        // Ensures we don't exceed daily email limit when sending email after the current transaction is commited
        Messaging.reserveSingleEmailCapacity(2);
        // Creating email object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //Specifying the To Address
        String[] toAddresses = new String[] {'joshua.bruce-attah@revature.net'};
        //Assigning the To Address variable
        mail.setToAddresses(toAddresses);
        // Specify the address used when the recipients reply to the email.
        mail.setReplyTo('jbruceattah@yahoo.com');
        // Specify the name used as the display name.
        mail.setSenderDisplayName('Salesforce School Support');
        // Setting Subject
        mail.setSubject('Class Enrollment Approved');
        //Allowing email signature to be used in email
        mail.setUseSignature(true);
        //Creating Plain Text Body
        mail.setPlainTextBody('Your class enrollment has been approved ');
        //Creating HTML Body
        mail.setHtmlBody('You have successfully enrolled into class: <b> ' + classID +' </b> <br/> Contact Admin if you have questions.<p>');
        //Send Mail
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }




    public static void DepartmentDenyEmail(){
        // Ensures we don't exceed daily email limit when sending email after the current transaction is commited
        Messaging.reserveSingleEmailCapacity(2);
        // Creating email object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //Specifying the To Address
        String[] toAddresses = new String[] {'joshua.bruce-attah@revature.net'};
        //Assigning the To Address variable
        mail.setToAddresses(toAddresses);
        // Specify the address used when the recipients reply to the email.
        mail.setReplyTo('jbruceattah@yahoo.com');
        // Specify the name used as the display name.
        mail.setSenderDisplayName('Salesforce School Support');
        // Setting Subject
        mail.setSubject('Class Enrollment Approved');
        //Allowing email signature to be used in email
        mail.setUseSignature(true);
        //Creating Plain Text Body
        mail.setPlainTextBody('Your class enrollment has been denied');
        //Creating HTML Body
        mail.setHtmlBody('You cannot enroll into class: <b> ' + classID +' </b> <br/>  Contact Admin if you have questions.<p>');
        //Creating HTML Body
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    // public static void DepartmentSendMail(String ToAddresses, ){

    // }


}
