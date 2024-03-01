import { LightningElement,track} from 'lwc';
import Id from '@salesforce/user/Id';
import getCalendarType from '@salesforce/apex/CalenderController.getCalendarType2'
import MY_IMAGE from '@salesforce/resourceUrl/Logo';
export default class UserCalendar extends LightningElement {

    
    @track userId = Id;
    @track showbody = false;
    @track cId;
    @track result;
    @track childComponent = false;
    imageURL = MY_IMAGE;

    connectedCallback(){
        debugger;
        console.log('OPPPPP','LOPPPPP');
        // const params = new URLSearchParams(window.location.search);
        // this.userId = params.get('cId').replace('&','');
        console.log('UserId----',this.userId);

        if(this.userId){
            this.getCalendarType();
        }
    }


    getCalendarType(){
        debugger;
        getCalendarType({usId:this.userId}).then(result=>{
            this.result = result;
            this.showbody = true;
            console.log('Result----',result);
        }).catch(error=>{
            console.log('Error-----',error);
        })
    }


    eventClicked(event){
        debugger;
         this.cId = event.currentTarget.dataset.id;
        this.childComponent = true;
        this.showbody = false;  
    }

}