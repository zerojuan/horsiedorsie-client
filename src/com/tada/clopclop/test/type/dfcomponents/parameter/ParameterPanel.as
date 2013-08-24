package com.tada.clopclop.test.type.dfcomponents.parameter
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ParameterPanel extends Sprite implements IComponent
	{
		private  var txtLevel:TextField = new TextField;
		
		private var _labelSpeed:LabelSpeedBig;
		private var _labelStamina:LabelStaminaBig;
		private var _labelStrenght:LabelStrength;
		private var _labelBalance:LabelBalanceBig;
		private var _labelLuck:LabelLuckBig;
		
		private var _levelGauge:GaugeBlueBig;
		private var _levelMask:MaskBlueBig;
		private var _levelBar:BarBlueBig;
		
		private var _barGauge:Array = [];
		private var _barMask:Array = [];
		private var _barOrange:Array = [];
		private var _barYellow:Array = [];
		private var _barMask2:Array = [];
		
		private var val:Array = [];
		private var Stat:Array = [];	
		
		public function ParameterPanel()
		{
			intialization();
			setSkinBG();
			setProperties();							
			addListeners();
			
		}
		
		private function intialization():void{
			_labelSpeed = new LabelSpeedBig;
			_labelStamina = new LabelStaminaBig;
			_labelStrenght = new LabelStrength;
			_labelBalance = new LabelBalanceBig;
			_labelLuck = new LabelLuckBig;
			
			_levelGauge = new GaugeBlueBig;
			_levelMask = new MaskBlueBig;
			_levelBar = new BarBlueBig;
			
			
			for(var num:int=0;num<5;num++){		
				_barGauge[num] = new GaugeMultiBigShort;				
				_barOrange[num] = new BarOrangeBig;
				_barYellow[num] = new BarYellowBig;
				
				_barMask[num] = new MaskMultiBigShort;
				_barMask2[num] = new MaskMultiBigShort;
			}
		}
		
		private function setSkinBG():void{
			//set initial coordinate for level
			var _levelPosX:int = 0 - _levelBar.width;
			var _levelPosY:int =30;
				
			//set initial coordinate for status bars
			var _barPosX:int = _levelGauge.width - _barGauge[0].width;;
			var _barPosY:int =  50;
			
			setSkinLevel(_levelPosX,_levelPosY);
			setSkinStat(_barPosX,_barPosY);
			setStatTitle();
		}
		
		public function setStatTitle():void{			
			
			_labelSpeed.y = _barGauge[0].y;
			_labelStamina.y = _barGauge[1].y;		
			_labelStrenght.y =_barGauge[2].y;
			_labelBalance.y = _barGauge[3].y;
			_labelLuck.y = _barGauge[4].y;
				
			addChild(_labelSpeed);
			addChild(_labelStamina);
			addChild(_labelStrenght);
			addChild(_labelBalance);
			addChild(_labelLuck);
		}
		
		public function setSkinLevel(_posX:int, _posY:int):void{			
			
			//set level gauge skin
			_levelBar.mask = _levelMask;			
			
			addChild(_levelGauge);	
			_levelGauge.addChild(_levelMask);
			_levelGauge.addChild(_levelBar);
			
			_levelBar.x = _posX;
			_levelGauge.y = _posY;
			
			//set txt format			
			
			txtLevel.text = "test";
			addChild(txtLevel);			
			//set value for gaug skin
			setLevelVal(50);			
		}
		
		public function setLevelVal(levelVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - levelVal)/ 100;
			
			_levelMask.y = posY;
			_levelBar.y = posY;
			
			_levelMask.x = posX;	
			
			TweenLite.to(_levelBar, 1, {ease:Back.easeOut, x: posX + (0 - (_levelBar.width * revValue ))});
		}
		
		public function setSkinStat(_posX:int, _posY:int):void{			
			
			for(var num:int = 0; num < 5; num++){
			
				_barOrange[num].mask = _barMask[num];				
				_barYellow[num].mask = _barMask2[num];	
				
				
				addChild(_barGauge[num]);	
				_barGauge[num].addChild(_barMask[num]);
				_barGauge[num].addChild(_barMask2[num]);
				
				_barGauge[num].addChild(_barOrange[num]);
				_barGauge[num].addChild(_barYellow[num]);
				
				_barOrange[num].x = 0 - _barOrange[num].width;
				_barYellow[num].x = 0 - _barYellow[num].width;
				
				_barGauge[num].y = _posY += 30;
				_barGauge[num].x = _posX;
				
				_barMask[num].y =  5
				_barMask2[num].y =  5
				_barYellow[num].y = 5;	
				_barOrange[num].y = 5;	
				
				_barMask[num].x =  5;
				_barMask2[num].x =  5;
			}
			
			//test assign value
			setSpeedVal(30);		
			setStaminaVal(50);
			setStrenghtVal(40)
			setBalanceVal(10);
			setLuckVal(70);
			
			setSpeedVal2(60);		
			setStaminaVal2(70);
			setStrenghtVal2(90)
			setBalanceVal2(80);
			setLuckVal2(85);
			
		}			
		
		public function setSpeedVal(speedVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - speedVal)/ 100;				
			
			TweenLite.to(_barYellow[0], 1, {ease:Back.easeOut, x: posX + (0 - (_barYellow[0].width * revValue ))});
		}
		
		public function setStaminaVal(staminaVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - staminaVal)/ 100;				
			
			TweenLite.to(_barYellow[1], 1, {ease:Back.easeOut, x: posX + (0 - (_barYellow[1].width * revValue ))});
		}
		
		public function setStrenghtVal(strenghtVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - strenghtVal)/ 100;				
			
			TweenLite.to(_barYellow[2], 1, {ease:Back.easeOut, x: posX + (0 - (_barYellow[2].width * revValue ))});
		}
		
		public function setBalanceVal(balanceVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - balanceVal)/ 100;				
			
			TweenLite.to(_barYellow[3], 1, {ease:Back.easeOut, x: posX + (0 - (_barYellow[3].width * revValue ))});
		}
		
		public function setLuckVal(luckVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - luckVal)/ 100;				
			
			TweenLite.to(_barYellow[4], 1, {ease:Back.easeOut, x: posX + (0 - (_barYellow[4].width * revValue ))});
		}
		//set orange bar
		public function setSpeedVal2(speedVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - speedVal)/ 100;				
			
			TweenLite.to(_barOrange[0], 1, {ease:Back.easeOut, x: posX + (0 - (_barOrange[0].width * revValue ))});
		}
		
		public function setStaminaVal2(staminaVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - staminaVal)/ 100;				
			
			TweenLite.to(_barOrange[1], 1, {ease:Back.easeOut, x: posX + (0 - (_barOrange[1].width * revValue ))});
		}
		
		public function setStrenghtVal2(strenghtVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - strenghtVal)/ 100;				
			
			TweenLite.to(_barOrange[2], 1, {ease:Back.easeOut, x: posX + (0 - (_barOrange[2].width * revValue ))});
		}
		
		public function setBalanceVal2(balanceVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - balanceVal)/ 100;				
			
			TweenLite.to(_barOrange[3], 1, {ease:Back.easeOut, x: posX + (0 - (_barOrange[3].width * revValue ))});
		}
		
		public function setLuckVal2(luckVal:Number):void{
			var posX:int = 5;
			var posY:int = _levelGauge.x + 5;	
			
			var revValue:Number = (100 - luckVal)/ 100;				
			
			TweenLite.to(_barOrange[4], 1, {ease:Back.easeOut, x: posX + (0 - (_barOrange[4].width * revValue ))});
		}
		
		//set icomponent implementation
		
		private function setProperties():void{
			
		}
		
		public function addListeners():void
		{
		}
		
		public function removeListeners():void
		{
		}
		
		public function setPosition(X:Number, Y:Number):void
		{			
			this.x = 350;
			this.y = 50; 
			
			this.x = x;
			this.y = y;
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