public class P1 {
	/**
	 * Return the nth fiboacci number in the fibonacci sequence.
	 * It should start 1,1,2,3...
	 * */
	public static Integer fibonacci(Integer n) {
		if(n == 0 || n == 1) {
			return n;
		}
		return fibonacci(n - 1) + fibonacci(n - 2);
	}

	/**
	 * Given a string, return its backwards order.
	 * */
	public static String reverseString(String s) {
		String revStr = '';
		for(Integer i =(s.length() - 1); i >= 0; i --) {
			revStr += s.substring(i, i + 1);
		}
		return revStr;
	}

	/**
	 * Use recursion to compute the factorial of a given number.
	 * */
	public static Integer factorial(Integer n) {
		if(n < 0) {
			return null;
		}

		if(n == 0) {
			return 1;
		}
		return n * factorial(n - 1);
	}

	/**
	 * Given a string, determine if it is a palindrome.
	 * */
	public static Boolean isPalindrome(String s) {
		if(s.equals('')) {
			return true;
		}
		Integer forw = 0;
		Integer backw = s.length() - 1;
		// remove punctuation, convert to lowercase
		Pattern nonAlphanumeric = Pattern.compile('[^a-zA-Z0-9]');
		Matcher matcher = nonAlphanumeric.matcher(s);
		s = matcher.replaceAll('').toLowerCase();
		while(backw > forw && backw < s.length() && forw < s.length()) {
			String fChar = s.substring(forw, forw + 1);
			String bChar = s.substring(backw, backw + 1);
			if(!fChar.equals(bChar)) {
				return false;
			}
			forw++;
			backw--;
		}
		return true;
	}

	/**
	 *  Given a state, return the accounts in that state.
	 *  I only want the accounts that have a contact who works at the same place as the account.
	 * */
	public static List<Account> getAccountsForAGivenState(State s) {
		// select accounts for whose billig state is s
		List<Account> accounts = [SELECT Id, Name, BillingState FROM Account WHERE BillingState = :s.name()];
		// select all accounts
		List<Contact> contacts = [SELECT Id, Name, AccountId, MailingState FROM Contact];
		// create empty list of accounts
		List<Account> newAccount = new List<Account>();
		// for each contact c in contacts
		for(Contact c :contacts) {
			// for each account acc in accounts
			for (Account acc :accounts) {
				// if acc is related with c
				// and acc's billing state matches
				// c's mailing state
				if(c.AccountId == acc.Id &&
				   acc.BillingState == c.MailingState) {
					// add this account to list
					newAccount.add(acc);
					System.debug('contact->' + c.Name + 'account->' + acc.Name);
				}
			}
		}
		// return list of accounts
		System.debug('what is the size=>' + newAccount.size());
		return newAccount;
	}

	/**
	 * For each student, get the grade for each of their classes.
	 * */
	public static Map<Id, Map<Id, Double>> getClassGrades() {
		// array of students with their map of class->average grade
		Map<Id, Map<Id, Double>> allGrades = new Map<Id, Map<Id, Double>>();
		// get all students enrollements
		List<Student__c> students = [SELECT Id, Name, (SELECT Id, Class__c FROM ClassEnrollments__r) FROM Student__c LIMIT 2];
		// myGrades: stores the grades of one student
		Map<Id, Double> averageGradesPerClass;

		// get the grades without querying for each student
		List<AggregateResult> everytin =
	     [
		SELECT
	     	Class_Enrollment__r.Student__c sId, 
	     	Class_Enrollment__r.Class__c cId, 
	    	 AVG(Grade__c) average
	    FROM
	    	Grade__c
	    GROUP BY
	     Class_Enrollment__r.Student__c, 
	     Class_Enrollment__r.Class__c
		];

		Id currentSId =(Id) everytin.get(0).get('sId');
		averageGradesPerClass = new Map<Id, Double>();
		for (AggregateResult result :everytin) {
			if((Id) result.get('sId') != currentSId) {
				// put previous student's average grades to outer map
				allGrades.put(currentSId, averageGradesPerClass);
				// reset inner map
				averageGradesPerClass = new Map<Id, Double>();
				// change currentSId
				currentSId =(Id) result.get('sId');
			}
			// add average grade for a class for current student
			averageGradesPerClass.put((Id) result.get('cId'), (Double) result.get('average'));
			System.debug(result.get('sId') + '-' + result.get('cId') + '-' + result.get('average'));
		}   
		return allGrades;
	}

}