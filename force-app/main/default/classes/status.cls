public class status{

    private final string applicant='0037F00000nrQ5pQAE';

    public Static Blob resume {get; set;}

    public Static String contentType {get; set;}

    public Static String fileName {get; set;}

    public List<Attachment> favlist {set; get;}

    public Attachment att{get;set;}

    public boolean show{get;set;}   

    public status(ApexPages.StandardController stdController) {
			show=false;
       // applicant=ApexPages.currentPage().getParameters().get('id');

    }

    public PageReference saveApplication() {

       	System.debug('FileName'+resume);

        if(resume!=null){
			show=true;
            Attachment attach=new Attachment();

            attach.Body=resume;

            attach.Name=filename;

            attach.ContentType=contentType;

            attach.ParentID=id.valueof(applicant);

            try {

                insert(attach);

               

                

                 system.debug('hellooooo1111111'+favlist);

               att =new attachment();

                for(Attachment a:[select id,body, Name from Attachment order by createddate desc limit 1]){

                    att = a;

                  

                }

                system.debug('attachment'+att);

            } catch(System.DMLException e) {

                ApexPages.addMessages(e);

                return null;

            }

        }

       // PageReference p = Page.Confirmpage;

       // p.setRedirect(true);

        return null;                   

    }

}