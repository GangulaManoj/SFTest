trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
		
    List<BatchLeadConvertErrors__c> BatchLeadConver=new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent batchError:Trigger.New)
    {
        BatchLeadConvertErrors__c bacth=new BatchLeadConvertErrors__c();
        bacth.AsyncApexJobId__c=batchError.AsyncApexJobId;
        bacth.Records__c=batchError.JobScope;
        bacth.StackTrace__c=batchError.StackTrace;
        BatchLeadConver.add(bacth);
    }
    insert BatchLeadConver;
}