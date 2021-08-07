@isTest
public with sharing class MyTeamOrdersControllersTest {

       //Set up the data from TestDataFactory class
 @TestSetup
    static void setup(){
        List <Account> accounts = TestDataFactory.createAccounts(1);
        Product2 product = TestDataFactory.createProduct();
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product.Id,3000);
        Contract contract = TestDataFactory.createContract(accounts[0].id);
        	for (Account account : accounts){

          //   insert a list orders for those accounts
              	List <Order> orders = TestDataFactory.createOrders(account, priceBookEntry, 10);
        		List <OrderItem> createOrderItems = TestDataFactory.createOrderItems(5,orders, priceBookEntry);
              Order order = [SELECT Id,Status FROM Order LIMIT 1];
         // Set up the order status to 'Ordered'
        order.Status = 'Ordered';
        update order;  
       }
    }   
         @isTest
    public static void TestMyTeamOrdersController(){
       
        Test.startTest();
          	List<AggregateResult> groupedResults = MyTeamOrdersController.teamSumOrders();
        Test.stopTest();
        
        //5 orders * 3000 unitprice = 15000
        System.assertEquals(15000, groupedResults[0].get('sumOrders'));
    }
}