@isTest 
public class CalculAmountTriggerTest {

    @TestSetup
    static void setup(){
 				Account acc = TestDataFactory.createAccount('AccountTestTrigger');
                Product2 product2 = TestDataFactory.createProduct();
                PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product2.Id,100);
         		Contract contract = TestDataFactory.createContract(acc.id);
            		contract.Status = 'Activated';
        			update contract;
        		Order order = TestDataFactory.createOrder(acc.Id, priceBookEntry);
        OrderItem orderItem = TestDataFactory.createOrderItem(order.Id, product2.Id, 1 , 1000, priceBookEntry.Id);
            }
    
    @isTest 
    static void NetAmountTest(){
         
   		Account acc =[SELECT Id FROM Account WHERE Account.Name ='AccountTestTrigger'];
       Order order = [SELECT Id, ShipmentCost__c, TotalAmount ,NetAmount__c FROM Order WHERE Account.Name ='AccountTestTrigger'];

        order.shipmentCost__c = 100;
        decimal netToTest = order.TotalAmount- order.shipmentCost__c;

        Test.startTest();
        update(order);
        Test.stopTest();
//900 = 1Order*1000UnitPrice-100shipmentCost
       Order netCalculated = [SELECT NetAmount__c FROM Order ];
        System.assertEquals(netCalculated.NetAmount__c , netToTest);
    }
}