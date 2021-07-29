public class UpdateAccount {
    public static void updateChiffreAffaire(Set<Id> AccountId) {
        Map<Id, Account> accountWithOrders = new Map<Id, Account>([SELECT Id, Chiffre_d_affaire__c, 
        (SELECT Id, TotalAmount FROM Orders WHERE Status = 'Ordered') FROM Account WHERE id in: AccountId]);
        
        for(Account account : accountWithOrders.values()){
            Decimal totalAmount = 0;
            for(Order order : account.Orders){
                totalAmount += order.totalAmount;
            } 
            account.Chiffre_d_affaire__c = totalAmount;
            accountWithOrders.put(account.Id, account);
        }    
        update accountWithOrders.values();
    }    
 }