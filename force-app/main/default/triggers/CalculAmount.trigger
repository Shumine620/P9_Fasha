trigger CalculAmount on Order (before update) {
	
	for(Order newOrder: Trigger.New){
		if(newOrder.ShipmentCost__c == null) {
			newOrder.ShipmentCost__c = 0;
            newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
        }
        else{
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}
}
}