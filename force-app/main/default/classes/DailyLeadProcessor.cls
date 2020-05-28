global class DailyLeadProcessor implements Schedulable {
		global void execute(SchedulableContext ctx)
        {
            List<Lead> L=new List<Lead>([select id,Name,LeadSource from Lead where LeadSource='' Limit 200]);
            List<Lead> L2=new List<Lead>();
            for(Lead Lelement:L)
            {
                Lelement.LeadSource='Dreamforce';
                L2.add(Lelement);
            }
            update L2;	
        }
}