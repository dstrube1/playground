package FlexBalls
{
	import mx.controls.Image;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class BallsTest
	{
		function BallsTest(ballsO : Array = null, root_ball : Image = null, N : Number=0) {
			this._N = N; 
			if (null != root_ball){
				this._root_ball = root_ball;
				this._ballsO = new Array(); 
			}
			else {
				this._ballsO = ballsO;
				this._root_ball = null;
			}
			this._isRunning = false;
		}
		
		
		protected var _N : Number; // number of objects
		protected var _ballsO : Array; // what is? Array of FlexBalls
		protected var _isRunning : Boolean; //clear
		protected var _root_ball : Image; //clear
		protected var _F : Number = 0; // frames counter for FPS
		protected var _lastF : Number = 0;
		protected var _lastTime : Date;
		
		private var _frameTimer : Timer;
		private var _fpsTimer : Timer;
		
		public var _showFPS : Function = null;
		
		public function startN(N : Number) : void {
			this._N = N;
			this.start();
			//why not isRunning set true?
			// because start() does this
		}
		
		public function start() : void {
			if (this._isRunning) return;
			this._isRunning = true;
			
			this._F = 0;  
			this._lastF = 0;
			this._lastTime = new Date();

			var _this : BallsTest = this; //why?
			
			var moveBalls : Function = function() : void {
				if (_this._N > _this._ballsO.length) 
					return;
				_this._F++;
				// move balls
				for (var i : Number = 0; i<_this._N; i++) {
					_this._ballsO[i].move();
				}
				// process collisions
				for (i=0; i<_this._N; i++) {
					for (var j : Number = i+1; j<_this._N; j++) {
						_this._ballsO[i].doCollide(_this._ballsO[j]);
					}
				}
			}
			var showFps : Function = function() : void {
				if (_this._F - _this._lastF < 10) return;
				var currTime : Date = new Date();
				var delta_t : Number = (currTime.getMinutes() 
					- _this._lastTime.getMinutes())*60 + currTime.getSeconds() 
					- _this._lastTime.getSeconds() + (currTime.getMilliseconds() 
					- _this._lastTime.getMilliseconds())/1000.0;
				 
				var fps : Number = (_this._F - _this._lastF)/delta_t;
				
				_this._lastF = _this._F;
				_this._lastTime = currTime;
				
				if (_this._showFPS != null) 
					_this._showFPS.call(_this, Math.round(fps));
			}
			// create all our balls
			if (null!= this._root_ball){
				this._ballsO[0] = new FlexBall(this._root_ball);
				
				for (var i : Number =1; i<this._N; i++) {
					this._ballsO[i] = this._ballsO[0].clone();
				}
			}
			else{
				for (var i:Number =0; i< this._N; i++){
					var tempImage:Image = this._ballsO[i] as Image;
					tempImage.visible = true;
					tempImage.alpha = 0.5;
					this._ballsO[i] = tempImage;
					this._ballsO[i] = new FlexBall(this._ballsO[i]);
				}
			}
			
			this._frameTimer = new Timer(5);
			this._frameTimer.addEventListener(TimerEvent.TIMER, moveBalls);
			
			this._fpsTimer = new Timer(3000);
			this._fpsTimer.addEventListener(TimerEvent.TIMER, showFps);
			
			this._frameTimer.start();
			this._fpsTimer.start();
			
			//this._int1 = setInterval(moveBalls, 5);
			//this._int2 = setInterval(showFps, 3000);
		}
		
		public function stop() : Boolean{
			if (!this._isRunning) return false;
			this._isRunning = false;
			this._frameTimer.stop();
			this._fpsTimer.stop();
			
			for (var i : Number=1; i<this._N; i++) {
				this._ballsO[i].remove();
				delete this._ballsO[i];
			}
			delete this._ballsO[0];
			//clearInterval(this._int1);
			//clearInterval(this._int2);
			return true;
		}
	}
}