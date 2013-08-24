package com.tada.clopclop.world
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.common.assets.HorseHolderModel;
	import com.tada.clopclop.common.assets.I3DAsset;
	import com.tada.clopclop.common.assets.JockeyHolderModel;
	import com.tada.clopclop.events.HorseWorldEvent;
	import com.tada.clopclop.popups.HorseManagementPopup;
	import com.tada.clopclop.popups.PopupManager;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Iso3DItem implements IsoItem
	{
		private var _3dHolder:I3DAsset;
		
		private var _type:String;
		
		private var _horseManagementPopup:HorseManagementPopup;
		
		private var _popupIsShown:int = 0;
		
		private var _mainDisplay:MovieClip;
		
		private var _col:int;
		private var _row:int;
		private var _cols:int;
		private var _rows:int;
		
		public function Iso3DItem(type:String, col:int, row:int, cols:int, rows:int){
			_col = col;
			_row = row;
			_cols = cols;
			_rows = rows;
			
			_mainDisplay = new MovieClip();
			_type = type;
			if(type == "Jockey"){
				_3dHolder = new JockeyHolderModel();
			}else{
				_3dHolder = new HorseHolderModel();
				//(_3dHolder as HorseHolderModel).addEventListener(MouseEvent3D.MOUSE_UP, onMouseClick);
			}
			_mainDisplay.addChild(_3dHolder as View3D);			
			_mainDisplay.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_horseManagementPopup = new HorseManagementPopup();
		}
		
		/*---------------------------------------------------------------------- */
		/* 				IMPLEMENTATIONS FOR ISOITEM
		/*----------------------------------------------------------------------*/
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
		
		public function set visibleBase(val:Boolean):void{
			//TODO: Implementation for showing my base
		}
		
		public function get visibleBase():Boolean{
			//TODO: Implementation for showing my base
			return false;
		}
		
		public function get displayObject():DisplayObjectContainer{
			return _mainDisplay;
		}
		
		
		private function onMouseClick(evt:Event):void{
			if(_type=="Jockey"){
				
			}else{
				//TEngine.mainClass.dispatchEvent(new HorseWorldEvent(HorseWorldEvent.HORSE_CLICKED));
				PopupManager.instance.showPopup(displayObject, PopupManager.HORSE, onHorseManagement);
				//TEngine.mainStage.addEventListener(MouseEvent.MOUSE_UP, onStageClicked);
				Logger.print(this, "Hello logger! " + evt.target + " " + _popupIsShown);				
			}
		}
		
		private function onStageClicked(evt:MouseEvent):void{
			if(_popupIsShown > 0){
				Logger.print(this, "Stage Was Clicked " + evt.target);
				
				//TEngine.mainStage.removeEventListener(MouseEvent.MOUSE_UP, onStageClicked);				
				PopupManager.instance.hide();
				_popupIsShown = 0;
			}
			_popupIsShown++;			
		}
		
		private function onHorseManagement(result:String):void{
			Logger.print(this, "Horse Management Clicked");
			TEngine.mainClass.dispatchEvent(new HorseWorldEvent(HorseWorldEvent.HORSE_CLICKED));
		}
		
		public function update():void{
			try{
				_3dHolder.update();
			}catch(e:Error){
				Logger.error(this, "update", e.message);
			}
		}
	}
}