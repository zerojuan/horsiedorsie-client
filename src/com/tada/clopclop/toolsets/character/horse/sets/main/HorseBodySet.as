package com.tada.clopclop.toolsets.character.horse.sets.main
{
	import com.away3d.animators.Animator;
	import com.away3d.animators.VertexAnimator;
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.core.base.Mesh;
	import com.away3d.loaders.utils.AnimationLibrary;
	import com.away3d.materials.BitmapFileMaterial;
	import com.away3d.materials.CompositeMaterial;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.horse.sets.HorseCharacterSets;
	
	import flash.events.EventDispatcher;
	
	
	/**
	 * Author: Hedrick David
	 * 
	 * This class, among the other CharacterSets class instantiates the assets
	 * of the corresponding parts of the character. This class includes
	 * functions that help in the control of the character like the animation,
	 * texture and mesh customizations as well as other utilities.
	 * 
	 */
	
	public class HorseBodySet extends EventDispatcher implements HorseCharacterSets
	{
		private var _rotationHolder:Number = 0;
		private var _animationHolder:int = 0;
		private var _animationCycleHolder:String = "walk";
		private var _positionXHolder:Number = 0;
		private var _positionYHolder:Number = 0;
		private var _positionZHolder:Number = 0;
		private var _textureIndex:int;
		private var _decalIndex:int;
		private var _meshIndex:int;
		private var _fpsIndex:Number = 30;
		private var _saddleIndex:int = 0;
		private var _bridleIndex:int = 0;
		private var _assetLoaded:Boolean = false;
		private var _visibility:Boolean = true;
		
		private var _mesh:Mesh;
		private var _vertAnimator:VertexAnimator;
		private var _animationLibrary:AnimationLibrary;
		
		// material layers and composite varibles
		private var _decalCompoMaterial:CompositeMaterial;
		private var _compoMaterial:CompositeMaterial;
		private var _textureMaterial:BitmapFileMaterial;
		private var _saddleMaterial:BitmapFileMaterial;
		private var _bridleMaterial:BitmapFileMaterial;
		private var _decalPatternMaterial:BitmapFileMaterial;
		private var _meshContainer:ObjectContainer3D; 
		private var _horseGR:HorseGR = HorseGR.getInstance();
		private var _animator:Animator;
		private var _meshInstanceCode:String = ":";
		private var _instanceID:int;
		private var _canChangeIndex:Boolean = true;
		private var _meshRequestQueue:Vector.<int> = new Vector.<int>();
		private var _readyToLoadMesh:Boolean = false;
		
		public function HorseBodySet(instanceID:int, meshContainer:ObjectContainer3D)
		{ 
			_instanceID = instanceID; 
			_meshContainer = meshContainer;
			_compoMaterial = new CompositeMaterial();
			_decalCompoMaterial = new CompositeMaterial();
			loadAsset();
		}
		
		/**
		 * Starts the loading process of the mesh
		 * by listening for the xml loaded event.
		 */
		
		private function loadAsset():void{
			_assetLoaded = false;
			_horseGR.addOnXMLLoaded(onXMLLoaded);
			if (_horseGR.xmlLoaded[HorseGR.BODY_SET] == true){
				var params:Object = new Object();
				params.partType = HorseGR.BODY_SET;
				_horseGR.dispathcher.dispatchEvent(new HorseEvent(HorseEvent.XML_LOADED, params));
			}
		}
		
		/**
		 * Event function for when the xml has finished loaded.
		 */
		
		private function onXMLLoaded (evt:HorseEvent):void{
			if (evt.params.partType == HorseGR.BODY_SET){
				_horseGR.removeOnXMLLoaded(onXMLLoaded);
				_readyToLoadMesh = false;
				_horseGR.loadMesh(_instanceID, HorseGR.BODY_SET, _meshIndex, _meshInstanceCode);
				_horseGR.addOnMeshLoaded(onMeshLoaded);
			}
		}
		
		/**
		 * Loads an instance of the mesh loaded
		 * and applies the necesary attributes.
		 */
		
		private function onMeshLoaded (evt:HorseEvent):void{
			if (evt.params.partType == HorseGR.BODY_SET && evt.params.assetID == _instanceID){
				if (_meshContainer.getChildByName("horseBody") != null){
					_meshContainer.removeChildByName("horseBody");
				}
				_assetLoaded = true;
				_horseGR.removeOnMeshLoaded(onMeshLoaded);
				_mesh = _horseGR.getMesh(_instanceID, HorseGR.BODY_SET, _meshIndex);
				_meshInstanceCode = _horseGR.getMeshCode();
				textureLayeringManager(HorseGR.TEXLAYER_MAIN);
				_mesh.rotationY = _rotationHolder;
				_mesh.position.x = _positionXHolder;
				_mesh.position.y = _positionYHolder;
				_mesh.position.z = _positionZHolder;
				_mesh.visible = visibility;
				_mesh.name = "horseBody";
				_mesh.pushback = true;
				_animationLibrary = mesh.animationLibrary;
				_vertAnimator = _animationLibrary.getAnimation(_animationCycleHolder).animator as VertexAnimator;
				_vertAnimator.play();
				_vertAnimator.fps = _fpsIndex;
				_meshContainer.addChild(_mesh);
				dispatchEvent(new HorseEvent(HorseEvent.MESH_RETRIEVED));
				dispatchEvent(new HorseEvent(HorseEvent.MESH_LOADED_ANIM));
				_readyToLoadMesh = true;
			}
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
					addEventListener(HorseEvent.MESH_RETRIEVED, onMeshRetrived);
				}
			}
		}
		
		/**
		 * Event function when a mesh is loaded.
		 */
		
		public function onMeshRetrived(evt:HorseEvent):void{
			removeEventListener(HorseEvent.MESH_RETRIEVED, onMeshRetrived);
			_meshIndex = _meshRequestQueue[0];
			loadAsset();
			_meshRequestQueue.shift();
		}
		
		/**
		 * Sets the indexes to its default or initial values.
		 * Use only when initializing.
		 */
		
		public function setInitialIndexes():void{
			_meshIndex = HorseGR.MESHBODY_DEFAULT;
			_textureIndex = HorseGR.TEXBODY_DEFAULT;
			_decalIndex = HorseGR.DECBODY_OFF;
			_bridleIndex = HorseGR.TEXBRIDLE_OFF;
			_saddleIndex = HorseGR.TEXSADDLE_OFF;
		}
		
		/**
		 * Returns the _mesh.
		 */
		
		public function get mesh():Mesh{
			return _mesh;
		}
		
	
		/**
		 * Sets the texture based on the textureType set.
		 * 
		 * @params1:textureType - set the texture index. Use the constant values in
		 * this character set for reference.
		 */
		
		public function changeTexture (textureType:int):void{
			_textureIndex = textureType;
			textureLayeringManager(HorseGR.TEXLAYER_MAIN);
		}
		
		/**
		 * Sets the bridle texture based on the textureTexType set.
		 * 
		 * @params1:bridleTexType - set the index of the bridle type. Use the constant values in
		 * this character set for reference. Set to TEXBRIDLE_OFF to remove the texture
		 */
		
		public function changeBridleTexture (bridleTexType:int):void{
			_bridleIndex = bridleTexType;
			if (_bridleIndex == HorseGR.TEXBRIDLE_OFF){
				_compoMaterial.removeMaterial(_bridleMaterial);
			} else {
				textureLayeringManager(HorseGR.TEXLAYER_BRIDLE);
			}
		}
		
		/**
		 * Function to set the changing of the texture
		 * and layer them accordingly.
		 */
		
		private function textureLayeringManager(layer:String = ""):void{
			// Main Texture
			if (layer == HorseGR.TEXLAYER_MAIN) {
				_compoMaterial.clearMaterials();
				_textureMaterial = _horseGR.getTexture(HorseGR.BODY_SET, _textureIndex);
				_compoMaterial.addMaterial(_textureMaterial);
			}
			
			// Decal Texture
			if (_decalIndex != HorseGR.DECBODY_OFF && (layer == HorseGR.TEXLAYER_DECAL || layer == HorseGR.TEXLAYER_MAIN)){
				_compoMaterial.removeMaterial(_decalCompoMaterial);
				_decalCompoMaterial.clearMaterials();
				_decalPatternMaterial = _horseGR.getDecals(HorseGR.BODY_SET, _decalIndex);
				_decalCompoMaterial.addMaterial(_decalPatternMaterial);
				_compoMaterial.addMaterial(_decalCompoMaterial);
			}
			
			// Bridle Texture
			if (_bridleIndex != HorseGR.TEXBRIDLE_OFF && (layer == HorseGR.TEXLAYER_BRIDLE || layer == HorseGR.TEXLAYER_MAIN || layer == HorseGR.TEXLAYER_DECAL)){
				_compoMaterial.removeMaterial(_bridleMaterial);
				_bridleMaterial = _horseGR.getTexture(HorseGR.BRIDLE_SET, _bridleIndex);
				_compoMaterial.addMaterial(_bridleMaterial);
			}
			
			// Saddle Texture
			if (_saddleIndex != HorseGR.TEXSADDLE_OFF && (layer == HorseGR.TEXLAYER_SADDLE || layer == HorseGR.TEXLAYER_MAIN || layer == HorseGR.TEXLAYER_DECAL)){
				_compoMaterial.removeMaterial(_saddleMaterial);
				_saddleMaterial = _horseGR.getTexture(HorseGR.SADDLE_SET, _saddleIndex);
				_compoMaterial.addMaterial(_saddleMaterial);
			}
			_mesh.material = _compoMaterial;
		}
		
		/**
		 * Sets the saddle texture based on the textureTexType set.
		 * 
		 * @params1:saddleTexType - set the index of the saddle type. Use the constant values in
		 * this character set for reference. Set to TEXSADDLE_OFF to remove the texture.
		 */
		
		public function changeSaddleTexture(saddleTexType:int):void{
			_saddleIndex = saddleTexType;
			if (_saddleIndex == HorseGR.TEXSADDLE_OFF){
				_compoMaterial.removeMaterial(_saddleMaterial);
			} else {
				textureLayeringManager(HorseGR.TEXLAYER_SADDLE);
			}
		}
		
		/**
		 * Function to change the decal texture of the mesh.
		 * 
		 * @params1:decalType - set the decal type to be changed. Use the constants in this class.
		 */
		
		public function changeDecals (decalType:int):void{
			_decalIndex = decalType;
			if (decalType == HorseGR.DECBODY_OFF){
				_compoMaterial.removeMaterial(_decalCompoMaterial);	
			} else {
				textureLayeringManager(HorseGR.TEXLAYER_DECAL);
			}
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
		 * Setter and getter function that sets and returns the index value of the current bridle texture
		 * for reference.
		 */
		
		public function set bridleIndex(value:int):void{
			_bridleIndex = value;
		}
		
		public function get bridleIndex():int{
			return _bridleIndex;
		}
		
		/**
		 * Setter and getter function that sets and returns the index value of the current saddle texture
		 * for reference.
		 */
		
		public function set saddleIndex(value:int):void{
			_saddleIndex = value;
		}
		
		public function get saddleIndex():int{
			return _saddleIndex;
		}
		
		/**
		 * Setter and getter function that sets and returns the index value of the current decal texture
		 * for reference.
		 */
		
		public function set decalIndex(value:int):void{
			_decalIndex = value;
		}
		
		public function get decalIndex():int{
			return _decalIndex;
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