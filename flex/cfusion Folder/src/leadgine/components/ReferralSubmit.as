

	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.managers.PopUpManager;
			
	private var params:Object = new Object();
	[Bindable] private var listData:XMLListCollection;
	
    public var myError:String;
	
	private function myPost():void{
	    params = {
	    "userid":Application.application.userID,
	    "refhotel":Application.application.myHotel,
	    "org":referralModel.org, 
	    "evt":referralModel.evt, 
	    "estNum":referralModel.estNum, 
	    "contactName":referralModel.contactName, 
	    "contactTitle":referralModel.contactTitle, 
	    "address":referralModel.address, 
	    "address2":referralModel.address2, 
	    "city":referralModel.city, 
	    "state":referralModel.state, 
	    "country":referralModel.country, 
	    "zipcode":referralModel.zipcode, 
	    "emailAddress":referralModel.emailAddress, 
	    "phone":referralModel.phone, 
	    "fax":referralModel.fax, 
	    "estDecisionDate":referralModel.estDecisionDate, 
	    "commissionable":referralModel.commissionable, 
	    "commPercent":referralModel.commPercent, 
	    "IATA":referralModel.IATA, 
	    "estRate":referralModel.estRate, 
	    "referralType":referralModel.referralType, 
	    "startDate":referralModel.startDate, 
	    "comments":referralModel.comments, 
	    "requests":referralModel.requests
	    }; 
		//referralService.cancel();
		//referralService.method = "POST";
		referralService.send(params);
		//sendReferral();
	}
	
	private function sendReferral():void{
		referralService.addEventListener(ResultEvent.RESULT,resultHandlerReferral);
		referralService.method = "POST";
		//params['method'] = "FindAll";
		referralService.cancel();
		referralService.send();
	}
	
	private function resultHandlerReferral(event:ResultEvent):void {	
		var result:XML = XML(event.result);  

		myError = result.item.error.toString();
		if (myError != ""){
			Alert.show(myError, "There has been an error...");
		} else {
			//submitSuccess();
		}
	}
	
	private function faultHandlerReferral(event:FaultEvent):void {	

		myError = "An error has occurred within the application.  Please try again.";
		Alert.show(myError, "There has been an error...");
	}

	private function submitSuccess():void{
		mainVS.selectedIndex = 5;
	}


