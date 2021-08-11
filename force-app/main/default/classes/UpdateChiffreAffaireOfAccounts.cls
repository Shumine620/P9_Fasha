/**
 * Batch Apex class calling UpdateAccount 
 */
global class UpdateChiffreAffaireOfAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
                //Request only accounts that have at least one order with the Status 'Ordered'
        return Database.getQueryLocator([SELECT Id FROM Account 
        WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')]);
    }
    global void execute(Database.BatchableContext info, List<Account> scope){
        //Set Ids to the accounts to retreived them
        Set<Id> accountToUpdate = new Set<Id>();
        
            for(Account account : scope){
           accountToUpdate.add(account.Id);
        }  
        UpdateAccount.updateChiffreAffaire(accountToUpdate);
    }
    global void finish(Database.BatchableContext info){}   
            
}