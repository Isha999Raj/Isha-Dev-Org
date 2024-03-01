import { LightningElement,track,wire,api} from 'lwc';
import Id from '@salesforce/user/Id';
import checkAvailibility from '@salesforce/apex/CalenderController.checkAvailibility'
import checkEventAvailibilityDays from '@salesforce/apex/CalenderController.checkEventAvailibilityDays'
import createBookSlot from '@salesforce/apex/CalenderController.createBookSlot'
import getBookedSlotForParticularDate from '@salesforce/apex/CalenderController.getBookedSlotForParticularDate'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import MY_IMAGE from '@salesforce/resourceUrl/Logo';

export default class EventCalendar extends LightningElement {

    UserId = Id;
    eventOccurenceMap;
    @api calendarId;
    @track selectedMonth = {name:'November 2022',month:10,weeks:[],year:2022};
    @track cId;
    @track result;
    @track todayDate = new Date();
    imageURL = MY_IMAGE;


    connectedCallback(){
        debugger;
        console.log('calendarId===>'+ this.calendarId);
        this.fetchEventOccurence();
        this.fetchAvailability();
    }

    fetchAvailability(){
        debugger;
       
        checkAvailibility({cId:this.calendarId}).then(result=>{
            this.result = result;
            this.configCalendar();
            console.log('Result----',result);
        }).catch(error=>{
            console.log('Error to fetch calendar availability 14 ',error.message);
        })
        
    }

    fetchEventOccurence(){
        debugger;
        let hashval = this.calendarId;
        console.log('calendarId =====> ',this.calendarId);
        console.log('hashval =====> ',hashval);
        checkEventAvailibilityDays({cId:hashval}).then(result=>{
            debugger;
            console.log('eventOccurenceMap ---->', result);
            this.eventOccurenceMap = result;
        }).catch(error=>{
            console.log('Error to fetch event occurence availability',error);
        })
    }

    handleBack(){
        debugger;
        let cId = this.result.user.Id;
        location.href = location.origin+'/EventCalenderPage/UserCalenderPage?cId='+cId;
    }


    calendarBackNextAction(event){
        debugger;
        let action = event.currentTarget.dataset.action;

        if(action=='left'){
            this.todayDate.setMonth(this.todayDate.getMonth()-1);
        }else{
            this.todayDate.setMonth(this.todayDate.getMonth()+1);
        }

        this.configCalendar();
        console.log('SELECTEDMONTH----',this.todayDate);
    }

    months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    @track sMonth;
    @track sYear;
    @track disablePrev = false;
    @track disableNext = false;

    configCalendar(){
        debugger;
        this.createCalendar(this.todayDate.getFullYear(),this.todayDate.getMonth()+1);
        this.sMonth = this.months[this.todayDate.getMonth()];
        this.sYear = this.todayDate.getFullYear();

        let startDate = new Date(this.result.user.Start_Date__c);
        let endDate = new Date(this.result.user.End_Date__c);

        this.disablePrev = this.todayDate < startDate;
        this.disableNext = this.todayDate > endDate;
        
        this.selectedAv = null;
    }
    
    createCalendar(year,month){
        debugger;
        let mon = month - 1;
        let d = new Date(year, mon);
        debugger;

        let spaces = [];

        for (let i = 0; i < this.getDay(d); i++) {  
            console.log('i--',i);
            spaces.push({hide:true});
        }

        this.selectedMonth.weeks = [];

        this.selectedMonth.weeks.push({week:`week1`,days:spaces});
        
        spaces = [];
        let days = [];

        while (d.getMonth() == mon) {
            let newDate = new Date(d);
            newDate.setMinutes(newDate.getMinutes()+330);
            newDate.setDate(newDate.getDate());
            let av = this.result.availibility.find(item=>new Date(item.Date__c).toDateString()==new Date(d).toDateString());
            let isEnabled = av!=null && newDate >= new Date(this.result.cdetails.Event_Start_Date__c) && newDate <= new Date(this.result.cdetails.Event_End_Date__c);
            console.log('this.eventOccurenceMap==> ' + this.eventOccurenceMap);
            if(isEnabled && !this.eventOccurenceMap.hasOwnProperty(newDate.getDay())){
                isEnabled = false;
            }
            console.log('av-->'+ av);
            console.log('isEnabled-->'+ isEnabled);
            console.log('newDate-->'+ newDate);
            console.log('d-->' + d);
            console.log('new Date(this.result.cdetails.Event_Start_Date__c)-->'+ new Date(this.result.cdetails.Event_Start_Date__c));

            if(this.selectedMonth.weeks[0].days.length!=7){
                this.selectedMonth.weeks[0].days.push({hide:false,selected:false,date:d.getDate(),fDate:new Date(d),enabled:isEnabled,avId:av?av.Id:''});
            }else{
                days.push({hide:false,selected:false,date:d.getDate(),fDate:new Date(d),enabled:isEnabled,avId:av?av.Id:''});
            }
    
            if (this.getDay(d) % 7 == 6) {
                if(days.length>0){
                    this.selectedMonth.weeks.push({week:`week${this.selectedMonth.weeks.length+1}`,days:days});
                    days = [];
                }
            }
            d.setDate(d.getDate() + 1);    
            //console.log('d.setDate(d.getDate() + 1)-->'+ d.setDate(d.getDate() + 1));
        }

        if (this.getDay(d) != 0) {
            for (let i = this.getDay(d); i < 7; i++) {
              days.push({hide:true})
            }
        }

        if(days.length>0){
            this.selectedMonth.weeks.push({week:`week${this.selectedMonth.weeks.length+1}`,days:days});
        }

        console.log('SELECTEDWEEK----',this.selectedMonth);
    }


    getDay(date) {
        debugger;
        let day = date.getDay();
        if (day == 0) day = 7;
        return day - 1;
    }


    @track selectedDate;
    @track selectedAv;

    weekList = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];

    dayClick(event){
        debugger;
        let sDate = event.currentTarget.dataset.id;
        let sWeek = event.currentTarget.dataset.week;


        console.log('CurrentSelectedDate----',sDate);
        console.log('CurrentSelectedWeek----',sWeek);

        this.removePrevious();

        let selectedWeekIndex = this.selectedMonth.weeks.findIndex(week=>week.week==sWeek);
        if(selectedWeekIndex!=-1){
            let selectedWeek = this.selectedMonth.weeks[selectedWeekIndex];
            let selectedDateIndex = selectedWeek.days.findIndex(day=>day.date==sDate);

            this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].selected = true;
            this.selectedAv = this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].avId;

            this.selectedDate = `${this.weekList[this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].fDate.getDay()]}, ${this.sMonth} ${this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].date}`
            
            let year = this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].fDate.getFullYear();
            let month = this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].fDate.getMonth()+1;
            let date = this.selectedMonth.weeks[selectedWeekIndex].days[selectedDateIndex].fDate.getDate();
            let hashval = this.calendarId;
            getBookedSlotForParticularDate({cId:this.cId,year:year,month:month,day:date}).then(result=>{
                console.log('Booked slot response from APEX---',result);
                this.calculateHours(result);
            }).catch(error=>{
                console.log('Error to fetch booked slot---',error);
            })
            
        }


        console.log('SelectedDate---',this.selectedMonth);
    }

    removePrevious(){
        debugger;
        this.selectedAv = null;
        this.selectedMonth.weeks.forEach(week=>{
            week.days.forEach(day=>{
                day.selected = false;
            })
        })
    }


    @track selectedTimes = [];
    @track sTime;

    @track showTime = false;

    calculateHours(slots){
        debugger;
       
        let startTime   = new Date(new Date(this.result.cdetails.Start_Time__c).toUTCString());
        let endTime   = new Date(new Date(this.result.cdetails.End_Time__c).toUTCString());
        
        this.selectedTimes = [];
        while(startTime<endTime){
            debugger;
            this.selectedTimes.push({lvalue:startTime.getTime(),disabled:slots.find(item=>item.Start_Time__c==startTime.getTime())!=null});
            startTime.setMinutes(startTime.getMinutes()+parseInt(this.result.cdetails.Slot_Duration__c));
        }

        this.showTime = true;

        console.log('SELECTEDTIMES----',this.selectedTimes);
        // this.sTime = this.result.cdetails.Start_Time__c;
    }


    @track showScheduleEvent = false;
    @track selectedTime;
    @track selectedEndTime;
    @track showEnterDetails = false;
    @track showLeftDownSection = true;

    showScheduleModal(event){
        debugger;
        this.selectedTime = null;
        let index = event.currentTarget.dataset.index;

        this.selectedTime = this.selectedTimes[index].lvalue;

        let startTime = new Date(new Date(this.selectedTime).toUTCString());
        startTime.setMinutes(startTime.getMinutes()+parseInt(this.result.cdetails.Slot_Duration__c));
        if(this.result.cdetails.End_Time__c < startTime){
            this.selectedEndTime = this.result.cdetails.End_Time__c;
        }else{
        this.selectedEndTime = startTime.getTime();
        }

        console.log('StartTime',this.selectedTime);
        console.log('EndTIme',this.selectedEndTime);

        this.showScheduleEvent = true;
        this.showEnterDetails = true;
        this.showLeftDownSection = false;
    }


    closeScheModal(){
        debugger;
        this.showScheduleEvent = false;
        this.selectedTime = null;
        this.showLeftDownSection = true;
    }


    @track newSlot = {
        Name:'',
        Availability__c:'',
        Email__c:'',
        Meeting_Description__c:''
    }



    inputChangeHandler(event){
        debugger;
        let eventName = event.target.name;
        let value = event.target.value;

        this.newSlot[eventName] = value;
    }

    @track showLoader;

    scheduleEvent(){
        debugger;
        if(!this.newSlot.Name){
            this.showToast('Failed','Please enter your name','error');
            return;
        }
        if(!this.newSlot.Email__c){
            this.showToast('Failed','Please enter your email','error');
            return;
        }else if(this.valid(this.newSlot.Email__c)){
            console.log('inside valid function');
            this.showToast('Failed','Please enter valid email','error');
            return;
        }
        if(!this.newSlot.Meeting_Description__c){
            this.showToast('Failed','Please enter meeting description','error');
            return;
        }

        this.newSlot.Availability__c = this.selectedAv;

        console.log('StartTime',this.selectedTime);
        console.log('EndTIme',this.selectedEndTime);
        this.showLoader = true;
        let hashval = this.calendarId;

        createBookSlot({bookedSlot:this.newSlot,sLongTime:this.selectedTime,eLongTime:this.selectedEndTime,hashValue:'$userId'}).then(result=>{
            console.log('Booking created successfully!',result);
            alert('Event Scheduled succesfully.');
            this.showLoader = false;
            this.closeScheModal();
            location.reload();
        }).catch(error=>{
            console.log('Error while booking slots----',error);
            this.showLoader = false;
        })
    }


    showToast(title,message,variant){
        alert(message);
    }

    valid(value){
        debugger;
        if(value!=undefined){
            var x=value;
            var atpos = x.indexOf("@");
            var dotpos = x.lastIndexOf(".");
            if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
                
                return true;
            }
            return false;
        }
    }

}