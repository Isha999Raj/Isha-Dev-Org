import { LightningElement } from 'lwc';
//Toast is kind of notification/pop-up
import { ShowToastEvent} from 'lightning/platformShowToastEvent'    ;

export default class MyFirstLWC extends LightningElement {
    myTitle = "Salesforce";

    connectedCallback(){
        // var is functional scope.
        var name = "Isha Raaz";

        if(this.myTitle){
            window.alert("name ----> "+name);
        }

        //let is inside block scope
        
        if(this.myTitle){
            let name2 = "Ajeet Kumar";
            window.alert("name2 ----> "+name2);
        }

        //const is inside block scope
        if(this.myTitle){
            const name3 = "Kishan Panchal";
            window.alert("name3 ----> "+name3);
        }

        var myName = "Isha";
        myName = "Ajeet";
        window.alert("myName ----> "+myName);

        let myName2 = "Isha";
        myName2 = "Aakash";
        window.alert("myName2 -----> "+myName2);

        // const myName3 = "Isha";
        // myName3 = "Kishan";
        // window.alert("myName3 -----> "+myName3);

        let callMyFunction = this.myFunction(10,5);
        window.alert("callMyFunction ---> "+callMyFunction);
        let callMyFunctionByArrowFunction = this.myArrowFunction(10,5);
        window.alert("callMyFunctionByArrowFunction ---> "+callMyFunctionByArrowFunction);
    }

    handleClick(){
        // window.alert("Hello Salesforce...");
        this.showToast(this.myTitle);
    }

    showToast(mytitle){
        const event = new ShowToastEvent({
            title: mytitle,
            message: 'want to display toast example',
            variant: 'error'
        })
        this.dispatchEvent(event);
    }

    myFunction(divident, divisor){
        return(divident/divisor);
    }

    myArrowFunction = (divident,divisor) => {
        return(divident/divisor);
    }
}