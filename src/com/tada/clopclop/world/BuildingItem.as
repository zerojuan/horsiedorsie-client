package com.tada.clopclop.world
{	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.tada.clopclop.datamodels.Building;
	import com.tada.clopclop.datamodels.IDBModel;
	import com.tada.clopclop.events.RedecorateEvent;
	import com.tada.clopclop.popups.BuildingManagementPopup;
	import com.tada.clopclop.popups.PopupManager;
	import com.tada.clopclop.ui.components.ProgressBarComponent;
	import com.tada.clopclop.ui.textdisplay.TimeDisplayer;
	import com.tada.engine.TEngine;
	import com.tada.engine.iso.Coordinate;
	import com.tada.engine.rendering.SwfVectorCache;
	import com.tada.engine.resource.SWFResource;
	import com.tada.utils.debug.Logger;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Class for the buildings and decorations,
	 * This has functions for showing the base and glowing and showing
	 * if it's valid or invalid to build there
	 */
	public class BuildingItem implements IsoItem{
		public static const UNDERCONSTRUCTION_MC:int = 0;
		public static const NORMAL_MC:int = 1;
		public static const FLIPPED_MC:int = 2;
		public static const DROPPING_MC:int = 3;

		public var centerX:Number;
		public var centerY:Number;		
		
		private var isMouseOver:Boolean = false;
		
		public function BuildingItem(model:Building)
		{
			_model = model;
			
			//setup the layers
			_mainDisplay = new MovieClip();
			_swfName = _model.mcClass;			
			_base = new Sprite();
			_buildingGraphics = new Sprite();
			_distractor = new LoadingImage();
			_mainDisplay.addChild(_base);	
			_mainDisplay.addChild(_distractor);
			_mainDisplay.addChild(_buildingGraphics);
			//mainDisplay.addChild(_buildingMC);
			if(_model.category != Building.TILES && _model.buildTime != 0){
				_progressBarComponent = new ProgressBarComponent(new SkinBuildingBar, new GaugeBuildingBar, new MaskBuildingBar);
				_progressBarComponent.textDisplayer = new TimeDisplayer();
				Logger.print(this,"Time: " + _model.buildTime);
				_progressBarComponent.setCurrentValue(_model.buildTime);
				_mainDisplay.addChild(_progressBarComponent.displayObject);
				_progressBarComponent.displayObject.x = -50;
				_progressBarComponent.displayObject.y = -60;
			}
				
			if(_model.flipped){
				var temp:int = cols;
				cols = rows;
				rows = temp;
			}
			
			addEventListeners();
		}
		
		public function get bitmapContainer():Bitmap{
			return _bitmapContainer;
		}
		
		public function get model():IDBModel{
			return _model;
		}
		
		public function set row(val:int):void{
			_model.row = val;
		}
		
		public function get row():int{
			return _model.row;
		}
		
		public function set rows(val:int):void{
			_model.rows = val;
		}
		
		public function get rows():int{
			return _model.rows;
		}
		
		public function set col(val:int):void{
			_model.col = val;
		}
		
		public function get col():int{
			return _model.col;
		}
		
		public function set cols(val:int):void{
			_model.cols = val;
		}
		
		public function get cols():int{
			return _model.cols;
		}
		
		public function get displayObject():DisplayObjectContainer{
			return _mainDisplay;
		}
		
		public function get sellPrice():int{
			return _model.sellPrice;
		}
		
		public function get coinPrice():int{
			return _model.buyCoinPrice;
		}
		/**
		 * Attempts to look for a vector cache, if non is found tries to load it
		 */
		public function initOnWorld():void{
			_currentVectorCache = BitmapAnimationManager.instance.getVectorCache(_swfName, NORMAL_MC);
			if(!_currentVectorCache){
				TEngine.resourceManager.load(getSwfURL(), SWFResource, onSwfLoaded, onSwfFailed);
			}else{
				displayObject.removeChild(_distractor);				
				_bitmapContainer = new Bitmap(_currentVectorCache.getSourceFrames()[0] as BitmapData);
				_buildingGraphics.addChild(_bitmapContainer);
				
				flipped = _model.flipped;
			}
		}
		
		public function update(elapsedTime:Number):void{
			if(_currentVectorCache){
				_bitmapContainer.bitmapData = _currentVectorCache.getSourceFrames()[_currentFrame] as BitmapData;
				_bitmapContainer.x = -_currentVectorCache.center.x;
				_bitmapContainer.y = -_currentVectorCache.center.y;
				_currentFrame++;
				if(_currentFrame >= _currentVectorCache.getSourceFrames().length){
					if(_animationState == DROPPING_MC){
						setMCToFrame(UNDERCONSTRUCTION_MC);
					}
					_currentFrame = 0;
				}
				testForMouseOver();
				testForMouseOut();
			}
		}
		
		public function get rotation():int{
			return (flipped) ? 1 : 0;
		}
		
		public function set flipped(val:Boolean):void{
			if(val != _model.flipped){
				var temp:int = cols;
				cols = rows;
				rows = temp;
			}
			
			_model.flipped = val;
			
			if(_model.flipped)
				setMCToFrame(FLIPPED_MC);
			else
				setMCToFrame(NORMAL_MC);
			reconstructGrid(0x00cc00);
		}
		
		public function get flipped():Boolean{
			return _model.flipped;
		}
		
		public function get worldId():int{
			return _model.ranchId;
		}
		
		public function set worldId(val:int):void{
			_model.ranchId = val;
		}
		
		public function get typeId():int{
			return _model.id;
		}
		
		public function set world(isoWorld:RanchController):void{
			_ranchControl = isoWorld;
			reconstructGrid(0x00cc00);
		}
		
		public function get world():RanchController{
			return _ranchControl;
		}
		
		public function reconstructGrid(color:uint):void{
			if(!_ranchControl){
				return;
			}
			
			var east:Coordinate = _ranchControl.mapToScreen(0, 0, -_ranchControl.tileHeight * rows);
			var south:Coordinate = _ranchControl.mapToScreen(_ranchControl.tileWidth * cols, 0, -_ranchControl.tileHeight * rows);
			var north:Coordinate = _ranchControl.mapToScreen(0, 0, 0);
			var west:Coordinate = _ranchControl.mapToScreen(_ranchControl.tileWidth * cols, 0, 0);
			
			with(_base){
				graphics.clear();
				graphics.beginFill(color);							
				graphics.lineTo(north.x, north.y);
				graphics.lineTo(east.x, east.y);
				graphics.lineTo(south.x, south.y);
				graphics.lineTo(west.x, west.y);
				graphics.endFill();
			}
			
			var _center:Coordinate = _ranchControl.mapToScreen((_ranchControl.tileWidth * (cols/2)), 0, -(_ranchControl.tileHeight * (rows/2)));
			
			setCenterPoint(_center.x, _center.y - 40);
		}
		
		public function setCenterPoint(X:Number, Y:Number):void{
			centerX = X;
			centerY = Y;
		}
		
		public function set state(str:String):void{
			_model.state = str;
			
			switch(_model.state){
				case Building.UNDER_CONSTRUCTION:
					setMCToFrame(DROPPING_MC);					
					TweenLite.to(this, 5, {onComplete: function():void{
						state = Building.FUNCTIONAL;
					}}); 
					break;
				case Building.NON_BOUGHT:
					break;
				case Building.FUNCTIONAL:
					if(flipped){
						setMCToFrame(FLIPPED_MC);						
					}else{
						setMCToFrame(NORMAL_MC);						
					}
					break;
				case Building.REDECORATING:
					break;
			}
		}
		
		public function get state():String{
			return _model.state;
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
		
		private function testForMouseOver():void{
			if(_model.state != Building.NON_BOUGHT){
				//displayObject.alpha = 0;
				if(bitmapContainer.bitmapData.hitTest(new Point(0,0), 0, new Point(bitmapContainer.mouseX, bitmapContainer.mouseY))){
					isMouseOver = true;
					TweenMax.to(displayObject, .5, {glowFilter:{color:0xffff33, alpha:1, blurX:3, blurY:3, strength:10}});
				}
			}
		}
		
		private function testForMouseOut():void{
			if(isMouseOver){
				if(!bitmapContainer.bitmapData.hitTest(new Point(0,0), 0, new Point(bitmapContainer.mouseX, bitmapContainer.mouseY))){
					if(_model.state != Building.NON_BOUGHT){
						TweenMax.to(displayObject, .5, {glowFilter:{color:0x00cc00, alpha:0, blurX:3, blurY:3, strength:0}});
					}
					isMouseOver = false;
				}
			}
		}
		
		private function onMouseClick(evt:MouseEvent):void{
			Logger.print(this, "Clicked me");
			if(!bitmapContainer.bitmapData.hitTest(new Point(0,0), 0, new Point(bitmapContainer.mouseX, bitmapContainer.mouseY))){
				return;
			}
			
			if(_ranchControl && _ranchControl.state == RanchController.REDECORATE){
				if(_model.state == null){
					return;
				}
				if(_model.state != Building.NON_BOUGHT && _model.state != Building.REDECORATING){
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
					TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.ROTATE, this));									
					break;
				case BuildingManagementPopup.SELL:
					TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.SELL, this));
					break;
				case BuildingManagementPopup.STORAGE:
					TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.STORAGE, this));
					break;
				case BuildingManagementPopup.MOVE:
					saveState();
					TEngine.mainClass.dispatchEvent(new RedecorateEvent(RedecorateEvent.MOVE, this));
					break;
				
			}
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
			_animationState = frame;
			
			var tempVectorCache:SwfVectorCache = BitmapAnimationManager.instance.getVectorCache(_swfName, frame);
			if(tempVectorCache){
				_currentVectorCache = tempVectorCache;
			}			
			_bitmapContainer.bitmapData = (_currentVectorCache.getSourceFrames()[0]) as BitmapData;
			_bitmapContainer.x = -_currentVectorCache.center.x;
			_bitmapContainer.y = -_currentVectorCache.center.y;
			_currentFrame = 0;
			/*if(_buildingMC){
				try{
					(_buildingMC as _type).state.gotoAndStop(frame);
				}catch(error:Error){
					Logger.error(this, "setMCToFrame", "BuildingMC " + this._className + error.message);
				}
			}*/										
		}
		
		private function onSwfLoaded(res:SWFResource):void{
			BitmapAnimationManager.instance.addToVectorCache(_swfName, res);
			initOnWorld();
		}
		
		private function addEventListeners():void{
			//displayObject.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//displayObject.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			displayObject.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function removeEventListeners():void{
			//displayObject.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//displayObject.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			displayObject.removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onSwfFailed(res:SWFResource):void{
			Logger.error(this, "onSwfFailed", "Failed to load " + res.filename);
		}				
		
		private function getSwfURL():String{			
			return "./assets/swf/"+_swfName+".swf";
		}
		private var _buildingGraphics:Sprite;
		
		private var _progressBarComponent:ProgressBarComponent;
		/**
		 * The display object where all the layers (base, building, possibly the status bar) are added
		 */
		private var _mainDisplay:MovieClip; 
		/**
		 * Reference to the ranch
		 */
		private var _ranchControl:RanchController; 
		/** Used to show whether you can build on current location or not
		 */
		private var _isValid:Boolean;
		/**
		 * Store original col, row and flipped
		 */
		private var _prevCol:int;
		private var _prevRow:int;
		private var _prevFlipped:Boolean;
		/**
		 * The colored grid beneath all buildings
		 */		
		private var _base:Sprite;
		/**
		 * The loading distractor. Removed when the vectorcache is loaded
		 */
		private var _distractor:MovieClip;
		/**
		 * The name of the swf file
		 */
		private var _swfName:String;
		/**
		 * The current active vector cache
		 */
		private var _currentVectorCache:SwfVectorCache;
		/**
		 * Current frame of the current animation
		 */
		private var _currentFrame:int = 0;
		/**
		 * The data model of this building
		 */
		private var _model:Building;		
		/**
		 * The bitmap where the bitmapdata from the vector cache is drawn
		 */
		private var _bitmapContainer:Bitmap;
		/**
		 * The current animation state
		 */
		private var _animationState:int;
	}
}