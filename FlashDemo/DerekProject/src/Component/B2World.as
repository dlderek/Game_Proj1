package Component 
{
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2FrictionJoint;
	import Box2D.Dynamics.Joints.b2FrictionJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2LineJointDef;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.Joints.b2WeldJoint;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import Component.Block.BaseBlock;
	import Component.Block.Block1;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;0
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.utils.clearInterval;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import Manager.LoadingManager;
	import Utils.B2ContactListener;
	import Utils.B2DestroyEvent;
	import Utils.B2PlayerHitCeilEvent;
	import Utils.B2PlayerPauseEvent;
	import Utils.B2PlayerPlatformEvent;
	import Utils.B2PlayerStackEvent;
	import Utils.B2PlayerUnStackedEvent;
	import Utils.B2PlayerUnStackEvent;
	
    public class B2World extends Sprite {
        public var world:b2World=new b2World(new b2Vec2(0,5), false);
        public var world_scale:int=30;
        public var player:b2Body;
		public var blockUpSpeed:Number = -3;
        public var force:b2Vec2;
		private var ContactListener:B2ContactListener;
		private var WorldCreateId:int = 0;
		public var BlockList:Vector.<b2Body> = new Vector.<b2Body>();
		public var DestroyList:Array = [];
		private var stackJoint:b2Joint;
		private var stackedLevel:int;
		private var touchPoint:b2Vec2;
		private var getTouchTime:uint;
		private var fixTouchInterval:uint;
		
		private const maxPlayHP:int = 10;
		private var playerHP:int = 10;
		
		private var pointerArrow:Arrow;
		
		//{ BasicSetup
        public function B2World():void {
			pointerArrow = new Arrow();
			pointerArrow.alpha = 0.75;
			ContactListener = new B2ContactListener();
			world.SetContactListener(ContactListener);
            //debug_draw();
			add_player(270, 150, new Character());
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
        }
		
		private function onStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			this.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
		}
		
		private function offStage(e:Event):void
		{
			world.ClearForces();
			e.target.removeEventListener(e.type, arguments.callee);
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
			removeEventListener(Event.ENTER_FRAME, B2WorldUpdate);
			removeEventListener(Event.ENTER_FRAME, Update);
			stage.removeEventListener("B2PlayerStack", PlayerStack);
			stage.removeEventListener("B2PlayerUnStack", PlayerUnStack);
			removeEventListener(Event.EXIT_FRAME, DestroyBlockList);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onSwipe);
			clearInterval(fixTouchInterval);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onSwipe);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.removeEventListener("B2PlayerUnStacked", PlyerUnStacked);
			stage.removeEventListener("B2PlayerPause", onPlayerPause);
			stage.removeEventListener("B2PlayerPlatform", onPlayerPlatform);
			stage.removeEventListener("B2PlayerHitCeil", onPlayerHitCeil);
		}
		
		public function StartGame():void
		{
			addEventListener(Event.ENTER_FRAME, B2WorldUpdate);
			addEventListener(Event.ENTER_FRAME, Update);
			stage.addEventListener("B2PlayerStack", PlayerStack);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(Event.EXIT_FRAME, DestroyBlockList);
			stage.addEventListener("B2PlayerPause", onPlayerPause);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onSwipe);
			stage.addEventListener(MouseEvent.MOUSE_UP, onSwipe);
			stage.addEventListener("B2PlayerPlatform", onPlayerPlatform);
			stage.addEventListener("B2PlayerHitCeil", onPlayerHitCeil);
		}
		
		public function add_player(px:Number,py:Number, mc:DisplayObject):void {
            var my_body:b2BodyDef= new b2BodyDef();
            my_body.position.Set(px/world_scale, py/world_scale);
            my_body.type = b2Body.b2_dynamicBody;
            //var my_circle:b2PolygonShape = new b2PolygonShape();
			//my_circle.SetAsArray([new b2Vec2(0 / world_scale, -30 / world_scale), new b2Vec2(14 / world_scale, -16 / world_scale), new b2Vec2(15 / world_scale, -7 / world_scale), 
									//new b2Vec2(25 / world_scale, 10 / world_scale), new b2Vec2(17 / world_scale, 23 / world_scale), new b2Vec2(0 / world_scale, 30 / world_scale), 
									//new b2Vec2( -17 / world_scale, 24 / world_scale), new b2Vec2( -25 / world_scale, 9 / world_scale), new b2Vec2( -19 / world_scale, -4 / world_scale), 
									//new b2Vec2( -20 / world_scale, -12 / world_scale), new b2Vec2( -11 / world_scale, -22 / world_scale)], 11);
			var my_circle:b2CircleShape = new b2CircleShape(37/ world_scale);
            var my_fixture:b2FixtureDef = new b2FixtureDef();
            my_fixture.shape = my_circle;
			my_fixture.restitution = 0.5;
			my_fixture.density = 1;
            player=world.CreateBody(my_body);
            player.CreateFixture(my_fixture);
			player.SetLinearDamping(1);
			player.SetAngularDamping(0.1);
			player.SetUserData( { name:"player", mc:mc } );
			//mc.alpha = 0.5;
			mc.x = px;
			mc.y = py;
			addChild(mc);
        }
		// debug draw
        public function debug_draw():void {
            var debug_draw:b2DebugDraw = new b2DebugDraw();
            var debug_sprite:Sprite = new Sprite();
            addChild(debug_sprite);
			debug_draw.SetFillAlpha(1);
			debug_draw.SetAlpha(0);
            debug_draw.SetSprite(debug_sprite);
            debug_draw.SetDrawScale(world_scale);
            debug_draw.SetFlags(b2DebugDraw.e_shapeBit);
            world.SetDebugDraw(debug_draw);
        }
		
		//} endregion
		
		
		//{ UserControl
		private function onDown(e:MouseEvent):void
		{
			if (stackedLevel > 0)
				return;
			touchPoint = new b2Vec2(e.stageX, e.stageY);
			fixTouchInterval = setInterval(onTouch, 50);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onUp(e:MouseEvent):void
		{
			if (pointerArrow.parent)
				pointerArrow.parent.removeChild(pointerArrow);
			clearInterval(fixTouchInterval);
			e.target.removeEventListener(e.type, arguments.callee);
		}
		
		private function onTouch():void
		{
			if (stackedLevel > 0)
				return;
			if (touchPoint.x > 300)
			{
				pointerArrow.x = 453.5;
				pointerArrow.y = 933.9;
				pointerArrow.scaleX = -1;
			}
			else
			{
				pointerArrow.x = 86.5;
				pointerArrow.y = 933.9;
				pointerArrow.scaleX = 1;
			}
			if (!pointerArrow.parent)
				this.addChild(pointerArrow);
			touchPoint = new b2Vec2(stage.mouseX, stage.mouseY);
			var side:int = touchPoint.x > 300?3: -3;
			player.ApplyImpulse(new b2Vec2(side, 0), player.GetPosition());
		}
		
		private function onSwipe(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				touchPoint = new b2Vec2(e.stageX, e.stageY);
				getTouchTime = getTimer();
			}
			else if (e.type == MouseEvent.MOUSE_UP)
			{
				if (getTimer() - getTouchTime > 1000)
					return;
				var endPoint:b2Vec2 = new b2Vec2(e.stageX, e.stageY);
				endPoint.Subtract(touchPoint);
				endPoint.Multiply(1.3);
				if (stackedLevel == 0)
					player.ApplyImpulse(new b2Vec2(endPoint.x / 10, -endPoint.y / 20), player.GetPosition());
				if (Math.abs(endPoint.x) > 10)
				{
					stage.dispatchEvent(new B2PlayerUnStackEvent(endPoint));
				}
			}
		}
		//}
        
		
        //{ Update
        private function B2WorldUpdate(e:Event):void {
			
            world.Step(1/30,10,10);
            //world.ClearForces();
            //world.DrawDebugData();		
			
        }
		
		private function Update(e:Event):void
		{
			//updateTexturePosition
			updatePlayerPosition();
			updateBlockList();
		}
		
		private function updatePlayerPosition():void
		{
			var playerPosition:b2Vec2 = player.GetPosition();
			if (playerPosition.y > 35)
				stage.dispatchEvent(new Event("PlayerDie"));
			
			var mc:DisplayObject = player.GetUserData().mc;
			mc.x = player.GetPosition().x * world_scale;
			mc.y = player.GetPosition().y * world_scale;
			mc.rotation = player.GetAngle() * 180 / Math.PI;
			if(playerHP < maxPlayHP)
				playerHP++;
		}
		
		private function updateBlockList():void
		{
			for each(var block:b2Body in BlockList)
			{
				var mc:BaseBlock = block.GetUserData().mc;
				mc.x = block.GetPosition().x * world_scale;
				mc.y = block.GetPosition().y * world_scale;
				
				block.SetLinearVelocity(new b2Vec2(0,blockUpSpeed));
				if (mc.playerAction == BaseBlock.ACTION_SLIDE)
				{
					var v:b2Vec2 = block.GetLinearVelocity();
					v.Add(new b2Vec2(mc.sided?3: -3, 0));
					if (mc.x < 0 )
						mc.sided = true;
					else if (mc.x > 600 - mc.width)
						mc.sided = false;
				}
				
				if (mc.y < -200)
				{
					if(stage)
						stage.dispatchEvent(new B2DestroyEvent(block));
				}
				//mc.rotation = block.GetAngle() * 180 / Math.PI;
			}
		}
		
		private function DestroyBlockList(e:Event):void
		{
			if (DestroyList.length > 0)
			{
				var body:* = DestroyList.shift();
				if (body is b2Body)
				{
					world.DestroyBody(body);
				}
				else if (body is b2Joint)
				{
					world.DestroyJoint(body);
				}
			}
		}
		//}
		
		
		//{ EventListenerTigger
		private function PlayerStack(e:B2PlayerStackEvent):void
		{
			stackedLevel = e.stackLevel;
			var jointDef:b2WeldJointDef = new b2WeldJointDef();
			jointDef.Initialize(player, e.stackObject, e.stackPoint);
			jointDef.collideConnected = true;
			stackJoint = world.CreateJoint(jointDef) as b2WeldJoint;
			stage.addEventListener("B2PlayerUnStack", PlayerUnStack);
			stage.addEventListener("B2PlayerUnStacked", PlyerUnStacked);
		}
		
		private function PlayerUnStack(e:B2PlayerUnStackEvent):void
		{
			if (stackedLevel == 0)
				return;
			stackedLevel--;
			if (stackedLevel == 0)
			{
				stage.dispatchEvent(new B2PlayerUnStackedEvent(e.escapV));
				stage.removeEventListener("B2PlayerUnStack", PlayerUnStack);
			}
		}
		
		private function PlyerUnStacked(e:B2PlayerUnStackedEvent):void
		{
			stackedLevel = 0;
			world.DestroyJoint(stackJoint);
			//DestroyList.push(stackJoint);
			setTimeout(function():void
			{
				player.ApplyImpulse(new b2Vec2(e.escapV.x / 10, -e.escapV.y / 20), player.GetPosition());
			}, 50);
			stage.removeEventListener("B2PlayerUnStacked", PlyerUnStacked);
		}
		
		private function onPlayerPause(e:B2PlayerPauseEvent):void
		{
			var mc:BaseBlock = e.body.GetUserData().mc;
			var myTween:TweenLite = new TweenLite(mc, 0.25, { rotation: mc.flip?-10:10, ease:Back.easeInOut, onComplete:function():void
			{
				myTween.reverse();
				BlockList.splice(BlockList.indexOf(e.body), 1);
				//delete BlockList[e.body.GetUserData().name];
				DestroyList.push(e.body);
				mc.addEventListener(Event.ENTER_FRAME, TweenMcAfterDestroyBody);
			}});
			//TweenLite.to(mc, 0.25, { rotation: rotation, ease:Back.easeInOut,  onComplete:function():void
			//{
				//TweenLite.killTweensOf(mc);
				//delete BlockList[e.body.GetUserData().name];
				//DestroyList.push(e.body);
				//mc.addEventListener(Event.ENTER_FRAME, TweenMcAfterDestroyBody);
			//}} );
		}
		
		private function TweenMcAfterDestroyBody(e:Event):void
		{
			e.target.y += blockUpSpeed;
			e.target.alpha -= 0.01;
			if (e.target.alpha <=0)
			{
				e.target.removeEventListener(e.type, arguments.callee);
				if(e.target.parent)
					e.target.parent.removeChild(e.target);
			}
		}
		
		private function onPlayerPlatform(e:B2PlayerPlatformEvent):void
		{
			var normal:b2Vec2 = e.planeNormal.Copy();
			if (normal.y > -0.5)
				return;
			var v:b2Vec2 = player.GetLinearVelocity();
			v.MulM(new b2Mat22(1,0,0,-1));
			if (v.y > -12)
				v.y = -12;
			v.y *= -normal.y;
		}
		//}
		
		private function onPlayerHitCeil(e:B2PlayerHitCeilEvent):void
		{
			player.GetLinearVelocity().MulM(new b2Mat22(1,0,0,-0.5 ));
			playerHP -= 8;
			if (stackedLevel > 0)
				stage.dispatchEvent(new Event("PlayerDie"));
			if (playerHP <= 0)
					stage.dispatchEvent(new Event("PlayerDie"));
		}
    }
}