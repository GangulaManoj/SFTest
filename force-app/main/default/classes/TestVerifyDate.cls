@isTest
private class TestVerifyDate {
    @isTest static void CheckDate(){
        Date testdate=VerifyDate.CheckDates(Date.valueOf('2018-02-01') ,Date.valueOf('2018-02-27') );
        System.assertEquals(Date.valueOf('2018-02-27'), testdate);
    }
    @isTest static void PastDate(){
        Date testdate=VerifyDate.CheckDates(Date.valueOf('2018-02-01') ,Date.valueOf('2018-01-27') );
        System.assertEquals(Date.valueOf('2018-02-28'), testdate);
    }
    @isTest static void FutureDate(){
        Date testdate=VerifyDate.CheckDates(Date.valueOf('2018-02-01') ,Date.valueOf('2018-03-27') );
        System.assertEquals(Date.valueOf('2018-02-28'), testdate);
    }
}