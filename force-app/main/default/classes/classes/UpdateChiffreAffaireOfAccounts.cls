global class UpdateChiffreAffaireOfAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
                //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([SELECT Id FROM Account 
        WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')]);
    }
    global void execute(Database.BatchableContext info, List<Account> scope){
        
        Set<Id> accountToUpdate = new Set<Id>();
        
            for(Account account : scope){
           accountToUpdate.add(account.Id);
        }
        
        UpdateAccount.updateChiffreAffaire(accountToUpdate);
        }
    global void finish(Database.BatchableContext info){}   
            
         }
    
        
