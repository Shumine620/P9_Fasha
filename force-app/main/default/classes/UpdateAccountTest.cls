@isTest 
public with sharing class UpdateAccountTest {
    
    @TestSetup
    static void setup(){

        Account acc = TestDataFactory.createAccount('CATest');
        Product2 product = TestDataFactory.createProduct('XYX long green shirt','Shirt');
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product.Id,1000);
        Contract contract = TestDataFactory.createContract(acc.id);
        Order order = TestDataFactory.createOrder(acc.Id, contract.Id);
        OrderItem orderItem = TestDataFactory.createOrderItem(3, order, priceBookEntry);
        update order;
    }
        
        
@isTest
    static void updateChiffreAffaireForAccountTest() {
        
      Account acc = [SELECT Chiffre_d_affaire__c FROM Account];
      Order ord = [SELECT Id, TotalAmount FROM Order];
        
       Decimal newCA = Acc.Chiffre_d_affaire__c ;

        Test.startTest();
        update(ord);
        Test.stopTest();
       
        Account accCA = [SELECT Chiffre_d_affaire__c FROM Account];
//New Chiffre d'affaire equals initial Chiffre d'affaire
        System.assertEquals(accCA.Chiffre_d_affaire__c, newCA);
    }
    
    
}