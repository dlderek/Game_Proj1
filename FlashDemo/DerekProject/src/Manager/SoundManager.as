package Manager 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class SoundManager
	{
		private static var soundList:Dictionary = new Dictionary();
		private static var BGM:SoundChannel = new SoundChannel();
		private static var BGEffect:SoundChannel = new SoundChannel();
		private static var Effect:SoundChannel = new SoundChannel();
		
		public static function PlaySound(id:String):void
		{
			if (soundList[id] == null)
			{
				var request:URLRequest = new URLRequest("sound/" + id + ".mp3");
				var newSound:Sound = new Sound();
				newSound.addEventListener(Event.COMPLETE, onSoundLoaded);
				newSound.load(request);
			}
			else
			{
				var sound:Sound = soundList[id] as Sound;
				Effect = sound.play();
			}
		}
		
		public static function PlayBGM(id:String):void
		{
			if (soundList[id] == null)
			{
				var request:URLRequest = new URLRequest("sound/" + id + ".mp3");
				var newSound:Sound = new Sound();
				newSound.addEventListener(Event.COMPLETE, onBGMLoaded);
				newSound.load(request);
			}
			else
			{
				BGM = (soundList[id] as Sound).play(0,99999);
			}
		}
		
		public static function PlayBGEffect(id:String):void
		{
			if (soundList[id] == null)
			{
				var request:URLRequest = new URLRequest("sound/" + id + ".mp3");
				var newSound:Sound = new Sound();
				newSound.addEventListener(Event.COMPLETE, onBGEffectLoaded);
				newSound.load(request);
			}
			else
			{
				BGEffect = (soundList[id] as Sound).play();
			}
		}
		
		private static function onSoundLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			var id:String = (e.target as Sound).url.substr(11).replace(".mp3", "");
			soundList[id] = e.target as Sound;
			PlaySound(id);
		}
		
		private static function onBGMLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			var id:String = (e.target as Sound).url.substr(11).replace(".mp3", "");
			soundList[id] = e.target as Sound;
			PlayBGM(id);
		}
		
		private static function onBGEffectLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			var id:String = (e.target as Sound).url.substr(11).replace(".mp3", "");
			soundList[id] = e.target as Sound;
			PlayBGEffect(id);
		}
	}
}