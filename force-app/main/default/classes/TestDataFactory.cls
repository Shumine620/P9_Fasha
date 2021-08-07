
/** 
 *  Public class to create datas for the test classes
 **/

@isTest
public class TestDataFactory {
    
    public static Account createAccount(String name) {
        Account account = new Account( Name=name);
        insert account;
        return account;
    }
    
    public static Contract createContract(Id accountId) {
        Contract contract = New Contract(AccountId= accountId,
                                         StartDate= System.today(),
                                         ContractTerm=12,
                                         Status='Draft',
                                        Name = 'contractTest');
        insert contract;
        contract.Status = 'Activated';
       update contract;
        return contract;
    }

    public static Product2 createProduct() {
        Product2 product = new Product2(
            IsActive =true,
            Name = 'ProductTest'
                      );
        insert product;
        return product;
    }
    
     public static PricebookEntry createPricebookEntry(Id productId, Decimal amount) {
        PricebookEntry priceBookEntry = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = productId,
            UnitPrice = amount,
            IsActive = true
        );
        insert priceBookEntry;
        return priceBookEntry;     
     }
    
  public static Order createOrder(Id accountId, PricebookEntry priceBookEntry){
         
        Order order = New Order (
        AccountId = accountId,
        Status ='Draft',
        EffectiveDate = Date.today(),
        Pricebook2Id = pricebookEntry.Pricebook2ID
        );       
        insert order;
        return order;   
    }            
   
      
     public static OrderItem createOrderItem(Id orderId, Id productId, Integer quantity, Decimal unitPrice, Id priceBookEntryId) {
        OrderItem orderItem = new OrderItem(
        OrderId=orderId,
        Product2Id= productId,
        Quantity= quantity,
        UnitPrice=unitPrice,
        PricebookEntryId= priceBookEntryId
          );
        insert orderItem;
        return orderItem;
    }
    
     //Methode to create a list of Accounts
     public static List<Account> createAccounts(Integer accountNumber) {
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0 ; i < accountNumber; i++) {
                Account accts = new Account(
                Name = 'AccountTest '+i,
                chiffre_d_affaire__c=0
                );
            accounts.add(accts);
        }
        insert accounts;
        return accounts;
    }
    
      //Methode to create a list of Orders
     public static List<Order> createOrders(Account account, PricebookEntry priceBookEntry, Integer numberOrder) {
        List<Order> orders = new List<Order>();
         
        for(Integer i = 0; i < numberOrder; i++){
            Order order = TestDataFactory.createOrder(account.Id, priceBookEntry);
            order.Name='OrdersTest'+i;
            orders.add(order);
        }
        return orders;
    }

  //Methode to create a list of OrderItems
    public static List<OrderItem> createOrderItems(Integer quantity, List<Order> orders, PricebookEntry priceBookEntry) {
        List<OrderItem> orderItems = new List<OrderItem>();
               for (Order order : orders){
                   OrderItem orderItem = new OrderItem(
                    OrderId = order.Id,
                    PricebookEntryId = priceBookEntry.Id,
                   UnitPrice = priceBookEntry.UnitPrice,
                    Quantity = quantity
            );
            orderItems.add(orderItem);
        }
        insert orderItems;
        return orderItems;
    }
    //Methode to create One account with several orders
    public static List<Order> createAccountWithOrders(Integer numberOrders) {
        List<Order> ordersList = new List<Order> ();
       
        Account acc = TestDataFactory.createAccount('AccountTest');
        Contract contract = TestDataFactory.createContract(acc.Id);
        Product2 product2 = TestDataFactory.createProduct();
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product2.Id,100);
        
         // Create the list of orders 
        for(Integer i=0; i<numberOrders; i++) {
            Order order = TestDataFactory.createOrder(acc.Id, priceBookEntry);
            ordersList.add(order);
        }
                  
        for(Integer i = 0 ; i< numberOrders; i++) {
            for(Order order : ordersList) {
            OrderItem orderItem = TestDataFactory.createOrderItem(order.Id, product2.Id, 1, 1000, priceBookEntry.Id);
            }       
       update ordersList;
        }
        return ordersList;
    }
    
      
}