public with sharing class OpenActvites {
    
	@AuraEnabled
    public Static String getOpenActvit(id recordId)
    {
         List<openActivityWrapper> oaWrapperList = new List<openActivityWrapper>();
        String ObjectName=recordId.getSobjectType().getDescribe().getName();
       Account a=[SELECT Name, (SELECT AccountId, Id, WhoId, WhatId, Status, Subject, What.Name, Who.Name FROM OpenActivities  ORDER BY ActivityDate ASC NULLS LAST, LastModifiedDate DESC LIMIT 500 ) FROM Account WHERE Id = :recordId];
        for(OpenActivity o:a.OpenActivities)
        {
            openActivityWrapper OA=new openActivityWrapper(o.AccountId,o.WhoId,o.WhatId,o.Status,o.Subject,o.id);
            oaWrapperList.add(OA);
            System.debug('Task Data'+OA);
        }
        return JSON.serialize(oaWrapperList);
    }
    Public Class openActivityWrapper
    {
        Id AccountId;
        String WhoId;
        String Name;
        String WhatId;
        String relatedTo;
        String Status;
        String Subject;
        Id Id;
        String ActivitySubtype;
        
        Public openActivityWrapper(Id AccountId, Id WhoId, Id WhatId, String Status, String Subject, Id Id)
        {
            this.AccountId = AccountId;
            this.WhoId = '/'+WhoId;
        
            this.WhatId = '/'+WhatId;
           
            this.Status = Status;
            this.Subject = Subject;
            this.Id = Id;
        }
    }
}