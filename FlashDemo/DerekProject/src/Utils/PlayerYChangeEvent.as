package Utils 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author hello
	 */
	public class PlayerYChangeEvent extends Event
	{
		public var TweenSpeedRatio:Number;
		public function PlayerYChangeEvent(_TweenSpeedRatio:Number) 
		{
			super("PlayerYChange");
			TweenSpeedRatio = _TweenSpeedRatio;
		}
		
	}

}