package com.tada.clopclop.toolsets.character.horse
{
	import com.away3d.animators.VertexAnimator;
	import com.away3d.containers.View3D;
	import com.away3d.events.AnimatorEvent;
	import com.greensock.plugins.VolumePlugin;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.horse.sets.HorseCharacterSets;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class HorseAnimation extends VertexAnimator
	{
		private var _animation:Array = [];
		private var _animationIndex:int = 0;
		private var _view:View3D;
		private var _animTimeline:Vector.<Number> = new Vector.<Number>; 
		private var _animTimelineMax:Vector.<Number> = new Vector.<Number>;
		private var _animCycleNames:Vector.<String> = new Vector.<String>;
		
		// xml varibles
		private var _locLoader:URLLoader;
		private var _locRequest:URLRequest;
		private var _locXML:XML;
		
		private var _horseGR:HorseGR = HorseGR.getInstance();
		private var _animXMLLoaded:Boolean = false;
		private var _fps:Number = 30;
		
		/**
		 * 	Author: Hedrick David
		 *  The Animation Class controls all the sets animation
		 * 	both the main body parts and its corresponding equipments.
		 * 	This is used to play or stop animations or go through a specific loop
		 *  as well as the synchronization of animations.
		 * 
		 * 	@params1:view - needed for adding event listeners 
		 */
		
		public function HorseAnimation(view:View3D)
		{
			initDefaultValues();
			_view = view;
			addListeners();	
		}
		
		/**
		 * Sets default values for some values.
		 */
		
		private function initDefaultValues():void{
			if (_horseGR.animXMLLoaded() == false){
				_animTimeline[0] = 0;
				_animTimelineMax[0] = 20;
				_animCycleNames[0] = "walk";
			}
		}

		/**
		 * Adds listeners.
		 */
		
		private function addListeners():void{
			_horseGR.addOnAnimXMLLoaded(onAnimationXMLLoaded);						
		}
		
		/**
		 * Event listener function after the animation XML has loaded. 
		 */
		
		private function onAnimationXMLLoaded (evt:HorseEvent):void{
			_horseGR.removeOnAnimXMLLoaded(onAnimationXMLLoaded);
			_animTimeline = _horseGR.getAnimationTimeline();
			_animTimelineMax = _horseGR.getAnimationTimelineMax();
			_animCycleNames = _horseGR.getAnimationCycleNames();
			
		}
		
		/**
		 * The addSet function adds a specific character set to the animation
		 * which is usually used whenever the character asset needs 
		 * optional equipment like for example the wings.
		 * 
		 * @param1:characterSet - Input for the type of set to be added
		 * ex) EyeSet, BodySet, etc
		 */
		
		public function addSet(characterSet:HorseCharacterSets):void{
			_animation.push(characterSet);
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
			if (_animation[HorseGR.BODY_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length;item++){
					(_animation[item].mesh.animationLibrary.getAnimation("walk").animator as VertexAnimator).play();
				}
			} //else ErrorTracer.traceError("TCC0001");
		}
		
		/**
		 * Stops the animation of the character sets.
		 */
		
		public function stopAnimation ():void{
			if (_animation[HorseGR.BODY_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length;item++){
					(_animation[item].mesh.animationLibrary.getAnimation("default").animator as VertexAnimator).play();
				}
			} //else ErrorTracer.traceError("TCC0001");
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
			if (_animation[HorseGR.BODY_SET].assetLoaded == true) {
				_fps = fps;
				for (var item:int = 0; item <_animation.length;item++){
					if (_animation[item] != null){
						if (_animation[item].assetLoaded == true){
							(_animation[item].mesh.animationLibrary.getAnimation("default").animator as VertexAnimator).fps = _fps;
						} else {
							_animation[item].fpsIndex = _fps
						}
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
		 * to play the animation. Recommended to use the animation
		 * constants in this class.
		 */
		
		public function playAnimationCycle (animationIndex:int):void{
			_animationIndex = animationIndex;
			playCycle();
			sync();
		}
		
		/**
		 * Creates an enterFrame listener for synching.
		 */
		
		public function sync():void{
			_view.addEventListener(Event.ENTER_FRAME, onAnimationOrMeshChange); 
		}
		
		/**
		 * Plays the animation cycles.
		 */
		
		private function playCycle():void{
			for (var item:int = 0; item <_animation.length; item++){
				if (_animation[item] != null){
					if (_animation[item].assetLoaded == true){
						_animation[item].animationCycleName = _animCycleNames[animationIndex];
						(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).fps = _fps;
						(_animation[item].mesh.animationLibrary.getAnimation(_animCycleNames[animationIndex]).animator as VertexAnimator).gotoAndPlay(0);
					} else {
						_animation[item].fpsIndex = _fps;
						if (_horseGR.animXMLLoaded() == true){
							_animation[item].animationCycleName = _animCycleNames[animationIndex];
						} else {
							_animation[item].animationCycleName = "walk";
						}
					}
				}
			}
			_view.removeEventListener(Event.ENTER_FRAME, onAnimationOrMeshChange);
		}
		
		/**
		 * Checks if the current frames of specific assets are not in synch.
		 */
		
		public function checkSynch ():void{
			if (_animation.length > 0 && _animation[HorseGR.BODY_SET].assetLoaded == true) {
				for (var item:int = 0; item <_animation.length; item++){
					if (_animation[item] != null && _horseGR.animXMLLoaded() == true){
						if (_animation[item].assetLoaded == true){
							if (_animation[item].vertexAnimator.currentFrame > _animation[HorseGR.BODY_SET].vertexAnimator.currentFrame + 1 || _animation[item].vertexAnimator.currentFrame < _animation[HorseGR.BODY_SET].vertexAnimator.currentFrame - 1){ 
								playCycle();
								break;
							}
						}
					}
				}
			}
		}
		
		/**
		 * Checks the synchronization of animation.
		 */
		
		private function onAnimationOrMeshChange(evt:Event):void{
			checkSynch();
		}
		
		/**
		 * Returns the index of the animation for referencing.
		 */
		
		public function get animationIndex():int{
			return _animationIndex;
		}
		
		/**
		 * Returns the length of the array of the timeline animation 
		 * for referencing.
		 */
		
		public function get animLength():int{
			return _animTimeline.length;
		}
		
		/**
		 * Returns the array of the _animTimeline for referencing.
		 */
		
		public function get animArray ():Vector.<Number> {
			return _animTimeline;
		}
		
		/**
		 * Returns the array of the animation _animTimelineMax for referencing.
		 */
		
		public function get animMaxArray():Vector.<Number>{
			return _animTimelineMax;
		}
		
		/**
		 * Returns the current body frame.
		 */
		
		public function get currFrame():int {
			return _animation[HorseGR.BODY_SET].vertexAnimator.currentFrame;
		}
	}
}