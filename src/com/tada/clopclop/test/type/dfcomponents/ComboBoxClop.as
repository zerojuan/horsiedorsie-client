package com.tada.clopclop.test.type.dfcomponents
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.aswing.plaf.basic.background.ComboBoxBackground;

	public class ComboBoxClop extends Sprite
	{
		private var _wide:Boolean = false;
		
		private var txtArray:Array = [];
		private var ctr:int = 0;
		
		//set skin button arrow
		private var _btnUp:BtnNameArrowUp;
		private var _btnDown:BtnNameArrowUp;
		
		//set button oval
		private var _btnSUp:BtnNameScrollTop;
		private var _btnSMid:BtnNameScrollMid;
		private var _btnSDown:BtnNameScrollTop;
		
		private var _btnScroll:Sprite;
		
		//set box skin
		private var _comboTop:SkinComboBoxHorseTop;
		private var _comboMid:SkinComboBoxHorseMid;
		private var _comboBottom:SkinComboBoxHorseBottom;		
		
		private var _comboHighlight:SkinComboBoxHorseHighlight;
		
		private var _comboBox:Sprite;
		
		//combo location
		private var comboLocX:int = 0;
		private var comboLocY:int = 10;		
		
		//setting height for Textboxes, scroll button and combo box skin		
		private var scrollHeight:int = 80;
		private var comboHeight:int =15;
		private var txtFieldHeight:int = 20;
		private var comboHighlightHeigth:int;
		
		private var txtArrayY:int=10;
	
		public function ComboBoxClop()
		{		
			defaultCombo();
			initialization();			
			setProperties();
			setSkinBG();			
			addListener();								
		}		
		
		private function initialization():void{
			//set box skin
			_comboTop = new SkinComboBoxHorseTop;
			_comboMid = new SkinComboBoxHorseMid;
			_comboBottom = new SkinComboBoxHorseBottom;
			
			_comboHighlight = new SkinComboBoxHorseHighlight;
			
			_comboBox = new Sprite;			
			//set arrow up and down
			_btnUp	= new BtnNameArrowUp;
			_btnDown= new BtnNameArrowUp;			
			
			//set scroll button
			_btnSUp = new BtnNameScrollTop;
			_btnSMid = new BtnNameScrollMid;
			_btnSDown = new BtnNameScrollTop;
			
			_btnScroll = new Sprite;			
		}
		
		private function setProperties():void{		
			//set highlight position
			comboHighlightHeigth = _comboHighlight.height / 3;
			
			//set scroll button
			_btnSMid.y = _btnSUp.height;
			_btnSMid.height = scrollHeight;
			
			_btnSDown.rotationZ = 180;
			_btnSDown.y = 6 + _btnSUp.height + _btnSMid.height;
			_btnSDown.x = 17;
			
			//set combo box skin	
			updateCombo();
			
			//arrow button
			_btnDown.x = _comboMid.width - _btnDown.width / 2;
			_btnDown.rotationZ = 180;
			_btnDown.y = _comboBottom.y;			
		}
		
		private function defaultCombo():void{
			scrollHeight = 80;
			comboHeight=15;
			txtFieldHeight = 20;			
		}
		
		private function updateCombo():void{			
			//update skin
			_comboMid.height = comboHeight;
			_comboMid.y = _comboTop.height /2 ;
			_comboBottom.y = (_comboTop.height / 2  ) + _comboMid.height;
			
			_comboHighlight.x =(_comboTop.width / 2)  - (_comboHighlight.width / 2);	
			_comboHighlight.y = comboHighlightHeigth;
		}
		
		private function setSkinBG():void{	
			addChild(_comboBottom);		
			addChild(_comboMid);
			addChild(_comboTop);			
			addChild(_comboHighlight);
			addChild(_btnDown);
			//addChild(_btnUp);
						
			
			//_btnScroll.addChild(_btnSUp);
			//_btnScroll.addChild(_btnSMid);
			//_btnScroll.addChild(_btnSDown);	
			
			//addChild(_btnScroll);
		}
		
		private function addListener():void{
			//txtFieldHeight
			_btnDown.addEventListener(MouseEvent.CLICK, onMouseClick);					
		}
		
		private function onMouseClick(e:MouseEvent):void{
			_wide = true;	
			updateCombo();
			
			for(var num:int = 1; num<txtArray.length; num++){
				addChild(txtArray[num]);				
			}			
			
			TweenLite.to(_comboHighlight, 1, {x: (_comboTop.width / 2)  - (_comboHighlight.width / 2), y:txtArray[1].y, ease:Back.easeOut});			
			update();
		}		
		
		public function addItem(item:String):void{
			var txtField:TextField = new TextField;			
			
			ctr++;			
			
			txtField.height = txtFieldHeight;			
			txtField.text = item;			
			
			//trace(comboLocY);			
			txtArray[ctr] = txtField;
			txtArray[ctr].x = (_comboTop.width /2) - (txtField.width / 2);
			txtArray[ctr].y =  comboLocY+= txtField.height;		
			
		}		
		public function removeItem(item:String):void{
			
		}	
		
		public function update():void{
			if(_wide == true){	
				comboHeight  = 120;						
			}			
			updateCombo();
		}
	}
}