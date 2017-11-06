/**
* @author Scott Covert
* @date 11/6/2017
* @description Defines the service class for integrating with the OneSignal API
*/
public with sharing class OneSignalService {

    /** OneSignal Push Notification API Endpoing */
    public static final String PUSH_ENDPOINT = 'https://onesignal.com/api/v1/notifications';
    /** OneSignal Authorization Id */
    private static final String AUTH_ID = 'YOUR_ONESIGNAL_AUTHORIZATION_ID';
    /** OneSignal Application Id */
    private static final String APP_ID = 'YOUR_ONESIGNAL_APP_ID';

    /**
    * @author Scott Covert
    * @date 11/6/2017
    * @description Sends Push Notification using OneSignal API
    * @param String Header for Push Notification
    * @param String Body for Push Notification
    * @return HTTPResponse Response from OneSignal API
    */
    public static void sendPushNotification(String header, String body) {
        CalloutRequest__c cr = new CalloutRequest__c(Endpoint__c = PUSH_ENDPOINT, Method__c = CalloutHandler.POST_METHOD);
        insert cr;
        CalloutHandler.createRequestHeaders(new Map<String,String>{
                CalloutHandler.AUTH_HEADER_KEY=>CalloutHandler.AUTH_BASIC_PREFIX + AUTH_ID,
                CalloutHandler.CONTENT_HEADER_KEY=>CalloutHandler.JSON_CONTENT_TYPE
        }, cr.Id);
        CalloutHandler.createRequestBody(JSON.serialize(new Map<String,Object>{
                'app_id' => APP_ID,
                'included_segments' => new List<String>{'All'},
                'headings' => new Map<String,String>{
                        'en' => header
                },
                'contents' => new Map<String,String>{
                        'en' => body
                }
        }), cr.Id);
        CalloutHandler.sendAsyncCallout(cr.Id);
    }
}