public class TheStreetController { 
   // public integer day{get;set;}
     public List<Integer> nofdays{get;set;}
    // public static Integer Year=date.today().year();
     // public static Integer month= date.today().month();
     public Date tday=date.today();
    public String SelectedValue{get;set;}
    public List<CaseOn> CaseOnList{get;set;}
    public List<CaseList> CaseesList{get;set;}
    Map<String,List<CaseOn>> CMap{get;set;}
    
   public TheStreetController()
   {
       nofdays=new List<Integer>();
       CaseOnList=new List<CaseOn>();
       CaseesList=new List<CaseList>();
       CMap=new Map<String,List<CaseOn>>();
   }
    public List<Integer> getalldays()
    {
       
       //Day =System.today();
      //System.debug('Month'+ date.today().month()+'Day'+date.today().day()+'year'+date.today().year()+'days in a month'+date.daysInMonth(date.today().year(), date.today().month()));
     
        for(integer i=1;i<=(Date.daysInMonth(tday.year(),tday.month()));i++)
        {
            nofdays.add(i);
        }
          System.debug('My Date'+dateTime.now());
     	 //Date d2=new Date(dateTime.now());
     	 DateTime d=dateTime.now();
        System.debug(d.date().format());
        return nofdays;
      
    }
    public List<SelectOption> getpickval(){
        List<SelectOption> Plist=new List<SelectOption>();
        Plist.add(new SelectOption('BU','BU'));
        Plist.add(new SelectOption('TownShip','TownShip'));
        Plist.add(new SelectOption('Phases','Phases'));
        return Plist;
    }
  /*  
    public Set<BusinessUnit> getCases(List<Case> cases)
    {
        Set<BusinessUnit> BL=new Set<BusinessUnit>();
         for(Case c:cases)
        {
            
            integer count=1;
            for(Case c2:cases)
            {
                if(c.Created_Date__c == c2.Created_Date__c)
                {
                    count++;
                }
            }
            BusinessUnit b=new BusinessUnit(c.Business_Units__c,count,c.Created_Date__c);
            BL.add(b);
        }
        return BL;
	}*/
   // public Map<String,Object> map1=new Map<String,Object>();
    public void getcases()
    {
         
        for(Object o:(List<Object>)JSON.deserializeUntyped(JSON.serialize([select Created_Date__c,Unit__r.Name,Unit__r.Phase__r.Name,Unit__r.Phase__r.TownShip__r.Name,Unit__r.Phase__r.TownShip__r.Business_Unit__r.Name from case])))
        {
           CaseList  cl=new CaseList();
            Map<String,Object> map1=new Map<String,Object>();
            map1=(Map<String,Object>)o;
            String da=(String)(map1.get('Created_Date__c'));
            String[] split=da.split('-');
            da=split[1]+'/'+split[2]+'/'+split[0];
            cl.createdDate=Date.parse(da);
            System.debug('Date Chk'+cl.createdDate.day());
            if(map1.containsKey('Unit__r'))
            {
            Map<String,Object> UnitMap= (Map<String,Object>)((map1.get('Unit__r')));
          
             cl.Unit=(String)UnitMap.get('Name');
       
            System.debug('cl'+cl.Unit);
            
            Map<String,Object> PhaseMap = (Map<String,Object>)((UnitMap.get('Phase__r')));
             cl.Phase=(String)PhaseMap.get('Name');
                System.debug('pl'+cl.Phase);
             Map<String,Object> TownMap = (Map<String,Object>)((PhaseMap.get('TownShip__r')));
			cl.TownShip=(String)TownMap.get('Name');
                System.debug('Tl'+cl.TownShip);
            Map<String,Object> BUMap = (Map<String,Object>)((TownMap.get('Business_Unit__r')));
			cl.BU=(String)BUMap.get('Name');
                System.debug('BUl'+cl.BU);
            System.debug('Map data'+cl);
                CaseesList.add(cl);
        }
        }
    }
    public class CaseList
    {
        public Date createdDate{get;set;}
        public String Unit{get;set;}
        public String Phase{get;set;}
        public String TownShip{get;set;}
        public String BU{get;set;}
        public CaseList()
        {
            
        }
       /* public CaseList(Date createdDate,String Unit,String Phase,String TownShip,String BU)
        {
            this.createdDate=createdDate;
            this.Unit=Unit;
            this.Phase=Phase;
            this.TownShip=TownShip;
            this.BU=BU;
        }*/
	}
    public class CaseOn
    {
        public String CaseType{get;set;}
        public List<CaesesOnDay> COD{get;set;}
    }
    public class CaesesOnDay
    {
         public Integer CaseDay{get;set;}
        public Integer NumberOfCases{get;set;}
    }
    public List<CaseOn> NoOfcases()
    {
        getcases();
        return null;
    }
    public Map<String,List<CaseOn>> getSpecificCases(String PickValue)
    {
     Map<String,List<CaseOn>> CMap=new Map<String,List<CaseOn>>();
        List<CaseOn> Clist=new list<CaseOn>();
        if(/*SelectedValue=='BU'*/true)
        {
            CMap.put(PickValue,new List<CaseOn>());
        for(CaseList c:CaseesList)
        {
            System.debug('SizeMap'+CMap.get(PickValue).size());
            if(Clist.size()!=0)
            {
                
                integer flag2=0;
                for(CaseOn CON:Clist)
                {
                    
                    if(c.BU==CON.CaseType)
                    {
                        flag2=1;
                        CaesesOnDay CODay=new CaesesOnDay();
                        Integer flag=0;
                        for(CaesesOnDay CODList:CON.COD)
                        {
                            if(c.createdDate.day() == CODList.CaseDay)
                            {
                                CODList.NumberOfCases+=1;
                                System.debug('Numbers'+CODList.NumberOfCases);
                                flag=1;
                            }
                        }
                        if(flag==0)
                        {
                            CODay.CaseDay=c.createdDate.day();
                            CODay.NumberOfCases=1;
                            CON.COD.add(CODay);
                        }
                        
                        
                    }
                }
                if(flag2==0)
                {
                     CaseOn CONRefer=new CaseOn();
                List<CaesesOnDay> CDayList=new List<CaesesOnDay>();
                CONRefer.CaseType=c.BU;
                 CaesesOnDay CaseOnDa=new CaesesOnDay();
                 CaseOnDa.CaseDay=c.createdDate.day();
                 CaseOnDa.NumberOfCases=1;
                CDayList.add(CaseOnDa);
               CONRefer.COD=CDayList;
                Clist.add(CONRefer);
                }
            }
            else
            {
                CaseOn CONRefer=new CaseOn();
                List<CaesesOnDay> CDayList=new List<CaesesOnDay>();
                CONRefer.CaseType=c.BU;
                 CaesesOnDay CaseOnDa=new CaesesOnDay();
                 CaseOnDa.CaseDay=c.createdDate.day();
                 CaseOnDa.NumberOfCases=1;
                CDayList.add(CaseOnDa);
               CONRefer.COD=CDayList;
                Clist.add(CONRefer);

            }
        }
         CMap.get(PickValue).addall(Clist);
        }
        System.debug('List'+CMap);
        return CMap;   
    }
}