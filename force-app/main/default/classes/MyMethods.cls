public with sharing class MyMethods {

    /** 
     * Return the nth fibonacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     */
    public static Integer fibonacci(Integer n) {
        if (n <= 0) {
            System.debug('Please enter a positive number.');
            return -1;
        } else if (n <= 2) {
            return 1;
        } else {
            return fibonacci(n - 1) + fibonacci(n - 2);
        }
    }

    /**
     * Given a string, return its backwards order.
     */
    public static String reverseString(String s) {
        String stringReversed = '';

        // Starting at the last character, and moving towards
        // the first, append each character to the 
        // String stringReversed
        for (Integer i = s.length() - 1; i >= 0; --i) {
            stringReversed += s.substring(i, i + 1);
        }
        return stringReversed;
    }

    /**
     * Use recursion to compute the factorial of a given number.
     */
    public static Integer factorial(Integer n) {
        if (n < 0) { 
            return -1;
        } else if (n <= 1) {
            return 1;
        } else {
            return n * factorial(n - 1);
        }
    }

    /**
     * Given a string, determine if it is a palindrome.
     */
    public static Boolean isPalindrome(String s) {
        s = s.toLowerCase();

        Integer i = 0;
        Integer j = s.length() - 1;

        // Check if first and last characters are equal. 
        // Continue checking characters while moving toward the 
        // center of the String. 
        while (i < j && s.charAt(i) == s.charAt(j)) {
            ++i;
            --j;
        }
        return (i >= j);
    }

    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        // Get a list of Accounts in State s
        List<Account> accountList = [
            SELECT 
                Id 
            FROM Account 
            WHERE BillingState =: s.name()
        ];

        // Get a list of Contacts in State s
        List<Contact> contactList = [
            SELECT 
                AccountId 
            FROM Contact 
            WHERE MailingState =: s.name()
                AND AccountId != null
        ];
            
        List<Account> resultList = new List<Account>();
    
        for (Account account : accountList) {

            Object accountId = account.get('Id');

            // Compare the Account Id from each Account in accountList to the Account Id for each Contact in contactList. 
            // If they match, we know that the Account has a related Contact that is in the same state. 
            // Setting the accountHasContact Boolean flag to true will stop execution of the while loop
            // early, so we don't loop through Contacts unnecesarily. 
            Boolean accountHasContact = false;
            Integer i = 0;
            while (!accountHasContact && i < contactList.size()) {
                Object contactsAccountId = contactList[i].get('AccountId');

                if (accountId.equals(contactsAccountId)) {
                    resultList.add(account);
                    accountHasContact = true;
                }
                ++i;
            }
        }
        return resultList;
    }

    /**
     * For each student, get the grade for each of their classes.
     */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        // Get a list of Students and the Classes they are enrolled in
        List<ClassEnrollment__c> classEnrollmentList = [
            SELECT
                Id 
                ,Student__c
                ,Class__c 
            FROM ClassEnrollment__c 
            WHERE Student__r.Status__c = 'Enrolled'
        ];

        // Get a List<AggregrateResult> of average Grades for each ClassEnrollment
        AggregateResult[] gradeList = [
            SELECT 
                Class_Enrollment__c
                ,AVG(Grade__c) averageGrade
                FROM Grade__c 
                GROUP BY Class_Enrollment__c
        ];

        // Map to store result in
        Map<Id, Map<Id, Double>> resultMap = new Map<Id, Map<Id, Double>>();

        // Loop through the Students in the classEnrollmentList
        for (ClassEnrollment__c student : classEnrollmentList) {

            Object currentStudent = student.get('Student__c');

            // Inner map to put inside of the result map. 
            // <Class Id, Grade>
            Map<Id, Double> classAndGradeMap = new Map<Id, Double>();

            // Loop through the classes in the classEnrollmentList
            for (ClassEnrollment__c classes : classEnrollmentList) {

                Object currentClass = classes.get('Class__c');

                for (AggregateResult grade : gradeList) {

                    // In order to add only add the current class and the associated average grade
                    // we need to check that the ClassEnrollment Ids match up on both the
                    // Class and the Student
                    if ((Id)classes.get('Id') == (Id)grade.get('Class_Enrollment__c') &&
                        (Id)student.get('Id') == (Id)grade.get('Class_Enrollment__c')) {
                        classAndGradeMap.put((Id)currentClass, (Double)grade.get('averageGrade'));    
                    }    
                }
            }
            resultMap.put((Id)currentStudent, classAndGradeMap);
        }
        return resultMap;
    }
}




