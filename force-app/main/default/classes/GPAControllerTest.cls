

@isTest(seeAllData = true)

public with sharing class GPAControllerTest {
    
    
    @isTest
    static void testcalculateGPA(){
        Student__C s = [SELECT Id
        FROM Student__C
        WHERE Name='Greg Maddox'
        ];
        Double testGPA = 0.0;
        try{
            testGPA = GPAController.getGPA(s.Id);
        }catch(UnableToCalculateGPAException calcGPAFail){
            calcGPAFail.getMessage();
        }
        System.assertEquals(2, GPAController.getGPA(s.Id));
    }
}
