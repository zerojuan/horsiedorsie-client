package com.tada.clopclop.social
{
	import com.tada.clopclop.events.SocialEvent;
	import com.tada.clopclop.toolsets.facebookconnection.FacebookConnection;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	

	public class SocialController extends Sprite
	{
		//base decalrtion
		private var _view:Sprite;
		private var _socialView:SocialView
		
		public var FRIEND_PICS:Array = []
		public var FRIEND_NAMES:Array = []
		public var CURRENT_SELECTED:String
		public var CURRENT_NAVIGATION:Number = 0
		public var CLICK_COUNTER:Number = 0
		
		public function SocialController(view:Sprite)
		{
			_view = view
			this.name = "_socialController"
			_view.addChild(this)
		}
		
		public function startSocialController():void{	
			
			_socialView = new SocialView();
			_socialView.name = "_socialView";
			_view.addChild(_socialView);			
			_socialView.initSocialView();
			
			connectToFacebook();
			
			
		}
		
		private function connectToFacebook ():void 
		{
				
			
			var _clopclopMainController:Object = parent.getChildByName("_clopclopMainController")
				
			/* updates facebook data/informations */
			FRIEND_PICS = FacebookConnection.instance.getFriendPics();
			
			//_clopclopMainController.UID = _facebookConnection.UID
			FacebookConnection.instance.updateFriendNames();
			//TODO: This is horrible!!!!
			FacebookConnection.instance.CALLER = this;
			TEngine.mainClass.addEventListener(SocialEvent.FACEBOOK_COMPLETE, facebookConnectionComplete);
			
		}
		
		
		
		public function testValue(value:String):void 
		{
			
			_socialView.testValue(value);
			
			
		}
		
		public function facebookConnectionComplete (evt:Event = null):void 
		{
			Logger.print(this, "FacebookConnection Complete");
			_socialView.updateFriendBoxModels(CURRENT_NAVIGATION)
			_socialView.enableNavigation();
		}
		
		public function visibility(value:Boolean):void 
		{
			_socialView.visibility(value);
		}
		
		public function navigateLeft():void 
		{
				
			if(CURRENT_NAVIGATION > 0) 
			{
				CLICK_COUNTER -= 1
				CURRENT_NAVIGATION = processNavigation("left",CLICK_COUNTER)
				_socialView.clearFriendBoxModels();
				_socialView.startFriendBoxModels();
				_socialView.updateFriendBoxModels(CURRENT_NAVIGATION)
			}
		}
		public function navigateRight():void 
		{
			
			
			if(CURRENT_NAVIGATION < (FRIEND_NAMES.length-6) ) 
			{
				CLICK_COUNTER += 1
				CURRENT_NAVIGATION = processNavigation("right",CLICK_COUNTER);
				_socialView.clearFriendBoxModels();
				_socialView.startFriendBoxModels();
				_socialView.updateFriendBoxModels(CURRENT_NAVIGATION)
			}
		}
		
		private function processNavigation(direction:String, counter:Number):Number 
		{
			var new_number:Number
			var friend_count:Number = FRIEND_NAMES.length
			var exceed:Number
			var diff:Number = exceed - friend_count
			var max_counter:Number = (Math.floor(friend_count / 6))
				
			
			switch (direction) 
			{
				case "right" :
					exceed = (counter + 1) * 6 //12
					
					
					
					testValue(max_counter + "," + counter)
						//getting the last
					
					if(max_counter > counter ) {
						new_number = counter * 6							
					}
					
					if(max_counter == counter) {
						new_number = friend_count - 6
					}
						
					
					break;
				
				case "left" :
					//exceed = (6 * (max_counter+1)) - friend_count
					
					testValue(exceed + "," + counter)
					
					if(counter == 0) {
						new_number = 0
					} 
					
					if(counter > 0) {
						new_number = (friend_count - (6 * counter)) - 6       //(counter * 6) // - exceed
					}
					
					
					
					
					
					
					break;
			}
			
			
			
			return new_number
		}
		
		
		
	}
}