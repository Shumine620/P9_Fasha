@isTest
public class TestDataFactory {
    
    public static Account createAccount(String name) {
        Account account = new Account(
            Name = 'AccountTest',
            chiffre_d_affaire__c=0);
        
        insert account;
        return account;
    }


    public static Product2 createProduct(String name, String family) {
        Product2 product = new Product2(
            Name = name,
            Family = family,
            IsActive = true);
        insert product;
        return product;
    }

 
    public static PricebookEntry createPriceBookEntry(Id productId, Decimal amount) {
        PricebookEntry priceBook = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = productId,
            UnitPrice = 100,
            IsActive = true);
        
        insert priceBook;
        return priceBook;
    }

public static Contract createContract(Id accountId) {
        Contract contract = New Contract(Name = 'ContractTest', AccountId= accountId, StartDate= System.today(), ContractTerm=12, Status='Draft');
        insert contract;
         contract.Status = 'Activated';
         update contract;
        return contract;
    }
    public static Order createOrder(Id accountId, Id contractId) {
        Order order = new Order (
        AccountId= accountId,
        ContractId= contractId,
        Status='Draft',
        EffectiveDate= Date.today(),
        Pricebook2Id= Test.getStandardPricebookId()
        );
        insert order;
        return order;
    }

   public static OrderItem createOrderItem(Integer quantity, Order order, PricebookEntry priceBookEntry) {
        OrderItem orderItem = new OrderItem(
            OrderId = order.Id, 
            PricebookEntryId = priceBookEntry.Id,
            Quantity = quantity,
            UnitPrice = 100);
       
       insert orderItem;
        return orderItem;
    }
   
    public static List<Account> createAccounts(Integer accountNumber) {
        List<Account> accounts = new List<Account>();
        
        for (Integer i=0; i < accountNumber; i++) {
            	Account accts = new Account(
                Name='AccountTest '+i,
                chiffre_d_affaire__c=0);
            accounts.add(accts);
        }
        
        insert accounts;
        return accounts;
    }


    public static List<Order> createOrders( List<Account>accts, PricebookEntry priceBookEntry, Integer ordersNumber) {
        List<Order> orders = new List<Order>();
        for (Integer a = 0 ; a < accts.size() ; a++) {
            Account acct = accts[a];
            
        for(Integer i=0;  i< ordersNumber; i++){
            Order order = new Order();
            order.Name='OrderTest '+i;
            order.Status = 'Ordered';
            orders.add(order);
        }
        }
       // insert orders;
        return orders;
    }


    public static List<OrderItem> createOrderItems(Integer quantity, List<Order> orders, PricebookEntry priceBookEntry) {
         List<OrderItem> orderItems = new List<OrderItem>();
        for (Order order : orders) {
            OrderItem orderItem = new OrderItem(
                    OrderId = order.Id,
                    PricebookEntryId = priceBookEntry.Id,
                    UnitPrice = priceBookEntry.UnitPrice,
                    Quantity = quantity
            );
            orderItems.add(orderItem);
        }
        
        return orderItems;
    }

}