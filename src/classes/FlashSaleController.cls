/**
* @author Scott Covert
* @date 11/6/2017
* @description Defines the controller class for the Flash Sale Lightning Quick Action
*/
public with sharing class FlashSaleController {

    /**
    * @author Scott Covert
    * @date 11/6/2017
    * @description Initiates a Flash Sale and sends customized push notification to customers
    */
    @AuraEnabled
    public static void start(Id contactId) {
        list<Contact> c = [SELECT Id, Name, FlashSaleDiscount__c FROM Contact WHERE Id = :contactId];
        if (!c.isEmpty()) {
            OneSignalService.sendPushNotification('Flash Sale!','Hi ' + c[0].Name + '! As a thank you for stopping by all purchases made today will be ' + c[0].FlashSaleDiscount__c + '% off!');
        }
    }

}