package Control 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Component.B2World;
	import Component.Block.BaseBlock;
	import Component.Block.*;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import Manager.GameLoopManager;
	import Utils.B2DestroyEvent;
	/**
	 * ...
	 * @author JL
	 */
	public class B2WordBlockGenerateControl
	{
		private var blockClassList:Vector.<Class> = new Vector.<Class>();
		private var AppePobability:Vector.<Number> = new Vector.<Number>();
		private var normalizedVector:Vector.<Number> = new Vector.<Number>();
		private var world:B2World;
		private var WorldCreateId:int = 0;		
		private var fixBlockGeneratorInterval:uint;
		private var physicsData:PhysicsData;
		
		public function B2WordBlockGenerateControl(_world:B2World) 
		{
			physicsData = new PhysicsData();
			blockClassList.push(Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8);
			AppePobability.push(0.5,	0.5,	0.2,	0.2,	0.2,    0.2,    0.2,    0.2   );
			var total:Number = 0;
			for (var i:int = 0; i < AppePobability.length; i++)
				total += AppePobability[i];
			for (i = 0; i < AppePobability.length; i++)
				normalizedVector.push(AppePobability[i]/total);
			
			world = _world;
			world.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			world.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
		}
		
		private function offStage(e:Event):void
		{
			GameLoopManager.Core.stage.removeEventListener("B2Destroy", DestroyBlock);
			e.target.removeEventListener(e.type, arguments.callee);
			//world.addEventListener(Event.ADDED_TO_STAGE, onStage);
			clearInterval(fixBlockGeneratorInterval);
		}
		
		public function start():void
		{
			// create boundary
			draw_box(-20,600,20,1200,"left");
            draw_box(560,600,20,1200,"right");
            draw_box(270, -500, 540, 10, "ceiling");
			//draw_box(270,2500,540,200,"ground");
			fixBlockGeneratorInterval = setInterval(GenerateBlock, 250);
			GameLoopManager.Core.stage.addEventListener("B2Destroy", DestroyBlock);
		}
		
		private function GenerateBlock():void
		{
			if (Math.random() > 0.65)	// trigger the creation event
			{
				var BlockClass:Class = RandomBlock();
				var block:BaseBlock = new BlockClass();
				var xPosition:Number;
				switch(block.type)
				{
					case BaseBlock.TYPE_free:
						xPosition = Math.random() * 550;
						break;
					case BaseBlock.TYPE_wall_L:
						xPosition = 0;
						break;
					case BaseBlock.TYPE_wall_R:
						xPosition = 550 - block.width;
						break;
				}
				//block.alpha = 0.5;
				//block.visible = false;
				draw_Obstacle(xPosition, 1050, block.PhysicsKey, "block" + WorldCreateId, block );
				
				WorldCreateId++;
				if (WorldCreateId > 999)
					WorldCreateId = 0;
			}
		}
		
		private function DestroyBlock(e:B2DestroyEvent):void
		{
			var target:b2Body = e.DestroyBody as b2Body;
			var name:String = target.GetUserData().name;
			var mc:MovieClip = target.GetUserData().mc;
			if (mc.parent)
				mc.parent.removeChild(mc);
			delete world.BlockList[name];
			trace("Destroy " + name);
			world.DestroyList.push(target);
		}
		
		private function draw_box(px:Number,py:Number,w:Number,h:Number,ud:String):void {
            var my_body:b2BodyDef= new b2BodyDef();
            my_body.position.Set(px/world.world_scale, py/world.world_scale);
			my_body.type = b2Body.b2_kinematicBody;
			var my_box:b2PolygonShape;
			my_box = new b2PolygonShape();
			my_box.SetAsBox(w / 2 / world.world_scale, h / 2 / world.world_scale);
            var my_fixture:b2FixtureDef = new b2FixtureDef();
            my_fixture.shape = my_box;
			my_fixture.restitution = 0.8;
			my_fixture.density = 1;
			my_fixture.friction = 0;
            var world_body:b2Body=world.world.CreateBody(my_body);
            world_body.CreateFixture(my_fixture);
			world_body.SetUserData( { name:ud, mc:null, active:true } );
			world_body.SetFixedRotation(true);
        }
		
		private function draw_Obstacle(px:Number,py:Number, PhysicsKey:String, name:String, mc:MovieClip ):void
		{
			if (mc == null)
				return;
				
			var world_body:b2Body = physicsData.createBody(PhysicsKey, world.world, b2Body.b2_dynamicBody, { name:name, mc:mc, active:true } );
			world_body.SetPosition(new b2Vec2(px / world.world_scale, py / world.world_scale));
			world_body.SetFixedRotation(true);
			mc.x = px;
			mc.y = py;
			world.addChild(mc);
			world.BlockList[name] = world_body;
		}
		
		private function RandomBlock():Class
		{
			var randomNumber:Number = Math.random();
			
			var cum:Number = 0;
			for (var i:int = 0; i < blockClassList.length; i++)
			{
				cum += normalizedVector[i];
				if (cum > randomNumber)
					return blockClassList[i];
			}
			return Block1;
		}
	}
}