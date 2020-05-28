trigger HelloWorldTrigger on Account (before insert) {
System.debug('Hello Wirld');
     for(Account a : Trigger.New) {
        a.Description = 'New description';
    } 
}