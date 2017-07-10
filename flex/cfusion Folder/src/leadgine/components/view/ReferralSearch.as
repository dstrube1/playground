
//import mx.rpc.events.ResultEvent;
	import com.login.register;
	
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;

			
	private var params:Object = new Object();
	[Bindable] private var listData:XMLListCollection;
	
	private var registerWindow:IFlexDisplayObject;            
	
	public var inbound:String;
	public var hotel:String;
	public var code:String;
	public var userid:String;
	public var contactfirst:String;
	public var contactlast:String;
	public var referrer:String;
	public var company:String;
	public var myEvent:String;
	public var status:String;
	public var roomsMin:Number;
	public var roomsMax:Number;
	public var revenueMin:Number;
	public var revenueMax:Number;
	public var rateMin:Number;
	public var rateMax:Number;
	public var myState:String;
	public var myCountry:String;

	
	public function search():void{
		searchService.addEventListener(ResultEvent.RESULT,resultHandlerSearch);
		searchService.method = "GET";
		params['method'] = "FindAll";
		searchService.cancel();
		searchService.send(params);
		//viewstack1.selectedIndex=1;
	}
	
	public function resultHandlerSearch(event:ResultEvent):void {	
		var result:XML = XML(event.result);  
		
		//hotelname = result.data.hotelname.toString();
		code = result.item.code.toString();
		hotel = result.item.hotel.toString();
		hotelname = result.item.hotelname.toString();
		userid = result.item.userid.toString();
		userfirst = result.item.userfirst.toString();
		userlast = result.item.userlast.toString();
		role = result.item.role.toString();
		email = result.item.email.toString();
		admin = result.item.admin.toString();
		lastlogin = result.item.lastlogin.toString();
		
		//Alert.show(admin);
		
	    //var xmlList:XMLList = result.data.children();	
		//listData = new XMLListCollection(xmlList);
		//trace(result.hotel.name); 
		if (code != "0"){
			Alert.show("We could not find your login on file.  Please try logging in again, or register.", "Invalid Login");
		} else {
			accessGranted();
			//var hotelName:String = event.result.data.children;
			//Alert.show(email, "Success");
		}
	}
	
	public function myPost():void{
	    params = {"inbound":radioInbound.selected, 
	    		"referrer":radioMyReferrals.selected,
	    		"company":companyText.text,
	    		"event":eventText.text,
	    		"firstName":firstNameText.text,
	    		"lastName":lastNameText.text,
	    		"status":statusCB.selectedItem,
	    		"roomMin":roomMin.text,
	    		"roomMax":roomMax.text,
	    		"revMin":revenueMin.text,
	    		"revMax":revenueMax.text,
	    		"rateMin":rateMin.text,
	    		"rateMax":rateMax.text,
	    		"state":stateCB.selectedItem,
	    		"country":countryCB.selectedItem
	    		}; 
		searchService.cancel();
		searchService.send(params);
		searchService.method = "POST";
		clearInputFields();
		search();
	}
	
	private function clearInputFields():void{
	    radioOutbound.selected = true;
	    radioMyReferrals.selected = true;
	    companyText.text = "";
	    eventText.text = "";
	    firstNameText.text = "";
	    lastNameText.text = "";
	    statusCB.selectedItem = "";
	    roomMin.text = "";
	    roomMax.text = "";
	    revenueMin.text = "";
	    revenueMax.text = "";
	    rateMin.text = "";
	    rateMax.text = "";
	    stateCB.selectedItem = "";
	    countryCB.selectedItem = "";
	}