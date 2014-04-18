package Component 
{
	import Manager.SoundManager;
	import Manager.XMLManager;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author JL
	 */
	public class SoundSwitcher extends BaseComponent
	{
		private var btnon:Button;
		private var btnoff:Button;
		public function SoundSwitcher(onState:Texture, offState:Texture) 
		{
			btnon = new Button(onState, "", onState);
			btnoff = new Button(offState, "", offState);
			super(btnon);
			btnon.touchable = true;
			this.addChild(btnoff);
			btnon.name = "btn_on";
			btnoff.name = "btn_off";
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			btnon.visible = SoundManager.SoundActive;
			btnoff.visible = !btnon.visible;
		}
		
		protected override function offStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this); 
			if (!touch)
				return;
			if (touch.phase != TouchPhase.ENDED)
				return;
			try{
				if (!((e.target as DisplayObject).parent.parent is Button))
					return;
			}catch(e:Error){return}
			var Target:String = ((e.target as DisplayObject).parent.parent as Button).name;
			switch(Target)
			{
				case "btn_off":
					SoundManager.SoundActive = true;
					SoundManager.ResumeBGM();
					XMLManager.config["music"] = "on";
					btnoff.visible = false;
					btnon.visible = true;
					break;
				case "btn_on":
					SoundManager.SoundActive = false;
					SoundManager.PauseBGM();
					XMLManager.config["music"] = "off";
					btnoff.visible = true;
					btnon.visible = false;
					break;
			}
		}
	}
}