public class LightiningCampaignCreate {
@auraenabled
    public static Id creatCampaignRecord(Campaign CampaignObj){
        upsert CampaignObj;
        return CampaignObj.Id;
    }
}