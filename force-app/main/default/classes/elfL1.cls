public class elfL1 {
    @AuraEnabled public static Lead         getLead(){
       
        return (Lead) Database.query( ' select Name,Company,Email from Lead DESC  Limit 1' );
    }
    @AuraEnabled public static Lead EditLead(Lead account){
        upsert account;
        return account;
    }   
}