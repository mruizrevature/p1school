public class P1
{
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) 
    {
        if(n==0 || n==1)
        {
            return n;
        }
        else if(n<0)
        {
            return 0;
        }
        else 
        {
            return fibonacci(n-1) + fibonacci(n-2);    
        }
    }

    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) 
    {
        Integer[] chars = s.getChars();
        List<Integer> backwardsChars = new List<Integer>();
        Integer size = chars.size();
        for(Integer i=size-1; i>=0; i--)
        {
            backwardsChars.add(chars[i]);
        }

        return String.fromCharArray(backwardsChars);
    }


    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) 
    {
        if(n<0)
        {
            return 0;
        }
        else if(n==1)
        {
            return 1;
        }
        else 
        {
            return n * factorial(n-1);
        } 
    }


    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) 
    {
        s = s.toLowerCase();
        Integer[] chars = s.getChars();
        Integer size = chars.size();
        for(Integer i=0; i<size; i++)
        {
            if(chars[i]!=chars[size-i-1])
            {
                return false;
            }
        }
        return true;
    }


    /**
     *  Given a state, return the accounts in that state.
     * 	I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) 
    {
        List<Account> acc = [SELECT Name FROM Account WHERE BillingState =: s.name() AND Id IN (SELECT AccountId FROM Contact WHERE MailingState =: s.name())];
        return acc;
    }



     /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() 
    {
        // query the database for every student's average grade for all their classes
        List<AggregateResult> averageGrades = [SELECT Grade__c.Class_Enrollment__r.Class__c, Grade__c.Class_Enrollment__r.Student__c, 
                                                AVG(Grade__c) 
                                                FROM Grade__c 
                                                GROUP BY Grade__c.Class_Enrollment__r.Class__c, Grade__c.Class_Enrollment__r.Student__c 
                                                ORDER BY Grade__c.Class_Enrollment__r.Student__c];

        Map<Id, Map<Id, Double>> studentGrades = new Map<Id, Map<Id, Double>>();
        Id currentStudent = averageGrades[0].get('Student__c').toString();
        Map<Id, Double> classAverages = new Map<Id, Double>();

        // create the studentGrades map by adding the average for each class 
        // the student is enrolled in to the classAverages map then adding that as the value of the studentGrades map
        for(AggregateResult ag: averageGrades)
        {
            Id student = ag.get('Student__c').toString();
            Id clas = ag.get('Class__c').toString();
            Decimal avgGrade = (Decimal)ag.get('expr0');
            // when you get to the next student, add the classAverages map to the studentGrades map, 
            // reset classAverages, and update the currentStudent
            if(student!=currentStudent)
            {
                studentGrades.put(currentStudent, classAverages);
                classAverages = new Map<Id, Double>();
                currentStudent = student;
            }
            classAverages.put(clas, avgGrade);
        }
        // because it is only updating the value when the student changes
        // the last student is not added, so you have to add it here
        studentGrades.put(currentStudent, classAverages);

        return studentGrades;
    }
}