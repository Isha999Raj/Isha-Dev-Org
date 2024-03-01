import { LightningElement,track,wire,api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Id from '@salesforce/user/Id';
import createEvent from "@salesforce/apex/CalenderController.createEvent";
import getPicklistFieldsValues from "@salesforce/apex/CalenderController.getPicklistFieldsValues";
import getUserAppointmentType from '@salesforce/apex/CalenderController.getUserAppointmentType';

export default class createEventForm extends LightningElement {
    @track userId;
    appointmentTypes = [];
    // @api loginHashVal ;
    @track eventForm = {
        Name:'',
        Slot_Duration__c:'',
        Before_Gap__c:'',
        After_Gap__c:'',
        Start_Time__c:'',
        End_Time__c:'',
        Event_Start_Date__c:'',
        Event_End_Date__c:''
    };

    @track isLoading = true;
    @track fieldValues = {};
    @track multipicklistOccurences = [];
    @track showCheckboxes = false;
    @track businesshourRec = {};
    debugger;
    @track today;
    @track dateOneYearFromNow;
    @track startTime;
    @track endTime;

    connectedCallback() {
        this.userId = Id;
        // Call your Apex method to fetch appointment type here
        getUserAppointmentType({ userId: this.userId })
            .then(result => {
                console.log('result -----< ',JSON.stringify(result));
                this.appointmentTypes = result.userRecord.Appointment_Type__c.split(';');
                debugger;
                this.businesshourRec = result.bhRecord;
                var todayDate = new Date();
                var dayTodayNumber = todayDate.getDay();
                if(dayTodayNumber == 1){
                    let date = new Date(this.businesshourRec['MondayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['MondayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;

                }else if(dayTodayNumber == 2){
                    let date = new Date(this.businesshourRec['TuesdayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['TuesdayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;

                }else if(dayTodayNumber == 3){
                    let date = new Date(this.businesshourRec['WednesdayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['WednesdayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;

                }else if(dayTodayNumber == 4){
                    let date = new Date(this.businesshourRec['ThursdayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['ThursdayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;
                }
                else if(dayTodayNumber == 5){
                    let date = new Date(this.businesshourRec['FridayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['FridayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;

                }
                else if(dayTodayNumber == 6){
                    let date = new Date(this.businesshourRec['SaturdayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['SaturdayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;

                }
                else if(dayTodayNumber == 0){
                    let date = new Date(this.businesshourRec['SundayStartTime']);
                    let hours = date.getUTCHours();
                    let minutes = date.getUTCMinutes();
                    hours = String(hours).padStart(2, '0');
                    minutes = String(minutes).padStart(2, '0');
                    this.startTime = hours + ':' + minutes;

                    let date1 = new Date(this.businesshourRec['SundayEndTime']);
                    let hours1 = date1.getUTCHours();
                    let minutes1 = date1.getUTCMinutes();
                    hours1 = String(hours1).padStart(2, '0');
                    minutes1 = String(minutes1).padStart(2, '0');
                    this.endTime = hours1 + ':' + minutes1;

                }

                this.eventForm.Start_Time__c = this.startTime;
                this.eventForm.End_Time__c = this.endTime;
                this.today = todayDate.toISOString().slice(0, 10);
                var yearFromNow = todayDate.getFullYear() + 1;
                var month = todayDate.getMonth();
                var day = todayDate.getDate();
                var date = new Date(yearFromNow, month, day);
                this.dateOneYearFromNow = date.toISOString().slice(0, 10);
                this.eventForm.Event_Start_Date__c = this.today;
                this.eventForm.Event_End_Date__c = this.dateOneYearFromNow

                this.roleOptions = []; // Clear existing options
                for (let i = 0; i < this.appointmentTypes.length; i++) {
                    this.roleOptions.push({
                        label: this.appointmentTypes[i],
                        value: this.appointmentTypes[i]
                    });
                }
            })
            .catch(error => {
                this.appointmentType = undefined; // Handle error gracefully
                console.error('Error fetching AppointmentType:', error);
            });
    }

    toggleCheckboxCard() {
        this.showCheckboxes = !this.showCheckboxes;
    }


    fieldList = ['Slot_Duration__c','Before_Gap__c','After_Gap__c','Occurence__c'];

    @wire(getPicklistFieldsValues,{objName:'Calender_Type__c','fieldList':'$fieldList'})
    wiredResponse(result){
        console.log('Result---',result);
        // this.multipicklistOccurences = result.Occurence__c;
        // debugger;
        // console.log('this.multipicklistOccurences ====> ',this.multipicklistOccurences);
        debugger;
        if(result.data){
            this.fieldList.forEach(field=>{
                let list = result.data[field];
                let fList = [];
                debugger;
                this.multipicklistOccurences = result.data.Occurence__c;
                console.log('this.multipicklistOccurences ====> ',this.multipicklistOccurences);
                list.forEach(item=>{
                    fList.push({label:item,value:item});
                })

                this.fieldValues[field] = fList;
            })
            console.log('FieldValues---',this.fieldValues);
           // this.fieldValues = result.data;
            this.isLoading = false;
        }
    }

    inputHandler(event){
        debugger;
        let fieldName = event.target.name;
        let value = event.target.value;

        this.eventForm[fieldName] = value;
    }

    createNewEvent(){
        debugger;
        // console.log('loginHashVal ====> '+this.loginHashVal);
        // let hashval = this.loginHashVal;
        // console.log('hashval =====> '+hashval);
        console.log('selectedValues---',JSON.stringify(this.fieldList.Occurence__c));
        this.eventForm.Occurence__c = this.fieldList.Occurence__c;
        console.log('this.eventForm.Occurence__c ====> ',this.eventForm.Occurence__c);
        if(!this.eventForm.Name || this.eventForm.Name.length==0){
            this.showNotification('Success','Please enter Event Name');
            return;
        }
        if(!this.eventForm.Slot_Duration__c || this.eventForm.Slot_Duration__c.length==0){
            this.showNotification('Success','Please enter Slot Duration');
            return;
        }
        if(!this.eventForm.Event_Start_Date__c || this.eventForm.Event_Start_Date__c.length==0){
            this.showNotification('Success','Please enter Event Start Date');
            return;
        }
        if(!this.eventForm.Event_End_Date__c || this.eventForm.Event_End_Date__c.length==0){
            this.showNotification('Success','Please enter Event End Date');
            return;
        }
        if(!this.eventForm.Start_Time__c || this.eventForm.Start_Time__c.length==0){
            this.showCustomToast('Success','Please enter Event Start Time');
            return;
        }
        if(!this.eventForm.End_Time__c || this.eventForm.End_Time__c.length==0){
            this.showCustomToast('Success','Please enter Event End Time');
            return;
        }
        if(this.eventForm.Occurence__c != null && this.eventForm.Occurence__c != undefined && this.eventForm.Occurence__c != ''){
            var occurenceArray = this.fieldList.Occurence__c;
            console.log('occurenceArray-->'+ occurenceArray);
            var isBetweenRange = false;
            console.log('this.eventForm.Event_Start_Date__c-->' + this.eventForm.Event_Start_Date__c);
            var EventStartDate = new Date(this.eventForm.Event_Start_Date__c);
            var EventEndDate = new Date(this.eventForm.Event_End_Date__c);
            console.log('EventStartDate-->'+ EventStartDate);
            console.log('EventEndDate-->'+ EventEndDate);
            var Difference_In_Time = EventEndDate.getTime() - EventStartDate.getTime();
            var Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);
            if(Difference_In_Days <7){
                var eventDays = [];
                while(EventStartDate<=EventEndDate){
                var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                var thisDay = days[EventStartDate.getDay()];
                console.log('thisDay-->' + thisDay);
                eventDays.push(thisDay);
                EventStartDate.setDate(EventStartDate.getDate() + 1);
            }
                for(let i=0 ; i<occurenceArray.length ; i++){
                    console.log('occurenceArray[i]-->' + occurenceArray[i]);
                    if(occurenceArray[i] == 'Daily' || eventDays.includes(occurenceArray[i])){
                        isBetweenRange = true;
                    }
                }
            }else{
                isBetweenRange = true;
            }
            
        }
        if(isBetweenRange){
            this.isLoading = true;

        console.log('Event---',this.eventForm);
        debugger;

        let startTime = this.eventForm.Start_Time__c;
        let endTime = this.eventForm.End_Time__c;
        delete this.eventForm.Start_Time__c;
        delete this.eventForm.End_Time__c;

        
        // console.log('hashval222 =====> '+hashval);
        debugger;
        createEvent({ct:this.eventForm,startTime,endTime,userId:this.userId}).then(result=>{
            if(result=='Success'){
                this.isLoading = false;
                this.showNotification('Success','New Event Created Succesfully!','success');
                this.refreshHandler();
                this.backHandler();
                window.location.reload();
            }else if(result == 'User is Not Available During Selected Time'){
                this.isLoading = false;
                this.showCustomToast('Error','User is Not Available During Selected Time');
            }
            else if(result == 'Event already exists on the same date time.'){
                this.isLoading = false;
                this.showCustomToast('Error','Event already exists on the same date time.');
            }
        }).catch(error=>{
            console.log('Error to create event----',error);
            this.showNotification('Failed','error','error');
        })
        }else{
            alert('Please Select Valid Occurences');
        }
        
    }

    showNotification(title,message,variant){
        const evt = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
    });
    this.dispatchEvent(evt);
    }

    showCustomToast(title,message){
        this.template.querySelector('c-custom-toast').showToast(title,'<span>'+message+'<span/>','utility:warning',10000);
    }

    backHandler(){
        this.eventForm = {
            Name:'',
            Slot_Duration__c:'',
            Before_Gap__c:'',
            After_Gap__c:'',
            Start_Time__c:'',
            End_Time__c:'',
            Event_Start_Date__c:'',
            Event_End_Date__c:''
        };
        let ev = new CustomEvent('close', {});
        this.dispatchEvent(ev);
    }

    refreshHandler(){
        let ev = new CustomEvent('refresh', {});
        this.dispatchEvent(ev);
    }
    @track allselectedValues = [];

    handleCheckboxChange(event) {
        debugger;
    const selectedValue = event.target.value;
    this.fieldValues.Occurence__c = this.fieldValues.Occurence__c.map((option) => {
        if (option.value === selectedValue) {
            option.selected = event.target.checked;
        }
        return option;
    });

    this.selectedValues = this.fieldValues.Occurence__c
        .filter((option) => option.selected)
        .map((option) => option.value);
        this.fieldList.Occurence__c = this.selectedValues;
}

handleCancelClick() {
        this.showCheckboxes = false;
    }

    handleConfirmClick() {
        debugger;
        // Set the selected checkbox values to fieldList.Occurence__c
        this.fieldList.Occurence__c = this.selectedValues;

        // Hide the checkboxes card
        this.showCheckboxes = false;
    }
}