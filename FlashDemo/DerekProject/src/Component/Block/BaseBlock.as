package Component.Block 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Component.BaseComponent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author hello
	 */
	public class BaseBlock extends BaseComponent
	{
		
		public static const ACTION_STACK:String = "stack";
		public static const ACTION_PAUSE:String = "pause";
		public static const ACTION_NONE:String = "none";
		public static const ACTION_JUMP:String = "jump";
		public static const ACTION_SLIDE:String = "slide";
		public static const ACTION_SLIDE_STACK:String = "slidestack";
		public static const ACTION_GET:String = "get";
		public static const ACTION_WATERFALL:String = "waterfall";
		public static const ACTION_FALL_AND_STACK:String = "fallandstack";
		public static const ACTION_PROTECT:String = "protect";
		
		public var ui:DisplayObject;
		
		public var stackLevel:int;
		public var type:String = "free";
		public var playerAction:String = "stack";
		public var PhysicsKey:String;
		public var sided:Boolean = false;
		public var mode:int = 0;
		
		public var InitX:Number;
		public var InitY:Number;
		public var flip:Boolean = false;
		
		public function BaseBlock(ui:Object) 
		{
			this.ui = ui as DisplayObject;
			super(this.ui);
			this.ui.cacheAsBitmap = true;
			//(ui as DisplayObject).cacheAsBitmapMatrix = new Matrix();
		}
	}
}