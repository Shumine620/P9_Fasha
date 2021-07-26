@isTest 
public class CalculAmountTriggerTest {

    @TestSetup
    static void setup(){
         Account acc = TestDataFactory.createAccount('AccountTestTrigger');
        update acc;
        Product2 product2 = TestDataFactory.createProduct('XYX long green shirt','Shirt');
        
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product2.Id,100);
         Contract contract = TestDataFactory.createContract(acc.id);
        Order order = TestDataFactory.createOrder(acc.Id, contract.Id);
    
    }
    @isTest static void NetAmountTest(){
        Order order = [SELECT Id, ShipmentCost__c, TotalAmount ,NetAmount__c FROM Order];

        order.shipmentCost__c = 100;
        decimal netToTest = order.TotalAmount- order.shipmentCost__c;

        Test.startTest();
        update(order);
        Test.stopTest();

       Order netCalculated = [SELECT NetAmount__c FROM Order ];
        System.assertEquals(netCalculated.NetAmount__c , netToTest);

    }

}
