@IsTest
public class UpdateChiffreAffaireOfAccountsTest {
 @TestSetup
    static void setup(){
        List<Account> accounts = TestDataFactory.createAccounts(10);
        Product2 product = TestDataFactory.createProduct('XYX long green shirt','Shirt');
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product.Id,100);
        List<Order> orders = TestDataFactory.createOrders(accounts, priceBookEntry, 300);
        List<OrderItem> createOrderItems = TestDataFactory.createOrderItems(10, orders, priceBookEntry);
       
    }
    
     @isTest 
    static void UpdateAllAccountsBatchTest() {
        //10 accounts * 300 orders *100 unitPrice  = 300000
        
        Test.startTest();
        UpdateChiffreAffaireOfAccounts updatedBatch = new UpdateChiffreAffaireOfAccounts();
        Id batchId = Database.executeBatch(updatedBatch);
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c, (SELECT Id, Status, TotalAmount FROM Orders 
                                  WHERE Status = 'Ordered') 
                                  FROM Account 
                                  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];
        
        for (Account account : accounts) {
            System.assertEquals(300000, account.chiffre_d_affaire__c);
        }
    }
}