/**
 * @Description : Apex class to test the batch execution. Verify that the Chiffre d'Affaire of several accounts and several orders
 */
@IsTest
public class UpdateChiffreAffaireOfAccountsTest {

    //Set up the data from TestDataFactory class
 @TestSetup
    static void setup(){
        Account acc = TestDataFactory.createAccount('AccountTest');
        List <Order> ordersList = TestDataFactory.createAccountWithOrders(40, acc.Id);
         // Set up the order status to 'Ordered'
        for( Order order : ordersList){
            order.Status = 'Ordered';
        update order;  
       }
       Account acc2 = TestDataFactory.createAccount('TestAccount');
        List <Order> ordersList2 = TestDataFactory.createAccountWithOrders(10, acc2.Id);
         // Set up the order status to 'Ordered'
        for( Order order2 : ordersList2){
            order2.Status = 'Ordered';
        update order2;  
       }
        system.debug('list'+ordersList2);
        system.debug('list1'+ordersList);
    }
    
     @isTest 
    static void UpdateAllAccountsBatchTest() {
             
           //Test the batch using the data defined in the previous set up  
                
        Test.startTest();
         List<Account> accs = [SELECT ID FROM Account WHERE Name LIKE '%est%' ];
        	UpdateChiffreAffaireOfAccounts updatedBatch = new UpdateChiffreAffaireOfAccounts();
        	Database.QueryLocator query = updatedBatch.start(null);
        	updatedBatch.execute(null, accs);
        	updatedBatch.finish(null);
        
         List<Account> batchList = [SELECT ID, Chiffre_d_affaire__c FROM Account WHERE ID IN (SELECT AccountID FROM Order WHERE Status = 'Ordered')];
       system.debug('size' +accs.size() +accs);
        Test.stopTest();
       
			 for(Account acc : batchList) {
          
         //10 accounts * 10 orders *3000 unitPrice  = 30000
            System.assertEquals(10, acc.Chiffre_d_affaire__c);
             }
    }
    
}

    
