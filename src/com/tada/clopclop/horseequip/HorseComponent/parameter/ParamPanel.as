package com.tada.clopclop.horseequip.HorseComponent.parameter
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.tada.clopclop.ui.components.IComponent;
	import com.tada.clopclop.ui.components.ProgressBarComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ParamPanel extends Sprite implements IComponent		
	{
		//constant
		public static const SPEED:int = 0;
		public static const STAMINA:int = 1;
		public static const STRENGHT:int = 2;
		public static const BALANCE:int = 3;
		public static const LUCK:int = 4;
		
		
		private  var txtLevel:TextField = new TextField;
		
		private var _labelSpeed:LabelSpeedBig;
		private var _labelStamina:LabelStaminaBig;
		private var _labelStrenght:LabelStrength;
		private var _labelBalance:LabelBalanceBig;
		private var _labelLuck:LabelLuckBig;
		
		public var _levelBar:ProgressBarComponent;
		public var _stat:Vector.<ProgressBarComponent> = new Vector.<ProgressBarComponent>;		
		
		public function ParamPanel()
		{
			intialization();
			setSkinBG();
			setProperties();							
			addListeners();				
			//_stat[0].setCurrentValue(50);
			//_stat[0].setSecondValue(30);			
		}
		
		private function intialization():void{
			
			_labelSpeed = new LabelSpeedBig;
			_labelStamina = new LabelStaminaBig;
			_labelStrenght = new LabelStrength;
			_labelBalance = new LabelBalanceBig;
			_labelLuck = new LabelLuckBig;
		
			_levelBar = new ProgressBarComponent(new GaugeBlueBig, new BarBlueBig, new MaskBlueBig, new BarBlueBig);			
			
			for(var num:int=0;num<5;num++){		
				_stat[num]= new ProgressBarComponent(new GaugeMultiBigShort, new BarYellowBig, new MaskMultiBigShort, new BarOrangeBig);
			}		
		}
		public function setLevel(currentVal:Number):void{
			_levelBar.setCurrentValue(currentVal);
		}
		
		public function setSpeed(currentVal:Number, secondVal:Number):void{
			_stat[SPEED].setCurrentValue(currentVal);
			_stat[SPEED].setSecondValue(secondVal);		
		}
		public function setStamina(currentVal:Number, secondVal:Number):void{
			_stat[STAMINA].setCurrentValue(currentVal);
			_stat[STAMINA].setSecondValue(secondVal);	
		}
		public function setStrenght(currentVal:Number, secondVal:Number):void{
			_stat[STRENGHT].setCurrentValue(currentVal);
			_stat[STRENGHT].setSecondValue(secondVal);	
		}
		public function setBalance(currentVal:Number, secondVal:Number):void{
			_stat[BALANCE].setCurrentValue(currentVal);
			_stat[BALANCE].setSecondValue(secondVal);		
		}
		public function setLuck(currentVal:Number, secondVal:Number):void{
			_stat[LUCK].setCurrentValue(currentVal);
			_stat[LUCK].setSecondValue(secondVal);	
		}		
		
		private function setSkinBG():void{
			//set initial coordinate for level
			var _levelPosX:int = 0;
			var _levelPosY:int =30;
				
			//set initial coordinate for status bars
			var _barPosX:int = (_levelBar.width / 2) - (_stat[0].width / 2);
			var _barPosY:int =  50;			
			
			
			setSkinLevel(_levelPosX,_levelPosY);
			setSkinStat(_barPosX,_barPosY);
			setStatTitle();
		}
		
		public function setStatTitle():void{			
			
			_labelSpeed.y = _stat[0].y;
			_labelStamina.y = _stat[1].y;		
			_labelStrenght.y =_stat[2].y;
			_labelBalance.y = _stat[3].y;
			_labelLuck.y = _stat[4].y;
				
			addChild(_labelSpeed);
			addChild(_labelStamina);
			addChild(_labelStrenght);
			addChild(_labelBalance);
			addChild(_labelLuck);
		}
		
		public function setSkinLevel(_posX:int, _posY:int):void{				
			//set level gauge skin
			addChild(_levelBar);
			_levelBar.x = _posX;
			_levelBar.y = _posY;
			
			//set txt format
			txtLevel.text = "test";
			addChild(txtLevel);						
		}
		
		public function setSkinStat(_posX:int, _posY:int):void{					
			for(var num:int = 0; num < 5; num++){				
				_stat[num].x = _posX;
				_stat[num].y = _posY += 30;
				
				addChild(_stat[num]);		
			}		
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
		
		public function setPosition(x:Number, y:Number):void
		{			
			//this.x = 350;
			//this.y = 50; 
			
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