

@isTest(seeAllData = true)

public with sharing class GPAControllerTest {
    
    
    @isTest
    static void testcalculateGPA(){
        Student__C s = [SELECT Id
        FROM Student__C
        WHERE Name='Greg Maddox'
        ];
        System.assertEquals(2, GPAController.getGPA(s.Id));
        

    }
}
