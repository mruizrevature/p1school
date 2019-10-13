System.debug(' Fibonacci= ' +  P0.Fibonacci(5));


System.debug(' String= ' + P0.reverseString('aleena'));

System.debug(P0.isPalindrome('Ragar'));

System.debug(P0.factorial(1));

System.debug(P0.getAccountsForAGivenState(State.NY));

for(Account a : P0.getAccountsForAGivenState(State.NY)) {
    System.debug('here: ' + a.Contacts);
    for (Contact c: a.Contacts) {
        System.debug('here2');
        System.debug('Contact: ' + c.FirstName);
    }
}

System.debug(P0.getClassGrades());

Map<Id, Map<Id, Double>> avgGradeForStudent = P0.getClassGrades();
for (Id student: avgGradeForStudent.keySet()) { // loop through students
    Map<Id, Double> classGrades = avgGradeForStudent.get(student); // get inner map for student or get the value part of the outer map
    for (Id studentClass: classGrades.keySet()) { // loop through classes for that student
        System.debug('Student: ' + student + ' class: ' + studentClass + ' grade: ' + classGrades.get(studentClass));
    }
}
