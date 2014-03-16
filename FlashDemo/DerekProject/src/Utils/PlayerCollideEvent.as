package Utils 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author hello
	 */
	public class PlayerCollideEvent extends Event
	{
		public var speed:Number
		public var position:Point;
		public function PlayerCollideEvent(_speed:Number, _position:b2Vec2 ) 
		{
			speed = _speed;
			position = new Point(_position.x, _position.y);
			super("PlayerCollide");
		}
		
	}

}