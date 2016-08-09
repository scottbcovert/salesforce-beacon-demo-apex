trigger MobileActivityTrigger on Mobile_Activity__c (before insert) {
	for (Mobile_Activity__c ma : Trigger.new)
		ma.Contact__c = ma.ContactId__c;
}