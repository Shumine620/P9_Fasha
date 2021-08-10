/**
 * @Description : Implements the Schedulable Interface to run the UpdateChiffreAffaireOfAccounts at regular interval
 */
global class UpdateChiffreAffaireScheduler implements Schedulable{
    
    //second minute hour day_of_month month day_of_week optional_year  
    //This class runs a scheduled job every Thursday at 7am. 
 
   public static String CRON_EXP = '0 0 7 ? * THU *';
    
    global void execute (SchedulableContext sc) {

    //Tracking the progress of the Scheduled Job using the SOQL query on CronTrigger ct    
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                FROM CronTrigger WHERE Id = :sc.getTriggerId()];

 //Implements the accountUpdate method of UpdateChiffreAffaireOfAccounts
        UpdateChiffreAffaireOfAccounts accountUpdate = new UpdateChiffreAffaireOfAccounts();
        database.executeBatch(accountUpdate);
    }
}