/**
	Copyright (c) 2007. Wheeler Street Design LLC.
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	  * Redistributions of source code must retain the above copyright notice,
	    this list of conditions and the following disclaimer.
	  * Redistributions in binary form must reproduce the above copyright notice,
	    this list of conditions and the following disclaimer in the documentation
	    and/or other materials provided with the distribution.
	  * Neither the name of Wheeler, and Street nor the names of its
	    contributors may be used to endorse or promote products derived from this
	    software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
	
	@author: Paul Rangel (prangel@wheelerstreet.com)
	@ignore
**/
package com.utils
{
	import mx.containers.Form;
	import mx.validators.Validator;
	import mx.events.ValidationResultEvent;
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.validators.Validator;
	import flash.events.Event;
	import flash.events.FocusEvent;

	[Event(name="valid", type="flash.events.Event")]
	[Event(name="invalid", type="flash.events.Event")]

	public class ValidatorForm extends Form
	{
		private var _validatorList:ArrayCollection;
		
		public function ValidatorForm()
		{
			_validatorList = new ArrayCollection();
		
			super();
		}
		/**
		 * Sets the validators and creates an array of objects with 
		 * referenced to the source of the Validator (the UIComponent
		 * being validated ), if the validator should supressEvents
		 * and the validator its self
		 * 
		 * The suppressEvents boolean tracks and visible representation
		 * of the Validation. Without it all of the fields being validated
		 * would be highlighted on the CHANGE event.
		 * 
		 **/
		 
		public function set validators(validators:Array):void 
		{
			for(var i:uint=0; i < validators.length; i++) 
			{
				var obj:Object = new Object();
				obj.source = Validator(validators[i]).source as UIComponent;
				obj.suppressEvents = true as Boolean; 
				obj.validator = validators[i] as Validator;
				
				UIComponent(obj.source).addEventListener(Event.CHANGE,handleDataChange);
				UIComponent(obj.source).addEventListener(FocusEvent.FOCUS_IN, addToEventsList);
				_validatorList.addItem(obj);
			}
		}
		
		/**
		 * On FOCUS_IN toggles the suppressEvents to allow for the 
		 * visual representation of the validation to be shown
		 * 
		 **/
		private function addToEventsList(event:FocusEvent):void 
		{
			var inputField:UIComponent = event.target.parent;
			for each(var v:Object in _validatorList) 
			{
				if(v.source == inputField) 
					v.suppressEvents = false;

			}
			inputField.addEventListener(Event.CHANGE,handleDataChange);
			inputField.removeEventListener(FocusEvent.FOCUS_IN, addToEventsList);
		}
		
		/**
		 * Checks errors and if there are none dispatches a
		 * generic Event and if the defaultButton is set
		 * will enable
		 **/
		
		private function handleDataChange(event:Event):void 
		{
			var errors:Array = validateAll() as Array;
			
			if(errors.length == 0 && defaultButton != null) {
				Button(defaultButton).enabled = true;
			} else {
				Button(defaultButton).enabled = false;
			}
			
			if(errors.length == 0) 
			{
				dispatchEvent(new Event(ValidationResultEvent.VALID));
			} else {
				dispatchEvent(new Event(ValidationResultEvent.INVALID));
			}
		}
		/**
		 * Validates the list and returns the number of errors. At 
		 * some point I'll try to do something meaningfull with this
		 * list of errors.
		 **/ 
		private function validateAll():Array
	    {   
	        var result:Array = [];

	        for each (var v:Object in _validatorList )
	        {
	            var resultEvent:ValidationResultEvent = Validator(v.validator).validate(null, v.suppressEvents);   
	            if (resultEvent.type != ValidationResultEvent.VALID)
	                result.push(resultEvent);
	        }   
	        
	        return result;
	    }
		
		
	}
}