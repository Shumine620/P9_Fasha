({
	init : function(component, event, helper) {
		
        component.set("v.columns", [
            {label: 'Commercial', fieldName: 'Name', type: 'text'},
            {label: 'Total des commandes', fieldName: 'orderCount'},
            {label: 'Montant des commandes', fieldName: 'sumOrders', type: 'currency', typeAttributes: { currencyCode: 'EUR', maximumSignificantDigits: 5}}
        ])
         
        const fetchData = component.get("c.teamSumOrders");
       
        fetchData.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            component.set("v.data", response.getReturnValue());
        });

        $A.enqueueAction(fetchData);
	}
})