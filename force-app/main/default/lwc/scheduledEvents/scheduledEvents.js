import { api, LightningElement, wire, track } from 'lwc';
import Id from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import getAllBookingSlots from '@salesforce/apex/ScheduledEventsController.getAllBookingSlots';
import getFilteredBookedSlots from '@salesforce/apex/ScheduledEventsController.getFilteredBookedSlots';
import updateStatus from '@salesforce/apex/ScheduledEventsController.updateStatus';
import rescheduleMeeting from '@salesforce/apex/ScheduledEventsController.rescheduleMeeting';
export default class ScheduledEvents extends LightningElement {

   // @api hashCode;
    userId = Id;
    listOfBookingSlots = [];
    filteredBookedSlots = [];
    @track startTime = '';
    @track endTime = '';
    @track eventForm = {
        Start_Time__c:'',
        End_Time__c:'',
        Date__c:''
    };

    connectedCallback() {
        this.getAllBookingSlots();
    }

    getAllBookingSlots(){
        //let hashval = this.hashCode;
         getAllBookingSlots({userId: this.userId})
        .then(result=>{ 
            //console.log('hashval ====> ',hashval);         
            this.listOfBookingSlots = result;
            this.filteredBookedSlots = result;
            console.log("result ===> "+result);
            console.log("Data ====> ",this.listOfBookingSlots);
            console.log("filteredBookedSlots ====> ",this.filteredBookedSlots);
            debugger;
            // const targetElement = this.template.querySelector('.element-to-change-class');
            if(this.filteredBookedSlots != undefined){
                var itemList = this.filteredBookedSlots;
                for(var i=0;i<itemList.length;i++){
                    let arry = {...itemList[i]};
                    if(itemList[i].Start_Time__c != null){
                        arry.Start_Time__c = itemList[i].Start_Time__c - 330*60*1000;
                    }
                    if(itemList[i].End_Time__c != null){
                        arry.End_Time__c = itemList[i].End_Time__c - 330*60*1000;
                    }
                    if(itemList[i].Status__c == 'Re-Scheduled'){
                        arry.styleClass = 'status-reschedule';
                        arry.accepetd = false;
                        arry.rejected = false;
                        arry.startMeet = false;
                        arry.reschedule = true;
                        arry.styleClassReschedule = 'disableButton';
                        arry.styleClassStartMeet = 'startMeetBtn startMeetButton';
                        arry.styleClassAccepted = 'acceptButton';
                        arry.styleClassRejected = 'rejectButton';

                    }else if(itemList[i].Status__c == 'Requested'){
                        arry.styleClass = 'status-requested';
                        arry.accepetd = false;
                        arry.rejected = false;
                        arry.startMeet = false;
                        arry.reschedule = false;
                        arry.styleClassReschedule = 'rescheduleButton';
                        arry.styleClassStartMeet = 'startMeetBtn startMeetButton';
                        arry.styleClassAccepted = 'acceptButton';
                        arry.styleClassRejected = 'rejectButton';

                    }else if(itemList[i].Status__c == 'Accepted'){
                        arry.styleClass = 'status-accepted';
                        arry.startMeet = false;
                        arry.accepetd = true;
                        arry.rejected = true;
                        arry.reschedule = true;
                        arry.styleClassReschedule = 'disableButton';
                        arry.styleClassStartMeet = 'startMeetBtn startMeetButton';
                        arry.styleClassAccepted = 'disableButton';
                        arry.styleClassRejected = 'disableButton';
                        

                    }else if(itemList[i].Status__c == 'Completed'){
                        arry.styleClass = 'status-completed';
                        arry.startMeet = true;
                        arry.accepetd = true;
                        arry.rejected = true;
                        arry.reschedule = true;
                        arry.styleClassReschedule = 'disableButton';
                        arry.styleClassStartMeet = 'startMeetBtn disableButton';
                        arry.styleClassAccepted = 'disableButton';
                        arry.styleClassRejected = 'disableButton';

                    }else if(itemList[i].Status__c == 'Rejected'){
                        arry.styleClass = 'status-rejected';
                        arry.startMeet = true;
                        arry.accepetd = true;
                        arry.rejected = true;
                        arry.reschedule = true;
                        arry.styleClassReschedule = 'disableButton';
                        arry.styleClassStartMeet = 'startMeetBtn disableButton';
                        arry.styleClassAccepted = 'disableButton';
                        arry.styleClassRejected = 'disableButton';

                    }
                    console.log('arry =====> ',arry);
                    itemList[i] = arry;

                }
                this.filteredBookedSlots = itemList;
                console.log("itemList ==> "+JSON.stringify(itemList));
                console.log("Data2 ====> ",JSON.stringify(this.filteredBookedSlots));
                setTimeout(() => this.template.querySelector('c-custom-pagination').setPagination(10));
            }
            
        }).catch(error =>{
            console.log("Error to fetch data of BookingSlots",error);
        })
    }

    showNotification(title,message,variant){
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }

    closeAction(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    pageRecordsToDisplay = [];
    paginationCallback(event) {
        debugger;
        this.filteredBookedSlots = event.detail.recordToDisplay;
    }

    handleTimeChange(event){
        var name = event.target.name;
        if(name == 'starttimeInput'){
            this.startTime = event.target.value;
            console.log('Start Date Time ==> ' + this.startTime);
        }else if(name == 'endtimeInput'){
            this.endTime = event.target.value;
        }
    }

    handleDateChange(event){
        var name = event.target.name;
        if(name == 'startDateInput'){
            this.startDate = event.target.value;
            console.log('Start Date Time ==> ' + this.startTime);
        }else if(name == 'endDateInput'){
            this.endDate = event.target.value;
        }
    }

    filterBookedSlots(){
        debugger;
        console.log('startTime ===> ',this.startTime);
        console.log('endTime ===> ',this.endTime);
        console.log('startDate ===> ',this.startDate);
        console.log('endDate ===> ',this.endDate);
        if(this.startDate == null || this.startDate == undefined || this.startDate == ''){
            alert('Please select a start Date first');
            return;
        }
        //let hashval = this.hashCode;
        getFilteredBookedSlots({ startTime: this.startTime, endTime: this.endTime, startDate: this.startDate, endDate:this.endDate, userId: this.userId})
        .then(result =>{
            this.filteredBookedSlots = structuredClone(result);
            console.log("result ===> "+result);
            console.log("Data ====> ",this.listOfBookingSlots);
            console.log("filteredBookedSlots ====> ",this.filteredBookedSlots);
            debugger;
            // const targetElement = this.template.querySelector('.element-to-change-class');
            if(this.filteredBookedSlots != undefined){
                var itemList = this.filteredBookedSlots;
                for(var i=0;i<itemList.length;i++){
                    let arry2 = {...itemList[i]};
                    if(itemList[i].Start_Time__c != null){
                        arry2.Start_Time__c = itemList[i].Start_Time__c - 330*60*1000;
                    }
                    if(itemList[i].End_Time__c != null){
                        arry2.End_Time__c = itemList[i].End_Time__c - 330*60*1000;
                    }
                    
                    if(itemList[i].Status__c == 'Re-Scheduled'){
                        arry2.styleClass = 'status-reschedule';
                        arry2.accepetd = false;
                        arry2.rejected = false;
                        arry2.startMeet = false;
                        arry2.reschedule = true;
                        arry2.styleClassReschedule = 'disableButton';
                        arry2.styleClassStartMeet = 'startMeetButton';
                        arry2.styleClassAccepted = 'acceptButton';
                        arry2.styleClassRejected = 'rejectButton';

                    }else if(itemList[i].Status__c == 'Requested'){
                        arry2.styleClass = 'status-requested';
                        arry2.accepetd = false;
                        arry2.rejected = false;
                        arry2.startMeet = false;
                        arry2.reschedule = false;
                        arry2.styleClassReschedule = 'rescheduleButton';
                        arry2.styleClassStartMeet = 'startMeetButton';
                        arry2.styleClassAccepted = 'acceptButton';
                        arry2.styleClassRejected = 'rejectButton';

                    }else if(itemList[i].Status__c == 'Accepted'){
                        arry2.styleClass = 'status-accepted';
                        arry2.startMeet = false;
                        arry2.accepetd = true;
                        arry2.rejected = true;
                        arry2.reschedule = true;
                        arry2.styleClassReschedule = 'disableButton';
                        arry2.styleClassStartMeet = 'startMeetButton';
                        arry2.styleClassAccepted = 'disableButton';
                        arry2.styleClassRejected = 'disableButton';
                        

                    }else if(itemList[i].Status__c == 'Completed'){
                        arry2.styleClass = 'status-completed';
                        arry2.startMeet = true;
                        arry2.accepetd = true;
                        arry2.rejected = true;
                        arry2.reschedule = true;
                        arry2.styleClassReschedule = 'disableButton';
                        arry2.styleClassStartMeet = 'disableButton';
                        arry2.styleClassAccepted = 'disableButton';
                        arry2.styleClassRejected = 'disableButton';

                    }else if(itemList[i].Status__c == 'Rejected'){
                        arry2.styleClass = 'status-rejected';
                        arry2.startMeet = true;
                        arry2.accepetd = true;
                        arry2.rejected = true;
                        arry2.reschedule = true;
                        arry2.styleClassReschedule = 'disableButton';
                        arry2.styleClassStartMeet = 'disableButton';
                        arry2.styleClassAccepted = 'disableButton';
                        arry2.styleClassRejected = 'disableButton';

                    }
                    console.log('arry2 =====> ',arry2);
                    itemList[i] = arry2;

                }
                this.filteredBookedSlots = itemList;
                console.log("itemList ==> "+JSON.stringify(itemList));
                console.log("Data2 ====> ",JSON.stringify(this.filteredBookedSlots));
                setTimeout(() => this.template.querySelector('c-custom-pagination').setPagination(10));
            }
            
        })
        .catch(error => {
                console.error('Error fetching filtered booked slots:', error);
            });
    }

    clearFilters(){
        debugger;
        this.filteredBookedSlots = this.listOfBookingSlots;
        // setTimeout(() => this.template.querySelector('c-custom-pagination').setPagination(10));
    }

    onClickOfAcceptReject(){
        debugger;
        const bookedSlotId = event.currentTarget.dataset.recordId;
        const statusvalue = event.target.dataset.value;
        console.log('bookedSlotId =====> ',bookedSlotId);
        console.log('statusvalue =====> ',statusvalue);
        updateStatus({bookedSlotId: bookedSlotId, statusVal: statusvalue})
        .then(result=>{
            console.log("result ===> "+result);
            this.reloadPage();
            // alert('updated');
        }).catch(error =>{
            console.log("Error to fetch data of BookingSlots",error);
        })
    }
      reloadPage() {
        window.location.reload();
    }

    @track urlToOpen = '';
    handleOpenLink(){
        debugger;
        this.urlToOpen = event.target.value;
        window.open(this.urlToOpen, '_blank');
    }

    @track isModalOpen = false;
    @track selectedBSId = false;

    openPopUp(){
        this.selectedBSId = event.currentTarget.dataset.recordId;
        debugger;
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }

    inputHandler(event){
        debugger;
        let fieldName = event.target.name;
        let value = event.target.value;

        this.eventForm[fieldName] = value;
    }

    rescheduleMeeting(){
        console.log('Event---',this.eventForm);
        debugger;
        if(!this.eventForm.Date__c || this.eventForm.Date__c.length==0){
            this.showNotification('Failed','Please enter Event Start Date','error');
            return;
        }
        console.log('this.listOfBookingSlots.length ====> '+this.listOfBookingSlots.length);
        for(let i=0;i<this.listOfBookingSlots.length;i++){
            if(this.listOfBookingSlots[i].Id == this.selectedBSId){
                if(this.listOfBookingSlots[i].Date__c > this.eventForm.Date__c){
                    this.showNotification('Failed','Please Enter Future Date.','error');
                    return;
                }
            }
        }
        if(!this.eventForm.Start_Time__c || this.eventForm.Start_Time__c.length==0){
            this.showNotification('Failed','Please enter Start Time','error');
            return;
        }
        if(!this.eventForm.End_Time__c || this.eventForm.End_Time__c.length==0){
            this.showNotification('Failed','Please enter End Time','error');
            return;
        }

        let startTime = this.eventForm.Start_Time__c;
        let endTime = this.eventForm.End_Time__c;
        let bsId = this.selectedBSId;
        console.log('this.selectedBSId ===> ',this.selectedBSId);

        delete this.eventForm.Start_Time__c;
        delete this.eventForm.End_Time__c;

        rescheduleMeeting({ct:this.eventForm,startTime,endTime,bsId}).then(result=>{
            if(result=='SUCCESS'){
                this.showNotification('Success','Meeting has been rescheduled!','success');
                this.closeModal();
                this.reloadPage();
                this.backHandler();
            }else if(result=='Availability Error'){
                this.showNotification('Failer','Please select a date in your available dates!','error');
                this.closeModal();
            }
        }).catch(error=>{
            console.log('Error to reschedule event----',error);
            this.showNotification('Failed',error,'error');
        })
    }

    backHandler(){
        this.eventForm = {
        Start_Time__c:'',
        End_Time__c:'',
        Date__c:''
        };
    }
}