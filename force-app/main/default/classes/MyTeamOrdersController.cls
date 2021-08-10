public without sharing class MyTeamOrdersController {
/**
 *  @description       : Apex class to obtain the sum of the TotalAmount of the orders with the status 'Ordered'
 *  Aggregate function in SOQL allows you to roll up and summarize your data in a query.
 **/
@AuraEnabled
public static List<AggregateResult> teamSumOrders(){
   
    List<AggregateResult> groupedResults = [SELECT Owner.Name,SUM(TotalAmount) sumOrders,
                          COUNT(Id) orderCount FROM Order WHERE Status = 'Ordered' GROUP BY Owner.Name];
    return groupedResults;
}

}