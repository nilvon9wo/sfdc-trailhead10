({
    doInit : function(component) {
        var action = component.get('c.getPickListValuesIntoList');
        action.setParams({
            sObjectType: component.get('v.sObjectName'), 
            selectedField: component.get('v.fieldName')
        }); 
        action.setCallback(this, function(response) {
            component.set('v.picklistValues', response.getReturnValue());
        })
        $A.enqueueAction(action);
    }
})
 