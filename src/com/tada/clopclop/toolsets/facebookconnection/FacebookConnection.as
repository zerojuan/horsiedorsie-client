package com.tada.clopclop.toolsets.facebookconnection
{
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	import com.facebook.graph.utils.FacebookDataUtils;
	import com.tada.clopclop.events.SocialEvent;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;

	public class FacebookConnection
	{
		private static var _instance:FacebookConnection;
		private static var allowInstantiation:Boolean;
		
		private var uname:String;
		private var token:String;
		private var app_user:String;
		private var app_user_total:uint;
		private var _uid:String;
		
		public var FRIEND_NAMES:Array = []
		public var CALLER:Object
		
		
		public static function get instance():FacebookConnection{
			if(!_instance){
				allowInstantiation = true;
				_instance = new FacebookConnection();
				allowInstantiation = false;
			}
			return _instance;
		} 
		
		public function FacebookConnection(){
			if(!allowInstantiation){
				throw new Error("Trying to instantiate a singleton FacebookConnection");
			}
		}
		
		public function init(uid:String, uname:String, token:String):void{
			this.uname = uname;
			this.token = token;
			
			if(uid != "undefined"){
				Logger.info(this, "init", "Facebook Session initialized");
				app_user = ExternalInterface.call("appUser", "");
				app_user_total = app_user.split(",").length;
				
				//app_user = JSON.decode(ExternalInterface.call("appUser", ""));
				
			}else{
				uid = "752846809";
				Logger.info(this, "init", "Non-Facebook Session");
				app_user = "752846809,752846809,752846809,752846809,752846809";
				app_user_total = app_user.split(",").length;
			}
			this._uid = uid;
		}
		
		public function get uid():String{						
			return _uid;
		}
		
		public function getFriendPics():Array 
		{
			Logger.print(this, "Loading FriendPics of " + uid); 
			var friend_pics_array:Array = []
			
			if(uid != "undefined") {
				for (var i:Number=0; i<app_user_total; i++) 
				{					
					var uid:String = app_user.split(",")[i];					
					var get_source:String = Facebook.getImageUrl(uid, "square");
					Logger.print(this, "URL: " + get_source);
					friend_pics_array.push(get_source);					
				}
			}
			
			return friend_pics_array;
		}
		
		public function updateFriendNames():void 
		{
			if(uid != "undefined") {
				
				for (var i:Number=0; i<app_user_total; i++) 
				{
					setTimeout(getUserNameByInterval,(15*i),i);
					
				}
				setTimeout(facebookComplete,16*i)
			}
		}
		
		private function facebookComplete():void{
			TEngine.mainClass.dispatchEvent(new SocialEvent(SocialEvent.FACEBOOK_COMPLETE));
		}
		
		private function getUserNameByInterval(id:Number):void 
		{
			var get_userid:String = app_user.split(",")[id].toString()
			Facebook.api("/"+get_userid,getUserNameHandler)
		}
		
		private function getUserNames(myUserId:String):void 
		{
						
		}
		
		private function getUserNameHandler(result:Object,fail:Object):void
		{
			if(result)
			{
				CALLER.FRIEND_NAMES.push(result.first_name)								
			}
		}
		
		
	}
}