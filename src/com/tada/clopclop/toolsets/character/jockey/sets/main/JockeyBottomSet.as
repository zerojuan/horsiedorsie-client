package com.tada.clopclop.toolsets.character.jockey.sets.main
{
	
	import com.away3d.animators.VertexAnimator;
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.core.base.Mesh;
	import com.away3d.events.Loader3DEvent;
	import com.away3d.loaders.utils.AnimationLibrary;
	import com.away3d.materials.BitmapFileMaterial;
	import com.away3d.materials.CompositeMaterial;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	import com.tada.clopclop.toolsets.character.jockey.sets.JockeyCharacterSets;
	
	import flash.events.EventDispatcher;
	
	public class JockeyBottomSet extends EventDispatcher implements JockeyCharacterSets
	{

		// mesh basic property variables
		private var _rotationHolder:Number = 0;
		private var _animationHolder:int = 0;
		private var _animationCycleHolder:String = "walk";
		private var _positionXHolder:Number = 0;
		private var _positionYHolder:Number = 0;
		private var _positionZHolder:Number = 0;
		private var _textureIndex:int;
		private var _meshIndex:int;
		private var _fpsIndex:Number = 30;
		private var _assetLoaded:Boolean = false;
		private var _visibility:Boolean = true;
		
		private var _mesh:Mesh;
		private var _vertAnimator:VertexAnimator;
		private var _animationLibrary:AnimationLibrary;
		
		private var _compoMaterial:CompositeMaterial;
		private var _textureMaterial:BitmapFileMaterial;
		
		private var _meshContainer:ObjectContainer3D;
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();
		private var _meshInstanceCode:String = ":";
		private var _instanceID:int;
		private var _canChangeIndex:Boolean = true;
		private var _meshRequestQueue:Vector.<int> = new Vector.<int>();
		private var _readyToLoadMesh:Boolean = true;
		
		public function JockeyBottomSet(instanceID:int, meshContainer3D:ObjectContainer3D)
		{ 
			_instanceID = instanceID;
			_meshContainer = meshContainer3D;
			_compoMaterial = new CompositeMaterial();
			loadAsset();
		}
		
		/**
		 * Starts the loading process of the mesh
		 * by listening for the xml loaded event.
		 */
		
		private function loadAsset():void{
			_assetLoaded = false;
			_jockeyGR.addOnXMLLoaded(onXMLLoaded);
			if (_jockeyGR.xmlLoaded[JockeyGR.BOTTOM_SET] == true){
				var params:Object = new Object();
				params.partType = JockeyGR.BOTTOM_SET;
				_jockeyGR.dispathcher.dispatchEvent(new JockeyEvent(JockeyEvent.XML_LOADED, params));
			}
		}
		
		/**
		 * Event function for when the xml has finished loaded.
		 */
		
		private function onXMLLoaded (evt:JockeyEvent):void{
			if (evt.params.partType == JockeyGR.BOTTOM_SET){
				_jockeyGR.removeOnXMLLoaded(onXMLLoaded);
				_readyToLoadMesh = false;
				_jockeyGR.loadMesh(_instanceID, JockeyGR.BOTTOM_SET, _meshIndex, _meshInstanceCode);
				_jockeyGR.addOnMeshLoaded(onMeshLoaded);
			}
		}
		
		/**
		 * Loads an instance of the mesh loaded
		 * and applies the necesary attributes.
		 */
		
		private function onMeshLoaded (evt:JockeyEvent):void{
			if (evt.params.partType == JockeyGR.BOTTOM_SET && evt.params.assetID == _instanceID){
				if (_meshContainer.getChildByName("jockeyBottom") != null){
					_meshContainer.removeChildByName("jockeyBottom");
				}
				_assetLoaded = true;
				_jockeyGR.removeOnMeshLoaded(onMeshLoaded);
				_mesh = _jockeyGR.getMesh(_instanceID, JockeyGR.BOTTOM_SET, _meshIndex);
				_meshInstanceCode = _jockeyGR.getMeshCode();
				textureLayeringManager(JockeyGR.TEXLAYER_MAIN);
				_mesh.rotationY = _rotationHolder;
				_mesh.position.x = _positionXHolder;
				_mesh.position.y = _positionYHolder;
				_mesh.position.z = _positionZHolder;
				_mesh.visible = visibility;
				_mesh.name = "jockeyBottom";
				_animationLibrary = mesh.animationLibrary;
				_vertAnimator = _animationLibrary.getAnimation(_animationCycleHolder).animator as VertexAnimator;
				_vertAnimator.play();
				_vertAnimator.fps = _fpsIndex;
				_meshContainer.addChild(_mesh);
				dispatchEvent(new JockeyEvent(JockeyEvent.MESH_RETRIEVED));
				dispatchEvent(new JockeyEvent(JockeyEvent.MESH_LOADED_ANIM));
				_readyToLoadMesh = true;
			}
		}
		
		/**
		 * Function to remove the mesh of the part type.
		 */
		
		public function removeMesh():void{
			for (var face:int=_mesh.faces.length-1; face>-1; face--){
				_mesh.removeFace(_mesh.faces[face]);
			}
			_meshContainer.removeChildByName("jockeyBottom");
			_mesh = null;
		}
		
		/**
		 * Sets the indexes to its default or initial values.
		 * Use only when initializing.
		 */
		
		public function setInitialIndexes():void{
			_meshIndex = JockeyGR.MESHBOTTOM_DEFAULT;
			_textureIndex = JockeyGR.MESHBOTTOM_DEFAULT;
		}
		
		/**
		 * Sets the texture based on the textureType set.
		 * 
		 * @params1:textureType - set the texture index. Use the constant values in
		 * this character set for reference.
		 */
		
		public function changeTexture (textureType:int):void{
			_textureIndex = textureType;
			textureLayeringManager(JockeyGR.TEXLAYER_MAIN);
		}
		
		/**
		 * Function to set the changing of the texture
		 * and layer them accordingly.
		 */
		
		private function textureLayeringManager(layer:String = ""):void{
			// Main Texture
			if (layer == JockeyGR.TEXLAYER_MAIN) {
				_compoMaterial.clearMaterials();
				_textureMaterial = _jockeyGR.getTexture(JockeyGR.BOTTOM_SET, _textureIndex);
				_compoMaterial.addMaterial(_textureMaterial);
			}
			_mesh.material = _compoMaterial;
		}
		
		/**
		 * Changes the mesh of the character set based on the int set.
		 * 
		 * @params1:meshType - set the mesh index. Use the constant values in
		 * this character set for reference.
		 */
		
		public function changeMesh (meshType:int):void{
			if (meshType != _meshIndex){
				_meshRequestQueue.push(meshType);
				if (_readyToLoadMesh == true){
					_meshIndex = _meshRequestQueue[0];
					_meshRequestQueue.shift();
					loadAsset();
				} else {
					addEventListener(JockeyEvent.MESH_RETRIEVED, onMeshRetrived);
				}
			}
		}
		
		/**
		 * Event function when a mesh is loaded.
		 */
		
		public function onMeshRetrived(evt:JockeyEvent):void{
			removeEventListener(JockeyEvent.MESH_RETRIEVED, onMeshRetrived);
			_meshIndex = _meshRequestQueue[0];
			loadAsset();
			_meshRequestQueue.shift();
		}
		
		/**
		 * Event function when asset loading is in process.
		 */
		
		private function onLoadProgress (evt:Loader3DEvent):void{
			//trace (evt.loader.bytesLoaded + "/" + evt.loader.bytesTotal);
		}
		
		/**
		 * Event function to trace error when loading the asset.
		 */
		
		// function to trace the error
		private function onLoadError (evt:Loader3DEvent):void{
			trace (evt.loader.IOErrorText);
		}
		
		/**
		 * Getter function to return the vertexAnimator variable of the mesh
		 * used to control the animation of the specific character set.
		 */
		
		public function get vertexAnimator():VertexAnimator{
			return _vertAnimator;
		}
		
		/**
		 * Sets the visibility of the mesh.
		 */
		
		public function visible (visibility:Boolean):void{
			_visibility = visibility;
			_mesh.visible = visibility;
		}
		
		/**
		 * Sets the alpha of the mesh. Use sparingly, since
		 * the use of ownCanvas properties can cause undesirable effects
		 * in viewing when the character set is integrated with other mesh. 
		 */
		
		public function alpha (alpha:Number):void{
			_mesh.ownCanvas = true;
			_mesh.alpha = alpha;
		}
		
		/**
		 * Return the value that specifies whether the asset has been loaded. 
		 */
		
		public function get assetLoaded():Boolean{
			return _assetLoaded;
		}
		
		/**
		 * Setter and getter function that sets and returns the index value of the current texture.
		 */
		
		public function set textureIndex(value:int):void{
			_textureIndex = value;
		}
		
		public function get textureIndex():int{
			return _textureIndex;
		}
		
		/**
		 * Setter and getter function that sets and returns the index value of the current mesh.
		 */
		
		public function set meshIndex(value:int):void{
			_meshIndex = value;
		}
		
		public function get meshIndex():int{
			return _meshIndex;
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
		 * Setter function that sets the visibility of the current mesh.
		 */
		
		public function set visibility (value:Boolean):void{
			_visibility = value;
		}
		
		/**
		 * Getter function that returns the state of the visibility of the 
		 * current mesh for reference.
		 */
		
		public function get visibility ():Boolean{
			return _visibility;
		}
		
		/**
		 * Returns the _mesh.
		 */
		
		public function get mesh():Mesh{
			return _mesh;
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