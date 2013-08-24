package com.tada.clopclop.jockeyequip.JockeyComponent.MatchPanel
{
	import com.tada.clopclop.horseequip.tool.ComboBoxClop;
	import com.tada.clopclop.ui.components.IComponent;
	import com.tada.clopclop.ui.components.ProgressBarComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class MatchPanel extends Sprite implements IComponent
	{
		private var _bar:ProgressBarComponent;
		
		//skin label
		private var _labelTitle:LabelMatchAHorse;
		private var _labelMatchPartnerEmpty:SkinMatchAPartnerEmpty;
		private var _labelMatchPartnerOccupied:SkinMatchAPartnerOccupied;
		private var _labelPartnership:LabelPartnership;
		
		//skin
		private var _matchPartnerBG:SkinMatchAPartnerBackground;
		private var _heartIcon:IconJockeyEquipPartnershipHeart;
		
		public function MatchPanel()
		{
			initialization();
			setSkinBG();
			setProperties();	
			setPartnershipEmpty();
			
			addListeners();				
		}
		private function initialization():void{
			_bar = new ProgressBarComponent(new GaugePartnership, new BarJockeyEquipPartnershipYellow, new MaskJockeyEquipPartnership, new BarJockeyEquipPartnershipOrange);
		
			//skin label
			_labelTitle = new LabelMatchAHorse;
			_labelMatchPartnerEmpty = new SkinMatchAPartnerEmpty;
			_labelMatchPartnerOccupied= new SkinMatchAPartnerOccupied;
			_labelPartnership= new LabelPartnership;
			
			//skin
			_matchPartnerBG = new SkinMatchAPartnerBackground;
			_heartIcon = new IconJockeyEquipPartnershipHeart;
		
		}
		private function setSkinBG():void{			
			addChild(_labelTitle);
			addChild(_matchPartnerBG);			
			addChild(_labelPartnership);
			addChild(_bar);
			addChild(_heartIcon);
		}
		private function setProperties():void{				
			
			_labelTitle.x = (_matchPartnerBG.width / 2) - (_labelTitle.width/2);
				
			_matchPartnerBG.y = _labelTitle.height;
			
			_labelPartnership.x = (_matchPartnerBG.width / 2) - (_labelTitle.width/2);
			_labelPartnership.y = _labelTitle.height + _matchPartnerBG.height;
			
			_bar.x = _matchPartnerBG.width - (_bar.width/2);
			_bar.y = _labelTitle.height + _matchPartnerBG.height + _labelPartnership.height;			
			
			_heartIcon.y = _labelTitle.height + _matchPartnerBG.height + _labelPartnership.height;
			
			_labelMatchPartnerEmpty.x = (_matchPartnerBG.width / 2) - (_labelMatchPartnerEmpty.width/2);
			_labelMatchPartnerEmpty.y =  (_matchPartnerBG.height / 2) - (_labelMatchPartnerEmpty.height/2);
			
			_labelMatchPartnerOccupied.x = (_matchPartnerBG.width / 2) - (_labelMatchPartnerOccupied.width/2);
			_labelMatchPartnerOccupied.y = (_matchPartnerBG.height / 2) - (_labelMatchPartnerOccupied.height/2);
		}
		
		public function setPartnershipEmpty():void{
			if(_labelMatchPartnerOccupied.parent !=null){
				_matchPartnerBG.removeChild(_labelMatchPartnerOccupied);
			}	
			_matchPartnerBG.addChild(_labelMatchPartnerEmpty);
		}
		
		public function setPartnerShipOccupied():void{
			if(_labelMatchPartnerOccupied.parent !=null){
				_matchPartnerBG.removeChild(_labelMatchPartnerEmpty);
			}	
			_matchPartnerBG.addChild(_labelMatchPartnerOccupied);
		}
		
		public function setBarValue(currentVal:Number, secondVal:Number):void{
			_bar.setCurrentValue(currentVal);
			_bar.setSecondValue(secondVal);
		}
		
		public function addListeners():void
		{
		}
		
		public function removeListeners():void
		{
		}
		
		public function setPosition(X:Number, Y:Number):void
		{
			this.x = X;
			this.y = Y;
		}
		
		public function getPosition():Point
		{
			return new Point(x,y);
		}
		
		public function get displayObject():DisplayObject
		{
			return this;
		}
	}
}