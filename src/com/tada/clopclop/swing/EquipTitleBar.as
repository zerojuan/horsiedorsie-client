package com.tada.clopclop.swing
{
	import org.aswing.AbstractButton;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.FrameTitleBar;
	import org.aswing.FrameTitleBarLayout;
	import org.aswing.Icon;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JWindow;
	import org.aswing.SoftBoxLayout;
	
	public class EquipTitleBar extends Container implements FrameTitleBar
	{
		protected var closeButton:AbstractButton;
		
		protected var buttonPane:Container;
		protected var buttonPaneLatout:SoftBoxLayout;
		
		protected var owner:JWindow;
		protected var frame:JFrame;
		
		public function EquipTitleBar()
		{
			super();
			titleEnabled = true;
			
			setLayout(new FrameTitleBarLayout());
			
			buttonPane = new Container();
			buttonPane.setCachePreferSizes(false);
			buttonPaneLayout = new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0);
			
		}
		
		public function getSelf():Component
		{
			return null;
		}
		
		public function setFrame(frame:JWindow):void
		{
			
		}
		
		public function getFrame():JWindow
		{
			return null;
		}
		
		public function addExtraControl(c:Component, position:int):void
		{
		}
		
		public function removeExtraControl(c:Component):Component
		{
			return null;
		}
		
		public function setTitleEnabled(b:Boolean):void
		{
		}
		
		public function isTitleEnabled():Boolean
		{
			return false;
		}
		
		public function isActive():Boolean
		{
			return false;
		}
		
		public function setButtonIconGap(gap:int):void
		{
		}
		
		public function setMinimizeHeight(h:int):void
		{
		}
		
		public function getMinimizeHeight():int
		{
			return 0;
		}
		
		public function setIcon(i:Icon):void
		{
		}
		
		public function getIcon():Icon
		{
			return null;
		}
		
		public function setText(t:String):void
		{
		}
		
		public function getText():String
		{
			return null;
		}
		
		public function getLabel():JLabel
		{
			return null;
		}
		
		public function setIconifiedButton(b:AbstractButton):void
		{
		}
		
		public function setMaximizeButton(b:AbstractButton):void
		{
		}
		
		public function setRestoreButton(b:AbstractButton):void
		{
		}
		
		public function setCloseButton(b:AbstractButton):void
		{
		}
		
		public function getIconifiedButton():AbstractButton
		{
			return null;
		}
		
		public function getMaximizeButton():AbstractButton
		{
			return null;
		}
		
		public function getRestoreButton():AbstractButton
		{
			return null;
		}
		
		public function getCloseButton():AbstractButton
		{
			return null;
		}
	}
}