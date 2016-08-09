@RestResource(urlMapping='/locationOpps/v2.0.0/*')
global with sharing class SalesforceBeaconDemoController_v2_0_0 {

    @HttpGet
    global static Opportunity getOpportunities() {
        String contactId = RestContext.request.params.get('contactId');
        String beaconIdentifier = RestContext.request.params.get('identifier');
        String beaconUuid = RestContext.request.params.get('uuid');
        String beaconMajor = RestContext.request.params.get('major');
        String beaconMinor = RestContext.request.params.get('minor');        
        String type = RestContext.request.params.get('type');
        list<OpportunityContactRole> ocr = [SELECT Id, Contactid, OpportunityId FROM OpportunityContactRole WHERE ContactId = :contactId LIMIT 1];
        if (!ocr.isEmpty()){
        	list<Opportunity> opp = [SELECT Id, Name, Description, StageName FROM Opportunity WHERE Id = :ocr[0].OpportunityId AND StageName != 'Closed Won' AND StageName != 'Closed Lost' LIMIT 1];
        	if (!opp.isEmpty()){
        		if (type == 'entered')
        		{
        			// Insert mobile activity & beacon info if necessary
	        		Beacon__c matchingBeacon = new Beacon__c(Identifier__c = beaconIdentifier, Uuid__c = beaconUuid, Major__c = beaconMajor, Minor__c = beaconMinor);
	        		Mobile_Activity__c newMobileActivity = new Mobile_Activity__c(ContactId__c = contactId, Beacon__r = new Beacon__c(Identifier__c = beaconIdentifier), Activity_Type__c = (type == 'entered') ? 'Entered Region' : 'Exited Region');
	        		upsert matchingBeacon;
	        		insert newMobileActivity;
        		}
        		return opp[0];
        	}
        }
        return null;
        
	}

}