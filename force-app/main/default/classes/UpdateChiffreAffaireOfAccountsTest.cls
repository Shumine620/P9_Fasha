/**
 * @Description : Apex class to test the batch execution. Verify that the Chiffre d'Affaire of several accounts and several orders
 */
@IsTest
public class UpdateChiffreAffaireOfAccountsTest {

    //Set up the data from TestDataFactory class
 @TestSetup
    static void setup(){
        List <Account> accounts = TestDataFactory.createAccounts(10);
        Product2 product = TestDataFactory.createProduct();
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product.Id,3000);
        Contract contract = TestDataFactory.createContract(accounts[0].id);
        	for (Account account : accounts){

          //   insert a list orders for those accounts
              	List <Order> orders = TestDataFactory.createOrders(account, priceBookEntry, 10);
        		List <OrderItem> createOrderItems = TestDataFactory.createOrderItems(10,orders, priceBookEntry);
              Order order = [SELECT Id,Status FROM Order LIMIT 1];
         // Set up the order status to 'Ordered'
        order.Status = 'Ordered';
        update order;  
       }
    }
    
     @isTest 
    static void UpdateAllAccountsBatchTest() {
           //Test the batch using the data defined in the previous set up    
        Test.startTest();
        	UpdateChiffreAffaireOfAccounts updatedBatch = new UpdateChiffreAffaireOfAccounts();
        	Id batchId = Database.executeBatch(updatedBatch);
        Test.stopTest();
        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c, (SELECT Id, Status, TotalAmount FROM Orders 
                                  WHERE Status = 'Ordered') 
                                  FROM Account 
                                  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];
 
         //10 accounts * 10 orders *3000 unitPrice  = 30000
            System.assertEquals(30000, accounts[0].Chiffre_d_affaire__c);
        
    }
    
}