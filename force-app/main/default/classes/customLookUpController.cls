public class customLookUpController {
	public List<SObject> fetchLookUp(String key,String ObjName)
    {
        String queryString=key+'%';
        List<SObject> returnList=new List<SObject>();
        String query1='select id,Name from'+ObjName+'where Name LIKE:'+key+'order by createdDate DESC limit 5';
        List<SObject> lstOfRecords=Database.query(query1);
        for(SObject s:lstOfRecords)
        {
            returnList.add(s);
        }
        return returnList;
    }
}