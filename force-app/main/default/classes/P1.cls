public class P1 {
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) {
        // seq1, seq2 are the counting values for facoring for fibonacci numbers.
        // result will be the final result after calculation.
        Integer seq1 = 0, seq2 = 1, result = 0;

        // if our value is 0, make sure to return 0
        if (n == 0) {
            return 0;
        }
        // if our value is 1, make sure to return 1
        if (n == 1) {
            return 1;
        }

        // set our i value to 2 and make sure it is greater than or equal to the
        // nth number we designate.
        for (Integer i = 2; i <= n; i++)
        {
            // let the result be the value of seq1 and seq2 added together
            result = seq1 + seq2;
            // set seq1 to be the value of seq2
            seq1 = seq2;
            // now set the value of result to be the value of seq2
            seq2 = result;
            // this will happen each iteration until we reach the nth count
        }
        // return the results that were stored.
        return result;
    }
    
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) {
        // create an empty string
        String reverseString = '';
        // our i value is going to be set to the value of the string s' value.
        // we want to go backwards with our loop so we do i--.
        for (Integer i = s.length() - 1; i >= 0; i--) {
            // we will now make the reverse string take each substring from the
            // backwards motion loop to add the letter that was taken from the original
            // string that was provided.
            reverseString += s.substring(i, i + 1);
        }
        // return the new string value from the results of the loop
        return reverseString;
    }
    
    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) {
        // if the number we provide is less than or equal to 0, return 1 instead
        // of trying to calculate these values. Which would cause a
        // Maximum stack depth reached error to occur
        if (n == 0) {
            return 1;
        }

        // Since n is never supposed to be less than 0, return -1 to denote a failure status code.
        if (n > 0) {
            return -1;
        }
        // since this is a recursive function. multiply our nth number by the
        // function call of factorial. The value is going to be our nth number
        // minus 1. This will return the proper value for our factorial.
        return n * factorial(n - 1);
    }
    
    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) {
        // create an empty string
        String reverseString = '';
        // our i value is going to be set to the value of the string s' value.
        // we want to go backwards with our loop so we do i--.
        for (Integer i = s.length() - 1; i >= 0; i--) {
            // we will now make the reverse string take each substring from the
            // backwards motion loop to add the letter that was taken from the original
            // string that was provided.
            reverseString += s.substring(i, i + 1);
        }
        if (s == reverseString) {
            return true;
        }
        return false;
    }
    
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        String stateString = String.valueOf(s);
        List<Account> getAccountList = [SELECT Id, Name, BillingState,
        (SELECT Id, Name, MailingState FROM Contacts WHERE MailingState =: stateString)
        FROM Account WHERE BillingState =: stateString];
        for (SObject accountData : getAccountList) {
            if (accountData.get('BillingState') == accountData.get('MailingState')) {
                return getAccountList;
            }
        }
    }
    
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        Map<Id, Map<Id, Double>> studentGrades = new Map<Id, Map<Id, Double>>();
        Map<Id, Double> classGrades = new Map<Id, Double>();

        List<Student__c> studentList = [SELECT Id, (SELECT Id, Class__c FROM ClassEnrollments__r) FROM Student__c];
        List<AggregateResult> grade =
        [SELECT Class_Enrollment__r.Class__c, AVG(Grade__c) averageGrade
        FROM Grade__c WHERE Class_Enrollment__r.Student__c =: StudentList
        GROUP BY Class_Enrollment__r.Class__c];
        for (Student__c students : studentList) {
            for (AggregateResult aggregateResult : grade) {
                classGrades.put((Id)aggregateResult.get('Id'), (Double)aggregateResult.get('averageGrade'));
            }
            studentGrades.put(students.Id, classGrades);
        }
        return studentGrades;
    }
}