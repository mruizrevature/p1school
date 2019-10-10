@isTest
public with sharing class P1Tests {
    @isTest static void testFibonacciThree(){
        Integer actual = P1.fibonacci(3);
        System.assertEquals(2, actual);
    }

    @isTest static void testFibonacciZero(){
        Integer actual = P1.fibonacci(0);
        System.assertEquals(0, actual);
    }

    @isTest static void testFibonacciOne(){
        Integer actual = P1.fibonacci(1);
        System.assertEquals(1, actual);
    }

    @isTest static void testFibonacciNegative(){
        Integer actual = P1.fibonacci(-2);
        System.assertEquals(-1, actual);
    }

    @isTest static void testFibonacciNotSeven(){
        Integer actual = P1.fibonacci(7);
        System.assertNotEquals(10, actual);
    }

    @isTest static void testFactorialFive(){
        Integer actual = P1.factorial(5);
        System.assertEquals(120, actual);
    }

    @isTest static void testFactorialZero(){
        Integer actual = P1.factorial(0);
        System.assertEquals(1, actual);
    }

    @isTest static void testFactorialOne(){
        Integer actual = P1.factorial(1);
        System.assertEquals(1, actual);
    }

    @isTest static void testFactorialNegativeTwo(){
        Integer actual = P1.factorial(-2);
        System.assertEquals(-1, actual);
    }

}
