package com.tada.clopclop.toolsets.character.jockey.sets.other
{
	import com.away3d.animators.VertexAnimator;
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.materials.CompositeMaterial;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class JockeyToolSet 
	{
		// mesh basic property variables
		private var _rotationHolder:Number = 0;
		private var _animationHolder:int = 0;
		private var _animationCycleHolder:String = "walk";
		private var _positionXHolder:Number = 0;
		private var _positionYHolder:Number = 0;
		private var _positionZHolder:Number = 0;
		private var _fpsIndex:Number = 30;
		private var _animation:int = 0;
		private var _meshArray:Array = [];
		private var _visibilityVector:Vector.<Boolean> = new <Boolean>[false, false, false, false, false, false]; // Boolean
		private var _assetLoaded:Vector.<Boolean> = new <Boolean>[false, false, false, false, false, false];
		private var _toolLen:int = 5;
		private var _vertAnimator:Array = []; // VertexAnimator
		private var _animationLibrary:Array = []; // AnimationLibrary

		// refer to animation documentation for changes
		private var _toolAssetLoc:Array = [];
		
		private var _toolTextureLoc:Array = [];
		
		// xml variables
		private var _locLoader:URLLoader;
		private var _locRequest:URLRequest;
		private var _locXML:XML;
		
		private var _compoMaterial:Array = [];
		private var _textureMaterial:Array = [];
		
		private var _meshContainer:ObjectContainer3D;
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();
		private var _meshInstanceCode:Vector.<String> = new Vector.<String>();
		private var _instanceID:int;
		private var _canChangeIndex:Boolean = true;
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _meshRequestQueue:Vector.<int> = new Vector.<int>();
		private var _readyToLoadMesh:Boolean = true;
		private var _loadedToolCtr:int =0;
		
		/**
		 * Author: Hedrick David
		 * 
		 * This class is a special set for the Jockey toolset that loads the respective
		 * tools and is used in specific jockey character animation.
		 * 
		 * @param1:view - the view (away3D) to be used.
		 */
		
		public function JockeyToolSet(instanceID:int, meshContainer3D:ObjectContainer3D)
		{ 
			_instanceID = instanceID;
			_meshContainer = meshContainer3D;
			for (var tool:int = 0; tool<_toolLen; tool++){
				_compoMaterial[tool] = new CompositeMaterial();
				_meshInstanceCode[tool] = ":";
				
			}
			loadAsset();
		}
		
		/**
		 * Starts the loading process of the mesh
		 * by listening for the xml loaded event.
		 */
		
		private function loadAsset():void{
			_jockeyGR.addOnXMLLoaded(onXMLLoaded);
		}
		
		/**
		 * Event function for when the xml has finished loaded.
		 */
		
		private function onXMLLoaded (evt:JockeyEvent):void{
			if (evt.params.partType == JockeyGR.TOOL_SET){
				_jockeyGR.removeOnXMLLoaded(onXMLLoaded);
				_readyToLoadMesh = false;
				for (var mesh:int = 0; mesh<_toolLen; mesh++){
					_assetLoaded[mesh] = false;
					_jockeyGR.loadMesh(_instanceID, JockeyGR.TOOL_SET, mesh, _meshInstanceCode[mesh]);
				}
				_jockeyGR.addOnMeshLoaded(onMeshLoaded);
			}
		}
		
		/**
		 * Loads an instance of the mesh loaded
		 * and applies the necesary attributes.
		 */
		
		private function onMeshLoaded (evt:JockeyEvent):void{
			if (evt.params.partType == JockeyGR.TOOL_SET && evt.params.assetID == _instanceID){
				_loadedToolCtr++;
				for (var tool:int = 0; tool<_toolLen; tool++){
					if (evt.params.meshIndex == tool){
						_meshArray[tool] = _jockeyGR.getMesh(_instanceID, JockeyGR.TOOL_SET, tool);
						_meshInstanceCode[tool] = _jockeyGR.getMeshCode();
						textureLayeringManager(tool, JockeyGR.TEXLAYER_MAIN);
						_meshArray[tool].rotationY = _rotationHolder;
						_meshArray[tool].position.x = _positionXHolder;
						_meshArray[tool].position.y = _positionYHolder;
						_meshArray[tool].position.z = _positionZHolder;
						_meshArray[tool].visible = _visibilityVector[tool];
						setToolParams(tool);
						_animationLibrary[tool] = _meshArray[tool].animationLibrary;
						_vertAnimator[tool] = _animationLibrary[tool].getAnimation(_animationCycleHolder).animator as VertexAnimator;
						_vertAnimator[tool].play();
						_vertAnimator[tool].fps = _fpsIndex;;
						_meshContainer.addChild(_meshArray[tool]);
						_assetLoaded[tool] = true;
						break;
					}
				}
				if (_loadedToolCtr == _toolLen){
					_jockeyGR.removeOnMeshLoaded(onMeshLoaded);
				}
			}
		}
		
		/**
		 * Sets the parameters of the mesh based on the type of tool.
		 * 
		 * @params1:toolType - the type of tool;
		 */
		
		private function setToolParams (toolType:int):void{
			switch (toolType) {
				case JockeyGR.TOOL_PITCHFORK:
					_meshArray[toolType].bothsides = true;
					_meshArray[toolType].name = "jockeyPitchfork";
					break;
				case JockeyGR.TOOL_BRUSH:
					_meshArray[toolType].bothsides = true;
					_meshArray[toolType].name = "jockeyBrush";
					break;
				case JockeyGR.TOOL_BATON:
					_meshArray[toolType].bothsides = true;
					_meshArray[toolType].name = "jockeyBaton";
					break;
				case JockeyGR.TOOL_HAMMER:
					_meshArray[toolType].bothsides = true;
					_meshArray[toolType].name = "jockeyHammer";
					break;
				case JockeyGR.TOOL_SYRINGE:
					_meshArray[toolType].bothsides = false;
					_meshArray[toolType].name = "jockeySyringe";
					break;
			}
		}
		
		/**
		 * Function to remove the mesh of the part type.
		 * 
		 * @params:toolType - set the tool to be removed;
		 */
		
		public function removeMesh(toolType:int):void{
			for (var tool:int = 0; tool<_toolLen; tool++){
				if (toolType == tool || toolType == JockeyGR.TOOL_ALL){
					for (var face:int=_meshArray[tool].faces.length-1; face>-1; face--){
						_meshArray[tool].removeFace(_meshArray[tool].faces[face]);
					}
					_meshArray[tool] = null;
				}
			}
		}
		
		/**
		 * Function to set the changing of the texture
		 * and layer them accordingly.
		 * 
		 * @params1:layer - the layer type. Use constants in this class.
		 * @params2:toolType - the texture to be changed based on the type of tool.
		 */
		
		private function textureLayeringManager(toolType:int, layer:String = ""):void{
			var textureIndex:int;
			if (toolType == JockeyGR.TOOL_SYRINGE){
				textureIndex = 1;
			} else {
				textureIndex = 0;
			}
			// Main Texture
			if (layer == JockeyGR.TEXLAYER_MAIN) {
				_compoMaterial[toolType].clearMaterials();
				_textureMaterial[toolType] = _jockeyGR.getTexture(JockeyGR.TOOL_SET, textureIndex);
				_compoMaterial[toolType].addMaterial(_textureMaterial[toolType]);
			}
			_meshArray[toolType].material = _compoMaterial[toolType];
		}
		
		/**
		 * Getter function to return the vertexAnimator variable of the mesh
		 * used to control the animation of the specific character set.
		 */
		
		public function get vertexAnimator():Array{
			return _vertAnimator;
		}
		
		/**
		 * Setter and getter function that sets and returns the index value of the current fps.
		 */
		
		public function set fpsIndex(value:Number):void{
			_fpsIndex = value;
		}
		
		public function get fpsIndex():Number{
			return _fpsIndex;
		}
		
		/**
		 * Sets the indexes to its default or initial values.
		 * Use only when initializing.
		 */
		
		public function setInitialIndexes():void{
		}
		
		/**
		 * Sets the visibility of the mesh.
		 * 
		 * @params:toolType - Set the type of tool to be visible.
		 * Use TOOL_OFF to set all tool visibility off. 
		 */
		
		public function visible (toolType:int = -1):void{
			
			for (var tool:int = 0; tool<_toolLen; tool++){
				if (_assetLoaded[tool] == true){
					_meshArray[tool].visible = false;
				} else {
					_visibilityVector[tool] = false;
				}	
			}
			
			if (toolType != -1){
				if (_assetLoaded[toolType] == true){
					_meshArray[toolType].visible = true;
				} else {
					_visibilityVector[toolType] = true;
				}
			}
		}
		
		/**
		 * Return the array value of the tools mesh. 
		 */
		
		public function get mesh():Array{
			return _meshArray;
		}
		
		/**
		 * Return the array value that specifies whether the tools asset has been loaded. 
		 */
		
		public function get assetLoaded():Vector.<Boolean>{
			return _assetLoaded;
		}
		
		/**
		 * Getter function that returns the state of the visibility of the 
		 * current mesh tools for reference.
		 */
		
		public function get visibility ():Vector.<Boolean>{
			return _visibilityVector;
		}
		
		/**
		 * Sets the mesh rotation placeholder.
		 */
		
		public function set rotationHolder(value:Number):void{
			_rotationHolder = value;
		}
		
		/**
		 * Sets the mesh animation placeholder.
		 */
		
		public function set animationHolder(value:int):void{
			_animationHolder = value;
		}
		
		/**
		 * Sets the mesh cycle name placeholder.
		 */
		
		public function set animationCycleName(value:String):void{
			_animationCycleHolder = value;
		}
		
		/**
		 * Sets the mesh positionX placeholder.
		 */
		
		public function set positionXHolder(value:Number):void{
			_positionXHolder = value;
		}
		
		/**
		 * Sets the mesh positionY placeholder.
		 */
		
		public function set positionYHolder(value:Number):void{
			_positionYHolder = value;
		}
		
		/**
		 * Sets the mesh positionZ placeholder.
		 */
		
		public function set positionZHolder(value:Number):void{
			_positionZHolder = value;
		}
	}
}