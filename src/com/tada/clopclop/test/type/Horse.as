package com.tada.clopclop.test.type
{
	import com.away3d.containers.View3D;
	import com.away3d.debug.AwayStats;
	import com.away3d.events.MouseEvent3D;
	import com.away3d.primitives.Cube;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAnimation;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseBodySet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseEyeSet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseHairSet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseMouthSet;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.osmf.composition.SerialElement;
	
	public class Horse extends Sprite
	{
		private var _view:View3D;
		private var _horseTest:HorseAsset;
		private var _testBox:Cube;
		private var _stats:AwayStats;
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
		
		private var _iconSetArray:Array = [];
		private var _iconEyeArray:Array = [];
		private var _iconHairArray:Array = [];
		private var _iconMouthArray:Array = [];
		private var _iconBodyArray:Array = [];
		private var _iconBridleArray:Array = [];
		private var _iconSaddleArray:Array = [];
		private var _iconWingArray:Array = [];	
		private var _iconDecalsArray:Array = [];
		private var _inputArray:Array = [];
		private var _canRotate:Boolean = false;
		private var _direction:String;
		private var _posButton:ButtonMC;
		private var _meshRotY:Number = 0;
		private var _stage:Stage;
		private var _scrollMoveArrayLeft:Array = [];
		private var _scrollMoveArrayRight:Array = [];
		private var _scrollerArray:Array = [];
		private var _aIButtons:Array = [];
		private var _iconPartsArray:Array = [];
		
		public function Horse(view:View3D, horse:HorseAsset)
		{
			_view = view;
			_horseTest = horse;
		}
		
		private function init():void{
			setTextFormat();
			initIcons();
			initTools();
			initIconContainers();
			initScrolls();
			addTextFields();
			addListeners();
		} 
		
		public function showHorse():void{
			init();
		}
		
		public function reset():void{
			_horseTest.resetSettings();
		}
		
		public function hideHorse():void{
			_horseTest.mesh.visible = false;
			removeListeners();
		}
		
		private function initIconContainers():void{
			_iconEyeArray[0] = new HBEye01();
			_iconEyeArray[1] = new HBEye02();
			_iconEyeArray[2] = new HBEye03();
			
			_iconHairArray[0] = new HBMane01();
			_iconHairArray[1] = new HBMane02();
			_iconHairArray[2] = new HBMane03();
			_iconHairArray[3] = new HBMane04();
			
			_iconBodyArray[0] = new HBSkin01();
			_iconBodyArray[1] = new HBSkin02();
			_iconBodyArray[2] = new HBSkin03();
			_iconBodyArray[3] = new HBPattern01();
			
			_iconMouthArray[0] = new HBMouth01();
			_iconMouthArray[1] = new HBMouth02();
			_iconMouthArray[2] = new HBMouth03();
			
			_iconWingArray[0] = new NoWing();
			_iconWingArray[1] = new Wing();
			
			_iconDecalsArray[0] = new DecalStar();
			_iconDecalsArray[1] = new DecalHeart();
			_iconDecalsArray[2] = new DecalCircles();
			_iconDecalsArray[3] = new DecalSpiked();
			
			_iconBridleArray[0] = new TextBoxedButtonIcon();
			_iconBridleArray[0].textWord.text = "No Bridle";
			_iconBridleArray[0].textWord.mouseEnabled = false;
			_iconBridleArray[1] = new TextBoxedButtonIcon();
			_iconBridleArray[1].textWord.text = "Bridle1";
			_iconBridleArray[1].textWord.mouseEnabled = false;
			_iconBridleArray[2] = new TextBoxedButtonIcon();
			_iconBridleArray[2].textWord.text = "Bridle2";
			_iconBridleArray[2].textWord.mouseEnabled = false;
			_iconBridleArray[3] = new TextBoxedButtonIcon();
			_iconBridleArray[3].textWord.text = "Bridle3";
			_iconBridleArray[3].textWord.mouseEnabled = false;
			_iconBridleArray[4] = new TextBoxedButtonIcon();
			_iconBridleArray[4].textWord.text = "Bridle4";
			_iconBridleArray[4].textWord.mouseEnabled = false;
			_iconBridleArray[5] = new TextBoxedButtonIcon();
			_iconBridleArray[5].textWord.text = "Bridle5";
			_iconBridleArray[5].textWord.mouseEnabled = false;
			_iconBridleArray[6] = new TextBoxedButtonIcon();
			_iconBridleArray[6].textWord.text = "Bridle6";
			_iconBridleArray[6].textWord.mouseEnabled = false;
			_iconBridleArray[7] = new TextBoxedButtonIcon();
			_iconBridleArray[7].textWord.text = "Bridle7";
			_iconBridleArray[7].textWord.mouseEnabled = false;
			_iconBridleArray[8] = new TextBoxedButtonIcon();
			_iconBridleArray[8].textWord.text = "Bridle8";
			_iconBridleArray[8].textWord.mouseEnabled = false;
			_iconBridleArray[9] = new TextBoxedButtonIcon();
			_iconBridleArray[9].textWord.text = "Bridle9";
			_iconBridleArray[9].textWord.mouseEnabled = false;
			_iconBridleArray[10] = new TextBoxedButtonIcon();
			_iconBridleArray[10].textWord.text = "Bridle10";
			_iconBridleArray[10].textWord.mouseEnabled = false;
			
			_iconSaddleArray[0] = new TextBoxedButtonIcon();
			_iconSaddleArray[0].textWord.text = "No Saddle";
			_iconSaddleArray[0].textWord.mouseEnabled = false;
			_iconSaddleArray[1] = new TextBoxedButtonIcon();
			_iconSaddleArray[1].textWord.text = "Saddle1";
			_iconSaddleArray[1].textWord.mouseEnabled = false;
			_iconSaddleArray[2] = new TextBoxedButtonIcon();
			_iconSaddleArray[2].textWord.text = "Saddle2";
			_iconSaddleArray[2].textWord.mouseEnabled = false;
			_iconSaddleArray[3] = new TextBoxedButtonIcon();
			_iconSaddleArray[3].textWord.text = "Saddle3";
			_iconSaddleArray[3].textWord.mouseEnabled = false;
			_iconSaddleArray[4] = new TextBoxedButtonIcon();
			_iconSaddleArray[4].textWord.text = "Saddle4";
			_iconSaddleArray[4].textWord.mouseEnabled = false;
			_iconSaddleArray[5] = new TextBoxedButtonIcon();
			_iconSaddleArray[5].textWord.text = "Saddle5";
			_iconSaddleArray[5].textWord.mouseEnabled = false;
			_iconSaddleArray[6] = new TextBoxedButtonIcon();
			_iconSaddleArray[6].textWord.text = "Saddle6";
			_iconSaddleArray[6].textWord.mouseEnabled = false;
			_iconSaddleArray[7] = new TextBoxedButtonIcon();
			_iconSaddleArray[7].textWord.text = "Saddle7";
			_iconSaddleArray[7].textWord.mouseEnabled = false;
			
			_iconSetArray[0] = new DefaultSet();
			_iconSetArray[1] = new WhiteStallionSet();
			_iconSetArray[2] = new BlackBeautySet();
			_iconSetArray[3] = new ZebraSet();
			
			_iconPartsArray[0] = null;
			_iconPartsArray[1] = null;
			_iconPartsArray[2] = _iconEyeArray;
			_iconPartsArray[3] = _iconHairArray;
			_iconPartsArray[4] = _iconBodyArray;
			_iconPartsArray[5] = _iconMouthArray;
			_iconPartsArray[6] = _iconWingArray;
			_iconPartsArray[7] = _iconDecalsArray;
			_iconPartsArray[8] = _iconBridleArray;
			_iconPartsArray[9] = _iconSaddleArray;
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
				
				if (a==1){
					var xPos:int = 20;
					for (var set:int=0; set<_iconSetArray.length; set++){
						_iconSetArray[set].x = xPos;
						_iconSetArray[set].y = 20;
						_iconSetArray[set].scaleX = .8;
						_iconSetArray[set].scaleY = .8;
						_scrollerArray[a-1].container.addChild(_iconSetArray[set]);
						_iconSetArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 130;
					}
				} else if (a==2){
					xPos = 20;
					for (set=0; set<_iconBodyArray.length; set++){
						_iconBodyArray[set].x = xPos;
						_iconBodyArray[set].y = 20;
						_iconBodyArray[set].scaleX = 2;
						_iconBodyArray[set].scaleY = 2;
						_scrollerArray[a-1].container.addChild(_iconBodyArray[set]);
						_iconBodyArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 130;
					}
				} else if (a==3){
					xPos = 20;
					for (set = 0; set<_iconEyeArray.length; set++){
						_iconEyeArray[set].x = xPos;
						_iconEyeArray[set].y = 20;
						_iconEyeArray[set].scaleX = 2;
						_iconEyeArray[set].scaleY = 2;
						_scrollerArray[a-1].container.addChild(_iconEyeArray[set]);
						_iconEyeArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 140;
					}
				} else if (a==4){
					xPos = 20;
					for (set = 0; set<_iconHairArray.length; set++){
						_iconHairArray[set].x = xPos;
						_iconHairArray[set].y = 20;
						_iconHairArray[set].scaleX = 2;
						_iconHairArray[set].scaleY = 2;
						_scrollerArray[a-1].container.addChild(_iconHairArray[set]);
						_iconHairArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 140;
					}
				} else if (a==5){
					xPos = 20;
					for (set = 0; set<_iconMouthArray.length; set++){
						_iconMouthArray[set].x = xPos;
						_iconMouthArray[set].y = 20;
						_iconMouthArray[set].scaleX = 2;
						_iconMouthArray[set].scaleY = 2;
						_scrollerArray[a-1].container.addChild(_iconMouthArray[set]);
						_iconMouthArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 140;
					}
				} else if (a==6){
					xPos = 10;
					for (set = 0; set<_iconBridleArray.length; set++){
						_iconBridleArray[set].x = xPos;
						_iconBridleArray[set].y = -10;
						_iconBridleArray[set].scaleX = 1;
						_iconBridleArray[set].scaleY = 1;
						_scrollerArray[a-1].container.addChild(_iconBridleArray[set]);
						_iconBridleArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 140;
					}
				} else if (a==7){
					xPos = 10;
					for (set = 0; set<_iconSaddleArray.length; set++){
						_iconSaddleArray[set].x = xPos;
						_iconSaddleArray[set].y = -10;
						_iconSaddleArray[set].scaleX = 1;
						_iconSaddleArray[set].scaleY = 1;
						_scrollerArray[a-1].container.addChild(_iconSaddleArray[set]);
						_iconSaddleArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 140;
					}
				} else if (a==8){
					xPos = 20;
					for (set = 0; set<_iconWingArray.length; set++){
						_iconWingArray[set].x = xPos;
						_iconWingArray[set].y = 25;
						_iconWingArray[set].scaleX = 1;
						_iconWingArray[set].scaleY = 1;
						_scrollerArray[a-1].container.addChild(_iconWingArray[set]);
						_iconWingArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 130;
					}
				}else if (a==9){
					xPos = 20;
					for (set = 0; set<_iconDecalsArray.length; set++){
						_iconDecalsArray[set].x = xPos;
						_iconDecalsArray[set].y = 25;
						_iconDecalsArray[set].scaleX = 1;
						_iconDecalsArray[set].scaleY = 1;
						_scrollerArray[a-1].container.addChild(_iconDecalsArray [set]);
						_iconDecalsArray[set].addEventListener(MouseEvent.CLICK, onScrollMouseClick);
						xPos += 130;
					}
				}				
			}
		}
		
		private function removeListeners():void{
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
			
			for (var a:int = 0; a<_aIButtons.length; a++){
				_aIButtons[a].removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			for (var item:int = 0; item < _iconPartsArray.length; item++){
				if (_iconPartsArray[item] != null){
					for (var set:int=0; set<_iconPartsArray.length; set++){
						if (_iconPartsArray[item][set] != null){
							_iconPartsArray[item][set].removeEventListener(MouseEvent.CLICK,onMouseClick);
						}
					}
				}
			}
			
			_horseTest.mesh.removeOnMouseDown(onMouse3DDown);
			_horseTest.mesh.removeOnMouseDown(onMouse3DUp);
		}
		
		private function setTextFormat():void{
			_textFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.CENTER;
		}
		
		private function initTools():void{
			
			// change visibility
			_visibilityBttn = new ButtonMC();
			_visibilityBttn.scaleX = .7;
			_visibilityBttn.scaleY = .7;0
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
			addChild(_fpsButton.buttonMCText)
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
			
			_yPos += 50;
			
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
		
		public function initIcons ():void{
			
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
		
		private function addTextFields():void{
			_debugTF = new TextField();
			_debugTF.x = 30;
			_debugTF.y = 30;
			_debugTF.width = 300;
			_debugTF.mouseEnabled = false;
			_debugTF.text = "Testing";
			addChild(_debugTF);
		} 
		
		public function addListeners():void{
			
			_horseTest.mesh.addOnMouseDown(onMouse3DDown);
			_horseTest.mesh.addOnMouseUp(onMouse3DUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onMouse3DDown (evt:MouseEvent3D):void{
			var geomLen:int = _horseTest.mesh.children.length;
			for (var a:int = 0; a<geomLen; a++){
				if (_horseTest.mesh.children[a] == evt.object){
					_debugTF.text = "mesh clicked";
					_horseTest.changeNextTexture(_horseTest.meshLoadedIndex[a]);
				}
			}
		}
		
		private function onMouse3DUp (evt:MouseEvent3D):void{
			_debugTF.text = "mesh unclicked";
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
		
		private function onMouseClick (evt:MouseEvent):void{
			switch (evt.currentTarget){
				case _horseTest:
					_debugTF.text = "mesh clicked";
					break;
				case _posButton:
					_horseTest.x = _inputArray[0];
					_horseTest.y = _inputArray[1];
					_horseTest.z = _inputArray[2];
					break;
				case _nextBttnAnimArray[0]:
					_horseTest.nextAnimationCycle();
					break;
				case _previousBttnAnimArray[0]:
					_horseTest.previousAnimationCycle();
					break;
				case _nextBttnAnimArray[1]:
					_horseTest.changeNextTexture(HorseAsset.BODY_SET);
					_horseTest.changeNextTexture(HorseAsset.EYE_SET);
					_horseTest.changeNextTexture(HorseAsset.HAIR_SET);
					_horseTest.changeNextTexture(HorseAsset.MOUTH_SET);
					_horseTest.changeNextTexture(HorseAsset.BRIDLE_SET);
					_horseTest.changeNextTexture(HorseAsset.SADDLE_SET);
					break;
				case _previousBttnAnimArray[1]:
					_horseTest.changePreviousTexture(HorseAsset.BODY_SET);
					_horseTest.changePreviousTexture(HorseAsset.HAIR_SET);
					_horseTest.changePreviousTexture(HorseAsset.EYE_SET);
					_horseTest.changePreviousTexture(HorseAsset.MOUTH_SET);
					_horseTest.changePreviousTexture(HorseAsset.BRIDLE_SET);
					_horseTest.changePreviousTexture(HorseAsset.SADDLE_SET);
					break;
				case _fpsButton:
					if (_fpsInput.text != "" || _fpsInput.text != "0"){
						var fpsValue:Number = Number (_fpsInput.text);
						_horseTest.changeFPS(fpsValue);
					} else _horseTest.changeFPS(24);
					break;
				case _visibilityBttn:
					if (_horseTest.mesh.visible == true){
						_horseTest.mesh.visible = false;
						_visibilityBttn.buttonMCText.text = "invisible";
						_fpsButton.buttonMCText.setTextFormat(_textFormat);
					} else {
						_horseTest.mesh.visible = true;	
						_visibilityBttn.buttonMCText.text = "visible";
						_fpsButton.buttonMCText.setTextFormat(_textFormat);
					}
					break;
				case _aIButtons[0]:
					_horseTest.setAI(HorseAsset.AI_OFF);
					break;
				case _aIButtons[1]:
					_horseTest.setAI(HorseAsset.AI_MOTION);
					break;
			}
		}
		
		private function onScrollMouseClick (evt:MouseEvent):void{
			for (var a:int = 0; a<_iconBodyArray.length; a++){
				if (evt.target == _iconBodyArray[a]){
					_horseTest.changeTextureByPart(HorseAsset.BODY_SET, a);
				}
			}
			
			for (a = 0; a<_iconEyeArray.length; a++){
				if (evt.target == _iconEyeArray[a]){
					_horseTest.changeTextureByPart(HorseAsset.EYE_SET, a);
				}
			}
			
			for (a = 0; a<_iconHairArray.length; a++){
				if (evt.target == _iconHairArray[a]){
					_horseTest.changeTextureByPart(HorseAsset.HAIR_SET, a);
				}
			}
			
			for (a = 0; a<_iconMouthArray.length; a++){
				if (evt.target == _iconMouthArray[a]){
					_horseTest.changeTextureByPart(HorseAsset.MOUTH_SET, a);
					
				}
			}
			
			for (a = 0; a<_iconWingArray.length; a++){
				if (a == 1 && evt.target == _iconWingArray[1]){
					if (_horseTest.equipmentExists(HorseAsset.WING_SET) == false){
						_horseTest.addEquipment(HorseAsset.WING_SET);
					} else {
						_horseTest.setSpecificEquipmentVisibility(HorseAsset.WING_SET, true);
					}
				} else if (a == 0 && evt.target == _iconWingArray[0]) {
					_horseTest.setSpecificEquipmentVisibility(HorseAsset.WING_SET, false);
				}
			}
			
			for (a = 0; a<_iconSaddleArray.length; a++){
				if (evt.currentTarget == _iconSaddleArray[a]){
					_horseTest.changeTextureByPart(HorseAsset.SADDLE_SET, a-1);
				}
			}
			
			for (a = 0; a<_iconBridleArray.length; a++){
				if (evt.currentTarget == _iconBridleArray[a]){
					_horseTest.changeTextureByPart(HorseAsset.BRIDLE_SET, a-1);
				}
			}
			
			for (a = 0; a<_iconDecalsArray.length; a++){
				if (evt.target == _iconDecalsArray[a]){
					_horseTest.changeDecalsByType(HorseAsset.BODY_SET, a);
				}
			}
			
			for (a = 0; a<_iconSetArray.length; a++){
				if (evt.target == _iconSetArray[a]){
					_horseTest.changeMeshBySet(a);
					_horseTest.changeTextureBySet(a);
				}
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
		
		public function onEnterFrame(evt:Event):void{
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
					_horseTest.mesh.rotationY = _meshRotY;
				}
				if (_direction == "left"){
					_meshRotY +=5;
					_horseTest.mesh.rotationY = _meshRotY;
				}
			}
		}
	}
}