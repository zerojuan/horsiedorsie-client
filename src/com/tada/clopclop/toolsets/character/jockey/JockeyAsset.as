package com.tada.clopclop.toolsets.character.jockey
{
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.containers.View3D;
	import com.away3d.core.base.Object3D;
	import com.away3d.primitives.Plane;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	import com.tada.clopclop.toolsets.character.jockey.sets.equipment.JockeyAccessorySet;
	import com.tada.clopclop.toolsets.character.jockey.sets.equipment.JockeyHeadSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyBottomSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyEyeSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyHairSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyShoesSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeySkinSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyTopSet;
	import com.tada.clopclop.toolsets.character.jockey.sets.other.JockeyToolSet;
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
	
	import flashx.textLayout.formats.Category;
	
	/**
	 * Author: Hedrick David
	 * 
	 * The JockeyAsset class is used to easily instantiate a jockey asset 
	 * with all its corresponding part meshes, textures and animation.
	 */
	
	public class JockeyAsset extends Object3D
	{
		
		private var _skin:JockeySkinSet;
		private var _hair:JockeyHairSet;
		private var _eye:JockeyEyeSet;
		private var _top:JockeyTopSet;
		private var _bottom:JockeyBottomSet;
		private var _shoes:JockeyShoesSet;
		private var _head:JockeyHeadSet;
		private var _accessory:JockeyAccessorySet;
		private var _tools:JockeyToolSet;
		private var _setArray:Array = [];
		
		private var _view:View3D;
		private var _animation:JockeyAnimation;
		
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
		private var _changeMotion:Boolean =false;
		
		private var _temp:Number;
		private var _timerRand:Number;
		private var _executeMotion:Boolean = false;
		private var _delayAdj:Number;
		private var _animType:int;
		private var _meshContainer:ObjectContainer3D;
		private var _hasExecutedArray:Array = [false, false, false, false, false, false, false, false];
		private var _meshListArray:Array = [];
		private var _tempCtr:int = 0;
		private var _instanceID:int = -1;
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();
		private var _preAnimation:int = 0;
		
		private var _runSyncTimer:Boolean = false;
		private var _canSync:Boolean = false;
		private var _syncDuration:Number = 10000;
		
		public function JockeyAsset (view:View3D)
		{ 
			_jockeyGR.initAnimXML();
			_instanceID = _jockeyGR.registerInstance(_instanceID);
			_view = view;
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
			_skin = new JockeySkinSet(_instanceID, _meshContainer);
			_top = new JockeyTopSet(_instanceID, _meshContainer);
			_shoes = new JockeyShoesSet(_instanceID, _meshContainer);
			_hair = new JockeyHairSet(_instanceID, _meshContainer);
			_eye = new JockeyEyeSet(_instanceID, _meshContainer);
			_bottom = new JockeyBottomSet(_instanceID, _meshContainer);
			_tools = new JockeyToolSet(_instanceID, _meshContainer);
			
			_setArray[JockeyGR.SKIN_SET] = _skin;
			_setArray[JockeyGR.TOP_SET] = _top;
			_setArray[JockeyGR.SHOES_SET] = _shoes;
			_setArray[JockeyGR.HAIR_SET] = _hair;
			_setArray[JockeyGR.EYE_SET] = _eye;
			_setArray[JockeyGR.BOTTOM_SET] = _bottom;
			_setArray[JockeyGR.ACC_SET] = null;
			_setArray[JockeyGR.HEAD_SET] = null;
			
			for (var a:int = 0; a<_setArray.length; a++){
				if (_setArray[a] != null){
					_setArray[a].setInitialIndexes();
				}
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
		 * Sets the AI of the character. Use the AI constants in this class.
		 * 
		 * @params:aIType - set the type of AI;
		 */
		
		public function setAI(AIType:int = -1):void{
			switch (AIType){
				case JockeyGR.AI_MOTION: 
					_isMotionAI = true;
					_changeMotion = true;
					break;
				case JockeyGR.AI_OFF:
					changeAnimationByType(_animation.animationIndex);
					setAllAIOff();
					break;
			}
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
					var random:Number = int (Math.random() * 3.9);
				} while (random == _temp);
				_temp = random;
				switch (random){
					case 0:
						_delayAdj = 0;
						_animType = JockeyGR.ANIM_WALK;
						_executeMotion = true;
						break;
					case 1:
						_delayAdj = 0;
						_animType = JockeyGR.ANIM_IDLE01;
						_executeMotion = true;
						break;
					case 2:
						_delayAdj = 0;
						_animType = JockeyGR.ANIM_IDLE02;
						_executeMotion = true;
						break;
					case 3:
						_delayAdj = .6;
						_animType = JockeyGR.ANIM_JUMP;
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
			_appearanceSetRequest = new URLRequest("xml/jockey/TCC_Jockey_AppearanceSet.xml");
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
			_animation = new JockeyAnimation(_view);
			for (var set:int = 0; set<_setArray.length; set++){
				_animation.addSet(_setArray[set]);
			}
			
			_animation.addToolSet(_tools);
			_animation.playAnimation();
			_animation.setFPS(24);
		}
		
		/**
		 * Function to add equipment parts to the body.
		 * For example the wings, head, etc.
		 * 
		 * @params1:partType - the part type to be added. Use the 
		 * constants in this class ex) JockeyAsset.ACC_SET
		 */
		
		public function addEquipment(partType:int):void{
			switch (partType){
				case JockeyGR.ACC_SET:
					if (_setArray[JockeyGR.ACC_SET] == null){
						_accessory = new JockeyAccessorySet(_instanceID, _meshContainer);
						_setArray[JockeyGR.ACC_SET] = _accessory;
						_animation.addSet(_accessory);
						changeAnimationByType(_animation.animationIndex);
						_accessory.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
					}
					break;
				case JockeyGR.HEAD_SET:
					if (_setArray[JockeyGR.HEAD_SET] == null){
						_head = new JockeyHeadSet(_instanceID, _meshContainer);
						_setArray[JockeyGR.HEAD_SET] = _head;
						_animation.addSet(_head);
						changeAnimationByType(_animation.animationIndex);
						_head.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
					}
					break;
			}
		}		
		
		/**
		 * Function to remove equipment parts to the body.
		 * For example the wings, head, etc.
		 * 
		 * @params1:partType - the part type to be removed. Use the 
		 * constants in this class ex) JockeyAsset.ACC_SET
		 */
		
		public function removeEquipment(partType:int):void{
			if (_setArray[partType] != null){
				if (partType < 6 || partType > 7){
					ErrorTracer.traceError("TCC0003");
				} else {
					_setArray[partType].visible(false);
					_animation.removeSet(partType);
					_setArray[partType] = null;
					_setArray[partType].removeEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
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
					_setArray[set].changeMesh(0);
					_setArray[set].changeTexture(0);
					_setArray[set].setInitialIndexes();
					if (set >= JockeyGR.HEAD_SET && set <= JockeyGR.ACC_SET){
						setSpecificEquipmentVisibility(set, false);
					}
				}
			}
			//_setArray[SKIN_SET].changeDecals(JockeySkinSet.DECSKIN_OFF);
			_setArray[JockeyGR.SKIN_SET].changeMouthTexture(JockeyGR.TEXMOUTH_DEFAULT);
			_setArray[JockeyGR.SKIN_SET].changeEyebrowTexture(JockeyGR.TEXEYEBROW_DEFAULT);
			_animation.playAnimationCycle(0);
			setAI();
		}
		
		/**
		 * Function to display error trace messages. 
		 */
		
		private function addListeners():void{	
			addEventListener(Event.ENTER_FRAME, onEnterFrame);	
			_skin.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_hair.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_eye.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_top.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_bottom.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
			_shoes.addEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
		}
		
		/**
		 * Calls the sync function whenever a mesh part finishes loading. 
		 */
		
		private function onMeshLoaded(evt:JockeyEvent):void{
			_animation.sync();
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
		
		/**
		 * Parses the XML and returns the array based from the given set and type of 
		 * information to be returned.
		 * 
		 * @params1:setType - The type of set, not the part of the body. Use the constants
		 * in this class.
		 * @params2:returnType - The type of information to be returned. Use the constants 
		 * in this class ex) XML_MESH or XML_TEXTURE.
		 */
		
		private function parseXMLSet (setType:int,returnType:String):Array{
			var xmlList:XMLList = new XMLList (_appearanceSetXML.jockey.children());
			var arr:Array = []; 
			
			if (returnType == JockeyGR.XML_MESH){
				for each (var set:XML in xmlList){
					if (set.attribute("id") == setType){
						for each (var part:XML in set.mesh.children()){
							arr.push(Number(part.text()));
						}
					}
				}
			}
			
			if (returnType == JockeyGR.XML_TEXTURE){
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
		
		public function get animation():JockeyAnimation{
			return _animation;
		}
		
		/**
		 * Sets the tool visibility.
		 * 
		 * @params1:animationType - the animation index with which 
		 * the corresponding tool will be visible;
		 */
		
		private function setToolVisibility (animationType:int = -1):void{
			switch (animationType){
				case JockeyGR.ANIM_FEED:
					_tools.visible(JockeyGR.TOOL_PITCHFORK);
					break;
				case JockeyGR.ANIM_SHOWER:
					_tools.visible(JockeyGR.TOOL_BRUSH);
					break;
				case JockeyGR.ANIM_TRAINING:
					_tools.visible(JockeyGR.TOOL_BATON);
					break;
				case JockeyGR.ANIM_CONSTRUCTION:
					_tools.visible(JockeyGR.TOOL_HAMMER);
					break;
				case JockeyGR.ANIM_CURE:
					_tools.visible(JockeyGR.TOOL_SYRINGE);
					break;
				default:
					_tools.visible();
					break;
			}
		}
		
		/**
		 * Sets the animation by the type set. Use the animation constant
		 * for reference on the animation types.
		 * 
		 * @param1:animation - animation.
		 */
		
		public function changeAnimationByType(animation:int):void{
			_animation.playAnimationCycle(animation);
			setToolVisibility(animation);
		}
		
		/**
		 * Initialize the simple shadow of the character.
		 */
		
		private function initShadow ():void{
			_shadowPlane = new Plane();
			_shadowPlane.scale(25);			
			_shadowPlane = JockeyGR.getInstance().getShadow();
			_meshContainer.addChild(_shadowPlane);
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
				setToolVisibility(_animation.animationIndex);
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
				setToolVisibility(_animation.animationIndex);
			} else {
				_animation.playAnimationCycle(_animation.animLength-1);
				setToolVisibility(_animation.animationIndex);
			}
		}
		
		/**
		 * Changes the decals by type.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 * @params2:decalType - set the decal type. Use the specific character set constant.
		 * 
		 * note: Still under construction, only the body has a decal...
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
			var textureArr:Array = parseXMLSet(setType, JockeyGR.XML_TEXTURE);
			_setArray[JockeyGR.SKIN_SET].setInitialIndexes();
			for (var part:int = 0;part<4;part++){
				try {
					changeTextureByPart(part,textureArr[part]);
				} catch (err:Error){
					trace ("Mesh still not loaded... just needs to wait");
				}
			}
		}
		
		/**
		 * Sets the texture of the specific character set with the corresponding texture type.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 * @params2:textureType - set the texture type. Use the specific character set constant.
		 * Ex) JockeySkinSet.TEXSKIN_DEFAULT, JockeyEyeSet.TEXEYE_DEFAULT, etc.
		 */
		
		public function changeTextureByPart (partType:int, textureType:int):void{
			if (partType < 8 && partType >-1){
				for (var set:int = 0; set<_setArray.length; set++){
					if (partType == set){
						if (_setArray[set].assetLoaded == true){
							_setArray[set].changeTexture(textureType);
						} else {
							_setArray[set].textureIndex = textureType;	
						}
						break;
					}
				}
			} else if (partType == JockeyGR.MOUTH_SET){
				if (_setArray[JockeyGR.SKIN_SET].assetLoaded == true){
					_setArray[JockeyGR.SKIN_SET].changeMouthTexture(textureType);
				} else {
					_setArray[JockeyGR.SKIN_SET].mouthIndex = textureType;	
				}
				
			} else if (partType == JockeyGR.EYEBROW_SET){
				if (_setArray[JockeyGR.SKIN_SET].assetLoaded == true){
					_setArray[JockeyGR.SKIN_SET].changeEyebrowTexture(textureType);	
				} else {
					_setArray[JockeyGR.SKIN_SET].eyebrowIndex = textureType;	
				}
			}
		}
		
		/**
		 * Sets the next texture based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changeNextTexture (partType:int):void{
			if (_setArray[partType] != null && partType != JockeyGR.MOUTH_SET && partType != JockeyGR.EYEBROW_SET){
				if (_setArray[partType].textureIndex < _setArray[partType].texLength -1){
					_setArray[partType].changeTexture(_setArray[partType].textureIndex + 1);
				} else {
					_setArray[partType].changeTexture(0);
				}
			} else if (partType == JockeyGR.MOUTH_SET){
				if (_setArray[JockeyGR.SKIN_SET].mouthIndex < _setArray[JockeyGR.SKIN_SET].mouthTexLength -1){
					_setArray[JockeyGR.SKIN_SET].changeMouthTexture(_setArray[JockeyGR.SKIN_SET].mouthIndex + 1);
				} else {
					_setArray[JockeyGR.SKIN_SET].changeMouthTexture(0);
				}
			} else if (partType == JockeyGR.EYEBROW_SET){
				if (_setArray[JockeyGR.SKIN_SET].eyebrowIndex < _setArray[JockeyGR.SKIN_SET].eyebrowTexLength -1){
					_setArray[JockeyGR.SKIN_SET].changeEyebrowTexture(_setArray[JockeyGR.SKIN_SET].eyebrowIndex + 1);
				} else {
					_setArray[JockeyGR.SKIN_SET].changeEyebrowTexture(0);
				}
			}
			/*
			if (partType == SKIN_SET){
			if (_setArray[partType].decalIndex < _setArray[partType].decalTexLength -1){
			_setArray[partType].changeDecals(_setArray[partType].decalIndex + 1);
			} else {
			_setArray[partType].changeDecals(-1);
			}
			}*/
		}
		
		/**
		 * Sets the previous texture based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changePreviousTexture (partType:int):void{
			if (_setArray[partType] != null && partType != JockeyGR.MOUTH_SET && partType != JockeyGR.EYEBROW_SET){
				if (_setArray[partType].textureIndex > 0){
					_setArray[partType].changeTexture(_setArray[partType].textureIndex - 1);
				} else {
					_setArray[partType].changeTexture(_setArray[partType].texLength -1);
				}
			} else if (partType == JockeyGR.MOUTH_SET){
				if (_setArray[JockeyGR.SKIN_SET].mouthIndex > 0){
					_setArray[JockeyGR.SKIN_SET].changeMouthTexture(_setArray[JockeyGR.SKIN_SET].mouthIndex - 1);
				} else {
					_setArray[JockeyGR.SKIN_SET].changeMouthTexture(_setArray[JockeyGR.SKIN_SET].mouthTexLength -1);
				}
			} else if (partType == JockeyGR.EYEBROW_SET){
				if (_setArray[JockeyGR.SKIN_SET].eyebrowIndex > 0){
					_setArray[JockeyGR.SKIN_SET].changeEyebrowTexture(_setArray[JockeyGR.SKIN_SET].eyebrowIndex - 1);
				} else {
					_setArray[JockeyGR.SKIN_SET].changeEyebrowTexture(_setArray[JockeyGR.SKIN_SET].eyebrowTexLength -1);
				}
			}
			/*
			if (partType == BODY_SET){
			if (_setArray[partType].decalIndex > -1){
			_setArray[partType].changeDecals(_setArray[partType].decalIndex - 1);
			} else {
			_setArray[partType].changeDecals(_setArray[partType].decalTexLength -1);
			}
			}*/
		}
		
		/**
		 * Removes the specific body part from the container.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		private function removeContainerContents (partType:int):void{
			switch (partType){
				case JockeyGR.SKIN_SET:
					_meshContainer.removeChildByName("jockeySkin");
					break;
				case JockeyGR.EYE_SET:
					_meshContainer.removeChildByName("jockeyEye");
					break;
				case JockeyGR.HAIR_SET:
					_meshContainer.removeChildByName("jockeyHair");
					break;
				case JockeyGR.TOP_SET:
					_meshContainer.removeChildByName("jockeyTop");
					break;
				case JockeyGR.ACC_SET:
					_meshContainer.removeChildByName("jockeyAcc");
					break;
				case JockeyGR.HEAD_SET:
					_meshContainer.removeChildByName("jockeyHead");
					break;
				case JockeyGR.BOTTOM_SET:
					_meshContainer.removeChildByName("jockeyBottom");
					break;
				case JockeyGR.SHOES_SET:
					_meshContainer.removeChildByName("jockeyShoes");
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
			if (_setArray[partType].meshIndex < _setArray[partType].meshLength -1){
				_setArray[partType].changeMesh(_setArray[partType].meshIndex + 1);
				_animation.resetCycleFrame = true;
			} else {
				_setArray[partType].changeTexture(0);
				_animation.resetCycleFrame = true;
			}
		}
		
		/**
		 * Sets the previous mesh based on the texture array of the specified character set.
		 * 
		 * @params1:partType - set the character set type. Use the constant in this class.
		 */
		
		public function changePreviousMesh (partType:int):void{
			if (_setArray[partType].meshIndex > 0){
				_setArray[partType].changeMesh(_setArray[partType].meshIndex - 1);
				_animation.resetCycleFrame = true;
			} else {
				_setArray[partType].changeMesh(_setArray[partType].meshLength -1);
				_animation.resetCycleFrame = true;
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
						try {
							changeMeshByType(part,_appearanceSetXML.tada_clopclop.jockey.set_default.mesh[part]);
							_animation.resetCycleFrame = true;
						} catch (err:Error){
							trace ("Mesh still not loaded... just needs to wait");
						}
					}
				}
			}
		}
		
		/**
		 * Getter function to return the value of the visibility variable,
		 * which is used for the the reference of character visibility.
		 */
		
		public function get visibility ():Boolean{
			return _setArray[0].visibility;
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
				case JockeyGR.REMOVEDECALS_ALL:
					break;
				case JockeyGR.REMOVEDECALS_PATTERNS:
					_setArray[JockeyGR.SKIN_SET].removeDecalPatterns();
					break;
			}
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
		 * Function to remove the instances of meshes of the character sets. 
		 */
		
		public function removeAsset ():void{
			for (var set:int = 0; set<_setArray.length; set++){
				if (_setArray[set] != null){
					_setArray[set].removeMesh();
				}
			}
			_tools.removeMesh(JockeyGR.TOOL_ALL);
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
			for (var set:int = 6; set<8; set++){
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
		 * Returns the mesh container that contains all the mesh.
		 */
		
		public function get mesh ():ObjectContainer3D{
			return _meshContainer;
		}
		
		/**
		 * Removes listeners. 
		 */
		
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);	
			for (var a:int = 0; a<_setArray.length; a++){
				if (_setArray[a] != null){
					_setArray[a].removeEventListener(JockeyEvent.MESH_LOADED_ANIM, onMeshLoaded);
				}
			}
			
		}
		
		/**
		 * Function to check if equipment is already added. 
		 * 
		 * Returns:Boolean - True or false if the equipment exists or not. Useful for just setting the visibility of the 
		 * equipment to avoid memory leaks which happens in the removing and instatiation of meshes
		 * in away3D.
		 */
		
		public function equipmentExists (equipmentType:int):Boolean{
			if ( equipmentType > 6 || equipmentType < 8){
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
	}
}