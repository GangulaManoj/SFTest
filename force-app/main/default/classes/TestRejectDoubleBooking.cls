@isTest
private class TestRejectDoubleBooking {
    
    static testmethod void TestSingleBooking()
    {
        Datetime now = System.now();
        Speaker__c speaker = new Speaker__c(First_Name__c='John', Last_Name__c='Snow');
        insert speaker;
        Session__c session = new Session__c(Name='Game Of Thron', Session_Date__c=now);
        insert session;
        Session_Speaker__c assignment =
            new Session_Speaker__c(Session__c=session.Id, Speaker__c=speaker.Id);
        Database.SaveResult result = Database.insert(assignment, false);
        System.assert(result.isSuccess());
    }
    static testmethod void TestDoubleBooking()
    {
        Datetime now = System.now();
        Speaker__c speaker = new Speaker__c(First_Name__c='John', Last_Name__c='Snow');
        insert speaker;
        Session__c session = new Session__c(Name='Game Of Thron', Session_Date__c=now);
        insert session;
         Session__c session2 = new Session__c(Name='Game Of Thron Session II', Session_Date__c=now);
        insert session2;
        Session_Speaker__c assignment =
            new Session_Speaker__c(Session__c=session.Id, Speaker__c=speaker.Id);
        Database.SaveResult result = Database.insert(assignment, false);
         Session_Speaker__c assignment2 =
            new Session_Speaker__c(Session__c=session2.Id, Speaker__c=speaker.Id);
         Database.SaveResult result2 = Database.insert(assignment2, false);
        System.assert(result.isSuccess());
          System.assert(result2.isSuccess());
    }
}