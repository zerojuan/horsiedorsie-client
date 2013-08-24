package com.tada.clopclop.test.type
{
	import com.away3d.containers.View3D;
	import com.away3d.events.MouseEvent3D;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyBottomSet;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Jockey extends Sprite
	{
		private var _view:View3D;
		private var _jockeyTest:JockeyAsset;
		private var _debugTF:TextField;
		private var _nextBttnAnimArray:Array = [];
		private var _previousBttnAnimArray:Array = [];
		private var _textFieldsArray:Array = [];
		private var _xPos:int = 630;
		private var _yPos:int = 80;
		private var _fpsButton:ButtonMC;
		private var _fpsInput:TextField;
		private var _visibilityBttn:ButtonMC;
		private var _textFormat:TextFormat;
		private var _inputArray:Array = [];
		private var _scrollerArray:Array = [];
		private var _iconSkinArray:Array = [];
		private var _iconHairArray:Array = [];
		private var _iconEyebrowArray:Array = [];
		private var _iconMouthArray:Array = [];
		private var _iconEyeArray:Array = [];
		private var _iconShoesArray:Array = [];
		private var _iconTopArray:Array = [];
		private var _iconBottomArray:Array = [];
		private var _iconAccessoryArray:Array = [];
		private var _iconHeadArray:Array = [];
		private var _scrollMoveArrayLeft:Array = [];
		private var _scrollMoveArrayRight:Array = [];
		private var _iconPartsArray:Array = [];
		private var _direction:String = "";
		private var _posButton:ButtonMC;
		private var _canRotate:Boolean = false;
		private var _aIButtons:Array = [];
		private var _meshRotY:Number = 0;
		
		public function Jockey(view:View3D, jockey:JockeyAsset)
		{
			_view = view;
			_jockeyTest = jockey;
		}
		
		public function init ():void{
			setTextFormat();
			initIconControllers();
			initScrolls();
			initTools();
			addTextFields();
			addListeners();
		}
		
		private function addTextFields():void{
			_debugTF = new TextField();
			_debugTF.x = 30;
			_debugTF.y = 30;
			_debugTF.width = 300;
			_debugTF.mouseEnabled = false;
			_debugTF.text = "Testing";
			addChild(_debugTF);
		} 
		
		
		private function setTextFormat():void{
			_textFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.CENTER;
		}
		
		public function reset():void{
			_jockeyTest.resetSettings();
		}
		
		private function addListeners():void{
			_jockeyTest.mesh.addOnMouseDown(onMouse3DDown);
			_jockeyTest.mesh.addOnMouseUp(onMouse3DUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onMouse3DDown (evt:MouseEvent3D):void{
			var geomLen:int = _jockeyTest.mesh.children.length;
			for (var a:int = 0; a<geomLen; a++){
				if (_jockeyTest.mesh.children[a] == evt.object){
					_debugTF.text = "mesh clicked";
					_jockeyTest.changeNextTexture(_jockeyTest.meshLoadedIndex[a]);
				}
			}
		}
		
		private function onMouse3DUp (evt:MouseEvent3D):void{
			_debugTF.text = "mesh unclicked";
		}
		
		private function initIconControllers():void{
			_iconSkinArray[0] = new JBSkin01;
			_iconSkinArray[1] = new JBSkin02;
			_iconSkinArray[2] = new JBSkin03;
			
			_iconHairArray[0] = new JBHair01;
			_iconHairArray[1] = new JBHair02;
			_iconHairArray[2] = new JBHair03;
			
			_iconEyeArray[0] = new JBEye01;
			_iconEyeArray[1] = new JBEye02;
			_iconEyeArray[2] = new JBEye03;
			
			_iconMouthArray[0] = new JBMouth01;
			_iconMouthArray[1] = new JBMouth02;
			_iconMouthArray[2] = new JBMouth03;
			
			_iconEyebrowArray[0] = new JBEyeBrow01;
			_iconEyebrowArray[1] = new JBEyeBrow02;
			_iconEyebrowArray[2] = new JBEyeBrow03;
			
			_iconTopArray[0] = new JETop01;
			_iconTopArray[1] = new JETop02;
			_iconTopArray[2] = new JETop03;
			
			_iconBottomArray[0] = new JEBottom01;
			_iconBottomArray[1] = new JEBottom02;
			_iconBottomArray[2] = new JEBottom03;
			
			_iconShoesArray[0] = new JEShoes01;
			_iconShoesArray[1] = new JEShoes02;
			_iconShoesArray[2] = new JEShoes03;
			
			_iconAccessoryArray[0] = new JEAcc01;
			
			_iconPartsArray[1] = _iconSkinArray;
			_iconPartsArray[2] = _iconHairArray;
			_iconPartsArray[3] = _iconEyeArray;
			_iconPartsArray[4] = _iconMouthArray;
			_iconPartsArray[5] = _iconEyebrowArray;
			_iconPartsArray[6] = _iconTopArray;
			_iconPartsArray[7] = _iconBottomArray;
			_iconPartsArray[8] = _iconShoesArray;
			_iconPartsArray[9] = _iconAccessoryArray;
		}
		
		private function initTools():void{
			// change visibility
			_visibilityBttn = new ButtonMC();
			_visibilityBttn.scaleX = .7;
			_visibilityBttn.scaleY = .7;
			_visibilityBttn.x = _xPos + 50;
			_visibilityBttn.y = _yPos - 20;
			addChild(_visibilityBttn);
			_visibilityBttn.buttonMCText = new TextField();
			_visibilityBttn.buttonMCText.mouseEnabled = false;
			_visibilityBttn.buttonMCText.type = TextFieldType.DYNAMIC;
			addChild(_visibilityBttn.buttonMCText);
			_visibilityBttn.buttonMCText.text = "Toggle Visibility";
			_visibilityBttn.buttonMCText.x = _xPos + 5;
			_visibilityBttn.buttonMCText.y = _yPos-28;
			_visibilityBttn.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_yPos+=25;
			
			// buttons for animation and texture change
			createChoiceSet ("change animation");
			
			// change
			createChoiceSet ("change texture");
			
			// function for fps change
			
			_fpsButton = new ButtonMC();
			_fpsButton.x = _xPos + 100;
			_fpsButton.y = _yPos + 10;
			_fpsButton.scaleX = .6;
			_fpsButton.scaleY = .6;
			addChild(_fpsButton);
			_fpsButton.buttonMCText = new TextField();
			_fpsButton.buttonMCText.mouseEnabled = false;
			_fpsButton.buttonMCText.x = _xPos + 40;
			_fpsButton.buttonMCText.y = _yPos;
			addChild(_fpsButton.buttonMCText);
			_fpsButton.buttonMCText.text = "Change FPS";
			_fpsButton.buttonMCText.width = 100;
			_fpsButton.buttonMCText.setTextFormat(_textFormat);
			
			_fpsButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_fpsInput = new TextField();
			addChild(_fpsInput);
			_fpsInput.type = TextFieldType.INPUT;
			//fpsInput.background = true;
			//fpsInput.backgroundColor = ;
			_fpsInput.border = true;
			_fpsInput.borderColor = 0x000000;
			_fpsInput.width = 40;
			//fpsInput.restrict = "0-9";
			_fpsInput.height = 20;
			_fpsInput.x = _xPos;
			_fpsInput.y = _yPos 
			addChild(_fpsInput);
			
			_yPos+=50;
			
			createChoiceSet("locaxis rotate");
			_nextBttnAnimArray[2].addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_previousBttnAnimArray[2].addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_nextBttnAnimArray[2].addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_previousBttnAnimArray[2].addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_inputArray[0] = new TextField();
			_inputArray[1] = new TextField();
			_inputArray[2] = new TextField();
			
			addChild(_inputArray[0]);
			addChild(_inputArray[1]);
			addChild(_inputArray[2]);
			
			_posButton = new ButtonMC();
			addChild(_posButton);
			_posButton.scaleX = .7;
			_posButton.scaleY = .8;
			_posButton.x = _xPos+22;
			_posButton.y = _yPos + 12;
			_posButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			var buttonText:TextField = new TextField();
			buttonText.text = "Change position";
			buttonText.x = _xPos-24;
			buttonText.y = _yPos;
			buttonText.mouseEnabled = false;
			addChild(buttonText);
			_xPos += 20;
			var posArrTF01Arr:Array = [];
			
			for (var a:int = 0;a<3;a++){
				posArrTF01Arr[a] = new TextField();
				addChild(posArrTF01Arr[a]); 
				posArrTF01Arr[a].setTextFormat(_textFormat);
				posArrTF01Arr[a].mouseEnabled = false;
			}	
			
			posArrTF01Arr[0].text = "x";
			posArrTF01Arr[1].text = "y";
			posArrTF01Arr[2].text = "z";
			
			_inputArray[0].x = _xPos + 80;
			_inputArray[0].y = _yPos;
			posArrTF01Arr[0].x = _inputArray[0].x - 20;
			posArrTF01Arr[0].y = _yPos ;
			
			_inputArray[1].x = _inputArray[0].x + 50;
			_inputArray[1].y = _yPos;
			posArrTF01Arr[1].x = _inputArray[1].x - 20;
			posArrTF01Arr[1].y = _yPos;
			
			_inputArray[2].x = _inputArray[1].x + 50;
			_inputArray[2].y = _yPos;
			posArrTF01Arr[2].x = _inputArray[2].x - 20;
			posArrTF01Arr[2].y = _yPos;
			
			for (a = 0; a<_inputArray.length;a++){
				_inputArray[a].type = TextFieldType.INPUT;
				_inputArray[a].border = true;
				_inputArray[a].borderColor = 0x000000;
				_inputArray[a].width = 20;
				_inputArray[a].height = 20;
				_inputArray[a].text = "0";
			}
			
			_yPos+=50;
			
			_aIButtons[0] = new ButtonMC();
			_aIButtons[0].addEventListener(MouseEvent.CLICK, onMouseClick);
			_aIButtons[0].buttonMCText = new TextField(); 
			_aIButtons[0].buttonMCText.text = "No AI";
			_aIButtons[0].buttonMCText.x = _xPos -20;
			_aIButtons[0].buttonMCText.y = _yPos - 10;
			_aIButtons[0].buttonMCText.mouseEnabled = false;
			addChild(_aIButtons[0]);
			addChild(_aIButtons[0].buttonMCText);
			_aIButtons[0].scaleX = .7;
			_aIButtons[0].scaleY = .7;
			_aIButtons[0].x = _xPos + 2;
			_aIButtons[0].y = _yPos;
			
			_aIButtons[1] = new ButtonMC();
			_aIButtons[1].addEventListener(MouseEvent.CLICK, onMouseClick);
			_aIButtons[1].buttonMCText = new TextField(); 
			
			_aIButtons[1].buttonMCText.text = "Normal Motion AI";
			_aIButtons[1].buttonMCText.x = _xPos + 70;
			_aIButtons[1].buttonMCText.y = _yPos - 10;
			_aIButtons[1].buttonMCText.mouseEnabled = false;
			addChild(_aIButtons[1]);
			addChild(_aIButtons[1].buttonMCText);
			_aIButtons[1].scaleX = .7;
			_aIButtons[1].scaleY = .7;
			_aIButtons[1].x = _xPos + 120;
			_aIButtons[1].y = _yPos;
		}
		
		private function onMouseClick (evt:MouseEvent):void{
			switch (evt.currentTarget){
				case _posButton:
					_jockeyTest.setPosition (Number(_inputArray[0].text),Number(_inputArray[1].text),Number(_inputArray[2].text));
					break;
				case _nextBttnAnimArray[0]:
					_jockeyTest.nextAnimationCycle();
					break;
				case _previousBttnAnimArray[0]:
					_jockeyTest.previousAnimationCycle();
					break;
				case _nextBttnAnimArray[1]:
					_jockeyTest.changeNextTexture(JockeyAsset.SKIN_SET);
					_jockeyTest.changeNextTexture(JockeyAsset.EYE_SET);
					_jockeyTest.changeNextTexture(JockeyAsset.EYEBROW_SET);
					_jockeyTest.changeNextTexture(JockeyAsset.MOUTH_SET);
					_jockeyTest.changeNextTexture(JockeyAsset.SHOES_SET);
					_jockeyTest.changeNextTexture(JockeyAsset.TOP_SET);
					_jockeyTest.changeNextTexture(JockeyAsset.SHOES_SET);
					break;
				case _previousBttnAnimArray[1]:
					_jockeyTest.changePreviousTexture(JockeyAsset.SKIN_SET);
					_jockeyTest.changePreviousTexture(JockeyAsset.EYE_SET);
					_jockeyTest.changePreviousTexture(JockeyAsset.EYEBROW_SET);
					_jockeyTest.changePreviousTexture(JockeyAsset.MOUTH_SET);
					_jockeyTest.changePreviousTexture(JockeyAsset.SHOES_SET);
					_jockeyTest.changePreviousTexture(JockeyAsset.TOP_SET);
					_jockeyTest.changePreviousTexture(JockeyAsset.SHOES_SET);
					break;
				case _fpsButton:
					if (_fpsInput.text != "" || _fpsInput.text != "0"){
						var fpsValue:Number = Number (_fpsInput.text);
						_jockeyTest.changeFPS(fpsValue);
					} else _jockeyTest.changeFPS(24);
					break;
				case _visibilityBttn:
					if (_jockeyTest.visibility == true){
						_jockeyTest.setCharacterVisibility(false);
						_visibilityBttn.buttonMCText.text = "invisible";
						_fpsButton.buttonMCText.setTextFormat(_textFormat);
					} else {
						_jockeyTest.setCharacterVisibility(true);	
						_visibilityBttn.buttonMCText.text = "visible";
						_fpsButton.buttonMCText.setTextFormat(_textFormat);
					}
					break;
				case _aIButtons[0]:
					_jockeyTest.setAI(JockeyAsset.AI_OFF);
					break;
				case _aIButtons[1]:
					_jockeyTest.setAI(JockeyAsset.AI_MOTION);
					break;
			}
		}
		
		private function createChoiceSet (textFieldName:String):void{
			var texFieldLen:int = _textFieldsArray.length;
			var previousBttnLen:int = _previousBttnAnimArray.length;
			var nextBttnAnimLen:int = _nextBttnAnimArray.length;
			
			_textFieldsArray.push (new TextField());
			_textFieldsArray[texFieldLen].mouseEnabled = false;
			_textFieldsArray[texFieldLen].x = _xPos + 10;
			_textFieldsArray[texFieldLen].y = _yPos-10;
			_textFieldsArray[texFieldLen].text = textFieldName;
			addChild(_textFieldsArray[texFieldLen]);
			
			_previousBttnAnimArray.push(new ButtonNext());
			_previousBttnAnimArray[previousBttnLen].x = _xPos;
			_previousBttnAnimArray[previousBttnLen].y = _yPos;
			_previousBttnAnimArray[previousBttnLen].scaleX = -.3;
			_previousBttnAnimArray[previousBttnLen].scaleY = .3;
			addChild(_previousBttnAnimArray[previousBttnLen]);
			_previousBttnAnimArray[previousBttnLen].addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_nextBttnAnimArray.push(new ButtonNext());
			_nextBttnAnimArray[previousBttnLen].x = _xPos + 115;
			_nextBttnAnimArray[previousBttnLen].y = _yPos;
			_nextBttnAnimArray[previousBttnLen].scaleX = .3;
			_nextBttnAnimArray[previousBttnLen].scaleY = .3;
			addChild(_nextBttnAnimArray[nextBttnAnimLen]);
			_nextBttnAnimArray[previousBttnLen].addEventListener(MouseEvent.CLICK,onMouseClick);
			
			_yPos += 50;
		}
		
		private function initScrolls():void{
			var posX:int = 10;
			var posY:int = 320;
			for (var a:int = 1; a<11; a++){
				if (a == 6){
					posX += 300;
					posY = 320;
				}
				var scrollCont:ScrollingContainer = new ScrollingContainer();
				addChild(scrollCont);
				scrollCont.scaleX = .5;
				scrollCont.scaleY = .5;
				scrollCont.x = posX;
				scrollCont.y = posY;
				posY += 100;
				_scrollerArray[a-1] = scrollCont;
				_scrollerArray[a-1].left.addEventListener(MouseEvent.MOUSE_DOWN, onScrollMouseDown);
				_scrollerArray[a-1].right.addEventListener(MouseEvent.MOUSE_DOWN, onScrollMouseDown);
				_scrollerArray[a-1].left.addEventListener(MouseEvent.MOUSE_UP, onScrollMouseUp);
				_scrollerArray[a-1].right.addEventListener(MouseEvent.MOUSE_UP, onScrollMouseUp);
				_scrollerArray[a-1].left.addEventListener(MouseEvent.MOUSE_OUT, onScrollMouseUp);
				_scrollerArray[a-1].right.addEventListener(MouseEvent.MOUSE_OUT, onScrollMouseUp);
				var xPos:Number;
				var set:int;
				
				for (var item:int = 0; item < _iconPartsArray.length; item++){
					if (a == item){
						xPos = 20;
						for (set=0; set<_iconPartsArray[item].length; set++){
							_iconPartsArray[item][set].x = xPos;
							_iconPartsArray[item][set].y = 20;
							_iconPartsArray[item][set].scaleX = 2;
							_iconPartsArray[item][set].scaleY = 2;
							_scrollerArray[a-1].container.addChild(_iconPartsArray[item][set]);
							_iconPartsArray[item][set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
							xPos += 130;
						}
					}
				}
			}
		}
		
		public function showJockey ():void{
			init();
		}
		
		private function onMouseDown (evt:MouseEvent):void{
			switch (evt.target){
				case _nextBttnAnimArray[2]:
					_canRotate = true;
					_direction = "right";
					break;
				case _previousBttnAnimArray[2]:
					_canRotate = true;
					_direction = "left";
					break;
			}
		}
		
		public function hideJockey ():void{
			if (_jockeyTest !=null){
				_jockeyTest.setCharacterVisibility(false);
				removeListeners();
			}
			
		} 
		
		private function removeListeners ():void{
			_visibilityBttn.removeEventListener(MouseEvent.CLICK, onMouseClick);
			_fpsButton.removeEventListener(MouseEvent.CLICK, onMouseClick);
			_nextBttnAnimArray[2].removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_previousBttnAnimArray[2].removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_nextBttnAnimArray[2].removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_previousBttnAnimArray[2].removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_posButton.removeEventListener(MouseEvent.CLICK, onMouseClick);
			_previousBttnAnimArray[0].removeEventListener(MouseEvent.CLICK, onMouseClick);
			_nextBttnAnimArray[0].removeEventListener(MouseEvent.CLICK,onMouseClick);
			_previousBttnAnimArray[1].removeEventListener(MouseEvent.CLICK, onMouseClick);
			_nextBttnAnimArray[1].removeEventListener(MouseEvent.CLICK,onMouseClick);
			stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			for (var item:int = 0; item < _iconPartsArray.length; item++){
				if (_iconPartsArray[item] != null){
					for (var set:int=0; set<_iconPartsArray[item].length; set++){
						if (_iconPartsArray[item][set] != null){
							_iconPartsArray[item][set].removeEventListener(MouseEvent.CLICK,onMouseClick);
						}
					}
				}
			}
			_jockeyTest.mesh.removeOnMouseDown(onMouse3DDown);
			_jockeyTest.mesh.removeOnMouseDown(onMouse3DUp);
		}
		
		private function onScrollMouseClick (evt:MouseEvent):void{
			for (var a:int = 0; a<_iconSkinArray.length; a++){
				if (evt.target == _iconSkinArray[a]){
					_jockeyTest.changeTextureByPart(JockeyAsset.SKIN_SET, a);
				}
			}
			
			for (a = 0; a<_iconMouthArray.length; a++){
				if (evt.target == _iconMouthArray[a]){
					_jockeyTest.changeTextureByPart(JockeyAsset.MOUTH_SET, a);
				}
			}
			
			for (a = 0; a<_iconEyebrowArray.length; a++){
				if (evt.target == _iconEyebrowArray[a]){
					_jockeyTest.changeTextureByPart(JockeyAsset.EYEBROW_SET, a);
				}
			}
			
			for (a = 0; a<_iconHairArray.length; a++){
				if (evt.target == _iconHairArray[a]){
					_jockeyTest.changeMeshByType(JockeyAsset.HAIR_SET, a);
					_jockeyTest.changeTextureByPart(JockeyAsset.HAIR_SET, a);
					_jockeyTest.changeAnimationByType(_jockeyTest.animation.animationIndex);
				}
			}
			
			for (a = 0; a<_iconEyeArray.length; a++){
				if (evt.target == _iconEyeArray[a]){
					_jockeyTest.changeTextureByPart(JockeyAsset.EYE_SET, a);
				}
			}
			
			for (a = 0; a<_iconTopArray.length; a++){
				if (evt.target == _iconTopArray[a]){
					_jockeyTest.changeTextureByPart(JockeyAsset.TOP_SET, a);
				}
			}
			
			for (a = 0; a<_iconBottomArray.length; a++){
				if (evt.target == _iconBottomArray[a]){
					if (a == 0){
						_jockeyTest.changeMeshByType(JockeyAsset.BOTTOM_SET, JockeyBottomSet.MESHBOTTOM_DEFAULT);
						_jockeyTest.changeTextureByPart(JockeyAsset.BOTTOM_SET, JockeyBottomSet.TEXBOTTOM_DEFAULT);
					} else if (a > 0) {
						_jockeyTest.changeMeshByType(JockeyAsset.BOTTOM_SET, JockeyBottomSet.MESHBOTTOM_002);
						if (a == 1){
							_jockeyTest.changeTextureByPart(JockeyAsset.BOTTOM_SET, JockeyBottomSet.TEXBOTTOM_002_0001);
						} 
						
						if (a==2){
							_jockeyTest.changeTextureByPart(JockeyAsset.BOTTOM_SET, JockeyBottomSet.TEXBOTTOM_002_0002);
						}
					}
				}
			}
			
			for (a = 0; a<_iconShoesArray.length; a++){
				if (evt.target == _iconShoesArray[a]){
					_jockeyTest.changeTextureByPart(JockeyAsset.SHOES_SET, a);
				}
			}
			
			for (a = 0; a<_iconAccessoryArray.length; a++){
				if (evt.target == _iconAccessoryArray[a]){
					if (_jockeyTest.equipmentExists(JockeyAsset.ACC_SET) == false) {
						_jockeyTest.addEquipment(JockeyAsset.ACC_SET);
					} else {
						if (_jockeyTest.equipmentVisibility(JockeyAsset.ACC_SET) == true){
							_jockeyTest.setSpecificEquipmentVisibility(JockeyAsset.ACC_SET, false);
						}	else {
							_jockeyTest.setSpecificEquipmentVisibility(JockeyAsset.ACC_SET, true);
						}
					}
				}
			}
		}
		
		private function onMouseUp (evt:MouseEvent):void{
			switch (evt.target){
				case _nextBttnAnimArray[2]:
					_canRotate = false;
					break;
				case _previousBttnAnimArray[2]:
					_canRotate = false;
					break;
			}
		}
		
		private function onScrollMouseDown (evt:MouseEvent):void{
			for (var scrollSet:int = 0; scrollSet<_scrollerArray.length;scrollSet++){
				if (evt.currentTarget.parent == _scrollerArray[scrollSet] && evt.currentTarget.name == "left"){
					_scrollMoveArrayLeft[scrollSet] = true;
				}
				
				if (evt.currentTarget.parent == _scrollerArray[scrollSet] && evt.currentTarget.name == "right"){
					_scrollMoveArrayRight[scrollSet] = true;
				}
			}
		}
		
		private function onScrollMouseUp (evt:MouseEvent):void{
			for (var scroll:int = 0; scroll<_scrollerArray.length; scroll++){
				_scrollMoveArrayLeft[scroll] = false;
				_scrollMoveArrayRight[scroll] = false;
			}
		}
		
		private function onEnterFrame(evt:Event):void {
			
			for (var scroll:int = 0; scroll<_scrollerArray.length; scroll++){
				if (_scrollMoveArrayLeft[scroll] == true){
					if (_scrollerArray[scroll].container.x < 25 && _scrollerArray[scroll].container.width > 490){
						_scrollerArray[scroll].container.x +=15;
					} else {
						_scrollerArray[scroll].container.x = 25;
					}
				} 
				if (_scrollMoveArrayRight[scroll] == true){
					if (_scrollerArray[scroll].container.x > -_scrollerArray[scroll].container.width + 510){
						_scrollerArray[scroll].container.x -=15;
					} else {
						if (_scrollerArray[scroll].container.width < 490){
							_scrollerArray[scroll].container.x = 25;
						} else {
							_scrollerArray[scroll].container.x = -_scrollerArray[scroll].container.width + 490;
						}
					}
				}
			}
			
			if (_canRotate){
				if (_direction == "right"){
					_meshRotY -=5;
					_jockeyTest.setMeshYRotation(_meshRotY);
				}
				if (_direction == "left"){
					_meshRotY +=5;
					_jockeyTest.setMeshYRotation(_meshRotY);
				}
			}
		}
	}
}