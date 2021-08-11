/**
 * @Description : Class to test the updated Chiffre d'Affaire and the next running time of the updateChiffreAffaireScheduler class 
 */
@isTest
public with sharing class UpdateChiffreAffaireSchedulerTest {
       
    static testMethod void UpdateChiffreAffaireSchedulerTest() {
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('testBasicScheduledApex', UpdateChiffreAffaireScheduler.CRON_EXP, 
         		new UpdateChiffreAffaireScheduler());
       			 UpdateChiffreAffaireScheduler updateScheduler = new UpdateChiffreAffaireScheduler();
        
         // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime FROM CronTrigger WHERE id = :jobId];
               
         System.assertEquals(UpdateChiffreAffaireScheduler.CRON_EXP,  ct.CronExpression);
        
        Test.stopTest();
    }
  
     static testMethod void nextTimeJobRunTest() {
       // This test runs a scheduled job on the next coming Thursday.  
        Test.startTest();
        String jobId = System.schedule('testBasicScheduledApex',
     			 UpdateChiffreAffaireScheduler.CRON_EXP, 
         		new UpdateChiffreAffaireScheduler());
       			 UpdateChiffreAffaireScheduler updateScheduler = new UpdateChiffreAffaireScheduler();
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime FROM CronTrigger WHERE id = :jobId];
      System.assertEquals('2021-08-12 07:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
     }
}