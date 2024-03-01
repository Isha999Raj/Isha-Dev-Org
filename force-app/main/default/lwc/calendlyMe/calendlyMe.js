import { LightningElement,track,wire,api} from 'lwc';
import Id from '@salesforce/user/Id';
import staticlogo from '@salesforce/resourceUrl/ImageCard';
import getCalendarsUserInfo from "@salesforce/apex/CalenderController.getCalendarsUserInfo";
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CalendlyMe extends LightningElement {
    // Id = '0035j00001AMukvAAD';
    userId = Id;
    debugger;
    // @api userId;  
    @track isFirstTabActive = true;
    @track firstTabClass ='slds-tabs_default__item slds-is-active';
    @track secTabClass = 'slds-tabs_default__item'; 
    @track wiredResult;
    @track calUserInfo ;
    @track calUserInfoV1=[];
    @track showCreateEvent = false;
    @track showImage = false;

    @track initials = '';

    // @track demo_banner = BANNER;

    @track userNameInitials ;

    @track userNameChar1 ;
    @track userNameChar2;
    ImageCard= staticlogo;

    @wire(getCalendarsUserInfo,{userId:'$userId', searchString:''})
    wiredResponse({error, data}){
        debugger;
        this.wiredResult = data;
        if(data){
              debugger;
            console.log('Result----',data);
            
            this.calUserInfo = data;
           // alert('Data === >'+ this.calUserInfo );
            console.log('Data Check --->',JSON.stringify(this.calUserInfo));
            if(this.calUserInfo.events.length==0){
                this.showImage = true;
            }
            else{
                this.showImage = false;
            }

            //console.log('Start_Time__c New Change==== >'+new Date(this.calUserInfo.events[0].Start_Time__c).toLocaleString("en-IN", { localeMatcher: "best fit", timeZoneName: "short" })); // 👉️ 15:00:00

           // console.log('this.calUserInfo --->',JSON.stringify(this.calUserInfo));
             console.log('this.calUserInfoEvents --->',JSON.stringify(this.calUserInfo.events));
            this.initials = this.calUserInfo.user.Name.charAt(0);
             if(this.calUserInfo.events.length>0){
            for(let i = 0; i< this.calUserInfo.events.length; i++){
               debugger;
               let newObj ={...this.calUserInfo.events[i]};
                    const text = this.calUserInfo.events[i].Name;
                     console.log('text--->',text);
                     console.log('this.calUserInfo.events[i].Start_Time__c ==> ',this.calUserInfo.events[i].Start_Time__c);
                    newObj.Start_Time__c -= 330 * 60 * 1000;
                    newObj.End_Time__c -= 330 * 60 * 1000;   
                    if(this.calUserInfo.events[i].Occurence__c != undefined && this.calUserInfo.events[i].Occurence__c != null){
                        newObj.dayArray = this.calUserInfo.events[i].Occurence__c.split(';');
                        for(let j = 0; j< newObj.dayArray.length; j++) {
                           newObj.dayArray[j] = ' ' +  newObj.dayArray[j];
                        }
                        console.log('dayArray-->' + newObj.dayArray);
                    }
                     this.calUserInfoV1.push(newObj);        
            }
             }
        }
    }

    tabSwitchHandler(event){
        debugger;
        let activeTab = event.currentTarget.dataset.name;
        debugger;
        this.isFirstTabActive =  activeTab=='first';
        if(this.isFirstTabActive){
            this.firstTabClass = 'slds-tabs_default__item slds-is-active';
            this.secTabClass = 'slds-tabs_default__item';
        }else{
            this.firstTabClass = 'slds-tabs_default__item';
            this.secTabClass = 'slds-tabs_default__item slds-is-active';
        }
    }

    showCreateEventHandler(){
         debugger;
        this.showCreateEvent = true;
    }

    refreshPage(){
        refreshApex(this.wiredResult);
    }

    hideCreateEventHandler(){
         debugger;
        this.showCreateEvent = false;
    }

    searchHanlder(event){
        let value = event.target.value;
        console.log('userId-->' + this.userId);
        console.log('value-->' + value);
        getCalendarsUserInfo({userId:this.userId, searchString:value})
        .then(result=>{
            console.log('Result----',result);
            this.calUserInfo = result;
            console.log('calUserInfo --->',JSON.stringify(this.calUserInfo));
            if(this.calUserInfo.length==0){
                this.showImage = true;
            }
            else{
                this.showImage = false;
            }
        })
    }


    // searchHanlder(event){
    //      debugger;
    //     let value = event.target.value;
    //     console.log('userId-->' + this.userId);
    //     console.log('value-->' + value);
    //     getCalendarsUserInfo({userId:this.userId, searchString:value})
    //     .then(result=> {
    //         console.log('Result----',result);
    //         if(result.events){
    //         console.log('Result.events----',result.events);
    //         this.calUserInfo = structuredClone(result.events);
    //        // alert('Data === >'+ this.calUserInfo );
    //         console.log('calUserInfo --->',JSON.stringify(this.calUserInfo));
    //         if(this.calUserInfo.length==0){
    //             this.showImage = true;
    //         }
    //         else{
    //             this.showImage = false;
    //         }
    //          console.log('this.calUserInfoEvents --->',JSON.stringify(this.calUserInfo));
    //          if(this.calUserInfo.length>0){
    //              console.log('this.calUserInfo.length-->'+ this.calUserInfo.length);
    //          }
    //     }

    //     });
    //     console.log('calUserInfo2222 --->',JSON.stringify(this.calUserInfo));
    // }

    copy(event) {
        debugger;
        let text = event.currentTarget.dataset.id;
        console.log('text ====>',text);
        debugger;
        if (window.clipboardData && window.clipboardData.setData) {
            // Internet Explorer-specific code path to prevent textarea being shown while dialog is visible.
            return window.clipboardData.setData("Text", text);
    
        }
        else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
            var textarea = document.createElement("textarea");
            textarea.textContent = text;
            textarea.style.position = "fixed";  // Prevent scrolling to bottom of page in Microsoft Edge.
            document.body.appendChild(textarea);
            textarea.select();
            try {
                return document.execCommand("copy");  // Security exception may be thrown by some browsers.
            }
            catch (ex) {
                console.warn("Copy to clipboard failed.", ex);
                return prompt("Copy to clipboard: Ctrl+C, Enter", text);
            }
            finally {
                document.body.removeChild(textarea);
                this.showNotification('Success','Link copied successfully!');
                // this.showNotification('Success','Link copied successfully!','success');
            }
        } 
      }

      showNotification(title,message,variant){
          debugger;
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

    // showCustomToast(title,message){
    //     this.template.querySelector('c-custom-toast').showToast(title,'<span>'+message+'<span/>','utility:warning',10000);
    // }

}