import { api, LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AllAccountWithsocialSchedular.getAccounts';

export default class AllAccountWithsocialSchedular extends LightningElement {
    @track myBooleanVariable = false;

    listOfAccount = [];

    @wire(getAccounts,{})
    wiredResponse(result){
        if(result.data){
            console.log('Accounts Data-------',result.data);
            this.listOfAccount = result.data;
        }else{
            console.log("Error to fetch data of Accounts",result);
        }
    }

    handleAccountClick(event) {
        myBooleanVariable = true;
        const accountId = event.currentTarget.dataset.accountId;
        // Fire a custom event to notify the parent component with the selected account ID
        this.dispatchEvent(new CustomEvent('accountselected', { detail: accountId }));
    }
}