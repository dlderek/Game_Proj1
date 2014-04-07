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
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import Manager.GameLoopManager;
	import Manager.GameStateManager;
	import Manager.ObstacleGroupManager;
	import Manager.XMLManager;
	import Utils.B2DestroyEvent;
	import Utils.B2NewBlockGroupEvent;
	/**
	 * ...
	 * @author JL
	 */
	public class B2WordBlockGenerateControl
	{
		private var world:B2World;
		private var WorldCreateId:int = 0;		
		private var RunTimeCreateClass:Array;
		//private var fixBlockGeneratorInterval:uint;
		private var physicsData:PhysicsData;
		private var GroupCreateId:int = 0;
		
		public function B2WordBlockGenerateControl(_world:B2World) 
		{
			physicsData = ObstacleGroupManager.PhyData;
			RunTimeCreateClass = [Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8, Collection, Block9, Block10, Block11, Block12, Block13, Block14, Block15, Block16, protect];
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
			//clearInterval(fixBlockGeneratorInterval);
			GameLoopManager.Core.stage.removeEventListener("B2NewBlockGroup", GenerateBlocks);
		}
		
		public function start():void
		{
			draw_box(-20,1000,20,2000,"left");
            draw_box(560,1000,20,2000,"right");
            draw_box(270, 20, 540, 10, "ceiling");
			//draw_box(270,2500,540,200,"ground");
			//trace(GameStateManager.CurrentStage);
			GroupCreateId = Math.floor(Math.random() * ObstacleGroupManager.ObstacleGroup.length);
			//fixBlockGeneratorInterval = setInterval(GenerateBlock, 550);
			GameLoopManager.Core.stage.addEventListener("B2NewBlockGroup", GenerateBlocks);
			GameLoopManager.Core.stage.addEventListener("B2Destroy", DestroyBlock);
			GenerateBlocks(null);
		}
		
		private function GenerateBlocks(e:B2NewBlockGroupEvent):void
		{
			var BlockGroup:Array = RandomBlockGroup();
			var LastBlock:BaseBlock;
			
			for each(var blockObj:Object in BlockGroup)
			{			
				var BlockClass:Class = getDefinitionByName("Component.Block." + (blockObj.name as String ) ) as Class;
				var block:BaseBlock = new BlockClass();
				block.InitX = blockObj.x;
				if (block.flip)
					block.InitX += block.width;
				block.InitY = blockObj.y + 1000;
				if (!LastBlock)
					LastBlock = block;
				else if (block.InitY > LastBlock.InitY)
					LastBlock = block;
				if (WorldCreateId > 999)
					WorldCreateId = 0;
				//block.alpha = 0.5;
				draw_Obstacle(block.InitX, block.InitY, block.PhysicsKey, "block" + WorldCreateId, block, b2Body.b2_kinematicBody, blockObj.fixture );
				WorldCreateId++;
			}
			LastBlock.addEventListener(Event.ENTER_FRAME, onLastBlockRemoved);
			LastBlock.addEventListener(Event.REMOVED_FROM_STAGE, onLastBlockRemoved);	
		}
		
		private function onLastBlockRemoved(e:Event):void
		{
			if (e.type == Event.REMOVED_FROM_STAGE)
			{
				e.target.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				e.target.removeEventListener(Event.REMOVED_FROM_STAGE, arguments.callee);
				return;
			}
			if (e.target.y < 775)
			{
				e.target.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				e.target.removeEventListener(Event.REMOVED_FROM_STAGE, arguments.callee);
				GameLoopManager.Core.stage.dispatchEvent(new B2NewBlockGroupEvent());
			}
		}
		
		private function DestroyBlock(e:B2DestroyEvent):void
		{
			var target:b2Body = e.DestroyBody as b2Body;
			var name:String = target.GetUserData().name;
			var mc:DisplayObject = target.GetUserData().mc;
			if(mc.parent)
				mc.parent.removeChild(mc)
			world.BlockList.splice(world.BlockList.indexOf(target),1);
			//delete world.BlockList[name];
			//trace("Destroy " + name);
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
			my_fixture.restitution = 1;
			my_fixture.density = 0;
			my_fixture.friction = 0;
            var world_body:b2Body=world.world.CreateBody(my_body);
            world_body.CreateFixture(my_fixture);
			world_body.SetUserData( { name:ud, mc:null, active:true } );
			world_body.SetFixedRotation(true);
        }
		
		private function draw_Obstacle(px:Number,py:Number, PhysicsKey:String, name:String, mc:DisplayObject , type:uint = 1, fixtureCollection:Vector.<b2FixtureDef> = null):void
		{
			if (mc == null)
				return;
			var world_body:b2Body;
			world_body = physicsData.createBody(PhysicsKey, world.world, type, { name:name, mc:mc, active:true } );
			world_body.SetPosition(new b2Vec2(px / world.world_scale, py / world.world_scale));
			//world_body.SetFixedRotation(true);
			mc.x = px;
			mc.y = py;
			world.addChild(mc);
			world.BlockList.push(world_body);
		}
		
		private function RandomBlockGroup():Array
		{
			var Group:Array = ObstacleGroupManager.ObstacleGroupX[GroupCreateId];
			//trace("Group : " + GroupCreateId);
			GroupCreateId++;
			if (GroupCreateId >= ObstacleGroupManager.ObstacleGroupX.length)
				GroupCreateId = 0;
			return Group;
			//var totalNum:int = ObstacleGroupManager.ObstacleGroup.length;
			//var randNum:int = Math.ceil(Math.random() * totalNum) - 1;
			//return ObstacleGroupManager.ObstacleGroup[randNum];
		}
	}
}