@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP='0 0 0 15 3 ? 2022';
	static testmethod void testLeads()
    {
         
       List<Lead> InsertLead=new List<Lead>();
        for(Integer i=0;i<200;i++)
        {
            Lead lead1=new Lead(LastName='Lead'+i,Company='LeadCompany'+i,Status='Open - Not Contacted');
            InsertLead.add(lead1);
        }
        insert InsertLead;
        map<Id,Lead> LeadMap=new map<Id,Lead>(InsertLead);
        List<Id> ids=new List<Id>(LeadMap.keySet());
        Test.startTest();
         String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor()); 
      // List<Lead> L1=new List<Lead>([select id,Name,LeadSource from Lead where Id IN: ids and LeadSource='']); 
        //System.assertEquals(0,InsertLead.size(), 'Field Update before Job run');
        
        Test.stopTest();	
    }
}