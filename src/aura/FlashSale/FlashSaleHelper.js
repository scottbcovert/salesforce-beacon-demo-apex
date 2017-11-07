({
    init : function(component) {
        var startFlashSaleAction = component.get('c.start');
        startFlashSaleAction.setParams({
            contactId : component.get('v.recordId')
        });
        startFlashSaleAction.setCallback(component, function(response){
            if (component.isValid() && response.getState() === "SUCCESS") {
                $A.get("e.force:closeQuickAction").fire();
                $A.get("e.force:showToast").setParams({
                    "title": "Flash Sale Started!",
                    "message": "Customer will be sent a push notification.",
                    "type":"success"
                }).fire();
            }
        });
        $A.enqueueAction(startFlashSaleAction);
    }
})