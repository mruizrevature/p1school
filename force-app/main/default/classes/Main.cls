Person p = new Person();
p.setAge(20)
System.debug('age: ' + p.getAge());


//Constructor examples
Person p = new Person('Matt');
System.debug('p: ' + p);


Professor p = new Person(); // Can't do this. Person isn't always a professor
Person p2 = new Professor('Matt'); // Can do this. Professor is always a person
// Professor methods will not work with the above statement
p2.display();

PurchaseOrder p = new CustomerPurchaseOrder();
System.debug('Discount: ' + p.discount());
p = new EmployeePurchaseOrder();
System.debug('Discount: ' + p.discount());

//need to cast as Double
Calculatable c = new Square((Double) 12.2);
System.debug('\n\n Area: ' + c.calculateArea());
System.debug('\n\n');

System.debug(Project1.fibonacci(4));

System.debug('Account: ' + Project1.getAccountsForAGivenState(State.CA));