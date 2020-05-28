public class Ordersentry {
  private integer count=1;   //to track the function calling
    private integer counter=0;   //to keep track of offset
    private integer limitSize=2; //to set the page size to show the rows/reco
    public integer totalsize=0; //used to show user the total size of the list  
    public List<wrapperClass> paginationList{get;set;}
    public List<wrapperClass> wrapperList{get;set;}
    public Set<wrapperClass> FinalDelete{get;set;}
      private final Order order;
    
     public Product2 product1{get;set;}
    
    public List<OrderItem> OrderLineItem{get;set;}
         public List<OrderItem> deleteOrderList = new List<OrderItem>();
    public Ordersentry(ApexPages.StandardController controller){
        system.debug(controller);
        this.order = (Order)controller.getRecord();
       OrderLineItem=new List<OrderItem>();
        paginationList=new List<wrapperClass>();
        wrapperList=new List<wrapperClass>();
         FinalDelete=new Set<wrapperClass>();
        product1 = new Product2();
        
    }
   


    public String baddress{get;set;}
    public String saddress{get;set;}
    public Id accid{get;set;}
     public Id proid{get;set;}
    public Account a{get;set;}
         public List<OrderItem> OrderLineItemtoinsert{get;set;}
    public PricebookEntry p{get;set;}
   
    public String FamilyVal{get;set;}
    
    public void autopopaddress(){
        a=[SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry FROM Account where id=:accid];
        
        baddress=a.BillingStreet+' '+a.BillingCity+' '+a.BillingState+' '+a.BillingPostalCode+' '+a.BillingCountry;
        saddress=a.ShippingStreet+' '+a.ShippingCity+' '+a.ShippingState+' '+a.ShippingPostalCode+' '+a.ShippingCountry;
    
    }
     public void autopopDetails(){
         System.debug('ProID'+proid);
        product1=[select ID,Family from Product2 where id=:proid];
         
        FamilyVal=product1.Family;
         System.debug('family val '+FamilyVal);
     }
/*    public List<OrderItem> getOLineItems()
    {
       
       // OrderLineItem=[select OrderId,OrderItemNumber,TotalPrice,UnitPrice,Quantity from OrderItem];
        //return OrderLineItem;
    }*/
    public void beginning(){
      updateFinalDelete();
        paginationList.clear();
        counter=0;
        if((counter + limitSize) <= wrapperList.size()){
       
            for(Integer i=0;i<limitSize;i++){
                paginationList.add(wrapperList.get(i));
            }   
           
        } else{
       
            for(Integer i=0;i<wrapperList.size();i++){
                System.debug('WrapperListSize In begining'+wrapperList.size());
                paginationList.add(wrapperList.get(i));
            }       
           
        }
       
    }
     public void next(){
		updateFinalDelete();   
        paginationList.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= wrapperList.size()){
            for(Integer i=counter;i<(counter+limitSize);i++){
                paginationList.add(wrapperList.get(i));
            }
        } else{
            for(Integer i=counter;i<wrapperList.size();i++){
                paginationList.add(wrapperList.get(i));
            }
        }
    }
    public void previous(){
   		updateFinalDelete();
        paginationList.clear();

        counter=counter-limitSize;       
       
        for(Integer i=counter;i<(counter+limitSize); i++){
            paginationList.add(wrapperList.get(i));
        }
    }
    
    public void last (){
        updateFinalDelete();
        paginationList.clear();
       
        if(math.mod(wrapperList.size() , limitSize) == 0){
            counter = limitSize * ((wrapperList.size()/limitSize)-1);
        } else if (math.mod(wrapperList.size() , limitSize) != 0){
            counter = limitSize * ((wrapperList.size()/limitSize));
        }
       
        for(Integer i=counter;i<wrapperList.size();i++){
                paginationList.add(wrapperList.get(i));
        }
       
    }
      public Boolean getDisableNext(){
   
        if((counter + limitSize) >= wrapperList.size() )
            return true ;
        else
            return false ;
    }
   
    public Boolean getDisablePrevious(){
   
        if(counter == 0)
            return true ;
        else
            return false ;
    }
    public void NewOrderItem()
    {
        updateFinalDelete();
        orderItem o = new orderItem();
       
        OrderLineItem.add(o);
        totalsize=OrderLineItem.size();
        System.debug('size'+totalsize);
        wrapperClass w=new wrapperClass();
        w.oi=o;
        wrapperList.add(w);
        if(totalsize<=limitSize)
        {
            beginning();
        }
        else
        {
            last();
        }
    }
    public void DeleteRows()
    {
        updateFinalDelete();
         System.debug('InDELROWS'+FinalDelete.size());
        for(wrapperClass w:FinalDelete)
        {
            if(w.selected==true)
            {
                for(Integer i=wrapperList.size()-1;i>=0;i--)
                {
                    if(wrapperList.get(i) == w)
                    {
                        for(Integer j=OrderLineItem.size()-1;j>=0;j--)
                        {
                            if(OrderLineItem.get(j) == w.oi)
                            {
                                 System.debug('In orderLine If ');
                                OrderLineItem.remove(j);
                            }
                        }
                        System.debug('In Wrapp If ');
                        System.debug('WrapperListSize'+wrapperList.get(i));
                       wrapperList.remove(i);
                    }
                }
                
            }
        }
        FinalDelete.clear();
        paginationList.clear();
        if(wrapperList.size()<=limitSize)
        {
            beginning();
        }
        else
        {
            last();
        }
    }
     public void removeOrderItem(){
        
     Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));
      System.debug('In removeOrder List'+OrderLineItem.size()); 
         system.debug('index value'+indexVal);
    // System.debug('Index'+OrderLineItem[indexVal-1].Id);
      //  System.debug('Index'+indexVal); 
         if(OrderLineItem[indexVal - 1].Id != null)
    deleteOrderList.add(OrderLineItem[indexVal - 1]);
    //Remove the contact from the table  
       OrderLineItem.remove(indexVal - 1); 
          beginning();
      
                      
	}
    public void doSave()
    {
        system.debug('Order Details'+order);
     
        order.billingstreet=a.billingstreet;
            order.BillingCity = a.BillingCity;
           order.BillingState = a.BillingState;
            order.BillingPostalCode= a.BillingPostalCode;
           order.BillingCountry = a.BillingCountry;
         order.ShippingStreet=a.ShippingStreet;
           order.ShippingCity= a.ShippingCity;
            order.ShippingState=a.ShippingState;
           order.ShippingPostalCode= a.ShippingPostalCode;
            order.ShippingCountry=a.ShippingCountry;
        order.Pricebook2Id='01s7F000007Feo3QAC';
        insert order;
      
        OrderLineItemtoinsert=new List<orderItem>();
      
    
        for(orderItem o:OrderLineItem)
        {
            system.debug(o.Product2Id);
            //system.debug('');
            system.debug(o.quantity);
            p=[select id,Pricebook2Id,UnitPrice from PricebookEntry where Product2Id=:o.Product2Id and Pricebook2Id='01s7F000007Feo3QAC'];
            system.debug(p);
            
            o.OrderId=order.Id;
            o.PricebookEntryId=p.id;
             o.UnitPrice=p.UnitPrice;   
           
            OrderLineItemtoinsert.add(o);

            
        }
   
    
        insert OrderLineItemtoinsert;
        
        
    }
    public void updateFinalDelete()
    {
         for(wrapperClass w:paginationList)
        {
            if(w.selected==true)
            {
               FinalDelete.add(w); 
            }
        }
        
    }
    class wrapperClass
    {
        public boolean selected {get;set;}
        public orderItem oi{get;set;}
        wrapperClass()
        {
            selected=false;
            
        }
    }

    
 }