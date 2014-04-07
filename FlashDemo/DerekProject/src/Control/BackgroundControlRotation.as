package Control 
{
	import Enum.AssetList;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author hello
	 */
	public class BackgroundControlRotation extends BaseComponentControl
	{
		private var bgList:Array = []
		private var speed:Number;
		
		public function BackgroundControlRotation(backgroundPoint:Object, img:Bitmap, speed:Number) 
		{
			super(backgroundPoint);
			this.speed = speed;
			
			for (var i:int = 0; i < 4; i++)
			{
				var newImage:Bitmap = new Bitmap(img.bitmapData.clone());
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
				bgList[i].y = 1000 * 1.58;
				bgList[i].x = 300;
				bgList[i].rotation = -90 + 45 * i;
				ui.addChild(bgList[i]);
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
				if (img.rotation < -90)
				{
					img.rotation = 90;
				}
			}
		}
	}
}