package acj.containers
{
	import mx.core.UIComponent;
	import mx.collections.ArrayCollection;
	import flash.display.Shape;
	import acj.menuClasses.MenuLabel;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import acj.events.MenuEvent;
	
	//-----------------------------------------------
	//EVENTS
	//-----------------------------------------------
	/**
	 * itemOver event is dispatched when an item is moused over
	 **/
	 [Event(name="itemClick", type="acj.events.MenuEvent")]
	 
	/**
	 * itemOver event is dispatched when an item is moused over
	 **/
	 [Event(name="itemOver", type="acj.events.MenuEvent")]

	//-----------------------------------------------
	//STYLES
	//-----------------------------------------------
	/**
	 * paddingLeft pads the left of the set of labels
	 */
	[Style(name="paddingLeft", type="Number")]
	
	/**
	 * paddingTop pads the top of the set of labels
	 */
	[Style(name="paddingTop", type="Number")]
	
	/**
	 * verticalGap is the gap between each MenuLabel
	 */
	[Style(name="verticalGap", type="Number")]
	
	public class MenuWrapper extends UIComponent
	{
		/*****************animation vars*******************/
		/**
		 * initLabelIndex is used in updateDisplayList when it loops over 
		 * the aLabels array and does it's animation
		 **/
		private var initLabelIndex:int = 0;
		
		/**
		 * initLabelsComplete is set to true when all of the labels are done 
		 * getting setup.
		 **/
		private var initLabelsComplete:Boolean = false;
		
		private var _border:Shape;
		
		//----------------------------------------------------
		//
		// PUBLIC PROPERTIES
		//
		//----------------------------------------------------
		
		/**
		 * aLabels is an array of MenuLabels, used in the updateDisplayList and commitProperties
		 */
		private var _aLabels:Array = [];
		public function get aLabels():Array{
			return _aLabels;
		}
		
		public function set aLabels(val:Array):void{
			_aLabels = val;
		}
		
		/**
		 * dataProvider takes an arrayCollection of strings
		 * that create an array of MenuLabels
		 **/
		private var _isDataProviderDirty:Boolean = false;
		private var _dataProvider:ArrayCollection = new ArrayCollection(); //set to a new ac to avoid null errors
		public function set dataProvider(val:ArrayCollection):void 
		{
			_dataProvider = val;
			_isDataProviderDirty = true;
			
			invalidateProperties();
		}
		public function get dataProvider():ArrayCollection 
		{
			return _dataProvider;
		}
		
		/**
		 * _isLabelDirty is a flag set to false, it is used for 
		 * properties of the label, color, alpha, minSize, hoverPadding... etc
		 * each setter, sets this property to true, and calls invalidateProperties();
		 **/
		
		private var _isLabelDirty:Boolean = false;
		private var _labelBackgroundColor:uint = 0xffffff;
		public function set labelBackgroundColor(val:uint):void
		{
			_labelBackgroundColor = val;
			_isLabelDirty = true;
			
			invalidateProperties();
		}
		public function get labelBackgroundColor():uint
		{
			return _labelBackgroundColor;
		}
		
		private var _labelBackgroundAlpha:Number = .5;
		public function set labelBackgroundAlpha(val:Number):void
		{
			_labelBackgroundAlpha = val;
			_isLabelDirty = true;
			
			invalidateProperties();
		}
		public function get labelBackgroundAlpha():Number
		{
			return _labelBackgroundAlpha;
		}
		
		/**
		 * labelMaxSize is the fontSize of the label that it will 
		 * increase to while hovering over it.
		 * when you set this to 25, you start to get overlap of the components
		 * this could be fixed with some logic, but just keep it at 
		 * 16 for this example so we don't get too complicated.
		 **/
		private var _labelMaxSize:Number = 16;
		public function set labelMaxSize(val:Number):void
		{
			_labelMaxSize = val;
			_isLabelDirty = true;
			
			invalidateProperties();
		}
		public function get labelMaxSize():Number
		{
			return _labelMaxSize;
		}
		
		/**
		 * labelMinSize is the minimum fontSize the the label will return
		 * back to after someone has hovered over it
		 * when you set this under 10, you start to see some issues
		 * with cropping of the labels, i think for this component we should just 
		 * be aware that 10 is a good min size.
		 **/
		private var _labelMinSize:Number = 10;
		public function set labelMinSize(val:Number):void
		{
			_labelMinSize = val;
			_isLabelDirty = true;
			
			invalidateProperties();
		}
		public function get labelMinSize():Number
		{
			return _labelMinSize;
		}
		
		/**
		 * labelHoverPadding is the padding that gets set when 
		 * you hover over a menu item, the higher the number
		 * the more right the menu item will move
		 */
		private var _labelHoverPadding:Number = 10;
		public function set labelHoverPadding(val:Number):void
		{
			_labelHoverPadding = val;
			_isLabelDirty = true;
			
			invalidateProperties();
		}
		public function get labelHoverPadding():Number
		{
			return _labelHoverPadding;
		}
		
		/**
		 * selectedItem is the is the label in which
		 * is currently selected
		 */
		private var _selectedItemDirty:Boolean = false;
		private var _selectedItem:MenuLabel = null;
		public function set selectedItem(val:MenuLabel):void
		{
			_selectedItem = val;
			_selectedItemDirty = true;
			
			invalidateProperties();
		}
		public function get selectedItem():MenuLabel
		{
			return _selectedItem;
		}
		
		//===============================================
		// Constructor 
		//===============================================
		
		public function MenuWrapper()
		{
			super();
		}

		
		//===============================================
		// overridden methods
		//===============================================
		override protected function createChildren():void
		{
			super.createChildren();
			
			// draws white background
			_border = new Shape();
			_border.graphics.clear();
			_border.graphics.beginFill(0xFFFFFF,.1);
			_border.graphics.drawRoundRectComplex(0,0,measuredWidth,measuredHeight,0,14,0,14);
			_border.graphics.endFill();

			addChild(_border);
			//trace('createChildren');
		}
		
		override protected function commitProperties():void
		{
			var l:MenuLabel;
			var i:int;
			
			if(_isDataProviderDirty)
			{
				//before resetting aLabels to empty loop through 
				//the array and remove the proper children
				for(var rli:int = aLabels.length - 1; rli >= 0; rli--)
				{
					//removeListeners
					removeListeners(aLabels[rli]);
					removeChild(aLabels[rli]);
				}
				aLabels = [];
				initLabelIndex = 0;
				initLabelsComplete = false;
				
				for(i = 0; i < dataProvider.length; i++)
				{
					l = new MenuLabel();
					l.text = dataProvider.getItemAt(i) as String;
					l.width = 100;
					l.height = 15;
					l.labelBackgroundAlpha = labelBackgroundAlpha;
					l.labelBackgroundColor = labelBackgroundColor;
					l.labelMaxSize = labelMaxSize;
					l.labelMinSize = labelMinSize;
					l.labelHoverPadding = labelHoverPadding;
					l.labelRowIndex = i;
					l.styleName = this;
					//setupListeners
					setupListeners(l);
					
					
					aLabels.push(l);
					addChild(l);
				}
				_isDataProviderDirty = false;
				invalidateDisplayList();
				
			}
			
			if(_isLabelDirty)
			{
				//loop through the children
				for(i = 0; i < dataProvider.length; i++)
				{
					l = aLabels[i] as MenuLabel;
					l.labelBackgroundAlpha = labelBackgroundAlpha;
					l.labelBackgroundColor = labelBackgroundColor;
					l.labelMaxSize = labelMaxSize;
					l.labelMinSize = labelMinSize;
					l.labelHoverPadding = labelHoverPadding;
					l.labelRowIndex = i;
					l.styleName = 'libel';
					
					l.invalidateDisplayList();
				}
				
				_isLabelDirty = false;
			}
			
			if(_selectedItemDirty)
			{
				//do something here to get the item that is selected
				//going to have to invalidate the label that is selected, 
				//so it changes color or something.
			}
				
			
			super.commitProperties();
		}
		
		override protected function measure():void
		{
			//trace('measure');
			
			super.measure();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			//trace('updateDisplaylist');
			
			
			/*****create vertical layout for menulabels*****/
			if(initLabelsComplete == false && aLabels.length)
			{
				if(initLabelIndex < aLabels.length)
				{
					proccessAnimation(initLabelIndex);
				}
			}
			
			_border.graphics.clear();
			_border.graphics.beginFill(0x000000,.5);
			_border.graphics.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,0,14,0,14);
			_border.graphics.endFill();
			
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
		
		private function proccessAnimation(i:int):void
		{
			//trace('[processAnimation]'+i);
			var paddingTop:Number = getStyle('paddingTop');
			var paddingLeft:Number = getStyle('paddingLeft');
			var verticalGap:Number = getStyle('verticalGap');
			
			
			var l:MenuLabel = aLabels[i] as MenuLabel;
			var myX:Number = paddingLeft;
			var myY:Number = paddingTop;
			if(i == 0)
			{
				l.x = myX += .5;
				l.y = myY;
			}
			else
			{
				var prevLabel:MenuLabel = aLabels[i-1] as MenuLabel;
				myX = paddingLeft; //x doesnt change
				myY = prevLabel.y + prevLabel.height + verticalGap;
				
				l.x = myX;
				l.y = myY;
			}
			
			if(i == aLabels.length)
				initLabelsComplete = true;
			
			initLabelIndex += 1;
				
			if(initLabelIndex < aLabels.length)
				updateDisplayList(width,height);
				
		}
		
		private function setupListeners(item:MenuLabel):void{
			item.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			item.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		private function removeListeners(item:MenuLabel):void{
			item.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			item.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		//========================================================
		//
		// HANDLERS
		//
		//========================================================
		
		private function onMouseOver(event:Event):void
		{
			var label:MenuLabel = event.currentTarget as MenuLabel;
			
			var e:MenuEvent = new MenuEvent("change", label);
			this.dispatchEvent(e);
		}
		
		private function onMouseDown(event:Event):void
		{
			var label:MenuLabel = event.currentTarget as MenuLabel;
			
			if(this.selectedItem != null)
			{
				selectedItem.isSelected = false;
				selectedItem.startDecreaseTimer();
			}
				
			label.isSelected = true;
			this.selectedItem = label;
			
			var e:MenuEvent = new MenuEvent(MenuEvent.ITEM_CLICK, label);
			this.dispatchEvent(e);
		}
		
		
	}
}