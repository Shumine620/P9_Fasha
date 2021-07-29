@isTest
public with sharing class UpdateChiffreAffaireSchedulerTest {
   
    
    static testMethod void UpdateChiffreAffaireSchedulerTest() {
        
        Test.startTest();
        
        String jobId = System.schedule('testBasicScheduledApex',
     			 UpdateChiffreAffaireScheduler.CRON_EXP, 
         		new UpdateChiffreAffaireScheduler());
       			 UpdateChiffreAffaireScheduler updateScheduler = new UpdateChiffreAffaireScheduler();
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime FROM CronTrigger WHERE id = :jobId];
               
         System.assertEquals(UpdateChiffreAffaireScheduler.CRON_EXP,  ct.CronExpression);
        
        Test.stopTest();
    }
  
     static testMethod void nextTimeJobRunTest() {
        
        Test.startTest();
        String jobId = System.schedule('testBasicScheduledApex',
     			 UpdateChiffreAffaireScheduler.CRON_EXP, 
         		new UpdateChiffreAffaireScheduler());
       			 UpdateChiffreAffaireScheduler updateScheduler = new UpdateChiffreAffaireScheduler();
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime FROM CronTrigger WHERE id = :jobId];
      System.assertEquals('2021-08-03 00:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
     }
}