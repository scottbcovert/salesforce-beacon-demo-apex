@RestResource(urlMapping='/locationOpps/v1.0.0/*')
global with sharing class SalesforceBeaconDemoController {

    @HttpGet
    global static Opportunity getOpportunities() {
        String contactId = RestContext.request.params.get('contactId');
        list<OpportunityContactRole> ocr = [SELECT Id, Contactid, OpportunityId FROM OpportunityContactRole WHERE ContactId = :contactId LIMIT 1];
        if (!ocr.isEmpty()){
        	list<Opportunity> opp = [SELECT Id, Name, Description, StageName FROM Opportunity WHERE Id = :ocr[0].OpportunityId AND StageName != 'Closed Won' AND StageName != 'Closed Lost' LIMIT 1];
        	if (!opp.isEmpty()){
        		return opp[0];
        	}
        }
        return null;
        
	}

}