({
    handleClick : function(component, event, helper) {
        var calculateGPA = component.get('c.calculateGPA');

        calculateGPA.setParams({
            "student" : component.get("v.recordId")
        });

        calculateGPA.setCallback(this, function(response) {
            var state = response.getState();

            console.log(`CalculateGPA finished executing with state: ${state}`);
        });

        $A.enqueueAction(calculateGPA);
    }
})
