package com.tada.clopclop.horseequip.tool
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;	

	public class ComboBoxClop extends Sprite implements IComponent
	{				
		private var _wideBox:Boolean = false;
		
		private var txtArray:Array = [];
		private var ctr:int = 0;
		
		private var _btnScroll:Sprite;
		private var _comboBox:Sprite;
		
		//set skin button arrow
		private var _btnUp:DisplayObject;
		private var _btnDown:DisplayObject;
		
		//set button oval
		private var _btnSUp:DisplayObject;
		private var _btnSMid:DisplayObject;
		private var _btnSDown:DisplayObject;
	
		//set box skin
		private var _comboTop:DisplayObject;
		private var _comboMid:DisplayObject;
		private var _comboBottom:DisplayObject;		
		
		private var _comboHighlight:DisplayObject;
		
		//combo location
		private var comboLocX:int = 0;
		private var comboLocY:int = -10;		
		
		//setting height for Textboxes, scroll button and combo box skin		
		private var scrollHeight:int = 80;
		private var comboHeight:int =20;
		private var txtFieldHeight:int = 20;
		private var comboHighlightY:int;
		
		//skin
		private var SkinBoxTop:SkinComboBoxJockeyTop = new SkinComboBoxJockeyTop;
		private var SkinBoxMid:SkinComboBoxJockeMid = new SkinComboBoxJockeMid;
		private var SkinBoxBottom:SkinComboBoxJockeyBottom = new SkinComboBoxJockeyBottom;
		
		private var BtnScrollTop:BtnNameScrollTop = new BtnNameScrollTop;
		private var BtnScrollMid:BtnNameScrollMid = new BtnNameScrollMid;
		
		private var SkinBoxHighlight:SkinComboBoxJockeyHighlight = new SkinComboBoxJockeyHighlight;
		private var BtnArrowUp:BtnNameArrowUp = new BtnNameArrowUp;
		
		private var txtNum:int = 1;
	
		public function ComboBoxClop(SkinBoxTop:DisplayObject,SkinBoxMid:DisplayObject,SkinBoxBottom:DisplayObject, SkinBoxHighlight:DisplayObject, BtnArrow:DisplayObject)
		{					
			initialization(SkinBoxTop,SkinBoxMid,SkinBoxBottom,SkinBoxHighlight,BtnArrow);			
			setProperties();
			setSkinBG();				
			defaultBox();		
			addListeners();				
		}		
		
		private function initialization(SkinBoxTop:DisplayObject,SkinBoxMid:DisplayObject,SkinBoxBottom:DisplayObject, SkinBoxHighlight:DisplayObject, BtnArrow:DisplayObject):void{
			//container
			_comboBox = new Sprite;	
			_btnScroll = new Sprite;
			
			//set box skin
			_comboTop = SkinBoxTop;
			_comboMid = SkinBoxMid;
			_comboBottom = SkinBoxBottom;
			
			_comboHighlight = SkinBoxHighlight;		
			
			//set arrow up and down
			_btnUp	= BtnArrowUp;
			_btnDown = BtnArrowUp;	
			
			//set scroll button
			_btnSUp = BtnScrollTop;
			_btnSMid = BtnScrollMid;
			_btnSDown = BtnScrollTop;
		}
		
		private function setProperties():void{		
			//set highlight position
			comboHighlightY = comboHeight /2;
					
			//set scroll button
			_btnSMid.y = _btnSUp.height;
			_btnSMid.height = scrollHeight;
			
			_btnSDown.rotationZ = 180;
			_btnSDown.y = 6 + _btnSUp.height + _btnSMid.height;
			_btnSDown.x = 17;
			
			//arrow button
			_btnDown.x = _comboMid.width - _btnDown.width / 4;
			_btnDown.rotationZ = 180;
			_btnDown.y =	(comboHeight /2) + _btnDown.height;
				//_comboMid.y + _btnDown.height + 5;			
			
			//set combo box skin
			openBox();			
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
		
		private function onMouseClick(e:MouseEvent):void{			
			openBox();			
		}		
		//update combobox skin
		private function updateCombo():void{				
			//set combobox size
			_comboMid.height = comboHeight;
			_comboMid.y = _comboTop.height /2 ;
			_comboBottom.y = (_comboTop.height / 2  ) + _comboMid.height;
			
			_comboHighlight.x =(_comboTop.width / 2)  - (_comboHighlight.width / 2);	
			_comboHighlight.y = comboHighlightY;			
		}
		
		private function openBox():void{		
			if(_wideBox){
				removeItem();
				displayItem();
				comboHeight = txtFieldHeight * txtNum;	
				_wideBox = false;
				
			}
			else{
				defaultBox();
				removeItem();
				comboHeight = txtFieldHeight * 1;	
				_wideBox = true;
			}
			updateCombo();
		}
		
		private function defaultBox():void{
			scrollHeight = 	80;
			txtFieldHeight 	= 	20;	
			comboHeight	=	txtFieldHeight;			
			updateCombo();
		}
		
		private function arrangeItem():void{
			for(var num:int = 0; num<txtArray.length; num++){
				txtArray[num].x = (_comboTop.width /2) - (txtArray[num].width / 2);
				txtArray[num].y = (txtFieldHeight * (num + 1)) - 10;
			}
		}
		
		// adds item to array
		public function addItem(item:String):void{
			var txtField:TextField = new TextField;	
					
			txtField.height = txtFieldHeight;			
			txtField.text = item;	
			txtField.maxChars = 0;	
				
			txtArray.push(txtField);
			arrangeItem();
			
		}		
		
		//removes item from array		
		public function deleteItem(item:int):void{
			txtArray.splice(item, 1);				
			arrangeItem();
		}
		
		private function displayItem():void{
			//var i:TextField = new TextField;	
			var _font:String = "Arial Bold";
			var _color:int = 0x666666;
			var _size:int = 14;
			
			var tf:TextFormat = new TextFormat(_font, _size, _color);
			tf.bold;
			
			for(var num:int = 0; num<txtArray.length; num++){
				txtArray[num].setTextFormat(tf);
				txtNum = txtArray.length;	
				
				if(txtArray[num] != null){
					addChild(txtArray[num]);				
				txtArray[num].addEventListener(MouseEvent.CLICK, onTextClick);
				txtArray[num].addEventListener(MouseEvent.MOUSE_OVER, onTextOver);
				txtArray[num].addEventListener(MouseEvent.MOUSE_OUT, onTextOut);
				}
				
				
			}				
							
		}
		
		private function removeItem():void{
			for(var num:int = 0; num<txtArray.length; num++){
				if(txtArray[num].parent != null){
					removeChild(txtArray[num]);
					txtArray[num].removeEventListener(MouseEvent.CLICK, onTextClick);
					txtArray[num].removeEventListener(MouseEvent.MOUSE_OVER, onTextOver);
					txtArray[num].addEventListener(MouseEvent.MOUSE_OUT, onTextOut);									
				}
			}	
		}		
		
		private function onTextOver(e:MouseEvent):void{
			var gf:flash.filters.GlowFilter = new flash.filters.GlowFilter(0xFF0000FF, 100, 1, 3, 5, 3, false, false);		
						
			//var gfMain:GlowFilter = new GlowFilter(
			for(var num:int = 0; num < txtArray.length; num++){
				if(e.target == txtArray[num]){
					txtArray[num].filters = [gf];					
				}
			}		
		}
		private function onTextOut(e:MouseEvent):void{			
			for(var num:int = 0; num < txtArray.length; num++){
				if(e.target == txtArray[num]){
					txtArray[num].filters = [];	
				}
			}
			
		}	
		private function onTextClick(e:MouseEvent):void{
			trace("item: " + e.target.text);
			
			_wideBox = false;
			openBox();		
			//defaultBox();
			for(var num:int = 0; num < txtArray.length; num++){
				if(e.target == txtArray[num]){
					
					trace("Test remove index: " + num);
					deleteItem(num);
				}
			}
		}		
	
		// implements IComponent
		public function addListeners():void{
			_btnDown.addEventListener(MouseEvent.CLICK, onMouseClick);		
			
			//test
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);	
		}
		//test
		private function onKeyDown(e:KeyboardEvent):void{			
			switch(e.keyCode){
				case Keyboard.SPACE:
					_wideBox = true;
					addItem("Horse item#" + String(int(txtArray.length + 1)));								
					break	
				
			}
			openBox();				
		}
		
		public function removeListeners():void{
			
		}
		
		public function setPosition(x:Number, y:Number):void{
			this.x = x;
			this.y = y;
		}		
		
		public function getPosition():Point{
			return new Point(x,y);
		}
		
		public function get displayObject():DisplayObject{
			
			return this;
		}
	}
}