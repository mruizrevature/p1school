public class P1Test {
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) {
        
        if(n==0){
            return 1;
         } if (n<=2){
            return 1;
         } if (n < 0){
             System.debug('Cant have negs');
             return -1;
         }
  
        return fibonacci(n-2) + fibonacci(n-1);
    }
    
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) {

        List<String> forward = new List<String>();
        List<String> backward = new List<String>();
      

        for(Integer i = 0; i<s.length(); i++){
            forward.add(s.subString(i,i+1));
        }

        String forwardWord = String.join(forward, '');

        for(Integer i = forwardWord.length()-1; i>=0; i--){

            backward.add(forwardword.subString(i, i+1));

        }

        String backWord = String.join(backward, '');

        return backWord;
    }
    
    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) {


        if(n == 0){
            n = 1;
            return n;
        }if(n==1){
            n=1;
            return n;
        }else{
         return n*factorial(n-1);
        }

    }
    
    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) {

        return reverseString(s).equals(s);
    }
    
        /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {


        //List<Account> stateContact = [SELECT Name FROM Account WHERE BillingState =: [SELECT MailingState FROM Contact WHERE MailingState =: BillingState(s.Name())]];
       List<Account> stateAccount = [SELECT id
        FROM Account
        WHERE BillingState =: s.name()
       ];


       List<Contact> stateContact = [SELECT Account.id
       FROM Contact
       WHERE MailingState =: s.name()
       ];

       List<Account> statesMatching = new List<Account>();

       for (Account matchingAccount: stateAccount){
            for(Contact matchingContact: stateContact){
                if(matchingAccount.get('id') == matchingCOntact.get('id')){
                    if(matchingAccount.get(s.name()) == matchingContact.get(s.name())){
                        statesMatching.add(matchingAccount);
                    }
                }
            }
       }

    return statesMatching;
    }
    
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {

        List<Student__c> studentList = [SELECT Id
        FROM Student__c
        ]; 

        List<ClassEnrollment__c> classEnrollment = [SELECT Id, Class__c
        FROM classEnrollment__c
        WHERE Student__c IN: studentList
        ];
        
        AggregateResult[] studentGrade = [SELECT AVG(grade__c), Class_Enrollment__c
        FROM Grade__c
        GROUP BY Class_Enrollment__c
        ];

        Map<Id, Map<Id, Double>> studentIdandClass = new Map<Id, Map<Id, Double>>();
        //Map<Id, Double> classEnrollmentandGrade = new Map<Id, Double>();

        for(Student__c si: studentList){

            Map<Id, Double> innerClassEnrollmentandGrade = new Map<Id, Double>();

            for(ClassEnrollment__c ce: classEnrollment){

                for(AggregateResult gg: studentGrade){

                    //Got rid of if statment since id of CE doesnt equal id of student
                    //if(ce.id==((id) gg.get('Id'))){
                    innerClassEnrollmentandGrade.put(ce.Class__c, (Double)gg.get('expr0'));
                    //}
                }
            }
            studentIdandClass.put(si.id, innerClassEnrollmentandGrade);
        }
        return studentIdandClass;
    }

}
