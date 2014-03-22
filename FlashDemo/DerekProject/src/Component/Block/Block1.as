package Component.Block 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Manager.LoadingManager;
	import Enum.AssetList;
	import Box2D.Dynamics.b2Body;
	/**
	 * ...
	 * @author hello
	 */
	public class Block1 extends BaseBlock
	{
		public function Block1() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK1) );
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block1";
		}
	}
}