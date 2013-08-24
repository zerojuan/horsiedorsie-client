package com.tada.clopclop.social
{
	import com.tada.clopclop.toolsets.textmanipulator.TextManipulator;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class FriendBoxModel extends Sprite
	{
		private var _friendBox:FriendBox;
		public var picLoader:Loader;
		
		public function FriendBoxModel(id:Number)
		{
			
			
			initializeFriendBox(id);
			
		}
		
		private function initializeFriendBox(id:Number):void 
		{
			
			inheritItemBox(id, 185, 38);
			addListeners();
		}
		
	
		
		
		
		public function startHirarchy(id:Number):void 
		{
			var _textManipulator:TextManipulator = new TextManipulator
			_friendBox.hirarchy.text = _textManipulator.processHirarchy(id+1)			 
		}
		
		
		private function addListeners():void 
		{
			_friendBox.friend_pic.addEventListener(MouseEvent.MOUSE_OVER,overFriendBox)
			_friendBox.friend_pic.addEventListener(MouseEvent.MOUSE_OUT,outFriendBox)
		}
		
		//listener functions
		private function overFriendBox(me:MouseEvent):void 
		{
			animateOverFriendBox();
		}
		private function outFriendBox(me:MouseEvent):void 
		{
			animateOutFriendBox();
		}
		
		private function animateOverFriendBox():void 
		{
			_friendBox.gotoAndStop(2);
			_friendBox.hirarchy.y = -8
			_friendBox.friend_pic.y = 16
			
		}
		private function animateOutFriendBox():void 
		{
			_friendBox.gotoAndStop(1);
			_friendBox.hirarchy.y = -3.05
			_friendBox.friend_pic.y = 21.25
		}
		
		private function inheritItemBox(id:Number, pos_x:Number, pos_y:Number):void 
		{
			picLoader = new Loader();			
			_friendBox = new FriendBox;
			_friendBox.name = "friend_box";
			//_friendBox.addChild(picLoader);
			_friendBox.friend_pic.addChild(picLoader);
			addChild(_friendBox);		
			
			x = (id * width) + pos_x
			y = pos_y
		}
		
		
	}
}