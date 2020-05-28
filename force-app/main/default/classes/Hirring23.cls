public with sharing class Hirring23 {
    list<String> skills= new list<string>();
    
    public static String FinalJSONResult;
    @AuraEnabled
    public static String hello() {
        
        System.debug('Hi Sravanthi');
        
        StaticResource sr= [select id,body from StaticResource Where Name = 'hirring'];
        String allcontents = sr.body.toString();
        system.debug('SR@@@'+allcontents );
        
        String data1 = JSON.serialize(allcontents);
        system.debug('SR@vs'+data1 );
        transient Map<String,Object> obj= (Map<String,Object>)JSON.deserializeUntyped(allcontents); 
        system.debug('SR@vs1'+ obj.get('hiring') );
         Map<String,Object>  o=  (Map<String,Object>)obj.get('hiring');
         system.debug('hello sravs'+o);
      
       /* for(Object obj1: o.values()){
        
          
          skills1.add(obj1);
        }*/
        
        new JSONClass(JSON.serialize(o.values()));
        
       return FinalJSONResult;
        
       
    
        
    }
    
    
}