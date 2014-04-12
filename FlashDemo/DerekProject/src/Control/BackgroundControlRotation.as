package Control 
{
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.geom.Point;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class BackgroundControlRotation extends BaseComponentControl
	{
		private var bgList:Array = []
		private var speed:Number;
		
		public function BackgroundControlRotation(backgroundPoint:Sprite, speed:Number) 
		{
			super(backgroundPoint);
			this.speed = speed;
			
			for (var i:int = 0; i < 4; i++)
			{
				var newImage:Image = new Image(BTool.GetImage("BattlePage_bg2", "bg2"));
				var newSprite:Sprite = new Sprite();
				newImage.x = -newImage.width / 2;
				newImage.y = -newImage.height * 1.5;
				newSprite.addChild(newImage);
				newSprite.alpha = .8;
				bgList.push(newSprite);
			}
		}
		
		public function start():void
		{
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				bgList[i].y = 1000 * 1.75;
				bgList[i].x = 300;
				bgList[i].rotation = (-90 + (180/4) * i) * Math.PI / 180;
				(ui as DisplayObjectContainer).addChild(bgList[i]);
			}
			ui.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			ui.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
			ui.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				if(bgList[i].parent)
					bgList[i].parent.removeChild(bgList[i]);
			}
			ui.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			for each(var img:DisplayObject in bgList)
			{
				img.rotation -= speed;
				if (img.rotation < -1.57)
				{
					img.rotation = 1.57;
				}
			}
		}
	}
}