package com.tada.clopclop.toolsets.character.jockey
{
	import com.away3d.animators.VertexAnimator;
	import com.away3d.containers.View3D;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	import com.tada.clopclop.toolsets.character.jockey.sets.JockeyCharacterSets;
	import com.tada.clopclop.toolsets.character.jockey.sets.other.JockeyToolSet;
	import com.tada.clopclop.toolsets.custom.ErrorTracer;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class JockeyAnimation extends VertexAnimator
	{
		
		private var _animation:Array = [];
		private var _animationIndex:int = 0;
		private var _view:View3D;
		private var _assetsLoaded:Boolean = true;
		private var _resetAnim:Boolean = false;
		private var _toolsAnimation:Array = [];
		private var _animTimeline:Vector.<Number> = new Vector.<Number>; 
		private var _animTimelineMax:Vector.<Number> =  new Vector.<Number>;
		private var _animCycleNames:Vector.<String> = new Vector.<String>;
		private var _fps:Number = 30;
		
		// xml varibles
		private var _locLoader:URLLoader;
		private var _locRequest:URLRequest;
		private var _locXML:XML;
		
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();
		private var _animXMLLoaded:Boolean = false;
		
		/**
		 * 	Author: Hedrick David
		 * 
		 *  The Animation Class controls all the sets animation
		 * 	both the main body parts and its corresponding equipments and tools.
		 * 	This is used to play or stop animations or go through a specific loop
		 *  as well as the synchronization of animations.
		 * 
		 * 	@params1:stage - set the stage of the view for the event listeners 
		 */
		
		public function JockeyAnimation(view:View3D)
		{
			initDefaultValues();
			_view = view;
			addListeners();	
		}
		
		/**
		 * Sets default values for some values.
		 */
		
		private function initDefaultValues():void{
			if (_jockeyGR.animXMLLoaded() == false){
				_animTimeline[0] = 0;
				_animTimelineMax[0] = 20;
				_animCycleNames[0] = "walk";
			}
		}
		
		/**
		 * Add listeners
		 */
		
		private function addListeners():void{
			_jockeyGR.addOnAnimXMLLoaded(onAnimationXMLLoaded);
		}
		
		/**
		 * Event listener function after the animation XML has loaded. 
		 */
		
		private function onAnimationXMLLoaded (evt:JockeyEvent):void{
			_jockeyGR.removeOnAnimXMLLoaded(onAnimationXMLLoaded);
			_animTimeline = _jockeyGR.getAnimationTimeline();
			_animTimelineMax = _jockeyGR.getAnimationTimelineMax();
			_animCycleNames = _jockeyGR.getAnimationCycleNames();
		}
		
		
		/**
		 * The addSet function adds a specific character set to the animation
		 * which is usually used whenever the character asset needs 
		 * optional equipment like for example the wings.
		 * 
		 * @param1:characterSet - Input for the type of set to be added
		 * ex) EyeSet, BodySet, etc
		 */
		
		public function addSet(characterSet:JockeyCharacterSets):void{
			_animation.push(characterSet);
		}
		
		/**
		 * The addToolSet function adds a specific character set of a toolset type to the animation
		 * which is usually used for the character tools that are animation dependent.
		 * 
		 * @param1:characterSet - Input for the type of set to be added
		 */
		
		public function addToolSet(toolSet:JockeyToolSet):void{
			_toolsAnimation.push(toolSet);
		}
		
		/**
		 * The removeSet function removes a specific character set to the animation
		 * which is usually used whenever the equipments animation needs to be removed.
		 * 
		 * @param1:partType - Input for the type of set to be removed
		 * ex) EyeSet, BodySet, etc
		 */
		
		public function removeSet(partType:int):void{
			_animation[partType] = null;
		}
		
		/**
		 * This function plays the animation of the sets.
		 * This is usually invoked at the start of the
		 * instantiation of the asset. 
		 */
		
		public function playAnimation ():void{
			if (_animation[JockeyGR.SKIN_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length;item++){
					(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).play();
				}
				for (item = 0; item < _toolsAnimation.length; item++){
					for (var tool:int = 0; tool<_toolsAnimation[item].vertexAnimator.length; tool++){
						(_toolsAnimation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).play();
					}
				}
			} //else ErrorTracer.traceError("TCC0001");
		}
		
		/**
		 * Stops the animation of the character sets.
		 */
		
		public function stopAnimation ():void{
			if (_animation[JockeyGR.SKIN_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length;item++){
					(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).stop();
				}
				for (item = 0; item < _toolsAnimation.length; item++){
					for (var tool:int = 0; tool<_toolsAnimation[item].vertexAnimator.length; tool++){
						(_toolsAnimation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).stop();
					}
				}
			}// else ErrorTracer.traceError("TCC0001");
		}
		
		
		/**
		 * This function sets the fps of the character sets,
		 * usefull for changing the values for an emotional
		 * scene or as an added effect, as well as to adjust 
		 * based on the scene load. 
		 * 
		 * @param1:fps - the fps to be used for changing the frames per second
		 * of the character sets
		 */
		
		public function setFPS(fps:Number):void{
			_fps = fps;
			if (_animation[JockeyGR.SKIN_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length;item++){
					if (_animation[item] != null){
						(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).fps = _fps;
					} else {
						_animation[item].fpsIndex = _fps
					}
					
				}
				for (item = 0; item < _toolsAnimation.length; item++){
					if (_toolsAnimation[item] != null){
						(_toolsAnimation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).fps = _fps;
					} else {
						_toolsAnimation[item].fpsIndex = _fps
					}
				}
			} //else ErrorTracer.traceError("TCC0001");
		}
		
		
		/**
		 * Plays the animation of the character sets at the 
		 * specified index, usually a constant is invoked to
		 *  call the animation which is specified in the timeline array.
		 * 
		 * @param1:animationIndex - set the animationIndex to be used 
		 * to play the animation. It is recommended to use the animation
		 * constants in this class.
		 */
		
		public function playAnimationCycle (animationIndex:int):void{
			_animationIndex = animationIndex;
			playCycle();
			sync();
		}
		
		private function playCycle():void{
			for (var item:int = 0; item <_animation.length; item++){
				if (_animation[item] != null){
					if (_animation[item].assetLoaded == true){ 
						(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).fps = _fps;
						(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).gotoAndPlay(0);
					} else {
						if (_jockeyGR.animXMLLoaded() == true){
							_animation[item].animationCycleName = _animCycleNames[animationIndex];
						} else {
							_animation[item].animationCycleName = "walk";
						}
					}
				}
			}
			
			for (item = 0; item < _toolsAnimation.length; item++){
				if (_toolsAnimation[item] != null){
					for (var tool:int = 0; tool<_toolsAnimation[item].vertexAnimator.length; tool++){
						if (_toolsAnimation[item].assetLoaded[tool] == true){
							_toolsAnimation[item].animationCycleName = _animCycleNames[animationIndex];
							(_toolsAnimation[item].mesh[tool].animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).fps = _fps;
							(_toolsAnimation[item].mesh[tool].animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).gotoAndPlay(0);
						} else {
							_animation[item].fpsIndex = _fps;
							if (_jockeyGR.animXMLLoaded() == true){
								_toolsAnimation[item].animationCycleName = _animCycleNames[animationIndex];
							} else {
								_toolsAnimation[item].animationCycleName = "walk";
							}
						}
					}
				}
			}
		}
		
		/**
		 * Checks if the current frames of specific assets are not in synch.
		 */
		
		public function checkSynch ():void{
			if (_animation.length > 0 && _animation[JockeyGR.SKIN_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length; item++){
					if (_animation[item] != null){
						if (_animation[item].assetLoaded == true){
							if (_animation[item].vertexAnimator.currentFrame > _animation[JockeyGR.SKIN_SET].vertexAnimator.currentFrame +1 || _animation[item].vertexAnimator.currentFrame < _animation[JockeyGR.SKIN_SET].vertexAnimator.currentFrame -1){ 
								playCycle();
								break;
							}
						}
					}
				}
			}
			if (_toolsAnimation.length > 0 && _toolsAnimation[JockeyGR.SKIN_SET].assetLoaded == true){
				for (item = 0; item <_toolsAnimation.length; item++){
					if (_toolsAnimation[item] != null){
						if (_toolsAnimation[item].assetLoaded == true){
							for (var tool:int = 0; tool<_toolsAnimation[item].vertexAnimator.length; tool++){
								if (_toolsAnimation[item].vertexAnimator[tool].currentFrame > _animation[JockeyGR.SKIN_SET].vertexAnimator.currentFrame +1 || _toolsAnimation[item].vertexAnimator[tool].currentFrame < _animation[JockeyGR.SKIN_SET].vertexAnimator.currentFrame -1){ 
									playCycle();
									break;
								}
							}
						}
					}
				}
			}
			_view.removeEventListener(Event.ENTER_FRAME, onAnimationOrMeshChange);
		}
		
		/**
		 * Checks the synchronization of animation.
		 */
		
		private function onAnimationOrMeshChange(evt:Event):void{
			checkSynch();
		}
		
		/**
		 * Plays the animation of the character sets at the 
		 * specified frame.
		 * 
		 * @param1:frame - set the frame to be used 
		 * to play the animation.
		 */
		
		public function playAnimationFrame (frame:int):void{
			for (var item:int = 0; item <_animation.length; item++){
				if (_animation[item].assetLoaded == true){ 
					(_toolsAnimation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).gotoAndPlay(frame);
				} //else ErrorTracer.traceError("TCC0001");
			}
			for (item = 0; item < _toolsAnimation.length; item++){
				for (var tool:int = 0; tool<_toolsAnimation[item].vertexAnimator.length; tool++){
					if (_toolsAnimation[item].assetLoaded[tool] == true){
						(_toolsAnimation[item].mesh[tool].animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).gotoAndPlay(frame);
					} else {
						if (_jockeyGR.animXMLLoaded() == true){
							_toolsAnimation[item].animationCycleName = _animCycleNames[animationIndex];
						} else {
							_toolsAnimation[item].animationCycleName = "walk";
						}
					}
				}
			}
		}
		
		public function sync():void{
			_view.addEventListener(Event.ENTER_FRAME, onAnimationOrMeshChange);
		}
		
		/**
		 * Returns the index of the animation for referencing.
		 */
		
		public function get animationIndex():int{
			return _animationIndex;
		}
		
		/**
		 * Returns the timeline array of the animation for referencing.
		 */
		
		public function get animationTimeline():Vector.<Number>{
			return _animTimeline;
		}
		
		/**
		 * Returns the length of the array of the timeline animation 
		 * for referencing.
		 */
		
		public function get animLength():int{
			return _animTimeline.length;
		}
		
		/**
		 * Sets the reset variable to true. Used 
		 * to reset the current animation cycle frame.
		 */
		
		public function set resetCycleFrame (value:Boolean):void{
			_resetAnim = true;
		}
		
		/**
		 * Returns the array of the animation _animTimelineMax for referencing.
		 */
		
		public function get animMaxArray ():Vector.<Number>{
			return _animTimelineMax;
		}
		
		
		/**
		 * Returns the current skin frame.
		 */
		
		public function get currFrame():int {
			return _animation[JockeyGR.SKIN_SET].vertexAnimator.currentFrame;
		}
	}
}