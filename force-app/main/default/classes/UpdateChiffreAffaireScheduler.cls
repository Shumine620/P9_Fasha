/**
 * @Description : Implements the Schedulable Interface to run the UpdateChiffreAffaireOfAccounts at regular interval
 */
global class UpdateChiffreAffaireScheduler implements Schedulable{
    
    // This test runs a scheduled job at midnight 3rd. 
 
   public static String CRON_EXP = '0 0 0 3 * ?';
    
    global void execute (SchedulableContext sc) {

    //Tracking the progress of the Scheduled Job using the SOQL query on CronTrigger ct    
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                FROM CronTrigger WHERE Id = :sc.getTriggerId()];

 //Implements the accountUpdate method of UpdateChiffreAffaireOfAccounts
        UpdateChiffreAffaireOfAccounts accountUpdate = new UpdateChiffreAffaireOfAccounts();
        database.executeBatch(accountUpdate);
    }
}