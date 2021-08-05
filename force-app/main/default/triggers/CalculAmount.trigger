/**
 * CalculAmount's trigger to be launch before the update of the order
 **/
trigger CalculAmount on Order (before update) {
	
	for(Order newOrder: Trigger.New){
		
		//Condition the null value of ShipmentCost to avoid compiling errors

		if(newOrder.ShipmentCost__c == null) {
			newOrder.ShipmentCost__c = 0;
            newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
        }
        else{
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}
}
}