package com.tada.clopclop.toolsets.camera
{
	import com.away3d.cameras.HoverCamera3D;
	import com.away3d.cameras.lenses.AbstractLens;
	import com.away3d.cameras.lenses.PerspectiveLens;
	import com.greensock.TweenLite;
	import com.tada.clopclop.toolsets.custom.ErrorTracer;
	
	import flash.debugger.enterDebugger;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.tlf_internal;
	
	public class CameraHover extends HoverCamera3D
	{
		
		public static const CAMHOVER_DEFAULT:String = "default";
		public static const CAMHOVER_MOUSEDRIVEN:String = "mouseDriven";
		public static const CAMHOVER_YAWING:String = "yawing";
		public static const RACING_CRANE:String = "crane";
		public static const RACING_JIGGLE:String = "jiggle";
		
		private var _move:Boolean;
		private var _lastX:Number;
		private var _lastY:Number;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _mouseSpeed:Number = 0.5;
		private var _isMouseMovable:Boolean = false;
		private var _stage:Stage;
		private var _debugMsg:String;
		private var _preset:String = CAMHOVER_DEFAULT;
		private var _racingPreset:String = "";
		private var _yawCtr:int = 0;
		private var _sineCtr:Number = 0;
		
		/**
		 * Author: Hedrick David
		 * 
		 * The CameraHover Class contains the settings for camera settings 
		 * and presets for the hover type of camera. The class is extended through Away3D's CameraHover3D class.  
		 * 
		 * @params1:stage - set the stage of the view for the event listeners.
		 */
		
		public function CameraHover(stage:Stage)
		{
			_stage = stage;
			addListeners();
		}
		
		/**
		 * Function to add listeners.
		 */
		
		private function addListeners():void{ 
			if (_stage != null){
				_stage .addEventListener(Event.ENTER_FRAME, onEnterFrame);
			} else ErrorTracer.traceError("TCC0010");
		}
		
		/**
		 * onEnterFrame listener event.
		 */
		
		private function onEnterFrame(evt:Event):void{
			if (_move && _isMouseMovable){
				tiltAngle = _lastTiltAngle + (_stage.mouseY - _lastY) * _mouseSpeed ;
				panAngle = _lastPanAngle + (_stage.mouseX - _lastX) * _mouseSpeed;
			}
			
			if (_preset == CAMHOVER_YAWING){
				yaw(_yawCtr);
				_yawCtr++;
			}
			//if (_preset == CAMHOVER_DEFAULT){
			//panAngle -= 1;
			//}
			hover();
		}
		
		/**
		 * Setter function that sets the speed with which the
		 * movement affects the camera.
		 * 
		 * @params1:speed - the amount of movement with mouse activity.
		 */
		
		public function set mouseSpeed(speed:Number):void{
			_mouseSpeed = speed;
		}
		
		/**
		 * Sets the type of camera hover preset.
		 * 
		 * @params1:speed - the amount of movement with mouse dragging activity.
		 */
		
		public function setCameraPreset(camPreset:String):void{
			switch (camPreset){
				case CAMHOVER_DEFAULT:
					setAsDefaultHover();
					break;
				case CAMHOVER_MOUSEDRIVEN:
					setAsMouseHover();
					break;
				case CAMHOVER_YAWING:
					setAsYawing();
					break;
			}
		}
		
		/**
		 * Sets the camera yawing.
		 */
		
		private function setAsYawing():void{
			_preset = CAMHOVER_YAWING;
			setBasicCameraSettings();
		}
		
		/**
		 * Sets the racing camera preset.
		 * 
		 */
		
		public function setRacingPreset(preset:String, duration:Number, params:Object = null):void{
			var sPos:Number = params.sPos;
			var ePos:Number = params.ePos;
			
			switch (preset){
				case RACING_CRANE:
					_racingPreset = RACING_CRANE;
					moveDown(sPos);
					TweenLite.to(this, duration, {y:ePos}); 
					break;
				case RACING_JIGGLE:
					_racingPreset = RACING_JIGGLE;
					addEventListener(Event.ENTER_FRAME, onJiggle);
					break;
			}
		}
		
		private function onJiggle ():void{
			if (_racingPreset == RACING_JIGGLE){
				y = Math.sin(_sineCtr);
				_sineCtr = _sineCtr++ % 360;
			} else {
				removeEventListener(Event.ENTER_FRAME, onJiggle);
			}
		}
		
		/**
		 * Sets the camera to a mouse hover. Enables camera movement,
		 * which is centered on the target object through mouse dragging activity.
		 */
		
		private function setAsMouseHover ():void{
			_preset = CAMHOVER_MOUSEDRIVEN;
			_debugMsg = "setAsMouseHover: true";
			_isMouseMovable = true;
			if (_stage !=null){
				_lastX = _stage.mouseX;
				_lastY = _stage.mouseY;
				_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_debugMsg = "stage not null: true";
			} else ErrorTracer.traceError("TCC0010");
			
			setBasicCameraSettings();
		}
		
		private function setBasicCameraSettings():void{
			zoom = 5;
			focus = 100;
			lens = new PerspectiveLens();
			fov = 45;
			distance = 10000;
			panAngle = -45;
			tiltAngle = 0;
			minTiltAngle = -10;
			hover(true);
		}
		
		/**
		 * Mouse down event activity
		 */
		
		private function onMouseDown (evt:MouseEvent):void{
			if (_isMouseMovable = true){
				_lastPanAngle = panAngle;
				_lastTiltAngle = tiltAngle;
				_lastX = _stage.mouseX;
				_lastY = _stage.mouseY;
				_move = true;
				_debugMsg = "_move: "+_move;
			}
		}
		
		/**
		 * Mouse up event activity
		 */
		
		private function onMouseUp (evt:MouseEvent):void{
			if (_isMouseMovable = true){
				_move = false;
				_debugMsg = "_move: "+_move;
			}
		}
		
		/**
		 * Function for the defult hover preset.
		 */
		
		private function setAsDefaultHover ():void{
			_preset = CAMHOVER_DEFAULT;
			setBasicCameraSettings();
			tiltAngle = 10;
			panAngle = -145;
			hover(true);
			_isMouseMovable = false;
			_debugMsg = "_isMouseMovable: "+_isMouseMovable;
		}
		
		/**
		 * Getter for the debug msg.
		 */
		
		public function get debugMsg():String{
			return _debugMsg;
		}		
		
	}
}