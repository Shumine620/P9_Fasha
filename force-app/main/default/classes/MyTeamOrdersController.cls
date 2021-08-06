
/**
 *  @description       : Apex class to obtain the sum of the TotalAmount of the orders with the status 'Ordered'
 *  Aggregate function in SOQL allows you to roll up and summarize your data in a query.
 **/
public with sharing class MyTeamOrdersController {
    public static decimal SumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status ='Ordered' ];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}