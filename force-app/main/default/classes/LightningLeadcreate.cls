public class LightningLeadcreate {
  @auraenabled
    public static Id creatLeadRecord(Lead leadObj){
        upsert leadObj;
        return leadObj.id;
    }
    public static List<Lead> GetLeads()
    {
        List<Lead> Llist =new List<lead>();
        Llist=[select Name,Company,Email from Lead ];
        return Llist;
    }
}