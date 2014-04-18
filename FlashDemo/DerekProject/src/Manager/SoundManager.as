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
		public static var SoundActive:Boolean;
		
		private static var soundList:Dictionary = new Dictionary();
		private static var BGM:SoundChannel = new SoundChannel();
		private static var BGMsound:Sound;
		private static var BGEffect:SoundChannel = new SoundChannel();
		private static var Effect:SoundChannel = new SoundChannel();
		
		private static var CurrentBGMKey:String = "";
		
		public static function PauseBGM():void
		{
			if(BGM)
				BGM.stop();
		}
		
		public static function ResumeBGM():void
		{
			if (BGM)
			{
				BGM.stop();
				BGM = null;
			}
			if (BGMsound)
				if(SoundActive)
					BGM = BGMsound.play(0, 99999);
		}
		
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
				if(SoundActive)
					Effect = sound.play();
			}
		}
		
		public static function PlayBGM(id:String):void
		{
			if (CurrentBGMKey == id)
				return;
				
			CurrentBGMKey = id;
			if (BGM)
			{
				BGM.stop();
				BGM = null;
			}
			
			if (soundList[id] == null)
			{
				var request:URLRequest = new URLRequest("sound/" + id + ".mp3");
				BGMsound = new Sound();
				BGMsound.addEventListener(Event.COMPLETE, onBGMLoaded);
				BGMsound.load(request);
			}
			else
			{
				BGMsound = soundList[id];
				if(SoundActive)
					BGM = BGMsound.play(0, 99999);
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
				if(SoundActive)
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
			CurrentBGMKey = "";
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