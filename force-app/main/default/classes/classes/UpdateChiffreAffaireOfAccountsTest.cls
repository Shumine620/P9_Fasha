@IsTest
public class UpdateChiffreAffaireOfAccountsTest {
 @TestSetup
    static void setup(){
        List <Account> accounts = TestDataFactory.createAccounts(10);
        Product2 product = TestDataFactory.createProduct();
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product.Id,3000);
        Contract contract = TestDataFactory.createContract(accounts[0].id);
        	for (Account account : accounts){
          
              	List <Order> orders = TestDataFactory.createOrders(account, priceBookEntry, 10);
             //   insert orders;
        		List <OrderItem> createOrderItems = TestDataFactory.createOrderItems(10,orders, priceBookEntry);
              Order order = [SELECT Id,Status FROM Order LIMIT 1];
     
        order.Status = 'Ordered';
        update order;  
       }
    }
    
     @isTest 
    static void UpdateAllAccountsBatchTest() {
        //10 accounts * 10 orders *3000 unitPrice  = 30000
       
        Test.startTest();
        	UpdateChiffreAffaireOfAccounts updatedBatch = new UpdateChiffreAffaireOfAccounts();
        	Id batchId = Database.executeBatch(updatedBatch);
        Test.stopTest();
List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c, (SELECT Id, Status, TotalAmount FROM Orders 
                                  WHERE Status = 'Ordered') 
                                  FROM Account 
                                  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];
       
            System.assertEquals(30000, accounts[0].Chiffre_d_affaire__c);
        /**limité   Id batchId = Database.executeBatch(uppAcc,100);
         * 
         * alors si j'etais toi quand tu testes ta classe schedule que tu as bien x job créé
AsyncApexJob job = [
                SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                FROM AsyncApexJob
                WHERE Id = :info.getJobId()
        ];**/
    }
    
}