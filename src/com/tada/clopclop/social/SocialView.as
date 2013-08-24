package com.tada.clopclop.social
{
	import com.tada.clopclop.ClopClopMainController;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.toolsets.textmanipulator.TextManipulator;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	

	public class SocialView extends Sprite
	{
		private var _socialUI:SocialUI;
		private var _friendBoxModel:FriendBoxModel;
		
		
		
		public function SocialView()
		{
		}
		
		public function initSocialView ():void
		{
			inheritSocialUI(0,552);
			
			startFriendBoxModels();			
			
			addListeners();
		}
		
		//facebook
		public function startFriendBoxModels():void 
		{
			//getFriendList();
			
			for (var i:Number=0; i<6; i++) 
			{
				inheritFriendBoxModels(i,null);
			}
		}
		
		public function testValue(value:String):void 
		{
			//_socialUI.t_uid.text = value
		}
		
		public function enableNavigation():void 
		{
			_socialUI.socialRight.addEventListener(MouseEvent.CLICK,navigateRight)
			_socialUI.socialLeft.addEventListener(MouseEvent.CLICK,navigateLeft)
		}
		
		public function setMe():void 
		{
			
		}
		
		
		public function updateFriendBoxModels (navigation:Number):void 
		{
			
			var _socialController:Object = _socialUI.parent.parent.getChildByName("_socialController"); 
			
			
			for (var i:Number=0; i<6; i++) 
			{
				var friendBoxModel:FriendBoxModel = _socialUI.getChildByName("friend_box_" + i ) as FriendBoxModel;
					
				if(friendBoxModel != null) {
					var friendBox:Object = friendBoxModel.getChildByName("friend_box")
					
					if(_socialController.FRIEND_NAMES[i+navigation] != null) {
						friendBox.username.text = _socialController.FRIEND_NAMES[i+navigation]													
						Logger.print(this, "Loading pic at: " + _socialController.FRIEND_PICS[i+navigation]);
						Security.loadPolicyFile("https://api.facebook.com/crossdomain.xml");
						var context:LoaderContext = new LoaderContext();
						context.checkPolicyFile = true;
						context.applicationDomain = ApplicationDomain.currentDomain;						
						friendBoxModel.picLoader.load(new URLRequest(_socialController.FRIEND_PICS[i+navigation]), context);
						friendBoxModel.picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoaded);
							
						var _textManipulator:TextManipulator = new TextManipulator
						friendBox.hirarchy.text = _textManipulator.processHirarchy(i+navigation+1)
					} else {						
						var defaultURL:String = "http://b.static.ak.fbcdn.net/rsrc.php/v1/yo/r/UlIqmHJn-SK.gif";
						friendBoxModel.picLoader.load(new URLRequest(defaultURL));
						friendBoxModel.picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoaded);
						//friendBox.gotoAndStop(6);
					}					
				} 
				
			}
			
		}
		
		public function onPicLoaded(evt:Event):void{
			//var image:Bitmap = new Bitmap(evt.target.content.bitmapData);
			//image.width = 50;
			//image.height = 50;
			//evt.target.content.width = 50;
			//evt.target.content.height = 50;			
		}
		
		public function clearFriendBoxModels():void 
		{
			for (var i:Number = 0; i<6; i++) 
			{
				clearFriendBox(i);				
			}
		}
		private function clearFriendBox(id:Number):void{
			
			var _friendBoxModel:DisplayObject = _socialUI.getChildByName("friend_box_" + id)
			_socialUI.removeChild(_friendBoxModel);			
		}
		
		
		private function inheritFriendBoxModels(id:Number,uid:String):void 
		{
			_friendBoxModel = new FriendBoxModel(id);
			_friendBoxModel.name = "friend_box_" + id;
			_socialUI.addChild(_friendBoxModel);	
			
			_friendBoxModel.startHirarchy(id);
			 
		}
		
		
		private function addListeners():void 
		{
			//click listeners			
			_socialUI.redecorate.addEventListener(MouseEvent.CLICK,clickRedecorate);			
			_socialUI.equipHorse.addEventListener(MouseEvent.CLICK,clickHorseEquip);
			_socialUI.equipJockey.addEventListener(MouseEvent.CLICK,clickJockeyEquip);
			
			
		}
		
		//navigate functions
		public function navigateLeft(me:MouseEvent):void 
		{
			var _socialController:Object = parent.getChildByName("_socialController")
			_socialController.navigateLeft();
		}
		public function navigateRight(me:MouseEvent):void 
		{
			var _socialController:Object = parent.getChildByName("_socialController")
			_socialController.navigateRight();
			
		}
		
		//listener functions
		private function clickRedecorate(me:MouseEvent):void{
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.REDECORATE));
				
		}
		private function clickHorseEquip(me:MouseEvent):void {
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.HORSE_EQUIP));
		}
		private function clickJockeyEquip(me:MouseEvent):void{
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.JOCKEY_EQUIP));
		}
		
		private function inheritSocialUI (pos_x:Number,pos_y:Number):void 
		{
			_socialUI = new SocialUI;
			_socialUI.name = "_socialUI";
			addChild(_socialUI);
			
			x = pos_x;
			y = pos_y;
		}
		
		public function visibility(value:Boolean):void 
		{
			visible = value;
		}
		
		
	}
}