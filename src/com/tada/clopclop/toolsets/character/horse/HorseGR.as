package com.tada.clopclop.toolsets.character.horse
{
	import com.away3d.core.base.Mesh;
	import com.away3d.events.Loader3DEvent;
	import com.away3d.loaders.Loader3D;
	import com.away3d.loaders.Md2;
	import com.away3d.materials.BitmapFileMaterial;
	import com.away3d.materials.WireframeMaterial;
	import com.away3d.primitives.Plane;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * Author: Hedrick David
	 * 
	 * HorseGR = "Horse Global Reference"
	 * This is a singleton class that contains 
	 * the mesh and texture references 
	 * of the horse character.
	 */
	
	public class HorseGR 
	{
		//////////////////////////////////////////////////////////////////////
		// Start of constants
		//////////////////////////////////////////////////////////////////////
		
		// job queue constants
		public static const QUEUE_ANIM:int = 0;
		public static const QUEUE_MESH:int = 1;
		public static const QUEUE_TEX:int = 2;
		public static const QUEUE_DECAL:int = 3;
		
		// animation constants
		public static const ANIM_WALK:int = 0;
		public static const ANIM_IDLE01:int = 1;
		public static const ANIM_IDLE02:int = 2;
		public static const ANIM_PLEASANT:int = 3;
		public static const ANIM_DANCE:int = 4;
		public static const ANIM_SHOWER:int = 5;
		public static const ANIM_EAT:int = 6;
		public static const ANIM_HUNGRY:int = 7;
		public static const ANIM_SICK:int = 8;
		public static const ANIM_RODEO:int = 9;
		public static const ANIM_RUN:int = 10;
		public static const ANIM_PUSHUP:int = 11;
		public static const ANIM_SWIMMING:int = 12;
		public static const ANIM_HANDSTANDING:int = 13;
		public static const ANIMD_DIGGING:int = 14;
		public static const ANIM_SITUP:int = 15;
		public static const ANIM_JUMP:int = 16;
		public static const ANIM_LOSE:int = 17;
		
		// texture layering constants
		public static const TEXLAYER_INIT:String = "init";
		public static const TEXLAYER_MAIN:String = "main";
		public static const TEXLAYER_DECAL:String = "decal";
		public static const TEXLAYER_BRIDLE:String = "bridle";
		public static const TEXLAYER_SADDLE:String = "saddle";
		
		// AI constants
		public static const AI_OFF:int = -1;
		public static const AI_MOTION:int = 0;
		
		
		// Remove decals constants
		public static const REMOVEDECALS_ALL:int = 0;
		public static const REMOVEDECALS_PATTERNS:int =1;
		
		// XML
		public static const XML_MESH:String = "mesh";
		public static const XML_TEXTURE:String = "texture";
		
		// Main Body Parts
		public static const BODY_SET:int = 0;
		public static const EYE_SET:int = 1;
		public static const HAIR_SET:int = 2;
		public static const MOUTH_SET:int = 3;
		
		// Equipments
		public static const WING_SET:int = 4;
		public static const HEAD_SET:int = 5;
		public static const ACC_SET:int = 6;
		public static const BRIDLE_SET:int = 7;
		public static const SADDLE_SET:int = 8;
		
		// Sets
		public static const SET_DEFAULT:int = 0;
		public static const SET_WHITE:int = 1;
		public static const SET_BLACK:int = 2;
		public static const SET_ZEBRA:int = 3;
		
		// body mesh constants
		public static const MESHBODY_DEFAULT:int = 0;
		
		// body texture constants
		public static const TEXBODY_DEFAULT:int = 0;
		public static const TEXBODY_001_0002:int = 1;
		public static const TEXBODY_001_0003:int = 2;
		public static const TEXBODY_001_0004:int = 3;
		public static const TEXBODY_001_0005:int = 4;
		public static const TEXBODY_001_0006:int = 5;
		public static const TEXBODY_001_0007:int = 6;
		public static const TEXBODY_001_0008:int = 7;
		public static const TEXBODY_001_0009:int = 8;
		
		// saddle texture constants
		public static const TEXSADDLE_OFF:int = -1
		public static const TEXSADDLE_DEFAULT:int = 0;
		public static const TEXSADDLE_0002:int = 1;
		public static const TEXSADDLE_0003:int = 2;
		public static const TEXSADDLE_0004:int = 3;
		public static const TEXSADDLE_0005:int = 4;
		public static const TEXSADDLE_0006:int = 5;
		public static const TEXSADDLE_0007:int = 6;
		public static const TEXSADDLE_0008:int = 7;
		public static const TEXSADDLE_0009:int = 8;
		public static const TEXSADDLE_0010:int = 9;
		public static const TEXSADDLE_0011:int = 10;
		public static const TEXSADDLE_0012:int = 11;
		public static const TEXSADDLE_0013:int = 12;
		public static const TEXSADDLE_0014:int = 13;
		
		// bridle texture constants
		public static const TEXBRIDLE_OFF:int = -1
		public static const TEXBRIDLE_DEFAULT:int = 0;
		public static const TEXBRIDLE_0002:int = 1;
		public static const TEXBRIDLE_0003:int = 2;
		public static const TEXBRIDLE_0004:int = 3;
		public static const TEXBRIDLE_0005:int = 4;
		public static const TEXBRIDLE_0006:int = 5;
		public static const TEXBRIDLE_0007:int = 6;
		public static const TEXBRIDLE_0008:int = 7;
		public static const TEXBRIDLE_0009:int = 8;
		public static const TEXBRIDLE_0010:int = 9;
		public static const TEXBRIDLE_0011:int = 10;
		
		// body decal constants
		public static const DECBODY_OFF:int = -1;
		public static const DECBODY_001_0001:int = 0;
		public static const DECBODY_001_0002:int = 1;
		public static const DECBODY_001_0003:int = 2;
		public static const DECBODY_001_0004:int = 3;
		public static const DECBODY_001_0005:int = 4;
		public static const DECBODY_001_0006:int = 5;
		
		// eye mesh constants
		public static const MESHEYE_DEFAULT:int = 0;
		
		// eye texture constants
		public static const TEXEYE_DEFAULT:int = 0;
		public static const TEXEYE_001_0002:int = 1;
		public static const TEXEYE_001_0003:int = 2;
		public static const TEXEYE_001_0004:int = 3;
		public static const TEXEYE_001_0005:int = 4;
		public static const TEXEYE_001_0006:int = 5;
		public static const TEXEYE_001_0007:int = 6;
		public static const TEXEYE_001_0008:int = 7;
		public static const TEXEYE_001_0009:int = 8;
		public static const TEXEYE_001_0010:int = 9;
		public static const TEXEYE_001_0011:int = 10;
		public static const TEXEYE_001_0012:int = 11;
		public static const TEXEYE_001_0013:int = 12;
		
		// hair mesh constants
		public static const MESHHAIR_DEFAULT:int = 0;
		public static const MESHHAIR_002:int = 1;
		public static const MESHHAIR_003:int = 2;
		public static const MESHHAIR_004:int = 3;
		public static const MESHHAIR_005:int = 4;
		public static const MESHHAIR_006:int = 5;
		public static const MESHHAIR_007:int = 6;
		
		// hair texture constants
		public static const TEXHAIR_DEFAULT:int = 0;
		public static const TEXHAIR_001_0002:int = 1;
		public static const TEXHAIR_002_0001:int = 2;
		public static const TEXHAIR_002_0002:int = 3;
		public static const TEXHAIR_003_0001:int = 4;
		public static const TEXHAIR_003_0002:int = 5;
		public static const TEXHAIR_004_0001:int = 6;
		public static const TEXHAIR_004_0002:int = 7;
		public static const TEXHAIR_005_0001:int = 8;
		public static const TEXHAIR_005_0002:int = 9;
		public static const TEXHAIR_006_0001:int = 10;
		public static const TEXHAIR_006_0002:int = 11;
		public static const TEXHAIR_007_0001:int = 12;
		public static const TEXHAIR_007_0002:int = 13;

		
		// mouth mesh constants
		public static const MESHMOUTH_DEFAULT:int = 0;
		public static const MESHMOUTH_002:int = 1;
		public static const MESHMOUTH_003:int = 2;
		public static const MESHMOUTH_004:int = 3;
		
		// mouth texture constants
		public static const TEXMOUTH_DEFAULT:int = 0;
		public static const TEXMOUTH_001_0002:int = 1;
		public static const TEXMOUTH_002_0001:int = 2;
		public static const TEXMOUTH_002_0002:int = 3;
		public static const TEXMOUTH_002_0003:int = 4;
		public static const TEXMOUTH_003_0001:int = 5;
		public static const TEXMOUTH_003_0002:int = 6;
		public static const TEXMOUTH_003_0003:int = 7;
		public static const TEXMOUTH_004_0001:int = 8;
		public static const TEXMOUTH_004_0002:int = 9;
		public static const TEXMOUTH_004_0003:int = 10;
		
		// mesh constants
		public static const MESHWING_001:int = 0;
		
		// texture constants
		public static const TEXWING_001_0001:int = 0;
		
		// mesh constants
		public static const MESHHEAD_001:int = 0;
		
		// texture constants
		public static const TEXHEAD_001_0001:int = 0;
		
		// mesh constants
		public static const MESHACC_001:int = 0;
		
		// texture constants
		public static const TEXACC_001_0001:int = 0;
		
		//////////////////////////////////////////////////////////////////////
		// End of constants
		//////////////////////////////////////////////////////////////////////
		
		// instance of singleton class
		private static var _instance:HorseGR = new HorseGR();

		// XML locations
		private var _xmlLocations:Vector.<String> = new Vector.<String>();
		
		// mesh locations
		private var _assetPartsLocationVector:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();

		// texture locations
		private var _texturePartsLocationVector:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
		// decal locations
		private var _decalsPartsLocationVector:Vector.<Vector.<String>> =  new Vector.<Vector.<String>>();
	
		// xml variables
		private var _locLoaderVector:Vector.<URLLoader> = new Vector.<URLLoader>();
		private var _locRequestVector:Vector.<URLRequest> = new Vector.<URLRequest>();
		private var _locXMLVector:Vector.<XML> = new Vector.<XML>();
		
		// horse mesh parts container
		private var _horsePartContainerVector:Vector.<Vector.<Vector.<Mesh>>> = new Vector.<Vector.<Vector.<Mesh>>>();
		
		// horse texture parts container
		private var _horseTextureContainerVector:Vector.<Vector.<BitmapFileMaterial>> = new Vector.<Vector.<BitmapFileMaterial>> ();
		
		// horse decal parts container
		private var _horseDecalContainerVector:Vector.<Vector.<BitmapFileMaterial>> =  new Vector.<Vector.<BitmapFileMaterial>>();
		
		// animation container 
		private var _horseAnimTimeline:Vector.<Number> = new Vector.<Number>();
		private var _horseAnimTimelineMax:Vector.<Number> = new Vector.<Number>();
		private var _horseAnimCycleNames:Vector.<String> = new Vector.<String>();
		
		private var _animLocLoader:URLLoader = new URLLoader();
		private var _animRequestLoader:URLRequest = new URLRequest();
		private var _animXML:XML = new XML();
		
		private var _md2:Md2;
		private var _loaderVector:Vector.<Vector.<Loader3D>> = new Vector.<Vector.<Loader3D>>;
		private var _mesh:Mesh;
		private var _indexQueue:Array = [new Array()];
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _xmlLoadedArray:Array = [false,false,false,false,false,false,false,false,false];
		private var _meshPartsLen:int = 7;
		private var _texturePartsLen:int = 9;
		private var _instanceCode:String = "";
		private var _instanceCount:int = -1;
		
		// shadow variables
		private var _meshPlane:Plane;
		private var _shadowMesh:Plane;
		private var _shadowTexture:BitmapFileMaterial;
		
		private var _animXMLLoaded:Boolean = false;
		private var _initAnimExec:Boolean = false;
		private var _assetXMLLoaded:Vector.<Boolean> = new Vector.<Boolean>;
		
		public function HorseGR()
		{
			if (_instance){
				throw new Error ("Cannot create a new instance of this singleton class" +
					" Pls. use the HorseGR.getInstance()");
			} 
			initBasicPlane();
			initShadow();
			initVectors();
			for (var part:int =0; part<_meshPartsLen; part++){
				initXML(part);
			}
		}
		
		/**
		 * Creates a basic mesh for temporary placement.
		 */
		
		public function initBasicPlane ():void{
			_meshPlane = new Plane();
		}
		
		public function get dispathcher ():EventDispatcher{
			return _dispatcher;
		}
		
		/**
		 * Retrives a copy of the plane.
		 */
		
		public function getTempMesh ():Plane{
			var mesh:Plane = new Plane();
			_meshPlane.clone(mesh); 
			return mesh;
		}

		
		/**
		 * Returns the array that determines if the xml has been loaded.
		 */
		
		public function get xmlLoaded ():Array{
			return _xmlLoadedArray;
		}
		
		/**
		 * Initializes the XML for the animation locations.
		 */
		
		public function initAnimXML():void{
			if (_initAnimExec == false){ 
				_animRequestLoader = new URLRequest("xml/horse/TCC_Horse_Animation.XML");
				_animLocLoader = new URLLoader();
				_animLocLoader.load(_animRequestLoader);
				initAnimXMLListeners();
				_initAnimExec = true;
			} 
		}
		
		/**
		 * Initializes the listeners for the XML
		 */
		
		private function initAnimXMLListeners():void{
			_animLocLoader.addEventListener(Event.COMPLETE, onAnimLoaderComplete);
			_animLocLoader.addEventListener(IOErrorEvent.IO_ERROR, onAnimLoaderError);
		}
		
		/**
		 * Gets the loaded data when loader completes.
		 */
		
		private function onAnimLoaderComplete(evt:Event):void{
			_animLocLoader.removeEventListener(Event.COMPLETE, onAnimLoaderComplete);
			_animLocLoader.removeEventListener(IOErrorEvent.IO_ERROR, onAnimLoaderError);
			_animXML = new XML(evt.target.data);
			setAnimationTimeline();
		}
		
		/**
		 * Returns the status if the animation XML has been loaded.
		 */
		
		public function animXMLLoaded ():Boolean{
			return _animXMLLoaded;
		}
		
		/**
		 * Returns the status if the assets has been loaded.
		 */
		
		public function assetsXMLLoaded ():Vector.<Boolean>{
			return _assetXMLLoaded;
		}
		
		/**
		 * Sets the contents of the locations of the 
		 * animation timeline.
		 */
		
		private function setAnimationTimeline():void{
			var xmlList:XMLList = _animXML.children();
			for each (var set:XML in xmlList){
				var setAttr:String = set.attribute("name");
				var setStr:String = set.text();
				switch (setAttr){
					case "timeline":
						for each (var cycle:XML in set.children()){
							_horseAnimTimeline.push(int(cycle.text()));
							_horseAnimCycleNames.push(String(cycle.attribute("name")));
						}
						break;
					case "timelineEnd":
						for each (cycle in set.children()){
							_horseAnimTimelineMax.push(int(cycle.text()));
						}
						break;
				}
			}
			_animXMLLoaded = true;
			_dispatcher.dispatchEvent(new HorseEvent(HorseEvent.ANIMXML_LOADED));
		}
		
		/**
		 * Event function to trace error when loading animation XML.
		 */
		
		private function onAnimLoaderError (evt:IOErrorEvent):void{
			trace ("Error loading xml: " + evt);
		}
		
		/**
		 * Adds a listener if asset has been loaded.
		 */
		
		public function addOnMeshRetrieved (listener:Function):void{
			_dispatcher.addEventListener(HorseEvent.MESH_RETRIEVED, listener);
		}
		
		/**
		 * Removes the listener that has been added to check if asset has been loaded.
		 */
		
		public function removeOnMeshRetrieved (listener:Function):void{
			_dispatcher.removeEventListener(HorseEvent.MESH_RETRIEVED, listener);
		}
		
		/**
		 * Creates a listener for loaded animation XML.
		 */
		
		public function addOnAnimXMLLoaded (listener:Function):void{
			_dispatcher.addEventListener(HorseEvent.ANIMXML_LOADED, listener);
		}
		
		/**
		 * Removes the created listener for loaded animation XML.
		 */
		
		public function removeOnAnimXMLLoaded (listener:Function):void{
			_dispatcher.removeEventListener(HorseEvent.XML_LOADED, listener);
		}
		
		/**
		 * Returns the animationTimeLine Vector.
		 */
		
		public function getAnimationTimeline ():Vector.<Number>{
			return _horseAnimTimeline;
		}
		
		/**
		 * Returns the animationTimeLine Vector.
		 */
		
		public function getAnimationTimelineMax ():Vector.<Number>{
			return _horseAnimTimelineMax;
		}
		
		/**
		 * Returns the animationCycleNames Vector.
		 */
		
		public function getAnimationCycleNames ():Vector.<String>{
			return _horseAnimCycleNames;
		}
		
		/**
		 * Sets the shadows property.
		 */
		
		private function initShadow():void{
			_shadowMesh = new Plane;
			_shadowMesh.scale(21);
			_shadowMesh.moveBackward(29.5);
			_shadowMesh.moveLeft(3);
			_shadowMesh.bothsides = true;
			_shadowMesh.pushback = true;
			_shadowTexture = new BitmapFileMaterial("assets/horse/ETC/shadow.png")
			_shadowTexture.scaleY = .4;
			_shadowTexture.scaleX = 1;
			_shadowTexture.alpha = .4;
		}
		
		/**
		 * Returns a shadow.
		 */
		
		public function getShadow ():Plane{
			var shadow:Plane = new Plane();
			_shadowMesh.clone(shadow) as Plane;
			shadow.material = _shadowTexture;
			return shadow;
		}
		
		/**
		 * Initializes null or containers for vector content.
		 */
		
		private function initVectors ():void{
			_xmlLocations[0] = "xml/horse/TCC_Horse_BodyElementsLocation.xml";
			_xmlLocations[1] = "xml/horse/TCC_Horse_EyeElementsLocation.xml";
			_xmlLocations[2] = "xml/horse/TCC_Horse_HairElementsLocation.xml";
			_xmlLocations[3] = "xml/horse/TCC_Horse_MouthElementsLocation.xml";
			_xmlLocations[4] = "xml/horse/TCC_Horse_WingElementsLocation.xml";
			_xmlLocations[5] = "xml/horse/TCC_Horse_HeadElementsLocation.xml";
			_xmlLocations[6] = "xml/horse/TCC_Horse_AccessoryElementsLocation.xml";
			
			for (var vect:int = 0; vect < _meshPartsLen; vect++){
				_assetPartsLocationVector[vect] = null;
				_horsePartContainerVector[vect] = new Vector.<Vector.<Mesh>>();
				_loaderVector[vect] = new Vector.<Loader3D>;
				_indexQueue[vect] = new Array();
			}
			
			for (vect = 0; vect < _texturePartsLen; vect++){
				_assetXMLLoaded[vect] = false;
				_texturePartsLocationVector[vect] = null;
				_decalsPartsLocationVector[vect] = null;
				_horseTextureContainerVector[vect] = new Vector.<BitmapFileMaterial>();
				_horseDecalContainerVector[vect] = new Vector.<BitmapFileMaterial>();
			}
		}
		
		/**
		 * Registers new assets. Returns the id of the asset instance.
		 */
		
		public function registerInstance(instanceID:int):int {
			if (instanceID == -1){
				_instanceCount++;
				if (_horsePartContainerVector[0].length > 0){
					populateVector(instanceID);
				}
				return _instanceCount;
			} else if (instanceID <= _instanceCount){
				throw new Error ("Cannot duplicate registration of assets");
			} else {
				throw new Error ("Unauthorized registration");
			}
			return null;
		}
		
		private function populateVector (assetID:int):void{
			for (var vect:int = 0; vect<_horsePartContainerVector.length; vect++){
				for (var vect2:int = 0; vect2<_horsePartContainerVector[vect].length; vect2++){
					_horsePartContainerVector[vect][vect2][assetID] = null;
				}
			}
			for (var part:int =0; part<_meshPartsLen; part++){
				_indexQueue[part][assetID] = null;
				_loaderVector[part][assetID] = null;
			}
		}
		
		/**
		 * Returns the amount of instances used.
		 */
		
		public function get totalAssetUsed():int{
			return _instanceCount;
		}
		
		/**
		 * This function gets the specific part of the character mesh. 
		 * 
		 * @params1:partType - the type of body part.
		 * @params2:meshIndex - set the index of the mesh to be loaded.
		 */
		
		public function getMesh (assetID:int, partType:int, meshIndex:int):Mesh{
			if (assetID <= _instanceCount){
				return  _horsePartContainerVector[partType][meshIndex][assetID];
			} else {
				throw new Error ("Mesh not yet loaded, Pls. execute the loadMesh() function first");
			}
		}
		
		/**
		 * Returns the part and mesh index.  
		 * Separate string using ":" without the 
		 * quotes. The first number determines the
		 * part type and the second number determines 
		 * the mesh instance.
		 */
		
		public function getMeshCode ():String{
			return _instanceCode;
		}
		
		/**
		 * This function gets the texture of the specific body part. 
		 * 
		 * @params1:partType - set the index of the part of body type from 
		 * where the texture will be returned.
		 * @params2:textureIndex - set the index of the texture to be returned.
		 */
		
		public function getTexture (partType:int, textureIndex:int):BitmapFileMaterial{
			if (_horseTextureContainerVector[partType][textureIndex] == null){
				var texture:BitmapFileMaterial = new BitmapFileMaterial (_texturePartsLocationVector[partType][textureIndex]);
				_horseTextureContainerVector[partType][textureIndex] = texture;
				return _horseTextureContainerVector[partType][textureIndex];
			} else {
				return _horseTextureContainerVector[partType][textureIndex];
			}
		}
		
		/**
		 * This function gets the texture of the specific body part. 
		 * 
		 * @params1:partType - set the index of the part of body type from 
		 * where the decal will be returned.
		 * @params2:decalIndex - set the index of the decal to be returned.
		 */
		
		public function getDecals (partType:int, decalIndex:int):BitmapFileMaterial{
			if (_horseDecalContainerVector[partType][decalIndex] == null){
				var texture:BitmapFileMaterial = new BitmapFileMaterial (_decalsPartsLocationVector[partType][decalIndex]);
				_horseDecalContainerVector[partType][decalIndex] = texture;
				return _horseDecalContainerVector[partType][decalIndex];
			} else {
				return _horseDecalContainerVector[partType][decalIndex];
			}
		}
		
		/**
		 * This function loads the asset from the assetIndex and textureIndex set.
		 * 
		 * @params1:partType - set the index of the part of body type from 
		 * where the mesh will be loaded.
		 * Use the constants of this character set for reference.
		 * @params2:meshIndex - set the index of the mesh to be loaded.
		 * Use the constants of this character set for reference.
		 */
		
		public function loadMesh(assetID:int, partType:int, meshIndex:int, meshInstanceCode:String):void{
				_indexQueue[partType][assetID] = meshIndex;
				_md2 = new Md2();
				_md2.material = new WireframeMaterial();
				_loaderVector[partType][assetID] = new Loader3D();
				_loaderVector[partType][assetID].addEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
				_loaderVector[partType][assetID].addEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
				_loaderVector[partType][assetID].loadGeometry(_assetPartsLocationVector[partType][meshIndex],_md2);
		}
		
		/**
		 * Add a listener when the specific part of xml is loaded.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function addOnXMLLoaded (listener:Function):void{
			_dispatcher.addEventListener(HorseEvent.XML_LOADED, listener);
		}
		
		/**
		 * Remove the listener for the xml complete event.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function removeOnXMLLoaded (listener:Function):void{
			_dispatcher.addEventListener(HorseEvent.XML_LOADED, listener);
		}
		
		/**
		 * Add a listener when the specific part of mesh is loaded.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function addOnMeshLoaded (listener:Function):void{
			_dispatcher.addEventListener(HorseEvent.MESH_LOADED, listener);
		}
		
		/**
		 * Remove the listener for the mesh complete event.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function removeOnMeshLoaded (listener:Function):void{
			_dispatcher.removeEventListener(HorseEvent.MESH_LOADED, listener);
		}
		
		/**
		 * Event function when the asset loaded is complete.
		 */
		
		private function onLoadComplete (evt:Loader3DEvent):void{
			// Remove event listeners after complete
			var params:Object = new Object(); 
			for (var part:int = 0; part<_loaderVector.length; part++){
				for (var assetID:int = 0; assetID<_loaderVector[part].length; assetID++){
					if (evt.currentTarget == _loaderVector[part][assetID]){
						_loaderVector[part][assetID].removeEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
						_loaderVector[part][assetID].removeEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
						_horsePartContainerVector[part][_indexQueue[part][assetID]][assetID] = _loaderVector[part][assetID].handle as Mesh;
						params.partType = part;
						params.meshIndex = _indexQueue[part][assetID];
						params.assetID = assetID;
						_instanceCode = String(part) + ":" +  String(_indexQueue[part][assetID]) + ":" + String(_horsePartContainerVector[part][_indexQueue[part][assetID]].length - 1);
						_dispatcher.dispatchEvent(new HorseEvent (HorseEvent.MESH_LOADED,params));
						break;
					}
				}
			}
		}
		
		/**
		 * Event function to trace error when loading the asset.
		 */
		
		private function onLoadError (evt:Loader3DEvent):void{
			trace (evt.loader.IOErrorText);
		}
		
		/**
		 * Sets the contents of the locations of the 
		 * mesh, main and decal textures.
		 */
		
		private function initElementLocs(index:int):void{
			var xmlList:XMLList = _locXMLVector[index].children();
			for each (var type:XML in xmlList){
				var typeAttr:String = type.attribute("name");
				var setXMLList:XMLList = setXMLList = type.children();
				for each(var part:XML in setXMLList){ 
					var partAttr:String = part.attribute("name");
					var partStr:String = part.text();
					switch (partAttr){
						case "mesh":
							switch (typeAttr){
								case "body":
									_assetPartsLocationVector[BODY_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "hair":
									_assetPartsLocationVector[HAIR_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "eye":
									_assetPartsLocationVector[EYE_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "mouth":
									_assetPartsLocationVector[MOUTH_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "wing":
									_assetPartsLocationVector[WING_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "acc":
									_assetPartsLocationVector[ACC_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "head":
									_assetPartsLocationVector[HEAD_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
							}
							break;
						case "texture":
							for each (var tex:XML in part.children()){
							var texAttr:String = tex.attribute("name");
							var texStr:String = tex.text();
							switch (texAttr){
								case "main":
									switch (typeAttr){
										case "body":
											_texturePartsLocationVector[BODY_SET]= convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "hair":
											_texturePartsLocationVector[HAIR_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "eye":
											_texturePartsLocationVector[EYE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "mouth":
											_texturePartsLocationVector[MOUTH_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "wing":
											_texturePartsLocationVector[WING_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "acc":
											_texturePartsLocationVector[ACC_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "head":
											_texturePartsLocationVector[HEAD_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "bridle":
											_texturePartsLocationVector[BRIDLE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "saddle":
											_texturePartsLocationVector[SADDLE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
									}
									break;
								case "decal":
									switch (typeAttr){
										case "body":
											_decalsPartsLocationVector[BODY_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "hair":
											_decalsPartsLocationVector[HAIR_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "eye":
											_decalsPartsLocationVector[EYE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "mouth":
											_decalsPartsLocationVector[MOUTH_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "wing":
											_decalsPartsLocationVector[WING_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "acc":
											_decalsPartsLocationVector[ACC_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "head":
											_decalsPartsLocationVector[HEAD_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "bridle":
											_decalsPartsLocationVector[BRIDLE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "saddle":
											_decalsPartsLocationVector[SADDLE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
									}
									break;
							}
						}
							break;
					}
				}
			}
			populateVectorContainer(index);
			if (index == BODY_SET){
				populateVectorContainer(SADDLE_SET);
				populateVectorContainer(BRIDLE_SET);
				_assetXMLLoaded[SADDLE_SET] = true;
				_assetXMLLoaded[BRIDLE_SET] = true;
			} 
			_assetXMLLoaded[index] = true;
		}
		
		/**
		 * Populate the vector containers of assets after the xml
		 * has loaded the asset locations. Needed as vector 
		 * procedure.
		 * 
		 * params1@:part -  the index wher the new vectors will be added;
		 */
		
		private function populateVectorContainer(part:int):void{
			if (part < _meshPartsLen){
				for (var item:int = 0; item<_assetPartsLocationVector[part].length;item++){
					_horsePartContainerVector[part][item] = new Vector.<Mesh>;
					for (var inst:int = 0; inst < _instanceCount; inst++){
						_horsePartContainerVector[part][item][inst] = null;
					}
				}
				
				for (inst = 0; inst < _instanceCount; inst++){
					_indexQueue[part][inst] = null;
					_loaderVector[part][inst] = null;
				}
			}
			
			for (item = 0; item<_texturePartsLocationVector[part].length;item++){
				_horseTextureContainerVector[part][item] = null;
			}

			for (item = 0; item<_decalsPartsLocationVector[part].length;item++){
				_horseDecalContainerVector[part][item] = null;
			}
		}
		
		/**
		 * Transforms the array containing strings into a vector. 
		 * Returns a vector containing the string.
		 * 
		 * params1@:setArray -  the array containing the strings;
		 */
		
		private function convertArrayToString (strArray:Array):Vector.<String>{
			var  vector:Vector.<String> = new Vector.<String>();
			for (var item:int = 0; item<strArray.length; item++){
				vector.push(strArray[item]);
			}
			return vector;
		}
		
		/**
		 * Transforms the array containing string into a vector. 
		 * Returns a vector containing the int.
		 * 
		 * params1@:setArray -  the array containing the strings;
		 */
		
		private function convertArrayToInt (strArray:Array):Vector.<int>{
			var  vector:Vector.<int> = new Vector.<int>();
			for (var item:int = 0; item<strArray.length; item++){
				vector.push(strArray[item]);
			}
			return vector;
		}
		
		/**
		 * Initializes the xml loader.
		 */
		
		private function initXML(part:int):void{
			_locRequestVector[part] = new URLRequest(_xmlLocations[part]);
			_locLoaderVector[part] = new URLLoader();
			_locLoaderVector[part].load(_locRequestVector[part]);
			initXMLlisteners(part);
		}
		
		/**
		 * Event listeners for xml loader
		 */
		
		private function initXMLlisteners(part:int):void{
			_locLoaderVector[part].addEventListener(Event.COMPLETE, onLoaderComplete);
			_locLoaderVector[part].addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		// Under Construction
		/**
		 * Function to remove all available mesh assets in container.
		 */
		
		public function removeAllMeshAssets():void{
			for (var vect1:int = _horsePartContainerVector.length -1; vect1 >= 0; vect1--){
				for (var vect2:int = _horsePartContainerVector[vect1].length -1; vect2 >= 0; vect2--){
					for (var mesh:int = _horsePartContainerVector[vect1][vect2].length -1; mesh >= 0; mesh--){
						
						
					}
				}
			}
		}
		
		/**
		 * Function to remove all available texture assets in container.
		 */
		
		public function removeAllTextureAssets():void{
			
		}
		
		/**
		 * Function to remove all available decal texture assets in container.
		 */
		
		public function removeAllDecalAssets():void{
			
		}
		
		
		/**
		 * Function to remove all assets.
		 */
		
		public function removeAll():void{
			removeAllMeshAssets();
			removeAllMeshAssets();
			removeAllDecalAssets();
		}
		//////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Sets the xml container, initializes contents of the locations
		 * for meshes and textures.
		 */
		
		private function onLoaderComplete(evt:Event):void{
			var params:Object = new Object(); 
			evt.currentTarget.removeEventListener(Event.COMPLETE, onLoaderComplete);
			evt.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, onAnimLoaderError);
			for (var loader:int = 0; loader<_locLoaderVector.length; loader++){
				if (evt.currentTarget == _locLoaderVector[loader]){
					_locXMLVector[loader] = new XML(evt.target.data);
					initElementLocs(loader);
					_xmlLoadedArray[loader] = true;
					params.partType = loader;
					break;
				}
			}
			_dispatcher.dispatchEvent(new HorseEvent(HorseEvent.XML_LOADED,params));
		}
		
		/**
		 * Event function to trace error when loading animation XML.
		 */
		
		private function onLoaderError (evt:IOErrorEvent):void{
			trace ("Error loading xml: " + evt);
		}
		
		/**
		 * Returns the instance of this singleton class.
		 */
		
		public static function getInstance():HorseGR{
			return _instance;
		}
	}
}