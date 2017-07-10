package acj.menuClasses
{
	import mx.core.UIComponent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import mx.controls.Text;
	import mx.effects.Effect;
	import mx.effects.Glow;
	import flash.filters.GlowFilter;
	import flash.filters.BlurFilter;
	import flash.display.Shape;
	import mx.controls.Label;

	public class MenuLabel extends Label
	{
		public var labelBackgroundAlpha:Number;
		public var labelBackgroundColor:uint;
		public var labelHoverPadding:Number = 9;
		public var labelMinSize:Number;
		public var labelMaxSize:Number;
		public var labelRowIndex:Number;
		public var isSelected:Boolean = false;
		
		private var animationIncreaseTimer:Timer = new Timer(25);
		private var animationDecreaseTimer:Timer = new Timer(25);
		private var overColor:uint = 0xfffccc;
		private var selectedColor:uint = 0xffffff;
		
		private var blurFilter:BlurFilter = new BlurFilter();
		private var highlightGlowFilter:GlowFilter = new GlowFilter(0xffcccc);
		
		private var _backgroundArea:Shape;
		
		private var _isProcessIncrease:Boolean = false;
		private var _isProcessDecrease:Boolean = false;
		
		private var _isFirstValidationPass:Boolean = true;
		
		
		public function MenuLabel()
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		
		/**
		 * startDecreaseTimer() is used from the MenuWrapper.
		 * when you click an item it sets the MenuLabel.isSelected to true.
		 * when the MenuWrapper handles the click, it deselects the current 
		 * label and sets MenuLabel.isSelected = false, then starts its 
		 * decrease timer so the item goes back to it's original state.
		 */
		public function startDecreaseTimer():void
		{
			animationDecreaseTimer.addEventListener(TimerEvent.TIMER, onAnimationDecreaseTimer);
			animationDecreaseTimer.start();
		}
		
		/**
		 * startIncreaseTimer() is a function that is called anywhere
		 * the IncreaseTimer might need to start, one place it is used
		 * and listened to is in this class onMouseOver().  
		 */
		public function startIncreaseTimer():void
		{
			animationIncreaseTimer.addEventListener(TimerEvent.TIMER, onAnimationIncreaseTimer);
			animationIncreaseTimer.start();
		}
		
		
		//-------------------------------------------------------
		//
		// OVERRIDDEN METHODS
		//
		//-------------------------------------------------------
		override protected function createChildren():void
		{
			_backgroundArea = new Shape();
			_backgroundArea.graphics.beginFill(labelBackgroundColor,labelBackgroundAlpha);
			_backgroundArea.graphics.drawRoundRectComplex(0,0,getExplicitOrMeasuredWidth(),getExplicitOrMeasuredHeight(),0,11,0,11);
			_backgroundArea.graphics.endFill();
			
			addChild(_backgroundArea);
			
			super.createChildren();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var myFontSize:Number = this.getStyle('fontSize');
			if(_isFirstValidationPass)
			{
				this.height = myFontSize + 5.2;
				this._backgroundArea.height = this.height;
				_isFirstValidationPass = false;
			}
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		private function onMouseOver(event:MouseEvent):void
		{
			//if the decrease timer is running, don't start the increaseTimer
			if( animationDecreaseTimer.hasEventListener(TimerEvent.TIMER) == false)
			{
				startIncreaseTimer();
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
		}
		
		private function onAnimationIncreaseTimer(event:TimerEvent):void
		{
			//trace('[increase]');
			//_isProcessIncrease = true;
			//invalidateDisplayList();
			var myFontSize:Number = this.getStyle('fontSize');
			
			myFontSize += 1;
			this.height = myFontSize + 6;
			this._backgroundArea.height = this.height;
			
			//move the label to the right.
			if(this.x < this.labelHoverPadding)
			{
				this.x += 1;
				//we have to offse the background and keep it at where it was
				//to do that, we just set it to 0
				if( this.x > 0 )
					this._backgroundArea.x -= 1;
			}
			
			this.filters = [blurFilter];
			
			if(myFontSize < labelMaxSize)
			{
				this.setStyle('fontSize',myFontSize);
			}
			
			if(myFontSize == labelMaxSize)
			{
				this._backgroundArea.filters = [highlightGlowFilter];
				this.filters = [];
			}

			if(this.isSelected)
				this._backgroundArea.filters = [highlightGlowFilter];
			else
				this.setStyle('fontColor',overColor);
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			this.removeIncreaseListener();
			
			this.startDecreaseTimer();
		}
		
		private function onAnimationDecreaseTimer(event:TimerEvent):void
		{
			//trace('[decrease]');
			//_isProcessDecrease = true;
			//invalidateDisplayList();
			
			if(this.isSelected)
			{
				this.removeDecreaseListener();
				return;
			}
				
			var myFontSize:Number = this.getStyle('fontSize');
			
			myFontSize -= 1;
			this.height = myFontSize + 5.2;
			
			this._backgroundArea.height = this.height;
			
			if(this.x > 0)
			{
				this.x -= 1;
				//we have to offse the background and keep it at where it was
				//to do that, we just keep it at 0
				this._backgroundArea.x += 1;
			}
			
			//we are going to reduce the fontSize and blur it as we do it.
			if(myFontSize > labelMinSize)
			{
				this.filters = [blurFilter];
				this._backgroundArea.filters = [];
				this.setStyle('fontSize',myFontSize);
			}
			
			
			if(this.x <= getStyle('paddingLeft') && myFontSize <= labelMinSize)
			{
				//make sure our x gets set to the original padding (most likely 0)
				//in case it ended up less than 0, we want set it back to 0
				this.x = getStyle('paddingLeft');
				
				removeDecreaseListener();
				this.filters = [];
			}
			
			this.setStyle('fontColor',overColor);
		}
		
		/**
		 * removeDecreaseListeners() is used to remove the 
		 * decreaseTimerListener and reset it
		 */
		 private function removeDecreaseListener():void
		 {
			animationDecreaseTimer.reset();
		 	animationDecreaseTimer.removeEventListener(TimerEvent.TIMER,onAnimationDecreaseTimer);
		 	_isProcessDecrease = false;
			
		 }
		 /**
		 * removeIncreaseListener() is used to remove the 
		 * removeIncreaseListener and reset it
		 */
		 private function removeIncreaseListener():void
		 {
		 	animationIncreaseTimer.reset();
			animationIncreaseTimer.removeEventListener(TimerEvent.TIMER, onAnimationIncreaseTimer);
			_isProcessIncrease = false;
			
		 }
		
		
	}
}
