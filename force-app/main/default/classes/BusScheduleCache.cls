public class BusScheduleCache {
    
    private Cache.OrgPartition part;
    
    public BusScheduleCache()
    {
        Cache.OrgPartition orgPart =Cache.Org.getPartition('local.BusSchedule');
        System.debug('Partion  '+orgPart);
        if(orgPart != null){
            part=OrgPart;
        }
    }
    public void putSchedule(String  busLine,Time[] schedule)
    {
        Cache.Org.put(busline, schedule);
    }
    public Time[] getSchedule(String busLine)
    {
        Time[] schedule= new List<Time>();
        Object obj=Cache.Org.get(busLine);
         Time t2;
        if(obj !=null)
        {
            t2 = (Time)obj;
        }
        if (t2 != null) {
            schedule.add(t2);
        }
        else {
            Time t3 = Time.newInstance(8,0,0,0);
            schedule.add(t3);
            Time t4 = Time.newInstance(17,0,0,0);
            schedule.add(t4);
        }        
        return schedule;
    }
}