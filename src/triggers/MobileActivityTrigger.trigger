trigger MobileActivityTrigger on Mobile_Activity__c (before insert) {
	list<Id> contactIds = new list<Id>();
	for (Mobile_Activity__c ma : Trigger.new) {
		ma.Contact__c = ma.ContactId__c;
		if (ma.Activity_Type__c == 'Entered Region') {
			contactIds.add(ma.ContactId__c);
		}
	}
	list<Contact> contacts = [SELECT Id, MobileCheckIns__c FROM Contact WHERE Id IN :contactIds];
	if (!contacts.isEmpty()) {
		for (Contact c : contacts) {
			c.MobileCheckIns__c = c.MobileCheckIns__c + 1;
		}
		update contacts;
	}
}