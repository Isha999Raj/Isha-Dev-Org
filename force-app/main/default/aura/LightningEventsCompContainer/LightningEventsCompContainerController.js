({
    
    //ACTION CALLED BY PARENT COMPONENT :
	handleTotalIncomeComponentEvent : function(component, event, helper) {
        debugger;
		alert('Event handler at the parent component');
        var totalIncome = event.getParam('totalIncome');
        component.set('v.totalIncome', totalIncome);
        //event.stopPropagation();
	}
})

//BUBBLE PHASE (Bottom to Top) : Event propagates from source(child) to root(parent) - it can be stopped anywhere in the hierarchy.
//CAPTURE PHASE (Top to Bottom) : Event propagates from root(parent) to source(child) - it can be stopped anywhere in the hierarchy.
//BUBBLE PHASE & CAPTURE PHASE are associated with the EventHandler not with Events.
//
//--------------------------------------------------------------------------------------------
//
// CAPTURE PHASE > BUBBLE PHASE
// 
// source and parent - bubble - bottom to top
// source and parent - capture - top to bottom
// 
// source - capture - executed first
// root - bubble 
// 
// source - bubble 
// root - capture - executed first
// 
// If Event is propagating in capture => it will not propagate in bubble too because capture is executed first.
// 
// If Event is propagating in bubble => it will not effect capture because it is already executed in capture phase.