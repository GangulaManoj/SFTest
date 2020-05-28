public class GetDynamicDpenedPickListLogic {
		public static Map<String,List<String>> getDependentOptionsImpl(string objectName , string controllingField , string dependentField){
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        //get the string to sobject global map
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
        
        if(!Schema.getGlobalDescribe().containsKey(objectName))
        {
            System.debug('***Object not found' + objectName);
            return null;
        }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null)
        {
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField))
        {
            System.debug('***Fields not found ' + controllingField +''+ dependentField);
            return objResults;     
        }
        
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
        List<Integer> controllingIndexes = new List<Integer>();
        Set<Integer> indexes;
        objFieldMap = null;
        
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++)
        {            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            String label = ctrlentry.getLabel();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<PicklistEntryWrapper> objJsonEntries = new List<PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++)
        {            
            Schema.PicklistEntry depentry = depEntries[dependentIndex];
            objEntries.add(depentry);
        } 
        objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
        
        for (PicklistEntryWrapper objJson : objJsonEntries)
        {
            if (objJson.validFor==null || objJson.validFor=='')
            {
                continue;
            }
            indexes = getIndexes(objJson.validFor);
            for (Integer idx : indexes)
            {                
                String contrLabel = contrEntries[idx].getLabel();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
        
        return objResults;
    }
    
    /*Used in getting picklist dependencies*/
    public class PicklistEntryWrapper
    {
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
    }
    
    Public Static String decToBin(integer num)
    {
        integer r = 0;
        String bin = '';
        integer q = num;
        for(;q>0;)
        {
            q = num / 2;
            r = num - q*2;
            bin += r;
            num = q;
        }
        for(Integer i=bin.length();i<6;i++)
        {
            bin += '0';
        }
        return(bin.reverse());
    }
    
    Public Static String b64ToBin(String b64String)
    {
        List<Integer> bitCodes = b64String.getChars();
        String bitCodeString = '';
        for(Integer i=0;i<bitCodes.size();i++)
        {
            if(bitCodes[i]>96)
                bitCodes[i] = bitCodes[i] - 71;
            else
                bitCodes[i] = bitCodes[i] - 65;     
            
            bitCodeString += decToBin(bitCodes[i]);
        }
        return bitCodeString;
    }
    
    Public Static set<Integer> getIndexes(String b64String)
    {
        Set<Integer> intSet = new Set<Integer>();
        String decodedString = b64ToBin(b64String);
        for(Integer i = 0;i<decodedString.length();i++)
        {
            if(decodedString.substring(i, i+1) == '1')
            {
                intSet.add(i);
            }
        }
        return intSet;
    }
}