@ isTest(SeeAllData=true)
public with sharing class P1Test {

	@isTest public static void testFibonnaci() {
		System.assert(P1.fibonacci(0) == 0);
		System.assert(P1.fibonacci(1) == 1);
		System.assert(P1.fibonacci(2) == 1);
		System.assert(P1.fibonacci(10) == 55);
		System.assert(P1.fibonacci(25) == 75025);
	}

	@isTest public static void testReverseString() {
		System.assert(P1.reverseString('') == '');
		System.assert(P1.reverseString('wow') == 'wow');
		System.assert(P1.reverseString('tinsae') == 'easnit');
		System.assert(P1.reverseString('a nber ole') == 'elo rebn a');
	}

	@isTest public static void testFactorial() {
		System.assert(P1.factorial(- 5) == null);
		System.assert(P1.factorial(0) == 1);
		System.assert(P1.factorial(5) == 120);
		System.assert(P1.factorial(8) == 40320);
	}

	@isTest public static void testPalindrome() {
		System.assert(P1.isPalindrome('') == true);
		System.assert(P1.isPalindrome('wow') == true);
		System.assert(P1.isPalindrome('Civic') == true);
		System.assert(P1.isPalindrome('Stats') == true);

		System.assert(P1.isPalindrome('A nut for a jar of tuna.') == true);
		System.assert(P1.isPalindrome('My gym') == true);
		System.assert(P1.isPalindrome('No lemon, no melon') == true);

		System.assert(P1.isPalindrome('danncnad') == false);
		System.assert(P1.isPalindrome('statss') == false);
		System.assert(P1.isPalindrome('wooow') == true);
	}


	@isTest public static void testGetAccountsForAGivenState() {
		// get california accounts
		List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :State.CA.name()];
		// get those accounts who have a contact with same address in california
		List<Account> matchingAccs = P1.getAccountsForAGivenState(State.CA);
		// account size is greater or equal to matchingAccs size
		// because the later is filtered.
		System.assert((accounts.size() >= matchingAccs.size()) == true);

		// Only one account in california satisfies the requirement
		System.assert(matchingAccs.size() == 1);
		// it is sForce
		System.assert(matchingAccs[0].Name == 'sForce');
	}

	@isTest public static void testGetClassGrades() {
		// The test works on my own data

        Map<Id, Map<Id, Double>> allGrades = P1.getClassGrades();

        // Mike Williams
        // Mike took 2 classes: MAT100 and BIO100

		// He took two assesments for MAT100 
		   // first assesment Grade: 70.0
		   // second assesment Grade: 89.0
		// Average = 94.5

		// He took one assesment for BIO100
			// first assesement Grade: 70.0
		// Average = 70.0

		// 
        Double [] grades = new List<Double>{70.0, 94.5};
		Map<Id, Double> mikeGrades = allGrades.get('a0B3j00000xPPLmEAO');
		Integer i = 0;
		for (String key: mikeGrades.keySet()){
            System.assert(grades[i] == mikeGrades.get(key));
			i++;
        }
	   

	}

}