package leadgine.components.dto {
	import leadgine.components.Item;
	import leadgine.components.view.sides.RoomRow;
	import leadgine.events.PropertyContentReadyEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectProxy;
	
	//[Event(name="propertyContentReady", type="leadgine.events.PropertyContentReadyEvent")]
	public class FullServiceReferral {
		public var savedContact:Boolean = false;
		public var savedRoomBlock:Boolean = false;
		public var savedFunctionDates:ArrayCollection = new ArrayCollection;
		public var savedPropertySelection:Boolean = false;
		public var savedAdditionalInfo:Boolean = false;
		[Bindable] public var referralFormX:uint = 262;
		[Bindable] public var referralFormY:uint = 69;
		public const referralFormHeight:uint = 550;
		public const referralFormWidth:uint = 900;
		
		//Contact
		//DS 20091004
		//these magic strings were floating around in too many places:
		public const NEW_OR_EXISTING_OPTIONS:Array = ["New Contact","Existing Contact"];
		[Bindable] public var newOrExisting:String = NEW_OR_EXISTING_OPTIONS[0];
		[Bindable] public var org:String = "test";
		[Bindable] public var evt:String;
		[Bindable] public var contactFirstName:String;
		[Bindable] public var contactLastName:String;
		[Bindable] public var contactTitle:String;
		[Bindable] public var numGuests:String;
		[Bindable] public var address:String;
		[Bindable] public var address2:String;
		[Bindable] public var city:String;
		[Bindable] public var state:String;
		[Bindable] public var country:String;
		[Bindable] public var zipcode:String;
		[Bindable] public var phone:String;
		[Bindable] public var emailAddress:String;
		[Bindable] public var fax:String;
		[Bindable] public var estDecisionDate:Date;
		[Bindable] public var rateType:String;
		[Bindable] public var commPercent:String;
		[Bindable] public var rate:String;
		[Bindable] public var IATA:String;
		public static const RATE_TYPE_COMMISIONABLE:String = "Commissionable";
		public static const RATE_TYPE_NET_RATE:String = "Net Rate";
		/* public static const STATES:Array = new Array("--Select a State--",
			"AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN",
			"MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY");
		*/
		public static const STATES:Array = [ {label:"Alabama", data:"AL"},
			{label:"Alaska", data:"AK"},
			{label:"Arizona", data:"AZ"},
			{label:"Arkansas", data:"AR"},
			{label:"California", data:"CA"},
			{label:"Colorado", data:"CO"},
			{label:"Connecticut", data:"CT"},
			{label:"Delaware", data:"DE"},
			{label:"District of Columbia", data:"DC"},
			{label:"Florida", data:"FL"},
			{label:"Georgia", data:"GA"},
			{label:"Hawaii", data:"HI"},
			{label:"Idaho", data:"ID"},
			{label:"Illinois", data:"IL"},
			{label:"Indiana", data:"IN"},
			{label:"Iowa", data:"IA"},
			{label:"Kansas", data:"KS"},
			{label:"Kentucky", data:"KY"},
			{label:"Louisiana", data:"LA"},
			{label:"Maine", data:"ME"},
			{label:"Maryland", data:"MD"},
			{label:"Massachusetts", data:"MA"},
			{label:"Michigan", data:"MI"},
			{label:"Minnesota", data:"MN"},
			{label:"Mississippi", data:"MS"},
			{label:"Missouri", data:"MO"},
			{label:"Montana", data:"MT"},
			{label:"Nebraska", data:"NE"},
			{label:"Nevada", data:"NV"},
			{label:"New Hampshire", data:"NH"},
			{label:"New Jersey", data:"NJ"},
			{label:"New Mexico", data:"NM"},
			{label:"New York", data:"NY"},
			{label:"North Carolina", data:"NC"},
			{label:"North Dakota", data:"ND"},
			{label:"Ohio", data:"OH"},
			{label:"Oklahoma", data:"OK"},
			{label:"Oregon", data:"OR"},
			{label:"Pennsylvania", data:"PA"},
			{label:"Rhode Island", data:"RI"},
			{label:"South Carolina", data:"SC"},
			{label:"South Dakota", data:"SD"},
			{label:"Tennessee", data:"TN"},
			{label:"Texas", data:"TX"},
			{label:"Utah", data:"UT"},
			{label:"Vermont", data:"VT"},
			{label:"Virginia", data:"VA"},
			{label:"Washington", data:"WA"},
			{label:"West Virginia", data:"WV"},
			{label:"Wisconsin", data:"WI"},
			{label:"Wyoming", data:"WY"}
		];
			
		public static const COUNTRIES:Array = [{label:"United States", data:"USA"},
		{label:"Canada", data:"CAN"},{label:"Mexico",data:"MEX"}];
		//public static const STATUS_OPTIONS:Array = new Array("Select",
		public static const STATUS_OPTIONS:Array = new Array("--Select a Status--","Pending","Tentative","Definite","Rejected","Lost");

		public function getState(state:String):Object{
			for each(var o:Object in FullServiceReferral.STATES){
				if (o.label == state){
					return o;
				}
			}
			return null;
		}
		public function getCountry(country:String):Object{
			for each(var o:Object in FullServiceReferral.COUNTRIES){
				if (o.label == country){
					return o;
				}
			}
			return null
		}

		//Room Block
		[Bindable] public var startDate:Date;
		public var roomRowArray:ArrayCollection;
		
		//Function
		public var functionArray:ArrayCollection;
		
		//PropertySelection
		[Bindable] 
		public var folderCollection:XMLListCollection;
		
		//AdditionalInfo
		[Bindable] public var commentsText:String;
		[Bindable] public var requestsText:String;
		
		//?
		//public var referralType:String;
		
		public static const GOOGLE_MAP_KEY:String = "ABQIAAAAXuXyTCQMOvuNsde1kkcArhQgrU5kbjlKk2X0omoanmzVDSsrVBREIpIaxGvHFAyYleNAOfcudxaxbA";
		
		public function FullServiceReferral():void {
			
		}
		//Perhaps these functions should be moved to a utility class:
		public function middlize(callerWidth:uint = referralFormWidth, callerHeight:uint = referralFormHeight):void{
			var midX:uint = Application.application.width / 2;
			var midY:uint = Application.application.height / 2;
		
			referralFormX = midX - (callerWidth / 2);
			referralFormY = midY - (callerHeight / 2);
			//Alert.show("x = "+referralFormX+"; y="+referralFormY);
		}
		public function setSummary(listIncoming:XMLListCollection):void{
			var xml:XML = listIncoming[0];
			org = xml.child("company");
			evt = xml.child("myEvent");
			//newOrExisting = xml.child("");
			//contactFirstName = xml.child("");
			//contactLastName = xml.child("");
			//contactTitle = xml.child("");
			numGuests = xml.child("attendees");
			//address = xml.child("");
			//address2 = xml.child("");
			//city = xml.child("");
			//state = xml.child("");
			//country = xml.child("");
			//zipcode = xml.child("");
			//phone = xml.child("");
			//emailAddress = xml.child("");
			//fax = xml.child("");
			estDecisionDate = new Date(xml.child("decision_date"));
			if(xml.child("commissionable") == "False"){
				rateType = RATE_TYPE_NET_RATE;
			}else{
				rateType = RATE_TYPE_COMMISIONABLE;
			}
			commPercent = xml.child("commission");
			rate = xml.child("rate");
			IATA = xml.child("iata");

			/*
			<id>1</id>
			<contact_id>0</contact_id>
			<comments>No special comments yet.</comments>
			<requests>No special requests at this time</requests>
			<userid>1</userid>
			<hotel>78</hotel>
			<checked_out>False</checked_out>
			<approved>False</approved>
			<approval_person></approval_person>
			<check_cut>False</check_cut>
			<extended_stay>False</extended_stay>
			<nights>0</nights>
			<arrival>9/3/2009 6:08:00 PM</arrival>
			<totalrooms>0</totalrooms>
			<roomRevenue>103992</roomRevenue>
			<rentalRevenue>0</rentalRevenue>
			<cateringRevenue>0</cateringRevenue>
			<sentDate>4/21/2009</sentDate>
			<myStatus>Tentative</myStatus>
			<bonus>1040</bonus>
			*/
		}
		private var tempHotels:ArrayCollection = new ArrayCollection();
		private var searchService:HTTPService;
		
		public function setSummaryFromObjectProxy(objectP:ObjectProxy):void{
			//Contact
			org = objectP.org;
			evt = objectP.evt;

			newOrExisting = NEW_OR_EXISTING_OPTIONS[objectP.newOrExisting];
			
			contactFirstName = objectP.firstname;
			contactLastName = objectP.lastname;
			contactTitle = objectP.mytitle;
			numGuests = objectP.numGuests;
			address = objectP.address;
			address2 = objectP.address2;
			city = objectP.city;
			state = objectP.mystate;
			country = objectP.country;
			zipcode = objectP.zip;
			phone = objectP.phone;
			emailAddress = objectP.email
			fax = objectP.fax;
			estDecisionDate = new Date(objectP.estDecisionDate);
			if(! objectP.rateType){
				rateType = RATE_TYPE_NET_RATE;
			}else{
				rateType = RATE_TYPE_COMMISIONABLE;
			}
			commPercent = objectP.commPercent;
			rate = objectP.rate;
			IATA = objectP.IATA;
			
			//Room Block
			//startDate = new Date(objectP.startDate)
			roomRowArray = new ArrayCollection();
			for each (var roomRowACOP:ArrayCollection in objectP.roomRows){
//ugh, this is not the right data structure.
//this function should only have one "for each" loop for the roomInfo.
//this roomRowAOP is an array of ObjectProxies
//this array of ObjectProxies looks like it always has only one element- making it redundant
//objectP.roomRows should be the array collection, with 0-n roomRow objects (or objectProxies)
//this may be unsolvable until the Single Referral webservice returns XML instead of ObjectProxies
				for each(var row:ObjectProxy in roomRowACOP){
					var roomRow:RoomRow = new RoomRow();
					roomRow.doubleCount = row.doubleCount;
					roomRow.singleCount = row.singleCount;
					roomRow.roomDateText = row.roomDate;
					//this shouldn't be necessary for RoomBlockContent:
					//roomRow.rate.text = rate;
					roomRowArray.addItem(roomRow);
				}
			}

			//Function
			functionArray = new ArrayCollection();
			savedFunctionDates = new ArrayCollection();
			for each (var functionsACOP:ArrayCollection in objectP.functions){
				for each (var functionItems:ObjectProxy in functionsACOP){
					var functionItem:ObjectProxy = functionItems.functionItems.functionItem;
					var item:Item = new Item();
					item.myDate			= functionItem.functionDate;
					if (!savedFunctionDates.contains(item.myDate)){
						savedFunctionDates.addItem(item.myDate);
					}
					item.myID			= functionItem.functionID;
					var isFirstItem:Boolean = true;
					for each (var temp:Item in functionArray){
						if (temp.myDate == item.myDate){
							isFirstItem = false;
							break;
						}
					}
					item.isFirstItem	= isFirstItem; //this should be in functionsACOP, shouldn't have to derive it - this is unnecessary delay
					item.startTime		= functionItem.startTime;
					item.endTime		= functionItem.endTime;
					item.functionDesc	= functionItem.functionDescription;
					item.numPeople		= functionItem.numPeople;
					item.setup			= functionItem.setup;
					item.foodBevComment = functionItem.foodBevComments;//note the difference here
					item.readOnly 		= true;
					item.myFunctionArray= functionArray;
					functionArray.addItem(item);
					//^?
					//Don't know why this isn't showing in the Summary screen
				}
			}
			
			//PropertySelection
			//be sure that folderCollection has already been set
			if (objectP.hotels != null && objectP.hotels.myState != null){
				tempHotels = objectP.hotels.myState;
				var arrayOfHotelNames:Array = new Array();
				for each (var myState:ObjectProxy in tempHotels){
					var myStateId:String = myState.id;
					if (myState.brand is ObjectProxy){ //the object type should NOT be conditional
						var brand:ObjectProxy = myState.brand;
						var hotelID:String = brand.hotel.hotelID;
						var hotelName:String = brand.hotel.hotelName;
						arrayOfHotelNames.push(hotelName);
					}else if (myState.brand is ArrayCollection){
						var brand2:ArrayCollection = myState.brand;
						for each (var o:ObjectProxy in brand2){
							if (o is ArrayCollection){//the object type should NOT be conditional
								var hotels:ArrayCollection = o.hotel;
								for each (var hotel:ObjectProxy in hotels){
									arrayOfHotelNames.push(hotel.hotelName);
								}
							}else if (o is ObjectProxy){
								//var debug:String = "set breakpoint here";
								if (o.hotel is ArrayCollection){
									var hotels:ArrayCollection = o.hotel;
									for each (var hotel:ObjectProxy in hotels){
										arrayOfHotelNames.push(hotel.hotelName);
									}
								}
								else if (o.hotel is ObjectProxy){
									arrayOfHotelNames.push(o.hotel.hotelName);
								}
								
							}
						}
					}
				}
				for each (var stateXML:XML in folderCollection.children()){
					for each (var brandXML:XML in stateXML.children()){
						for each (var hotelXML:XML in brandXML.children()){
							if (hotelXML.@isBranch == "false" ){
								for each (var hotelName:String in arrayOfHotelNames){
									//total += hotelName;
									if (hotelXML.@label == hotelName){
										hotelXML.@state = "checked";
										//on to the next hotelXML
										break;
									}
								}
							}
	
						}
					}
				}
			}
						
			//AdditionalInfo
			commentsText = objectP.commentsText;
			requestsText = objectP.requestsText;
		}

		public function setContact(listIncoming:XMLListCollection, id:String):void{
			for each (var xml:XML in listIncoming){
				if (xml.child("id")==id){
					org = xml.child("company");
					//evt = xml.child("myEvent");
					newOrExisting = NEW_OR_EXISTING_OPTIONS[1];
					contactFirstName = xml.child("first_name");
					contactLastName = xml.child("last_name");
					contactTitle = xml.child("myTitle");
					//numGuests = xml.child("attendees");
					address = xml.child("address1");
					address2 = xml.child("address2");
					city = xml.child("city");
					state = xml.child("state");
					country = xml.child("country");
					zipcode = xml.child("zip");
					phone = xml.child("phone1");
					emailAddress = xml.child("email1");
					fax = xml.child("fax");
					estDecisionDate = new Date();//if we leave this null, makes setting the date a chore
					/*if(xml.child("commissionable") == "False"){
						rateType = RATE_TYPE_NET_RATE;
					}else{
						rateType = RATE_TYPE_COMMISIONABLE;
					}
					commPercent = xml.child("commission");
					rate = xml.child("rate");
					*/
					IATA = xml.child("iata");

					return;
				}
			}
			/*
			<notes>Handles a lot of meetings for Hewlett Packard.</notes></lead>
			*/
		}
		
		public function resetAll():void{
			savedContact = false; //might need to set the saveds to true for this to work
			savedRoomBlock = false;
			savedFunctionDates = new ArrayCollection;
			savedPropertySelection = false;
			savedAdditionalInfo = false;
			referralFormX = 262;
			referralFormY = 69;
			newOrExisting = NEW_OR_EXISTING_OPTIONS[0];
			org = "";
			evt = "";
			contactFirstName = "";
			contactLastName = "";
			contactTitle = "";
			numGuests = "";
			address = "";
			address2 = "";
			city = "";
			state = "";
			country = "";
			zipcode = "";
			phone = "";
			emailAddress = "";
			fax = "";
			estDecisionDate = new Date();
			rateType = "";
			commPercent = "";
			rate = "";
			IATA = "";
			startDate = new Date();
			roomRowArray = new ArrayCollection;
			functionArray = new ArrayCollection;
			folderCollection = new XMLListCollection();
			commentsText = "";
			requestsText = "";
			
		}
	}
}