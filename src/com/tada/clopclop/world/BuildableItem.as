package com.tada.clopclop.world
{	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.tada.clopclop.buildables.BuildableFactory;
	import com.tada.clopclop.events.BuildablesEvent;
	import com.tada.clopclop.events.ItemEvent;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.events.RedecorateEvent;
	import com.tada.clopclop.popups.BuildingManagementPopup;
	import com.tada.clopclop.popups.PopupManager;
	import com.tada.engine.TEngine;
	import com.tada.engine.iso.Coordinate;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Class for the buildings and decorations,
	 * This has functions for showing the base and glowing and showing
	 * if it's valid or invalid to build there
	 */
	public class BuildableItem implements IsoItem{
		
		public static const UNDER_CONSTRUCTION:String = "underConstruction";
		public static const NON_BOUGHT:String = "unBought";
		public static const FUNCTIONAL:String = "functional";
		public static const REDECORATING:String  = "redecorating";
		
		public var centerX:Number;
		public var centerY:Number;
		
		public var worldId:int = 0;
		public var typeId:int = 0;
		public var coinPrice:int = 0;
		public var sellPrice:int = 0;
		
		private var _flipped:Boolean = false;
		
		private var _world:RanchController;
		
		private var _state:String;
		
		private var _type:Class;		
		
		private var _isValid:Boolean;
		
		private var _prevCol:int;
		private var _prevRow:int;
		private var _prevFlipped:Boolean;
		
		private var _mainDisplay:MovieClip;
		private var _buildingMC:MovieClip;
		private var _base:Sprite;
		
		private var _distractor:MovieClip;
		
		private var _className:String;
		
		private var _row:int;
		private var _col:int;
		private var _rows:int;
		private var _cols:int;
		
		public function BuildableItem(type:String, col:int, row:int, cols:int, rows:int)
		{
			_row = row;
			_col = col;
			_rows = rows;
			_cols = cols;
			
			//setup the layers
			_mainDisplay = new MovieClip();
			_className = type;			
			_base = new Sprite();
			_distractor = new LoadingImage();
			_mainDisplay.addChild(_base);	
			_mainDisplay.addChild(_distractor);
			//mainDisplay.addChild(_buildingMC);
			
			state = NON_BOUGHT;
			
			addEventListeners();
									
		}
		
		/**
		 * Tells this item that the world already exists
		 */
		public function initOnWorld():void{
			if(BuildableFactory.instance.isReady){ //if the building.swf had already loaded
				loadMC();
			}else{ //add event listener				
				TEngine.mainClass.addEventListener(BuildablesEvent.BUILDING_ASSETS_READY, loadMC);
			}
		}
		
		public function set row(val:int):void{
			_row = val;
		}
		
		public function get row():int{
			return _row;
		}
		
		public function set rows(val:int):void{
			_rows = val;
		}
		
		public function get rows():int{
			return _rows;
		}
		
		public function set col(val:int):void{
			_col = val;
		}
		
		public function get col():int{
			return _col;
		}
		
		public function set cols(val:int):void{
			_cols = val;
		}
		
		public function get cols():int{
			return _cols;
		}
		
		public function get displayObject():DisplayObjectContainer{
			return _mainDisplay;
		}
		
		
		public function get rotation():int{
			return (flipped) ? 1 : 0;
		}
		
		public function set flipped(val:Boolean):void{
			if(val != _flipped){
				var temp:int = cols;
				cols = rows;
				rows = temp;
			}
			
			_flipped = val;
					
			if(_flipped)
				setMCToFrame(3);
			else
				setMCToFrame(1);
			
			reconstructGrid(0x00cc00);
		}
		
		public function get flipped():Boolean{
			return _flipped;
		}
		
		public function set world(isoWorld:RanchController):void{
			_world = isoWorld;
			reconstructGrid(0x00cc00);
		}
		
		public function get world():RanchController{
			return _world;
		}
		
		public function reconstructGrid(color:uint):void{
			if(!_world){
				return;
			}
			
			var east:Coordinate = _world.mapToScreen(0, 0, -_world.tileHeight * rows);
			var south:Coordinate = _world.mapToScreen(_world.tileWidth * cols, 0, -_world.tileHeight * rows);
			var north:Coordinate = _world.mapToScreen(0, 0, 0);
			var west:Coordinate = _world.mapToScreen(_world.tileWidth * cols, 0, 0);
			
			with(_base){
				graphics.clear();
				graphics.beginFill(color);							
				graphics.lineTo(north.x, north.y);
				graphics.lineTo(east.x, east.y);
				graphics.lineTo(south.x, south.y);
				graphics.lineTo(west.x, west.y);
				graphics.endFill();
			}
			
			var _center:Coordinate = _world.mapToScreen((_world.tileWidth * (cols/2)), 0, -(_world.tileHeight * (rows/2)));
			
			setCenterPoint(_center.x, _center.y - 40);
		}
		
		public function setCenterPoint(X:Number, Y:Number):void{
			centerX = X;
			centerY = Y;
		}
		
		public function set state(str:String):void{
			_state = str;
			
			switch(_state){
				case UNDER_CONSTRUCTION:
					setMCToFrame(2);					
					TweenLite.to(this, 1, {onComplete: function():void{
						state = FUNCTIONAL;
					}}); 
					break;
				case NON_BOUGHT:
					break;
				case FUNCTIONAL:
					if(flipped){
						setMCToFrame(3);						
					}else{
						setMCToFrame(1);						
					}
					break;
				case REDECORATING:
					break;
			}
		}
		
		public function get state():String{
			return _state;
		}
		
		private function saveState():void{
			_prevCol = col;
			_prevRow = row;
			_prevFlipped = flipped;
		}
		
		public function loadState():void{
			col = _prevCol;
			row = _prevRow;
			flipped = _prevFlipped;
		}
		
		private function onMouseOver(evt:MouseEvent):void{
			if(_state != NON_BOUGHT){
				TweenMax.to(displayObject, .5, {glowFilter:{color:0xffff33, alpha:1, blurX:3, blurY:3, strength:10}});
			}
		}
		
		private function onMouseOut(evt:MouseEvent):void{
			if(_state != NON_BOUGHT){
				TweenMax.to(displayObject, .5, {glowFilter:{color:0x00cc00, alpha:0, blurX:3, blurY:3, strength:0}});
			}
		}
		
		private function onMouseClick(evt:MouseEvent):void{		
			if(_world && _world.state == RanchController.REDECORATE){
				if(_state != NON_BOUGHT && _state != REDECORATING){
					PopupManager.instance.showPopup(displayObject, PopupManager.BUILDING, onClickAPopup);
					TEngine.mainStage.addEventListener(MouseEvent.MOUSE_UP, onClickStage);
				}
			}			
		}
		
		private function onClickStage(evt:MouseEvent):void{
			Logger.print(this, "Target: " + evt.target);
				TEngine.mainStage.removeEventListener(MouseEvent.MOUSE_UP, onClickStage);
				PopupManager.instance.hide();
		}
		
		private function onClickAPopup(str:String):void{
			Logger.print(this, "Clicked on me: " + str);
			switch(str){
				case BuildingManagementPopup.ROTATE:
					saveState();
					flipped = !flipped;						
					//TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.ROTATE, this));									
					break;
				case BuildingManagementPopup.SELL:
					//TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.SELL, this));
					break;
				case BuildingManagementPopup.STORAGE:
					//TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.STORAGE, this));
					break;
				case BuildingManagementPopup.MOVE:
					saveState();
					//TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.MOVE, this));
					break;
					
			}
		}
		
		private function addEventListeners():void{
			displayObject.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			displayObject.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			displayObject.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function removeEventListeners():void{
			displayObject.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			displayObject.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			displayObject.removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function glow():void{
			var hue:uint = 0x00cc00;
			if(canBuild){
				hue = 0x00cc00;
			}else{
				hue = 0xcc0000;
			}
			if(visibleBase){				
				TweenMax.to(displayObject, .5, {glowFilter:{color:hue, alpha:1, blurX:3, blurY:3, strength:10}});
			}else{
				TweenMax.to(displayObject, .5, {glowFilter:{color:hue, alpha:0, blurX:3, blurY:3, strength:0}});
			}
		} 
		
		public function set visibleBase(val:Boolean):void{
			_base.visible = val;
			glow();			
		}
		
		public function get visibleBase():Boolean{
			return _base.visible;
		}
		
		public function set canBuild(val:Boolean):void{
			_isValid = val;			
			if(_isValid){
				reconstructGrid(0x00cc00);
			}else{
				reconstructGrid(0xcc0000);
			}
			
			glow();
		}
		
		public function get canBuild():Boolean{
			return _isValid;
		}
		
		private function setMCToFrame(frame:int):void{
			if(_buildingMC){
				try{
					(_buildingMC as _type).state.gotoAndStop(frame);
				}catch(error:Error){
					Logger.error(this, "setMCToFrame", "BuildingMC " + this._className + error.message);
				}
			}										
		}
		
		private function loadMC(evt:BuildablesEvent = null):void{
			_type = BuildableFactory.instance.getMCClass(_className);
			
			_buildingMC = new _type();
			
			flipped = flipped;
			
			displayObject.removeChild(_distractor);
			displayObject.addChild(_buildingMC);						
			
			_distractor = null;
		}
		
	}
}