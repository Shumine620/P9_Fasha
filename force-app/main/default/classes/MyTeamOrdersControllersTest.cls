@isTest
public with sharing class MyTeamOrdersControllersTest {

       //Set up the data from TestDataFactory class
 @TestSetup
    static void setup(){
         Account acc = TestDataFactory.createAccount('AccountTest');
        List <Order> ordersList = TestDataFactory.createAccountWithOrders(30, acc.Id);
         // Set up the order status to 'Ordered'
        for( Order order : ordersList){
            order.Status = 'Ordered';
        update order;  
       }
           }   
         @isTest
    public static void TestMyTeamOrdersController(){
       
        List <Order> ordersList = [SELECT AccountId, ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Account.Name = 'AccountTest'];
        
        Test.startTest();
          	List<AggregateResult> groupedResults = MyTeamOrdersController.teamSumOrders();
        Test.stopTest();
        
        //30 orders * 100 unitprice = 3000
        System.assertEquals(3000, groupedResults[0].get('sumOrders'));
    }
}