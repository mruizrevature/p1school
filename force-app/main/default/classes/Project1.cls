public class Project1 {
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) {
        if (n < 0) return -1; // error
        if (n == 0) return 0;
        if (n == 1) return 1;
        //return fibonacci(n - 1) + fibonacci(n - 2);

        Integer first, second = 0, third = 1;
        for (Integer i = 1; i < n; i++) {
            first = second;
            second = third;
            third = first + second;
        }
        return third;
    }
    
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) {
        List<String> chars = s.split('');
        String reverse = '';
        for (Integer i = chars.size() - 1; i >= 0; i--) {
            reverse += chars[i];
        }
        return reverse;
    }
    
    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) {
        if (n < 0) return -1; // error
        if (n == 0) return 1;
        return n * factorial(n - 1);
    }
    
    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) {
        return s == Project1.reverseString(s);
    }
    
    /**
     *  Given a state, return the accounts in that state.
     * 	I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        List<Account> acc = [SELECT Id, Name, BillingState,
            (SELECT Id, Name, MailingState FROM Contacts WHERE MailingState = :s.name())
            FROM Account WHERE BillingState = :s.name()];
        List<Account> match = new List<Account>();
        for (Account a : acc) if (a.Contacts.size() > 0) match.add(a);
        return match;
    }
    
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        List<Student__c> students = [ SELECT Id, (SELECT Id, Class__c FROM ClassEnrollments__r) FROM Student__c];
        List<Grade__c> grades = [SELECT Id, Grade__c, Class_Enrollment__c FROM Grade__c];
        Map<Id, Map<Id, Double>> classGrades = new Map<Id, Map<Id, Double>>();
        for (Student__c s : students) {
            Map<Id, Double> classGrade = new Map<Id, Double>();
            for (ClassEnrollment__c ce : s.ClassEnrollments__r) {
                Double sum = 0; 
                for (Grade__c g : grades) if (ce.Id == g.Class_Enrollment__c) sum += g.Grade__c;
                if (grades.size() > 0) classGrade.put(ce.Id, sum / grades.size());
            } classGrades.put(s.Id, classGrade);
        }
        return classGrades;
    }
}