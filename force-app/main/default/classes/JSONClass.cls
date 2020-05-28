public class JSONClass 
{
    //  objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
    //  
    
    Public Class innerWrapper
    {
        
        List<Map<String, String>> skills;
        List<String> titles;
    }
    
    
    
    Public JSONClass(String JSONString)
    {
        //  = '[{"skills":[{"applications":"54"},{"publiccloud":"30"},{"googlecloud":"0"},{"fullstack":"5"},{"hardware":"2"},{"web":"4"}],"titles":["AccountExecutive,GoogleCloudPlatform","AndroidPartnerEngineering,TechnicalSolutionsConsultant","CloudConsultant,ProfessionalServices,GoogleCloud","CustomerEngineer,GoogleCloud","FieldSalesManager,GoogleCloud(Mandarin,Cantonese)","PartnerGrowthLead,StrategicTechnologyPartners","PartnerSalesManager,GoogleCloud","PartnerSuccessManager,GoogleCloud","PSOManager,GoogleCloudProfessionalServices","SalesEngineeringManager,GoogleCloud","SolutionsArchitect,GoogleCloud","StrategicCloudEngineer,GoogleProfessionalServices(English)"]},{"skills":[{"applications":"54"},{"publiccloud":"0"},{"googlecloud":"10"},{"fullstack":"2"},{"hardware":"5"},{"web":"4"}],"titles":["AccountExecutive,GoogleCloudPlatform","AndroidPartnerEngineering,TechnicalSolutionsConsultant","CloudConsultant,ProfessionalServices,GoogleCloud","CustomerEngineer,GoogleCloud","FieldSalesManager,GoogleCloud(Mandarin,Cantonese)","PartnerGrowthLead,StrategicTechnologyPartners","PartnerSalesManager,GoogleCloud","PartnerSuccessManager,GoogleCloud","PSOManager,GoogleCloudProfessionalServices","SalesEngineeringManager,GoogleCloud","SolutionsArchitect,GoogleCloud","StrategicCloudEngineer,GoogleProfessionalServices(English)"]}]';
        //String JSONString  = '{"title":["t1", "t2"]}';
        List<innerWrapper> wrapper = new List<innerWrapper>();
        
        Map<String, Integer> summaryMap = new Map<String, Integer>();
        
        wrapper = (List<innerWrapper>)JSON.deserialize(JSONString, List<innerWrapper>.class);
        for(innerWrapper wrapperInstance :wrapper)
        {
            for(Map<String, String> mapInstance :wrapperInstance.skills)
            {
                for(String key :mapInstance.keySet())
                {
                    if(summaryMap.get(key) != null)
                    {
                        Integer bufferVariable = summaryMap.get(key);
                        bufferVariable += Integer.valueOf(mapInstance.get(key));
                        summaryMap.put(key, bufferVariable);
                    }
                    else
                    {
                        summaryMap.put(key, Integer.valueOf(mapInstance.get(key)));
                    }
                }
                
            }
        }
        for(innerWrapper wrapperInstance :wrapper)
        {
            for(Map<String, String> mapInstance :wrapperInstance.skills)
            {
                for(String key :mapInstance.keySet())
                {
                    if(summaryMap.get(key) != null)
                    {
                        String bufferVariable = String.valueOf(summaryMap.get(key));
                        mapInstance.put(key, bufferVariable);
                    }
                }
            }
        }
        System.debug('Serialize code '+JSON.serialize(wrapper));
        Hirring23.FinalJSONResult=JSON.serialize(wrapper);
    }
}