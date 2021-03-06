global class SendReminderEmail implements Database.Batchable<SObject>  {
    
    global String query;
    global String subject;
    global String body;
    
    global SendReminderEmail(String query,String subject,String body)
    {
        this.query=query;
        this.subject=subject;
        this.body=body;
    }
    global Database.QueryLocator start(Database.BatchableContext cx)
    {
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext ctx,List<Speaker__c> scope)
    {
        System.debug('List Of Speakers'+scope);
        System.debug('BtachAble '+ctx.getJobId() +'Child Jobs'+ctx.getJobId());
          String[] addresses = new String[]{},subjects = new String[]{},messages = new String[]{};
        for (Speaker__c speaker : scope) {
            addresses.add(speaker.Email__c);
            subjects.add(this.subject);
            messages.add(this.body);
        }
        EmailManager.sendMail(addresses, subjects, messages);
    }
    global void finish(Database.BatchableContext ctx)
    {
        
    }
}