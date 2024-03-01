({
    doInit : function(component, event, helper) {
        component.set("v.myColumns", [
            {label: 'SNo.', fieldName: 'sno', type: 'number'},
            {label: 'Name of Source', fieldName: 'source', type: 'text'},
            {label: 'Amount', fieldName: 'amount', type: 'number'}
        ]);
        component.set('v.Incomes', [{
            sno: 1,
            source: 'Regular Job',
            amount: 10000
        },
        {
           sno: 2,
           source: 'Part-Time Job',
           amount: 5000                             
        }
        ]);
    },

    // HANDLING THE EVENT THAT IS FIRING BY THIS COMPONENT ITSELF :
    // SOURCE COMPONENT THAT IS FIRING AND FIRING EVENT 
    handleRegisteredComponentEvent: function(component, event, helper){
        alert('Event handler in source component that fired the event');
        //event.stopPropagation();
    },
    
    toggleIncomeForm: function(component, event, helper){
        var incomeForm = component.find('incomeForm');
        $A.util.toggleClass(incomeForm, 'hide');
    },
    
    AddIncome: function(component, event, helper){
        debugger;
        var incomes = component.get('v.Incomes');
        var newIncome = {
            sno: incomes.length + 1,
            source: component.find('source').get('v.value'),
            amount: parseFloat(component.find('amount').get('v.value'))
        }
        if(newIncome.source!='' && newIncome.amount!='' && newIncome.source!=null && newIncome.amount!=null){
          incomes.push(newIncome);
            component.set('v.Incomes', incomes);
            component.find('source').set('v.value', '');
            component.find('amount').set('v.value', '');
        }
    },
    
    // THIS FUNCTION IS RESPONSIBLE FOR FIRING THE EVENT :
    fireTotalCompEvent: function(component, event, helper){
        debugger;
        var incomes = component.get('v.Incomes');
        var totalIncome = 0;
        for(var i=0;i<incomes.length;i++){
            totalIncome = totalIncome+incomes[i].amount;
        }
        //alert(totalIncome);
        var totalIncomeComponentEvent = component.getEvent('totalIncomeComponentEvent');
        totalIncomeComponentEvent.setParams({
            "totalIncome": totalIncome
            
        });
        totalIncomeComponentEvent.fire();
    }
})