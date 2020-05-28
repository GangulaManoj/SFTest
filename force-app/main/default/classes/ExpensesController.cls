public with sharing class ExpensesController {
		
    	@AuraEnabled
    	public static List<Expense__c> getExpenses()
        {
            return [select 	Name,Amount__c,	Client__c,Date__c,Reimbursed__c from Expense__c];
        }
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c ex)
    {
        upsert ex;
        return ex;
    }
}