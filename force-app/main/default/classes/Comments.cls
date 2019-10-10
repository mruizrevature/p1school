 //List<Class__c> classes = [SELECT Id, Class__c, ]
        /**SELECT COUNT(Grade__c), SUM(Grade__c), ClassEnrollment__r.Class__c, ClassEnrollment__r.Student__c FROM Grade__c 
        GROUP BY ClassEnrollment__r.Student__c, ClassEnrollment__r.Class__c */
        //List<Assessment__c> assessments = [SELECT Id, Assessment__r.Class__c FROM Assessment__c WHERE Assessment__r.Class__c =: enrollments.Class_Enrollment__c.Class__c];
        //List<Grade__c> grades = [SELECT Id, Grade__c, Grade__c.Assessment__c, ClassEnrollment__r.Class__c, ClassEnrollment__r.Student__c FROM Grade__c];
        //List<Grade__c> grades = [SELECT Id, Grade__r.Assessment__c, Grade__c FROM Grade__c WHERE Grade__r.Assessment__c =: assessments.Id];
        //SELECT Id, Name, Grade__c.Assessment__c, ClassEnrollment__r.Class__c, ClassEnrollment__r.Student__c FROM Grade__c


         // List<Id> studentIds = new List<Id>();
        // Map<Id, Map<Id, Double>> theGrade = new Map<Id, Map<Id, Double>>();
        // Map<Id, Double> classToGrade = new Map<Id, Double>();
        // //theGrade.put(studentId, classToGrade);
        // //Can I populate 
        // for(Student__c stu : mystudents){
        //     //studentIds.add(stu.Id);
        //     for(ClassEnrollment__c enr : enrollments){
        //        for(Grade__c g1 : grade2){
        //            if((stu.Class__c == enr.Class__c) && (g1.Class_Enrollment__c == enr.Id)){

        //            }
        //        }
                
        //     }
        //     theGrade.put(stu.Id,classToGrade);
        // }
        // return theGrade;