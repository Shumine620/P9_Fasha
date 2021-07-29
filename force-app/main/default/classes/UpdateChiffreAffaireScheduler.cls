global class UpdateChiffreAffaireScheduler implements Schedulable{
    
    // This test runs a scheduled job at midnight 3rd. 
 
   public static String CRON_EXP = '0 0 0 3 * ?';
    
    global void execute (SchedulableContext sc) {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                FROM CronTrigger WHERE Id = :sc.getTriggerId()];
 
        UpdateChiffreAffaireOfAccounts accountUpdate = new UpdateChiffreAffaireOfAccounts();
        database.executeBatch(accountUpdate);
    }
}