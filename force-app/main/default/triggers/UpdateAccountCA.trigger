/**
 * UpdateAccountCa's trigger to be launch after the update of the order
 **/
trigger UpdateAccountCA on Order (after update) {

    Set <Id> AccountId = new Set <Id> ();
    
    for (Order order: Trigger.new) { 
        if(order.Status == 'Ordered' && order.Status != Trigger.oldMap.get(order.Id).Status){
			AccountId.add (order.AccountId); 
        }
    } 
       if(AccountId.size() != 0)
     UpdateAccount.updateChiffreAffaire(AccountId);

}