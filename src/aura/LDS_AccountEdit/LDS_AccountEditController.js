({
    handleSaveRecord : function(cmp, event, helper) {
        var recordEditor = cmp.find("recordEditor");
        var recordSaveError = "";
        recordEditor.saveRecord($A.getCallback(function(saveResult) {            
        	if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                console.info("Save completed successfully.");
            } 
            else if (saveResult.state === "INCOMPLETE") {
                console.warn("User is offline, device doesn't support drafts.");
            } 
            else if (saveResult.state === "ERROR") {
                for (var i = 0; i < saveResult.error.length; i++) {
                    recordSaveError += saveResult.error[i].message + "\n";
                }
            } 
            else {
                console.error('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
            cmp.set("v.recordSaveError", recordSaveError);
        }));
    },
    
    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
            var changedFields = eventParams.changedFields;
            console.info('Fields that are changed: ' + JSON.stringify(changedFields));
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                title: "Saved",
                message: "The record was updated."
            });
            resultsToast.fire();
        } else if(eventParams.changeType === "ERROR") {
            console.log('Error: ' + component.get("v.recordSaveError"));
        }
    }
        
})