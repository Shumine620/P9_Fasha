@isTest
public class NetAmountTriggerTest {

      @TestSetup
    static void setup(){
        Account acc = TestDataFactory.createAccount('AccountTestTrigger');
        List <Order> ordersList = TestDataFactory.createAccountWithOrders(10); 
    }
   
 @isTest
    static void TotalAmountOfOneAccountWithSeveralOrders(){
        
         	Account acc =[SELECT Id FROM Account WHERE Name ='AccountTestTrigger' ];
      		List <Order> ordersList = [SELECT Id, AccountId, ShipmentCost__c,TotalAmount,NetAmount__c FROM Order ];
        
       		 	Decimal total =0; 
         		Decimal netToTest =0;
            	Decimal netShip = 0;
            	       
        for(Order ord : ordersList) {
             	ord.Status = 'Ordered';
            	ord.ShipmentCost__c= 100;           
                                       
           //Create the list of Ids for each order 
            	 List<Id> OrdersId = new List<Id>();
                	for(Order o : ordersList) {
            			ordersId.add(o.Id);
                }
            update ordersList;
        }
         // Get the price of the total ShipmentCost for all orders
            for(Order order : ordersList){
                 	total += order.TotalAmount;
                	netShip += order.ShipmentCost__c ; 
           			netToTest = total - netShip;
       }
     Test.startTest();
     update ordersList; 
     Test.stopTest();  
           
        System.assertEquals(100000, total) ;               
        
    } 
    @isTest
    static void NetAmountOfOneAccountWithSeveralOrders(){
        
         	Account acc =[SELECT Id FROM Account WHERE Name ='AccountTestTrigger' ];
      		List <Order> ordersList = [SELECT Id, AccountId, ShipmentCost__c,TotalAmount,NetAmount__c FROM Order ];
        
       		 	Decimal total =0; 
         		Decimal netToTest =0;
            	Decimal netShip = 0;
            	       
        for(Order ord : ordersList) {
             	ord.Status = 'Ordered';
            	ord.ShipmentCost__c= 100;           
                                       
           //Create the list of Ids for each order 
            	 List<Id> OrdersId = new List<Id>();
                	for(Order o : ordersList) {
            			ordersId.add(o.Id);
                }
            update ordersList;
        }
         // Get the price of the total ShipmentCost for all orders
            for(Order order : ordersList){
                 	total += order.TotalAmount;
                	netShip += order.ShipmentCost__c ; 
           			netToTest = total - netShip;
       }
     Test.startTest();
     update ordersList; 
     Test.stopTest();  
        
   //  (10 orders * 1000 unitprice)- 100*10 = 99000
        System.assertEquals(99000 ,netToTest);
                 
        
    } 
}