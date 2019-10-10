public with sharing class Part1 {
    
    public static Integer fibonacci(Integer n) {
        Integer num1 = 0;
        Integer num2 = 0;
        Integer sum = 0;

        for(Integer i = 0;i<n;i++){
            //The 1st and 2nd numbers have unique situations.
            if(i == 0){
                sum = 1;     
            }

            else if(i == 1){
                sum = 1;
                num2 = 1;
            }
             
            else{
                num1 = num2;
                num2 = sum;
                sum = num2+num1;
                }
        }

        System.debug(sum);
        return sum;
    }

    public static String reverseString(String s) {

        // List a stores input characters
        //List b stores output chartacters
        List<String> input = new List<String>();
        List<String> output = new List<String>();
        input = s.split('');

        for(Integer i=input.size()-1; i>=0; i--){
            String chars = input[i];
            output.add(chars);
        }

        String revString = String.join(output,'');

        System.debug(revString);
        return revString;
    }


    public static Boolean isPalindrome(String s) {

        String rev = reverseString(s);

        if(s==rev){
            return true;
        }
        else{
            return false;
        }
    }

    public static Integer factorial(Integer n){
        if(n==0){
            return 1;
        }
        else if (n==1){
            return 1;
        }
        else{
            return n*factorial(n-1);
        }
    }

    /*  I only want the accounts that have a contact who works at the same place as the account.
     * */

    //  Part1.getAccountsForAGivenState(State.CA);

    public static List<Account> getAccountsForAGivenState(State s) {
        
        List <Account> acc = [SELECT id , (SELECT id, name FROM Contacts WHERE Contact.mailingState =:s.name()) FROM Account WHERE Account.BillingState =:s.name()];

        // if (acc.size() == 0) return null;
        // else 
        System.debug('Returned acc list : ' + acc.size());
        return acc;
    }







}
