@RestResource(urlMapping='/TestManoj')
global class RestClasswithQueueable {
 
    @HttpPost
    global static String callCallout(String AccountNumber)
    {
        ID jobId = System.enqueueJob(new QueueableclassGetAccount(AccountNumber));
        AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
        system.debug('Job Info'+jobInfo.Status);
        return null;
    }
}