public with sharing class ProjectOnePartOne {
    
    public static Integer fibonacci(Integer n) {
        n--;
        List<Integer> sequence = new List<Integer>{1,1,2,3};
        
        if(n<4){
            return sequence[n];
        }
        else{
            for(Integer i = 4; i < (n + 1); i++) {
                sequence.add(sequence[i-1] + sequence[i-2]);
            }
            return sequence[n];
        }
    }

    public static String reverseString(String s) {
        String reversed = '';
        for(Integer i = s.length() -1; i > -1; i--){
            reversed += s.substring(i,(i+1));
        }
        return reversed;
    }

    public static Integer factorial(Integer n) {
        Integer f = 1;
        n++;
        for(Integer i = 1; i < n; i++) {
                f*= i;
        }
        return f;
    }

    public static Boolean isPalindrome(String s) {
        //boolean palindrome = true;
        String reversed = reverseString(s);
        for (Integer i = 0; i < s.length(); i++){
            if(!s.substring(i,(i+1)).equals(reversed.substring(i,(i+1)))){
                return false;
            }
        }
        return true;
    }
    
    public static List<Account> getAccountsForAGivenState(State s) {
        List<Account> stateAccounts = new List<Account>();
        List<Id> sameStateAccounts = new List<Id>();
        List<State> states = State.values();
        State compareState = null;
        List<Account> accounts = [SELECT Id , BillingAddress FROM Account];
        for (Account a: accounts) {
            //we need to put the states in a usable form, unfortunately that means having to go through every one
            for(State stateEnum : states){
               if(a.BillingAddress.getState() == stateEnum.name()){
                   compareState = stateEnum;
               } 
            }
            if(compareState == s){
                sameStateAccounts.add(a.Id);
            }
        }
        boolean alreadyAdded = false;
        List<Contact> contacts = new List<Contact>();
        for(Id i: sameStateAccounts){
            contacts = [SELECT Id , MailingAddress FROM Contact WHERE AccountID = :i];
            for (Contact c: contacts) {
                if(!alreadyAdded){
                    for(State stateEnum : states){
                        if(c.MailingAddress.getState() == stateEnum.name()){
                            compareState = stateEnum;
                        }     
                    }
                    if(compareState == s){
                        stateAccounts.addAll([SELECT Id , BillingAddress FROM Account WHERE Id = :i]);
                        alreadyAdded = true;
                    }
                }
            }
        }

        return stateAccounts;
    }

    public static Map<Id, Map<Id, Double>> getClassGrades() {
        Map<Id, Map<Id, Double>> studentsClassGrades = new Map<Id, Map<Id, Double>>();
        //the temp class is used for inserting the individual grades into
        Map<Id, Double> tempClassGrades = new Map<Id, Double>();
        Integer gradeNum = 0;
        Double gradeSum = 0.0;
        for(Student__c s: [SELECT Id FROM Student__c WHERE Id IN (
                           SELECT STUDENT__C FROM ClassEnrollment__c)]){
            for(ClassEnrollment__c ce : [SELECT Id, Class__c FROM ClassEnrollment__c WHERE Student__c = :s.Id]){
                //grabbing the classes here is not superflous because we need it for assignment purposes
                for(Class__C c : [SELECT Id FROM Class__c WHERE Id = :ce.Class__c]){
                    for(Grade__c g: [SELECT Grade__c FROM Grade__c WHERE Class_Enrollment__c =: ce.Id]){
                        gradeSum += g.Grade__c;
                        gradeNum++;
                    }       
                    if(gradeNum > 0){
                        tempClassGrades.put(c.Id, (gradeSum/gradeNum));
                    }
                    gradeNum = 0;
                    gradeSum = 0.0;
                }       
            }
            //if a students has no grade for a class then it's irrelevant
            if(tempClassGrades.size() > 0){
                studentsClassGrades.put(s.Id,tempClassGrades.clone());
            }
            tempClassGrades.clear();
        }
        
        return studentsClassGrades;
    }

    

}