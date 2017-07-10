package FlexBalls
{
	public class Ball {
		internal var model : Object = {
			"walls" : {"left":0, "top":0, "right": 500, "bottom": 300},
			"elastity" : -0.2,
			"ballRadius" : 26,
			"maxSpeed" : 3.0 
		};

		public function Ball() {
			// default provisioning
			this._x = (model.walls.right - model.walls.left - 2*model.ballRadius)*Math.random(); 
			this._y = (model.walls.bottom - model.walls.top - 2*model.ballRadius)*Math.random();
			this._vx = 2*model.maxSpeed*Math.random() - model.maxSpeed;
			this._vy = 2*model.maxSpeed*Math.random() - model.maxSpeed;
			this._r = model.ballRadius; // d = 52 px
			this._d = 2*this._r;
			this._d2 = this._d*this._d;
		}
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _r:Number = 26;
		protected var _d:Number;
		protected var _d2:Number;		
		
		public function move() : void {
			this._x += this._vx;
			this._y += this._vy;
			// walls collisons
			
			// left
			if (this._x < model.walls.left && this._vx<0) {
				//this._vx += (this._x - walls.left)*elastity;
				this._vx = -this._vx;
			}
			// top
			if (this._y < model.walls.top && this._vy<0) {
				//this._vy += (this._y - walls.top)*elastity;
				this._vy = -this._vy;
			}
			// right
			if (this._x > model.walls.right - this._d && this._vx>0) {
				//this._vx += (this._x - walls.right + this._d)*elastity;
				this._vx = -this._vx;
			}
			// bottom
			if (this._y > model.walls.bottom - this._d && this._vy>0) {
				//this._vy += (this._y - walls.bottom + this._d)*elastity;
				this._vy = -this._vy;
			}
		}
		
		public function doCollide (b : Ball) : Boolean {
			// calculate some vectors 
			var dx : Number = this._x - b._x;
			var dy : Number = this._y - b._y;
			var dvx : Number = this._vx - b._vx;
			var dvy : Number = this._vy - b._vy;	
			var distance2 : Number = dx*dx + dy*dy;
				
			if (Math.abs(dx) > this._d || Math.abs(dy) > this._d) 
				return false;
			if (distance2 > this._d2)
				return false;
			
			// make absolutely elastic collision
			var mag : Number = dvx*dx + dvy*dy;
			
			// test that balls move towards each other	
			if (mag > 0) 
				return false;
		
			mag /= distance2;
			
			var delta_vx : Number = dx*mag;
			var delta_vy : Number = dy*mag;
			
			this._vx -= delta_vx;
			this._vy -= delta_vy;
			
			b._vx += delta_vx;
			b._vy += delta_vy;
				
			return true;
		}
	}

}