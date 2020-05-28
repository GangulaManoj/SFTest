trigger OrderEventTrigger on Order_Event__e (after insert) {
List<Task> TaskList=new List<Task>();
    for(Order_Event__e OE:Trigger.New)
    {
        system.debug('In Trigger '+trigger.new);
        if(OE.Has_Shipped__c == true)
        {
            Task Tas=new task(Priority='Medium',Subject='Follow up on shipped order '+OE.Order_Number__c,OwnerId=OE.CreatedById);
            TaskList.add(Tas);
        }
    }
    insert TaskList;
}