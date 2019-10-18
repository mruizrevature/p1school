public class P1 {

    /**

     * Return the nth fiboacci number in the fibonacci sequence.

     * It should start 1,1,2,3...

     * */

    public static Integer fibonacci(Integer amount) 
    {
        if(amount<0)
        {
            System.debug('Need a positive integer for the fibonacci number');
            return -1; //a bad index
        }   
        else if(amount<=2)
            return 1;   //first 2
        else{
            Integer onebefore=1;
            Integer twobefore=1;
            Integer fib = 0;
            for(Integer count=2;count<amount;count++)
            {
                //compute through loop sum of two previous fib numbers
                fib = onebefore + twobefore;
                twobefore=onebefore;
                onebefore=fib;
            }
            return fib;
        }

    }

    

    /**

     * Given a string, return its backwards order.

     * */

    public static String reverseString(String s) 
    {

        if(s.length()<2)
        {
            return s;       //1 letter string already reversed
        }
        else
        {
            //reverse = last letter + reverse(the rest of the string)
            return s.right(1) + reverseString(s.left(s.length()-1));  
        }

    }

    /**

     * Calculate the factorial of an Integer

     * */

    public static Integer factorial(Integer n) 
    {
        if(n>1)
        {
            return n*factorial(n-1);
        }
        else if(n<0)
        {
            System.debug('No Negative Factorials');
            return 0;
        }
        else
            return 1;   //1! = 0! = 1

    }

    

    /**

     * Given a string, determine if it is a palindrome.

     * */

    public static Boolean isPalindrome(String s) 
    {

        //ignore case
        s=s.toLowerCase();

        for(Integer c=0;c<s.length()/2;c++)
        {
            //left most letter = right most letter, loop goes towards middle
            if(s.charAt(c)!=s.charAt(s.length()-1-c))
                return false;
        }
        return true;

    }

    

    /**

     *  Given a state, return the accounts in that state.

     *  I only want the accounts that have a contact who works at the same place as the account.

     * */
    public static List<Account> getAccountsForAGivenState(State state) 
    {

        //accoounts in the state, where contact with the account work in same state as well
        String s=state.name();
        List<Account> accounts = new List<Account>();
        accounts = [SELECT Id FROM Account WHERE (ShippingState=:s OR BillingState =:s)
                    AND Id IN(SELECT AccountId FROM Contact WHERE MailingState=:s)];
        
        return accounts;
    }

    

    /**

     * For each student, get the grade for each of their classes.

     * */

    public static Map<Id, Map<Id, Double>> getClassGrades() 
    {

        Map<Id, Map<Id,Double>> data = new Map<Id, Map<Id,Double>>();

        //table of associated student ids, id, and grade value from grades
        List<Grade__c> grades= [SELECT Class_Enrollment__r.Student__c, Id, Grade__c FROM Grade__c];
       //table with all student ids
        List<Student__c> students = [SELECT Id FROM Student__c];

        for(Student__c student: students)
        {
            //map each student id to map of grade ids and grade values
            //in case of students with no grades, there is still an empty map created - Why I used 2 queries not 1
            Map<Id,Double> sgrades = new Map<Id,Double>();
            data.put(student.Id,sgrades);
            for(Integer place=0;place<grades.size();place++)
            {
                //if student id matches student id from the grade, add grade to the associated map
                if(grades[place].Class_Enrollment__r.Student__c == student.Id)
                {
                    sgrades.put(grades[place].Id, Double.valueOf(grades[place].Grade__c));
                }
            }
        }

        return data;
    }

}

