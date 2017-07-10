
//import mx.rpc.events.ResultEvent;
	import com.login.register;
	
	import leadgine.components.view.homePage;
	
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;

			
	private var params:Object = new Object();
	[Bindable] private var listData:XMLListCollection;
	
	private var registerWindow:IFlexDisplayObject;            
	
	public var myhotelname:String;
	public var myhotel:String;
	public var code:String;
	public var myuserID:String;
	public var myuserfirst:String;
	public var myuserlast:String;
	public var myrole:String;
	public var myemail:String;
	public var myadmin:String;
	public var mylastlogin:String;
	public var myclientID:String;
	public var myclientName:String;

	private function showRegister():void {
	    // Create a non-modal TitleWindow container.
	    registerWindow = PopUpManager.createPopUp(this, register, true);
	    PopUpManager.centerPopUp(registerWindow);
	}	
	
	public function accessGranted():void {
		Application.application.home.lblWelcome.text = "Welcome " + myuserfirst + "!";
		Application.application.home.lblHotelName.text = myhotelname;
		Application.application.home.lblClientName.text = "for " + myclientName;
		Application.application.home.lblLastLogin.text = "Last login: " + mylastlogin;
		
		PopUpManager.removePopUp(this);
	}
	
	// This function retrieves the xml from the server.
	// The first line of the code calls the resultHandler function beneath it, which 
	// pulls the xml into a usable object (listData)
	
	public function getLogin():void{
		loginService.addEventListener(ResultEvent.RESULT,resultHandlerLogin);
		loginService.method = "GET";
		params['method'] = "FindAll";
		loginService.cancel();
		loginService.send(params);
		//viewstack1.selectedIndex=1;
	}
	
	public function resultHandlerLogin(event:ResultEvent):void {	
		var result:XML = XML(event.result);  
		
		//hotelname = result.data.hotelname.toString();
		code = result.item.code.toString();
		myhotel = result.item.hotel.toString();
		myhotelname = result.item.hotelname.toString();
		myuserID = result.item.userid.toString();
		myuserfirst = result.item.userfirst.toString();
		myuserlast = result.item.userlast.toString();
		myrole = result.item.role.toString();
		myemail = result.item.email.toString();
		myadmin = result.item.admin.toString();
		mylastlogin = result.item.lastlogin.toString();
		myclientID = result.item.clientid.toString();
		myclientName = result.item.clientname.toString();
		
		//Alert.show(admin);
		
		Application.application.userID = myuserID;
		Application.application.adminRole = myadmin;
		Application.application.hotel = myhotel;
		Application.application.hotelname = myhotelname;
		Application.application.clientID = myclientID;
		Application.application.clientName = myclientName;
		Application.application.userfirst = myuserfirst;
		Application.application.userlast = myuserlast;
		
		
	    //var xmlList:XMLList = result.data.children();	
		//listData = new XMLListCollection(xmlList);
		//trace(result.hotel.name); 
		if (code != "0"){
			Alert.show("We could not find your login on file.  Please try logging in again, or register.", "Invalid Login");
		} else {
			accessGranted();
			Application.application.init();
			
			//var hotelName:String = event.result.data.children;
			//Alert.show(email, "Success");
		}
	}
	
	// Called by the Submit button to send form variables to the server, 
	// then retrieve response by calling myGet()
	public function myPost():void{
		//loginService.removeEventListener(ResultEvent.RESULT,resultHandlerLogin);
		//loginService.method = "POST";
	    params = {"method":"Login", "userName":txtUsername.text, "password":txtPassword.text}; 
		loginService.cancel();
		loginService.send(params);
		loginService.method = "POST";
		clearInputFields();
		getLogin();
	}
	
	private function clearInputFields():void{
	    txtUsername.text = "";
	    txtPassword.text = "";
	    txtConfPassword.text = "";
	}