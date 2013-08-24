package com.tada.clopclop.toolsets.character.horse
{
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.containers.View3D;
	import com.away3d.core.base.Object3D;
	import com.away3d.primitives.Plane;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.horse.sets.equipment.HorseAccessorySet;
	import com.tada.clopclop.toolsets.character.horse.sets.equipment.HorseHeadSet;
	import com.tada.clopclop.toolsets.character.horse.sets.equipment.HorseWingSet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseBodySet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseEyeSet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseHairSet;
	import com.tada.clopclop.toolsets.character.horse.sets.main.HorseMouthSet;
	import com.tada.clopclop.toolsets.custom.ErrorTracer;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	/**
	 * Author: Hedrick David
	 * 
	 * The HorseAsset class is used to easily instantiate a horse asset 
	 * with all its corresponding part meshes, textures and animation.
	 */
	
	public class HorseAsset extends Object3D
	{

		private var _body:HorseBodySet;
		private var _hair:HorseHairSet;
		private var _mouth:HorseMouthSet;
		private var _eye:HorseEyeSet;
		private var _setArray:Array = [];
		
		private var _wing:HorseWingSet;
		private var _accessory:HorseAccessorySet;
		private var _head:HorseHeadSet;
		
		private var _view:View3D;
		private var _animation:HorseAnimation;
		
		private var _shadowPlane:Plane;
		private var _vector:Vector3D;
		
		private var _appearanceSetXML:XML;
		private var _appearanceSetRequest:URLRequest;
		private var _appearanceSetLoader:URLLoader;
		private var _appearanceSetMeshList:XMLList;
		private var _appearanceSetTextureList:XMLList;
		private var _canRotate:Boolean;
		
		private var _textureSetArray:Array = [];
		private var _meshSetArray:Array = [];
		
		private var _isMotionAI:Boolean = false;
		private var _timer:Timer;
		private var _syncTimer:Timer;
		private var _changeMotion:Boolean = false;
		
		private var _temp:Number;
		private var _timerRand:Number;
		private var _executeMotion:Boolean = false;
		private var _delayAdj:Number;
		private var _animType:int;
		private var _meshContainer:ObjectContainer3D;
		private var _hasExecutedArray:Array = [false, false, false, false, false, false, false, false, false];
		private var _meshListArray:Array = [];
		private var _tempCtr:int = 0;
		private var _instanceID:int = -1;
		private var _horseGR:HorseGR = HorseGR.getInstance();
		private var _jobQueue:Vector.<String> = new Vector.<String>; 
		
		private var _runSyncTimer:Boolean = false;
		private var _canSync:Boolean = false;
		private var _syncDuration:Number = 10000;
		
		public function HorseAsset(view:View3D)
		{ 
			_instanceID = _horseGR.registerInstance(_instanceID);
			_view = view;
			_horseGR.initAnimXML();
			initXML();
			initSets();
			initAnimation();
			initShadow();
			addListeners();			
		}				
		
		/**
		 * Initializes the main character sets that is required for the
		 * main parts of the character.
		 */
		
		private function initSets ():void{
			_meshContainer = new ObjectContainer3D();
			_view.scene.addChild(_meshContainer);
			_body = new HorseBodySet(_instanceID, _meshContainer);
			_hair = new HorseHairSet(_instanceID, _meshContainer);
			_mouth = new HorseMouthSet (_instanceID, _meshContainer);
			_eye = new HorseEyeSet (_instanceID, _meshContainer);
			
			_setArray[HorseGR.BODY_SET] = _body;
			_setArray[HorseGR.HAIR_SET] = _hair;
			_setArray[HorseGR.MOUTH_SET] = _mouth;
			_setArray[HorseGR.EYE_SET] = _eye;
			_setArray[HorseGR.WING_SET] = null;
			_setArray[HorseGR.HEAD_SET] = null;
			_setArray[HorseGR.ACC_SET] = null;
			
			for (var a:int = 0; a<_setArray.length; a++){
				if (_setArray[a] != null){
					_setArray[a].setInitialIndexes();
				}
			}
		}
		
		/**
		 * Initialize the simple shadow of the character.
		 */
		
		private function initShadow ():void{
			_shadowPlane = new Plane();
			_shadowPlane.scale(25);			
			_shadowPlane = HorseGR.getInstance().getShadow();
			_meshContainer.addChild(_shadowPlane);
		}
		
		/**
		 * Returns the mesh container that contains all the mesh.
		 */
		
		public function get mesh ():ObjectContainer3D{
			return _meshContainer;
		}
		
		/**
		 * Sets the AI of the character. Use the AI constants in this class.
		 * 
		 * @params:aIType - set the type of AI;
		 */
		
		public function setAI(aIType:int = -1):void{
			switch (aIType){
				case HorseGR.AI_MOTION: 
					_isMotionAI = true;
					_changeMotion = true;
					break;
				case HorseGR.AI_OFF:
					changeAnimationByType(_animation.animationIndex);
					setAllAIOff();
					break;
			}
		}
		
		/**
		 * Timer function
		 * 
		 * @params1:duration - set the amount of delay in milliseconds.
		 */
		
		private function timer(duration:Number):void{
			_changeMotion = false;
			_timer = new Timer(duration,1);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		
		/**
		 * TimerEvent function when set time has been completed
		 */
		
		private function onTimerComplete(evt:TimerEvent):void{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_changeMotion = true;
		}
		
		/**
		 * Enables the periodic synching timer of the animation based on the duration set.
		 * 
		 * @params1:duration - the duration of synching in "seconds".
		 */
		
		public function addPeriodicAnimationSync (duration:Number):void{
			_syncDuration = duration * 1000;
			_runSyncTimer = true;
			_canSync = true;
		}
		
		/**
		 * Disables the periodic synching timer of the animation.
		 */ 
		
		public function removePeriodicAnimationSync ():void{
			_runSyncTimer = false;
			_canSync = false;
		}
		
		/**
		 * Timer function for synching animation
		 * 
		 * @params1:duration - set the amount of delay in milliseconds.
		 */
		
		private function syncTimer(duration:Number):void{
			_canSync = false;
			_timer = new Timer(duration,1);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onSyncTimerComplete);
		}
		
		/**
		 * TimerEvent function when set time has been completed
		 */
		
		private function onSyncTimerComplete(evt:TimerEvent):void{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_animation.sync();
			_canSync = true;	
		}
		
		/**
		 * Sets all type of AI to false.
		 */
		
		private function setAllAIOff():void{
			_isMotionAI = false;
		}
		
		/**
		 * Set the random normal character animation when timer is true.
		 */
		
		private function setMotionAI():void{
			if (_changeMotion == true){
				_timerRand = int (7000 + 7000 * Math.random());
				timer(_timerRand);
				do {
					var random:Number = int (Math.random() * 4.9);
				} while (random == _temp);
				_temp = random;
				switch (random){
					case 0:
						_delayAdj = 0;
						_animType = HorseGR.ANIM_WALK;
						_executeMotion = true;
						break;
					case 1:
						_delayAdj = 0;
						_animType = HorseGR.ANIM_IDLE01;
						_executeMotion = true;
						break;
					case 2:
						_delayAdj = 0;
						_animType = HorseGR.ANIM_IDLE02;
						_executeMotion = true;
						break;
					case 3:
						_delayAdj = .7;
						_animType = HorseGR.ANIM_PLEASANT;
						_executeMotion = true;	
						break;
					case 4:
						_delayAdj = .4;
						_animType = HorseGR.ANIM_DANCE;
						_executeMotion = true;		
						break;
				}
			}
		}
		
		/**
		 * Checks for the current frame of the animation if its in the last frame of a specific cycle
		 * and plays the animation when the currently played cycle has ended.
		 * 
		 * @params1:delayAdj - the amount of delay to be deducted in the timer. Useful for animations
		 * that does not need to be looped exessively.
		 * @params2:animationType - the animation to played. Use the animation constants.
		 */
		
		private function checkAndExecuteAnimLoopInAI(delayAdj:Number, animationType:int):void{
			if (_animation.currFrame == _animation.animMaxArray[_animation.animationIndex]-2){
				changeAnimationByType(animationType);
				_timer.delay -= _timerRand * delayAdj;
				_executeMotion = false;
			}
		}
		
		/**
		 * Initializes the loader for the XML of the appearance set.
		 */
		
		private function initXML():void{
			_appearanceSetRequest = new URLRequest("xml/horse/TCC_Horse_AppearanceSet.xml");
			_appearanceSetLoader = new URLLoader();
			_appearanceSetLoader.load(_appearanceSetRequest);
			initAppearanceSetlisteners(_appearanceSetLoader);
		}
		
		/**
		 * Initializes the listeners for the XML
		 */
		
		private function initAppearanceSetlisteners(evt:IEventDispatcher):void{
			_appearanceSetLoader.addEventListener(Event.COMPLETE, onLoaderComplete);
			_appearanceSetLoader.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			_appearanceSetLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
		}
		
		/**
		 * Gets the loaded data when loader completes
		 */
		
		private function onLoaderComplete(evt:Event):void{
			_appearanceSetLoader.removeEventListener(Event.COMPLETE, onLoaderComplete);
			_appearanceSetLoader.removeEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			_appearanceSetXML = new XML(evt.target.data);
		}
		
		/**
		 * Event function when loading progress of the XML
		 */
		
		private function onLoaderProgress(evt:ProgressEvent):void{
			//trace ("BytesLoaded: "+evt.bytesLoaded + "/" + evt.bytesTotal + "BytesTotal");
		}
		
		/**
		 * Event function to trace error when loading XML
		 */
		
		private function onLoaderError (evt:IOErrorEvent):void{
			trace ("Error loading xml: " + evt);
		}
		
		/**
		 * Initializes the animation of the
		 * main parts of the character.
		 */
		
		private function initAnimation ():void{
			_animation = new HorseAnimation(_view);
			for (var set:int = 0; set<_setArray.length; set++){
				_animation.addSet(_setArray[set]);
			}
			_animation.playAnimation();
			_animation.setFPS(24);
		}
		
		/**
		 * Function to add equipment parts to the body.
		 * For example the wings, head, etc.
		 * 
		 * @params1:partType - the part type to be added. Use the 
		 * constants in this class ex) WING_SET
		 */
		
		public function addEquipment(partType:int):void{
			switch (partType){
				case HorseGR.WING_SET:
					if (_setArray[HorseGR.WING_SET] == null){
						_wing = new HorseWingSet(_instanceID, _meshContainer);
						_setArray[HorseGR.WING_SET] = _wing;
						_animation.addSet(_wing);
						changeAnimationByType(_animation.animationIndex);
						_wing.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
					}
					break;
				case HorseGR.ACC_SET:
					if (_setArray[HorseGR.ACC_SET] == null){
						_accessory = new HorseAccessorySet(_instanceID, _meshContainer);
						_setArray[HorseGR.ACC_SET] = _accessory;
						_animation.addSet(_accessory);
						changeAnimationByType(_animation.animationIndex);
						_accessory.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
					}
					break;
				case HorseGR.HEAD_SET:
					if (_setArray[HorseGR.HEAD_SET] == null){
						_head = new HorseHeadSet(_instanceID, _meshContainer);
						_setArray[HorseGR.HEAD_SET] = _head;
						_animation.addSet(_head);
						changeAnimationByType(_animation.animationIndex);
						_head.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
					}
					break;
			}
		}		
		
		/**
		 * Function to remove equipment parts to the body.
		 * For example the wings, head, etc.
		 * 
		 * @params1:partType - the part type to be removed. Use the 
		 * constants in this class ex) WING_SET
		 */
		
		public function removeEquipment(partType:int):void{
			if (_setArray[partType] != null){
				if (partType < 4 || partType >7){
					ErrorTracer.traceError("TCC0003");
				} else {
					_setArray[partType].visible(false);
					_animation.removeSet(partType);
					_setArray[partType].removeEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
				}
			}
		}
		
		/**
		 * Reset to default appearance. Use only
		 * when the mesh has been loaded.
		 */
		
		public function resetSettings():void{
			for (var set:int = 0; set<_setArray.length; set++){
				if (_setArray[set] != null){
					_setArray[set].setInitialIndexes();
					_setArray[set].changeTexture(0);	
					if (set >= HorseGR.WING_SET && set <= HorseGR.ACC_SET){
						setSpecificEquipmentVisibility(set, false);
					}
				}
			}
			_setArray[HorseGR.BODY_SET].changeDecals(HorseGR.DECBODY_OFF);
			_setArray[HorseGR.BODY_SET].changeSaddleTexture(HorseGR.TEXSADDLE_OFF);
			_setArray[HorseGR.BODY_SET].changeBridleTexture(HorseGR.TEXBRIDLE_OFF);
			_animation.playAnimationCycle(0);
			setAI();
		}
		
		/**
		 * Adds listeners. 
		 */
		
		private function addListeners():void{		
			addEventListener(Event.ENTER_FRAME, onEnterFrame);		
			_body.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_hair.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_mouth.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_eye.addEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
		}
		
		/**
		 * Removes listeners. 
		 */
		
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);	
			for (var a:int = 0; a<_setArray.length; a++){
				if (_setArray[a] != null){
					_setArray[a].removeEventListener(HorseEvent.MESH_LOADED_ANIM, onMeshLoaded);
				}
			}
			
		}
		
		/**
		 * Calls the sync function whenever a mesh part finishes loading. 
		 */
		
		private function onMeshLoaded(evt:HorseEvent):void{
			_animation.sync();
		}
		
		/**
		 * Parses the XML and returns the array based from the given set and type of 
		 * information to be returned.
		 * 
		 * @params1:setType - The type of set, not the part of the body. Use the constants
		 * in this class ex) SET_ZEBRA, SET_DEFAULT, etc
		 * @params2:returnType - The type of information to be returned. Use the constants 
		 * in this class ex) XML_MESH or XML_TEXTURE.
		 */
		
		private function parseXMLSet (setType:int,returnType:String):Array{
			var xmlList:XMLList = new XMLList (_appearanceSetXML.horse.children());
			var arr:Array = []; 
			
			if (returnType == HorseGR.XML_MESH){
				for each (var set:XML in xmlList){
					if (set.attribute("id") == setType){
						for each (var part:XML in set.mesh.children()){
							arr.push(Number(part.text()));
						}
					}
				}
			}
			
			if (returnType == HorseGR.XML_TEXTURE){
				for each (set in xmlList){
					if (set.attribute("id") == setType){
						for each (part in set.texture.children()){
							arr.push(Number(part.text()));
						}
					}
				}
			}
			return arr;
		}
		
		/**
		 * Getter and setter functions that sets the animation variable to invoke standard
		 * playback functions.
		 */
		
		public function get animation():HorseAnimation{
			return _animation;
		}
		
		/**
		 * Sets the animation by the type set. Use the animation constant
		 * for reference on the animation types.
		 * 
		 * @param1:animation - animation.
		 */
		
		public function changeAnimationByType(animation:int):void{
			_animation.playAnimationCycle(animation);
		}
		
		/**
		 * Returns the animation index. Useful to determine the 
		 * type of animation being played, say for example a walk,
		 * so that the corresponding rotation and potion could be controlled.
		 * 
		 * @return - animation index being played. ex. horse walk
		 */
		
		public function get animationIndex ():int{
			return _animation.animationIndex;
		}
		
		/**
		 * Setter and getter function for the character shadow.
		 */
		
		public function set shadow (visibility:Boolean):void {
			_shadowPlane.visible = visibility;
		}
		
		public function get shadow ():Boolean {
			return _shadowPlane.visible;
		}
		
		/**
		 * Sets the frame per second playback of the character sets
		 * 
		 * @param1:fps - the fps at which the mesh will play. Deafault is 24.
		 */
		
		public function changeFPS(fps:Number = 24):void{
			_animation.setFPS(fps);
		}
		
		/**
		 * Sets the animation to the next animation cycle in the timeline.
		 */
		
		public function nextAnimationCycle():void{
			if (_animation.animationIndex < _animation.animLength){
				_animation.playAnimationCycle(_animation.animationIndex+1);
			} else {
				_animation.playAnimationCycle(0);
			}
		}
		
		/**
		 * Sets the animation to the previous animation cycle in the timeline.
		 */
		
		public function previousAnimationCycle():void{
			if (_animation.animationIndex > 0){
				_animation.playAnimationCycle(_animation.animationIndex-1);
			} else {
				_animation.playAnimationCycle(_animation.animLength-1);
			}
		}
		
		/**
		 * Event listener function for asset locations.
		 */
		
		private function onAssetLocsLoaded (evt:HorseEvent):void{
			_horseGR.removeOnXMLLoaded(onAssetLocsLoaded);
			for (var queue:int; queue<_jobQueue.length; queue++){
				var jobType:int = _jobQueue[queue].split(":")[0];
				var partType:int = _jobQueue[queue].split(":")[1];
				var index:int = _jobQueue[queue].split(":")[2];
				if (evt.params.partType == partType){
					switch (jobType){
						case HorseGR.QUEUE_MESH:
							changeMeshByType(partType, index);
							break;
						case HorseGR.QUEUE_DECAL:
							changeDecalsByType(partType, index);
							break;
						case HorseGR.QUEUE_TEX:
							changeTextureByPart(partType, index);
							break;
					}
				}
			}
		}
		
		/**
		 * Sets the texture of the specific character set with the corresponding decal type.
		 * 
		 * @params1:partType - set the character set type. 
		 * @params2:decalType - set the decal type. 
		 */
		
		public function changeDecalsByType(partType:int, decalType:int):void{
			if (_setArray[partType].assetLoaded == true){
				_setArray[partType].changeDecals(decalType);
			} else {
				_setArray[partType].decalIndex = decalType;
			}
		}
		
		/**
		 * Changes the texture by set of the character.
		 * 
		 * @params1:setType - The set to be adopted.
		 */
		
		public function changeTextureBySet(setType:int):void{
			var textureArr:Array = parseXMLSet(setType,HorseGR.XML_TEXTURE);
			_setArray[HorseGR.BODY_SET].setInitialIndexes();
			for (var part:int = 0;part<4;part++){
				if (_setArray[part].assetLoaded == true){
					changeTextureByPart(part,textureArr[part]);
				} else {
					_setArray[part].textureIndex = textureArr[part];
				}
			}
		}
		
		/**
		 * Sets the texture of the specific character set with the corresponding texture type.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 * @params2:textureType - set the texture type. Use the specific character set constant.
		 * Ex) BodySet.TEXBODY_DEFAULT, EyeSet.TEXEYE_DEFAULT, etc.
		 * For the saddle and the bridle, set the textureType to a corresponding constant value of -1.
		 */
		
		public function changeTextureByPart (partType:int, textureType:int):void{
			if (partType < 7 && partType >-1){
				if (_setArray[partType].assetLoaded == true){
					_setArray[partType].changeTexture(textureType);
				} else {
					_setArray[partType].textureIndex = textureType;
				}
			} else if (partType == HorseGR.SADDLE_SET){
				if (_setArray[HorseGR.BODY_SET].assetLoaded == true){ 
					_setArray[HorseGR.BODY_SET].changeSaddleTexture(textureType);
				} else {
					_setArray[HorseGR.BODY_SET].saddleIndex = textureType;
				}
			} else if (partType == HorseGR.BRIDLE_SET){
				if (_setArray[HorseGR.BODY_SET].assetLoaded == true){
					_setArray[HorseGR.BODY_SET].changeBridleTexture(textureType);
				} else {
					_setArray[HorseGR.BODY_SET].bridleIndex = textureType;
				}
			}
		}
		
		/**
		 * Sets the next texture based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changeNextTexture (partType:int):void{
			if (_setArray[partType] != null && partType != HorseGR.SADDLE_SET && partType != HorseGR.BRIDLE_SET){
				if (_setArray[partType].textureIndex < _setArray[partType].texLength -1){
					_setArray[partType].changeTexture(_setArray[partType].textureIndex + 1);
				} else {
					_setArray[partType].changeTexture(0);
				}
			} else if (partType == HorseGR.SADDLE_SET){
				if (_setArray[HorseGR.BODY_SET].saddleIndex < _setArray[HorseGR.BODY_SET].saddleTexLength -1){
					_setArray[HorseGR.BODY_SET].changeSaddleTexture(_setArray[HorseGR.BODY_SET].saddleIndex + 1);
				} else {
					_setArray[HorseGR.BODY_SET].changeSaddleTexture(0);
				}
			} else if (partType == HorseGR.BRIDLE_SET){
				if (_setArray[HorseGR.BODY_SET].bridleIndex < _setArray[HorseGR.BODY_SET].bridleTexLength -1){
					_setArray[HorseGR.BODY_SET].changeBridleTexture(_setArray[HorseGR.BODY_SET].bridleIndex + 1);
				} else {
					_setArray[HorseGR.BODY_SET].changeBridleTexture(0);
				}
			}
			if (partType == HorseGR.BODY_SET){
				if (_setArray[partType].decalIndex < _setArray[partType].decalTexLength -1){
					_setArray[partType].changeDecals(_setArray[partType].decalIndex + 1);
				} else {
					_setArray[partType].changeDecals(-1);
				}
			}
		}
		
		/**
		 * Sets the previous texture based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changePreviousTexture (partType:int):void{
			if (_setArray[partType] != null && partType != HorseGR.SADDLE_SET && partType != HorseGR.BRIDLE_SET){
				if (_setArray[partType].textureIndex > 0){
					_setArray[partType].changeTexture(_setArray[partType].textureIndex - 1);
				} else {
					_setArray[partType].changeTexture(_setArray[partType].texLength -1);
				}
			} else if (partType == HorseGR.SADDLE_SET){
				if (_setArray[HorseGR.BODY_SET].saddleIndex > 0){
					_setArray[HorseGR.BODY_SET].changeSaddleTexture(_setArray[HorseGR.BODY_SET].saddleIndex - 1);
				} else {
					_setArray[HorseGR.BODY_SET].changeSaddleTexture(_setArray[HorseGR.BODY_SET].saddleTexLength -1);
				}
			} else if (partType == HorseGR.BRIDLE_SET){
				if (_setArray[HorseGR.BODY_SET].bridleIndex > 0){
					_setArray[HorseGR.BODY_SET].changeBridleTexture(_setArray[HorseGR.BODY_SET].bridleIndex - 1);
				} else {
					_setArray[HorseGR.BODY_SET].changeBridleTexture(_setArray[HorseGR.BODY_SET].bridleTexLength -1);
				}
			}
			if (partType == HorseGR.BODY_SET){
				if (_setArray[partType].decalIndex > -1){
					_setArray[partType].changeDecals(_setArray[partType].decalIndex - 1);
				} else {
					_setArray[partType].changeDecals(_setArray[partType].decalTexLength -1);
				}
			}
		}
		
		
		/**
		 * Removes the specific body part from the container.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		private function removeContainerContents (partType:int):void{
			switch (partType){
				case HorseGR.BODY_SET:
					_meshContainer.removeChildByName("horseBody");
					break;
				case HorseGR.EYE_SET:
					_meshContainer.removeChildByName("horseEye");
					break;
				case HorseGR.HAIR_SET:
					_meshContainer.removeChildByName("horseHair");
					break;
				case HorseGR.MOUTH_SET:
					_meshContainer.removeChildByName("horseMouth");
					break;
				case HorseGR.ACC_SET:
					_meshContainer.removeChildByName("horseAcc");
					break;
				case HorseGR.HEAD_SET:
					_meshContainer.removeChildByName("horseHead");
					break;
				case HorseGR.WING_SET:
					_meshContainer.removeChildByName("horseWing");
					break;
			}
		}
		
		/**
		 * Sets the mesh of the specific character set with the corresponding mesh type.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 * @params2:meshType - set the mesh type. Use the specific character set constant.
		 * Ex) BodySet.MESHBODY_DEFAULT, EyeSet.MESHEYE_DEFAULT, etc.
		 */
		
		public function changeMeshByType (partType:int, meshType:int):void{
			_setArray[partType].changeMesh(meshType);
		}
		
		/**
		 * Sets the next mesh based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changeNextMesh (partType:int):void{
			if (_setArray[partType].assetLoaded == true){
				if (_setArray[partType].meshIndex < _setArray[partType].meshLength -1){
					removeContainerContents(partType);
					_setArray[partType].changeMesh(_setArray[partType].meshIndex + 1);
					_meshContainer.addChild(_setArray[partType].mesh);
				} else {
					_setArray[partType].changeMesh(0);
				}
			} else {
				_setArray[partType].meshIndex = partType;
			}
		}
		
		/**
		 * Sets the previous mesh based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changePreviousMesh (partType:int):void{
			if (_setArray[partType].assetLoaded == true){
				if (_setArray[partType].meshIndex > 0){
					removeContainerContents(partType);
					_setArray[partType].changeMesh(_setArray[partType].meshIndex - 1);
					_meshContainer.addChild(_setArray[partType].mesh);
				} else {
					_setArray[partType].changeMesh(_setArray[partType].meshLength -1);
				}
			} else {
				_setArray[partType].meshIndex = partType;
			}
		}
		
		/**
		 * Changes the mesh by set of the character.
		 * 
		 * @params1:setType - The set to be adopted
		 */
		
		public function changeMeshBySet (setType:int):void{
			for (var set:int = 0; set<4;set++){
				if (setType == set){
					for (var part:int = 0;part<4;part++){
						if (_setArray[part].assetLoaded == true){
							removeContainerContents(part);
							changeMeshByType(part,_appearanceSetXML.tada_clopclop.horse.set_default.mesh[part]);
							_meshContainer.addChild(_setArray[set].mesh);
						} else {
							_setArray[part].meshIndex = _appearanceSetXML.tada_clopclop.horse.set_default.mesh[part];
						}
					}
				}
			}
		}
		
		/**
		 * Remove decals by category
		 * 
		 * @params1:decalCategory - remove the category of decals.
		 * Use the constants in this class. Use REMOVEDECALS_ALL or just leave
		 * parameter blank to remove all category.
		 */
		
		public function removeDecal(decalCategory:int = 0):void{
			switch(decalCategory){
				case HorseGR.REMOVEDECALS_ALL:
					break;
				case HorseGR.REMOVEDECALS_PATTERNS:
					_setArray[HorseGR.BODY_SET].removeDecalPatterns();
					break;
			}
		}
		
		/**
		 * Function to remove the instances of meshes of the character sets. 
		 */
		
		public function removeAsset ():void{
			for (var set:int = 0; set<_setArray.length; set++){
				if (_setArray[set] != null){
					_setArray[set].removeMesh();
				}
			}
			_view.scene.removeChild(_shadowPlane);
			_shadowPlane = null;
			_animation = null;
			removeListeners();
		}
		
		/**
		 * Function to show/hide all equipments.
		 * @params1:visibility - The specified equipment to be shown or hidden.
		 * Only works on the characters equipments.
		 */
		
		public function setEquipmentsVisible(visibility:Boolean):void{
			for (var set:int = 4; set<7; set++){
				if (_setArray[set] != null){
					if (_setArray[set].assetLoaded == true){
						_setArray[set].visible(visibility);
					} else {
						_setArray[set].visibility = visibility;
					}
				}
			}
		}
		
		/**
		 * Function to show/hide specific equipments.
		 * 
		 * @params1:equipmentType - The specified equipment to be shown/hidden.
		 * Only works on the characters equipments.
		 * @params2:visibility - The specified equipment to be shown/hidden.
		 * Only works on the characters equipments.
		 */
		
		public function setSpecificEquipmentVisibility(equipmentType:int, visibility:Boolean):void{
			if (_setArray[equipmentType] != null){
				if (_setArray[equipmentType].assetLoaded == true){
					_setArray[equipmentType].visible(visibility);
				} else {
					_setArray[equipmentType].visibility = visibility;
				} 
			} 
		}
		
		/**
		 * Function to return the visibility status of an equipment.
		 * @params1:equipmentType - The specified equipment's visibility to be checked. 
		 * Use constants in this class.
		 */
		
		public function equipmentVisibility(equipmentType:int):Boolean{
			if (_setArray[equipmentType] != null){
				if (_setArray[equipmentType].assetLoaded == true){
					return _setArray[equipmentType].visibility;
				}
			}
			return false;
		}
		
		/**
		 * Function to check if equipment is already added. 
		 * 
		 * Returns:Boolean - True or false if the equipment exists or not. Useful for just setting the visibility of the 
		 * equipment to avoid memory leaks which happens in the removing and instatiation of meshes
		 * in away3D.
		 */
		
		public function equipmentExists (equipmentType:int):Boolean{
			if ( equipmentType > 3 || equipmentType < 7){
				if (_setArray[equipmentType] != null){
					return true;
				} else {
					return false;
				}
			}else {
				ErrorTracer.traceError("TCC0003");
				return false;
			}
		}
		
		/**
		 * Returns the array containing the sequence of mesh loaded.
		 * Used for the 3d container for determining specific items
		 * to target in the mesh.
		 */
		
		public function get meshLoadedIndex ():Array{
			return _meshListArray;
		}
		
		/**
		 * Event for the onEnterFrame event.
		 */
		
		private function onEnterFrame(evt:Event):void{	
			if (_isMotionAI == true){
				setMotionAI();
				if (_executeMotion == true){
					checkAndExecuteAnimLoopInAI(_delayAdj,_animType);
				}
			}
			
			if (_runSyncTimer == true){
				if (_canSync == true){
					syncTimer(_syncDuration);
				}	
			}
		}
	}
}