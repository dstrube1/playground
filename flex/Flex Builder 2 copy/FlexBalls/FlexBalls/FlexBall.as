package FlexBalls
{
	import mx.controls.Image;
	public class FlexBall extends Ball
	{
		public function FlexBall(id : Image)
		{
			super();
			this._id = id;
			//this._elem = mx.collections.;

			this.move();
		}
		private var _id : Image;
		
		public override function move() : void {
			super.move();
			this._id.x = this._x;
			this._id.y = this._y;
		}
		
		public function clone() : FlexBall {
			var newId : Image = new Image();
			newId.source = this._id.source;
			this._id.parent.addChild(newId);
			return new FlexBall(newId);
		}
		
		public function remove() : void {
			this._id.parent.removeChild(this._id);
		}
	}
}