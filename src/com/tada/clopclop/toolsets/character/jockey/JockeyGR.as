package com.tada.clopclop.toolsets.character.jockey
{
	import com.away3d.core.base.Mesh;
	import com.away3d.events.Loader3DEvent;
	import com.away3d.loaders.Loader3D;
	import com.away3d.loaders.Md2;
	import com.away3d.materials.BitmapFileMaterial;
	import com.away3d.materials.WireframeMaterial;
	import com.away3d.primitives.Plane;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * Author: Hedrick David
	 * 
	 * JockeyGR = "Jockey Global Reference"
	 * This is a singleton class that contains 
	 * the mesh and texture references 
	 * of the jockey character.
	 */
	
	public class JockeyGR 
	{
		//////////////////////////////////////////////////////////////////////
		// Start of constants
		//////////////////////////////////////////////////////////////////////
		
		// job queue constants
		public static const QUEUE_ANIM:int = 0;
		public static const QUEUE_MESH:int = 1;
		public static const QUEUE_TEX:int = 2;
		public static const QUEUE_DECAL:int = 3;
		
		// Main Body Parts
		public static const SKIN_SET:int = 0;
		public static const HAIR_SET:int = 1;
		public static const EYE_SET:int = 2;
		public static const TOP_SET:int = 3;
		public static const BOTTOM_SET:int = 4;
		public static const SHOES_SET:int = 5;
		
		// Equipments
		public static const HEAD_SET:int = 6;
		public static const ACC_SET:int = 7;
		
		// tool based
		public static const TOOL_SET:int = 8;
		
		// Texture Based
		public static const EYEBROW_SET:int = 9;
		public static const MOUTH_SET:int = 10;
		
		// AI constants
		public static const AI_OFF:int = -1;
		public static const AI_MOTION:int = 0;
		
		// Remove decals constants
		public static const REMOVEDECALS_ALL:int = 0;
		public static const REMOVEDECALS_PATTERNS:int = 1;
		
		// XML
		public static const XML_MESH:String = "mesh";
		public static const XML_TEXTURE:String = "texture";
		
		// mesh constants
		public static const MESHACC_001:int = 0;
		public static const MESHACC_002:int = 1;
		public static const MESHACC_003:int = 2;
		public static const MESHACC_004:int = 3;
		public static const MESHACC_005:int = 4;
		public static const MESHACC_006:int = 5;
		public static const MESHACC_007:int = 6;
		
		// texture constants
		public static const TEXACC_001_0001:int = 0;
		public static const TEXACC_002_0001:int = 1;
		public static const TEXACC_003_0001:int = 2;
		public static const TEXACC_003_0002:int = 3;
		public static const TEXACC_003_0003:int = 4;
		public static const TEXACC_004_0001:int = 5;
		public static const TEXACC_004_0002:int = 6;
		public static const TEXACC_005_0001:int = 7;
		public static const TEXACC_005_0002:int = 8;
		public static const TEXACC_006_0001:int = 9;
		public static const TEXACC_006_0002:int = 10;
		public static const TEXACC_007_0001:int = 11;
		public static const TEXACC_007_0002:int = 12;
		
		// mesh constants
		public static const MESHHEAD_001:int = 0;
		public static const MESHHEAD_002:int = 1;
		public static const MESHHEAD_003:int = 2;
		public static const MESHHEAD_004:int = 3;
		public static const MESHHEAD_005:int = 4;
		public static const MESHHEAD_006:int = 5;
		public static const MESHHEAD_007:int = 6;
		public static const MESHHEAD_008:int = 7;
		public static const MESHHEAD_009:int = 8;
		public static const MESHHEAD_010:int = 9;
		public static const MESHHEAD_011:int = 10;
		
		// texture constants
		public static const TEXHEAD_001_0001:int = 0;
		public static const TEXHEAD_001_0002:int = 1;
		public static const TEXHEAD_002_0001:int = 2;
		public static const TEXHEAD_003_0001:int = 3;
		public static const TEXHEAD_003_0002:int = 4;
		public static const TEXHEAD_004_0001:int = 5;
		public static const TEXHEAD_005_0001:int = 6;
		public static const TEXHEAD_005_0002:int = 7;
		public static const TEXHEAD_005_0003:int = 8;
		public static const TEXHEAD_006_0001:int = 9;
		public static const TEXHEAD_007_0001:int = 10;
		public static const TEXHEAD_007_0002:int = 11;
		public static const TEXHEAD_008_0001:int = 12;
		public static const TEXHEAD_008_0002:int = 13;
		public static const TEXHEAD_009_0001:int = 14;
		public static const TEXHEAD_009_0002:int = 15;
		public static const TEXHEAD_010_0001:int = 16;
		public static const TEXHEAD_011_0001:int = 17;
		public static const TEXHEAD_011_0002:int = 18;
		public static const TEXHEAD_011_0003:int = 19;
		public static const TEXHEAD_011_0004:int = 20;
		public static const TEXHEAD_011_0005:int = 21;
		public static const TEXHEAD_011_0006:int = 22;
		public static const TEXHEAD_011_0007:int = 23;
		public static const TEXHEAD_011_0008:int = 24;
		public static const TEXHEAD_011_0009:int = 25;
		public static const TEXHEAD_011_0010:int = 26;
		public static const TEXHEAD_011_0011:int = 27;
		
		public static const TOOL_ALL:int = -2;
		public static const TOOL_OFF:int = -1;
		public static const TOOL_PITCHFORK:int = 0;
		public static const TOOL_BRUSH:int = 1;
		public static const TOOL_BATON:int = 2;
		public static const TOOL_HAMMER:int = 3;
		public static const TOOL_SYRINGE:int = 4;
		
		// mesh constants
		public static const MESHBOTTOM_DEFAULT:int = 0;
		public static const MESHBOTTOM_002:int = 1;
		public static const MESHBOTTOM_003:int = 2;
		public static const MESHBOTTOM_004:int = 3;
		public static const MESHBOTTOM_005:int = 4;
		public static const MESHBOTTOM_006:int = 5;
		public static const MESHBOTTOM_007:int = 6;
		
		// texture constants
		public static const TEXBOTTOM_DEFAULT:int = 0;
		public static const TEXBOTTOM_001_0002:int = 1;
		public static const TEXBOTTOM_001_0003:int = 2;
		public static const TEXBOTTOM_002_0001:int = 3;
		public static const TEXBOTTOM_002_0002:int = 4;
		public static const TEXBOTTOM_002_0003:int = 5;
		public static const TEXBOTTOM_003_0001:int = 6;
		public static const TEXBOTTOM_003_0002:int = 7;
		public static const TEXBOTTOM_003_0003:int = 8;
		public static const TEXBOTTOM_004_0001:int = 9;
		public static const TEXBOTTOM_004_0002:int = 10;
		public static const TEXBOTTOM_005_0001:int = 11;
		public static const TEXBOTTOM_005_0002:int = 12;
		public static const TEXBOTTOM_005_0003:int = 13;
		public static const TEXBOTTOM_006_0001:int = 14;
		public static const TEXBOTTOM_006_0002:int = 15;
		public static const TEXBOTTOM_007_0001:int = 16;
		public static const TEXBOTTOM_007_0002:int = 17;
		
		// mesh constants
		public static const MESHEYE_DEFAULT:int = 0;
		
		// texture constants
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
		public static const TEXEYE_001_0014:int = 13;
		public static const TEXEYE_001_0015:int = 14;
		
		// mesh constants
		public static const MESHHAIR_DEFAULT:int = 0;
		public static const MESHHAIR_002:int = 1;
		public static const MESHHAIR_003:int = 2;
		public static const MESHHAIR_004:int = 3;
		public static const MESHHAIR_005:int = 4;
		public static const MESHHAIR_006:int = 5;
		public static const MESHHAIR_007:int = 6;
		public static const MESHHAIR_008:int = 7;
		
		// texture constants
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
		public static const TEXHAIR_008_0001:int = 14;
		public static const TEXHAIR_008_0002:int = 15;
		
		// mesh constants
		public static const MESHSHOES_DEFAULT:int = 0;
		public static const MESHSHOES_002:int = 1;
		public static const MESHSHOES_003:int = 2;
		public static const MESHSHOES_004:int = 3;
		
		// texture constants
		public static const TEXSHOES_DEFAULT:int = 0;
		public static const TEXSHOES_001_0002:int = 1;
		public static const TEXSHOES_001_0003:int = 2;
		public static const TEXSHOES_002_0001:int = 3;
		public static const TEXSHOES_002_0002:int = 4;
		public static const TEXSHOES_002_0003:int = 5;
		public static const TEXSHOES_003_0001:int = 6;
		public static const TEXSHOES_003_0002:int = 7;
		public static const TEXSHOES_004_0001:int = 8;
		public static const TEXSHOES_004_0002:int = 9;
		public static const TEXSHOES_004_0003:int = 10;
		
		// mesh constants
		public static const MESHTOP_DEFAULT:int = 0;
		
		// texture constants
		public static const TEXTOP_DEFAULT:int = 0;
		public static const TEXTOP_001_0002:int = 1;
		public static const TEXTOP_001_0003:int = 2;
		public static const TEXTOP_001_0004:int = 3;
		public static const TEXTOP_001_0005:int = 4;
		public static const TEXTOP_001_0006:int = 5;
		public static const TEXTOP_001_0007:int = 6;
		public static const TEXTOP_001_0008:int = 7;
		public static const TEXTOP_001_0009:int = 8;
		public static const TEXTOP_001_0010:int = 9;
		public static const TEXTOP_001_0011:int = 10;
		public static const TEXTOP_001_0012:int = 11;
		public static const TEXTOP_001_0013:int = 12;
		public static const TEXTOP_001_0014:int = 13;
		public static const TEXTOP_001_0015:int = 14;
		public static const TEXTOP_001_0016:int = 15;
		public static const TEXTOP_001_0017:int = 16;
		public static const TEXTOP_001_0018:int = 17;
		public static const TEXTOP_001_0019:int = 18;
		public static const TEXTOP_001_0020:int = 19;
		public static const TEXTOP_001_0021:int = 20;
		public static const TEXTOP_001_0022:int = 21;
		public static const TEXTOP_001_0023:int = 22;
		public static const TEXTOP_001_0024:int = 23;
		
		// mesh constants
		public static const MESHSKIN_DEFAULT:int = 0;
		
		// texture constants
		public static const TEXSKIN_DEFAULT:int = 0;
		public static const TEXSKIN_001_0002:int = 1;
		public static const TEXSKIN_001_0003:int = 2;
		public static const TEXSKIN_001_0004:int = 3;
		public static const TEXSKIN_001_0005:int = 4;
		public static const TEXSKIN_001_0006:int = 5;
		public static const TEXSKIN_001_0007:int = 6;
		public static const TEXSKIN_001_0008:int = 7;
		public static const TEXSKIN_001_0009:int = 8;
		public static const TEXSKIN_001_0010:int = 9;
		public static const TEXSKIN_001_0011:int = 10;
		public static const TEXSKIN_001_0012:int = 11;
		public static const TEXSKIN_001_0013:int = 12;
		
		
		// eyebrow texture constants
		public static const TEXEYEBROW_DEFAULT:int = 0;
		public static const TEXEYEBROW_001_0002:int = 1;
		public static const TEXEYEBROW_001_0003:int = 2;
		public static const TEXEYEBROW_001_0004:int = 3;
		public static const TEXEYEBROW_001_0005:int = 4;
		public static const TEXEYEBROW_001_0006:int = 5;
		public static const TEXEYEBROW_001_0007:int = 6;
		public static const TEXEYEBROW_001_0008:int = 7;
		public static const TEXEYEBROW_001_0009:int = 8;
		public static const TEXEYEBROW_001_0010:int = 9;
		public static const TEXEYEBROW_001_0011:int = 10;
		public static const TEXEYEBROW_001_0012:int = 11;
		public static const TEXEYEBROW_001_0013:int = 12;
		public static const TEXEYEBROW_001_0014:int = 13;
		public static const TEXEYEBROW_001_0015:int = 14;
		
		// mouth texture constants
		public static const TEXMOUTH_DEFAULT:int = 0;
		public static const TEXMOUTH_001_0002:int = 1;
		public static const TEXMOUTH_001_0003:int = 2;
		public static const TEXMOUTH_001_0004:int = 3;
		public static const TEXMOUTH_001_0005:int = 4;
		public static const TEXMOUTH_001_0006:int = 5;
		public static const TEXMOUTH_001_0007:int = 6;
		public static const TEXMOUTH_001_0008:int = 7;
		public static const TEXMOUTH_001_0009:int = 8;
		public static const TEXMOUTH_001_0010:int = 9;
		public static const TEXMOUTH_001_0011:int = 10;
		public static const TEXMOUTH_001_0012:int = 11;
		public static const TEXMOUTH_001_0013:int = 12;
		public static const TEXMOUTH_001_0014:int = 13;
		
		// decal constants
		public static const DECSKIN_OFF:int = -1;
		
		// texture layering constants
		public static const TEXLAYER_INIT:String = "init";
		public static const TEXLAYER_MAIN:String = "main";
		public static const TEXLAYER_DECAL:String = "decal";
		public static const TEXLAYER_EYEBROW:String = "eyebrow";
		public static const TEXLAYER_MOUTH:String = "mouth";
		
		// Animation Constants
		public static const ANIM_WALK:int = 0;
		public static const ANIM_PICKUP:int = 1;
		public static const ANIM_IDLE01:int = 2;
		public static const ANIM_IDLE02:int = 3;
		public static const ANIM_JUMP:int = 4;
		public static const ANIM_FEED:int = 5;
		public static const ANIM_SHOWER:int = 6;
		public static const ANIM_TRAINING:int = 7;
		public static const ANIM_LOVE:int = 8;
		public static const ANIM_RIDING01:int = 9;
		public static const ANIM_CONSTRUCTION:int = 10;
		public static const ANIM_CURE:int = 11;
		public static const ANIM_WIN:int = 12;
		public static const ANIM_LOSE:int = 13;
		public static const ANIM_RIDING02:int = 14;
		public static const ANIM_RODEO:int = 15;
		
		//////////////////////////////////////////////////////////////////////
		// End of constants
		//////////////////////////////////////////////////////////////////////
		
		// instance of singleton class
		private static var _instance:JockeyGR = new JockeyGR();

		// XML locations
		private var _xmlLocations:Vector.<String> = new Vector.<String>();
		
		// mesh locations
		private var _assetPartsLocationArray:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();

		//tools locations
		private var _toolsPartsLocationArray:Vector.<Vector.<String>> = new Vector.<Vector.<String>>;
		
		// texture locations
		private var _texturePartsLocationArray:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
		private var _textureToolsPartsLocationArray:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
		
		// decal locations
		private var _decalsPartsLocationArray:Vector.<Vector.<String>> =  new Vector.<Vector.<String>>();
		
		// xml variables
		private var _locLoaderArray:Vector.<URLLoader> = new Vector.<URLLoader>();
		private var _locRequestArray:Vector.<URLRequest> = new Vector.<URLRequest>();
		private var _locXMLArray:Vector.<XML> = new Vector.<XML>();
		
		// jockey mesh parts container
		private var _jockeyPartContainerArray:Vector.<Vector.<Vector.<Mesh>>> = new Vector.<Vector.<Vector.<Mesh>>>();
		
		// jockey texture parts container
		private var _jockeyTextureContainerArray:Vector.<Vector.<BitmapFileMaterial>> = new Vector.<Vector.<BitmapFileMaterial>>();
		
		// jockey decal parts container
		private var _jockeyDecalContainerArray:Vector.<Vector.<BitmapFileMaterial>> =  new Vector.<Vector.<BitmapFileMaterial>>();
		
		// jockey tools parts container
		private var _jockeyToolsContainerArray:Vector.<Vector.<BitmapFileMaterial>> = new Vector.<Vector.<BitmapFileMaterial>>();
		
		// animation container 
		private var _jockeyAnimTimeline:Vector.<Number> = new Vector.<Number>();
		private var _jockeyAnimTimelineMax:Vector.<Number> = new Vector.<Number>();
		private var _jockeyAnimCycleNames:Vector.<String> = new Vector.<String>;
		
		private var _animLocLoader:URLLoader = new URLLoader();
		private var _animRequestLoader:URLRequest = new URLRequest();
		private var _animXML:XML = new XML();
		
		private var _md2:Md2;

		private var _loaderArray:Vector.<Vector.<Loader3D>> = new Vector.<Vector.<Loader3D>>;
		private var _toolsLoaderArray:Vector.<Vector.<Loader3D>> = new Vector.<Vector.<Loader3D>>;
		private var _mesh:Mesh;
		private var _indexQueue:Array = [new Array()];
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _xmlLoadedArray:Array = [false,false,false,false,false,false,false,false,false];
		private var _meshPartsLen:int = 9;
		private var _texturePartsLen:int = 11;
		private var _instanceCode:String = "";
		private var _instanceCount:int = -1;
		
		// shadow variables
		private var _meshPlane:Plane;
		private var _shadowMesh:Plane;
		private var _shadowTexture:BitmapFileMaterial;
		
		private var _animXMLLoaded:Boolean = false;
		private var _initAnimExec:Boolean = false;
		private var _assetXMLLoaded:Vector.<Boolean> = new Vector.<Boolean>;
		
		
		private var _toolsLen:int = 5;
		
		public function JockeyGR()
		{
			if (_instance){
				throw new Error ("Cannot create a new instance of this singleton class" +
					" Pls. use the JockeyGR.getInstance()");
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
				_animRequestLoader = new URLRequest("xml/jockey/TCC_Jockey_Animation.XML");
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
							_jockeyAnimTimeline.push(int(cycle.text()));
							_jockeyAnimCycleNames.push(String(cycle.attribute("name")));
						}
						break;
					case "timelineEnd":
						for each (cycle in set.children()){
							_jockeyAnimTimelineMax.push(int(cycle.text()));
						}
						break;
				}
			}
			_animXMLLoaded = true;
			_dispatcher.dispatchEvent(new JockeyEvent(JockeyEvent.ANIMXML_LOADED));
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
			_dispatcher.addEventListener(JockeyEvent.MESH_RETRIEVED, listener);
		}
		
		/**
		 * Removes the listener that has been added to check if asset has been loaded.
		 */
		
		public function removeOnMeshRetrieved (listener:Function):void{
			_dispatcher.removeEventListener(JockeyEvent.MESH_RETRIEVED, listener);
		}
		
		/**
		 * Creates a listener for loaded animation XML.
		 */
		
		public function addOnAnimXMLLoaded (listener:Function):void{
			_dispatcher.addEventListener(JockeyEvent.ANIMXML_LOADED, listener);
		}
		
		/**
		 * Removes the created listener for loaded animation XML.
		 */
		
		public function removeOnAnimXMLLoaded (listener:Function):void{
			_dispatcher.removeEventListener(JockeyEvent.XML_LOADED, listener);
		}
		
		/**
		 * Returns the animationTimeLine Vector.
		 */
		
		public function getAnimationTimeline ():Vector.<Number>{
			return _jockeyAnimTimeline;
		}
		
		/**
		 * Returns the animationTimeLine Vector.
		 */
		
		public function getAnimationTimelineMax ():Vector.<Number>{
			return _jockeyAnimTimelineMax;
		}
		
		/**
		 * Returns the animationCycleNames Vector.
		 */
		
		public function getAnimationCycleNames ():Vector.<String>{
			return _jockeyAnimCycleNames;
		}
		
		/**
		 * Sets the shadows property.
		 */
		
		private function initShadow():void{
			_shadowMesh = new Plane;
			_shadowMesh.scale(10);
			_shadowMesh.bothsides = true;
			_shadowMesh.pushback = true;
			_shadowTexture = new BitmapFileMaterial("assets/jockey/ETC/shadow.png")
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
			// xml locations
			_xmlLocations[0] = "xml/jockey/TCC_Jockey_SkinElementsLocation.xml";
			_xmlLocations[1] = "xml/jockey/TCC_Jockey_HairElementsLocation.xml";
			_xmlLocations[2] = "xml/jockey/TCC_Jockey_EyeElementsLocation.xml";
			_xmlLocations[3] = "xml/jockey/TCC_Jockey_TopElementsLocation.xml";
			_xmlLocations[4] = "xml/jockey/TCC_Jockey_BottomElementsLocation.xml";
			_xmlLocations[5] = "xml/jockey/TCC_Jockey_ShoesElementsLocation.xml";
			_xmlLocations[6] = "xml/jockey/TCC_Jockey_HeadElementsLocation.xml";
			_xmlLocations[7] = "xml/jockey/TCC_Jockey_AccessoryElementsLocation.xml";
			_xmlLocations[8] = "xml/jockey/TCC_Jockey_ToolsElementsLocation.xml";
			
			for (var vect:int = 0; vect < _meshPartsLen; vect++){
				if (vect != TOOL_SET){
					_assetPartsLocationArray[vect] = new Vector.<String>;
					_jockeyPartContainerArray[vect] = new Vector.<Vector.<Mesh>>();
					_loaderArray[vect] = new Vector.<Loader3D>();
					_indexQueue[vect] = new Array();
				}  else {
					_indexQueue[vect] = new Array();
					_jockeyPartContainerArray[TOOL_SET] = new Vector.<Vector.<Mesh>>(); 
				}
			}
			
			for (vect = 0; vect < _toolsLen; vect++){
				_toolsLoaderArray[vect] = new Vector.<Loader3D>;
			}
			
			for (vect = 0; vect < _texturePartsLen; vect++){
				_assetXMLLoaded[vect] = false;
				_texturePartsLocationArray[vect] = new Vector.<String>;
				_decalsPartsLocationArray[vect] = new Vector.<String>;
				_jockeyTextureContainerArray[vect] = new Vector.<BitmapFileMaterial>();
				_jockeyDecalContainerArray[vect] = new Vector.<BitmapFileMaterial>();
			}
			_textureToolsPartsLocationArray[0] = new Vector.<String>();
			_textureToolsPartsLocationArray[1] = new Vector.<String>();
			
			_toolsPartsLocationArray[0] = new Vector.<String>();
			
			for (var tool:int = 0; tool<_toolsLen; tool++){
				_toolsPartsLocationArray[0][tool] = null;
				_jockeyPartContainerArray[TOOL_SET][tool] = null; 
			}
		}
		
		/**
		 * Registers new assets. Returns the id of the asset instance.
		 */
		
		public function registerInstance(instanceID:int):int {
			if (instanceID == -1){
				_instanceCount++;
				if (_jockeyPartContainerArray[0].length > 0){
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
			for (var vect:int = 0; vect<_jockeyPartContainerArray.length; vect++){
				for (var vect2:int = 0; vect2<_jockeyPartContainerArray[vect].length; vect2++){
					_jockeyPartContainerArray[vect][vect2][assetID] = null;
				}
			}
				_toolsLoaderArray[TOOL_SET][assetID] = null;
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
				return  _jockeyPartContainerArray[partType][meshIndex][assetID];
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
			if (_jockeyTextureContainerArray[partType][textureIndex] == null){
				if (partType != JockeyGR.TOOL_SET){
					var texture:BitmapFileMaterial = new BitmapFileMaterial (_texturePartsLocationArray[partType][textureIndex]);
				} else {
					texture = new BitmapFileMaterial (_textureToolsPartsLocationArray[textureIndex][0]);
				}
				_jockeyTextureContainerArray[partType][textureIndex] = texture;
				return _jockeyTextureContainerArray[partType][textureIndex];
			} else {
				return _jockeyTextureContainerArray[partType][textureIndex];
			}
			return null;
		}
		
		/**
		 * This function gets the texture of the specific body part. 
		 * 
		 * @params1:partType - set the index of the part of body type from 
		 * where the decal will be returned.
		 * @params2:decalIndex - set the index of the decal to be returned.
		 */
		
		public function getDecals (partType:int, decalIndex:int):BitmapFileMaterial{
			if (_jockeyDecalContainerArray[partType][decalIndex] == null){
				var texture:BitmapFileMaterial = new BitmapFileMaterial (_decalsPartsLocationArray[partType][decalIndex]);
				_jockeyDecalContainerArray[partType][decalIndex] = texture;
				return _jockeyDecalContainerArray[partType][decalIndex];
			} else {
				return _jockeyDecalContainerArray[partType][decalIndex];
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
		
		// meshInstanceCode:String - under construction.
		public function loadMesh(assetID:int, partType:int, meshIndex:int, meshInstanceCode:String):void{
			_indexQueue[partType][assetID] = meshIndex;
			_md2 = new Md2();
			_md2.material = new WireframeMaterial();
			if (partType != TOOL_SET){
				_loaderArray[partType][assetID] = new Loader3D();
				_loaderArray[partType][assetID].addEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
				_loaderArray[partType][assetID].addEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
				_loaderArray[partType][assetID].loadGeometry(_assetPartsLocationArray[partType][meshIndex],_md2);
			} else {
				_toolsLoaderArray[meshIndex][assetID] = new Loader3D();
				_toolsLoaderArray[meshIndex][assetID].addEventListener(Loader3DEvent.LOAD_SUCCESS, onToolsLoadComplete);
				_toolsLoaderArray[meshIndex][assetID].addEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
				_toolsLoaderArray[meshIndex][assetID].loadGeometry(_toolsPartsLocationArray[0][meshIndex],_md2);
			}
		}
		
		/**
		 * Add a listener when the specific part of xml is loaded.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function addOnXMLLoaded (listener:Function):void{
			_dispatcher.addEventListener(JockeyEvent.XML_LOADED, listener);
		}
		
		/**
		 * Remove the listener for the xml complete event.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function removeOnXMLLoaded (listener:Function):void{
			_dispatcher.addEventListener(JockeyEvent.XML_LOADED, listener);
		}
		
		/**
		 * Add a listener when the specific part of mesh is loaded.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function addOnMeshLoaded (listener:Function):void{
			_dispatcher.addEventListener(JockeyEvent.MESH_LOADED, listener);
		}
		
		/**
		 * Remove the listener for the mesh complete event.
		 * 
		 * @params1:listener - the function to be used as the event listener.
		 */
		
		public function removeOnMeshLoaded (listener:Function):void{
			_dispatcher.removeEventListener(JockeyEvent.MESH_LOADED, listener);
		}
		
		/**
		 * Event function when the asset loaded is complete.
		 */
		
		private function onLoadComplete (evt:Loader3DEvent):void{
			// Remove event listeners after complete
			var params:Object = new Object(); 
			for (var part:int = 0; part<_loaderArray.length; part++){
				for (var assetID:int = 0; assetID<_loaderArray[part].length; assetID++){
					if (evt.currentTarget == _loaderArray[part][assetID]){
						_loaderArray[part][assetID].removeEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
						_loaderArray[part][assetID].removeEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
						_jockeyPartContainerArray[part][_indexQueue[part][assetID]][assetID] = _loaderArray[part][assetID].handle as Mesh;
						params.partType = part;
						params.meshIndex = _indexQueue[part][assetID];
						params.assetID = assetID;
						_instanceCode = String(part) + ":" + String(_indexQueue[part][assetID]) + ":" + String(_jockeyPartContainerArray[part][_indexQueue[part][assetID]].length - 1);
						_dispatcher.dispatchEvent(new JockeyEvent (JockeyEvent.MESH_LOADED,params));
						break;
					}
				}
			}
		}
		
		private function onToolsLoadComplete (evt:Loader3DEvent):void{
			var params:Object = new Object(); 
			for (var tool:int = 0; tool<_toolsLoaderArray.length; tool++){
				for (var assetID:int = 0; assetID<_toolsLoaderArray[tool].length; assetID++){
					if (evt.currentTarget == _toolsLoaderArray[tool][assetID]){
						_toolsLoaderArray[tool][assetID].removeEventListener(Loader3DEvent.LOAD_SUCCESS, onToolsLoadComplete);
						_toolsLoaderArray[tool][assetID].removeEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
						_jockeyPartContainerArray[TOOL_SET][tool][assetID] = _toolsLoaderArray[tool][assetID].handle as Mesh;
						params.partType = TOOL_SET;
						params.meshIndex = tool;
						params.assetID = assetID;
						_instanceCode = String(TOOL_SET) + ":" + String(tool) + ":" + String(_jockeyPartContainerArray[TOOL_SET][tool].length - 1);
						_dispatcher.dispatchEvent(new JockeyEvent (JockeyEvent.MESH_LOADED,params));
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
			var xmlList:XMLList = _locXMLArray[index].children();
			for each (var type:XML in xmlList){
				var typeAttr:String = type.attribute("name");
				var setXMLList:XMLList = setXMLList = type.children();
				for each(var part:XML in setXMLList){ 
					var partAttr:String = part.attribute("name");
					var partStr:String = part.text();
					switch (partAttr){
						case "mesh":
							switch (typeAttr){
								case "skin":
									_assetPartsLocationArray[SKIN_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "hair":
									_assetPartsLocationArray[HAIR_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "eye":
									_assetPartsLocationArray[EYE_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "shoes":
									_assetPartsLocationArray[SHOES_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "top":
									_assetPartsLocationArray[TOP_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "bottom":
									_assetPartsLocationArray[BOTTOM_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "acc":
									_assetPartsLocationArray[ACC_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "head":
									_assetPartsLocationArray[HEAD_SET] = convertArrayToString(partStr.split(",\r\n\t\t\t"));
									break;
								case "pitchfork":
									_toolsPartsLocationArray[0][TOOL_PITCHFORK] = partStr;
									break;
								case "brush":
									_toolsPartsLocationArray[0][TOOL_BRUSH] = partStr;
									break;
								case "baton":
									_toolsPartsLocationArray[0][TOOL_BATON] = partStr;
									break;
								case "hammer":
									_toolsPartsLocationArray[0][TOOL_HAMMER] = partStr;
									break;
								case "syringe":
									_toolsPartsLocationArray[0][TOOL_SYRINGE] = partStr;
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
										case "skin":
											_texturePartsLocationArray[SKIN_SET]= convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "hair":
											_texturePartsLocationArray[HAIR_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "shoes":
											_texturePartsLocationArray[SHOES_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "bottom":
											_texturePartsLocationArray[BOTTOM_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "top":
											_texturePartsLocationArray[TOP_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "eye":
											_texturePartsLocationArray[EYE_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "acc":
											_texturePartsLocationArray[ACC_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "head":
											_texturePartsLocationArray[HEAD_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "eyebrow":
											_texturePartsLocationArray[EYEBROW_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "mouth":
											_texturePartsLocationArray[MOUTH_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "pitchfork":
											_textureToolsPartsLocationArray[0] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "brush":
											break;
										case "baton":
											break;
										case "hammer":
											break;
										case "syringe":
											_textureToolsPartsLocationArray[1] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
									}
									break;
								case "decal":
									switch (typeAttr){
										case "skin":
											_decalsPartsLocationArray[SKIN_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "hair":
											_decalsPartsLocationArray[HAIR_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "shoes":
											_decalsPartsLocationArray[SHOES_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "top":
											_decalsPartsLocationArray[TOP_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "bottom":
											_decalsPartsLocationArray[BOTTOM_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "acc":
											_decalsPartsLocationArray[ACC_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "eye":
											_decalsPartsLocationArray[ACC_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "head":
											_decalsPartsLocationArray[HEAD_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "eyebrow":
											_decalsPartsLocationArray[EYEBROW_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
											break;
										case "mouth":
											_decalsPartsLocationArray[MOUTH_SET] = convertArrayToString(texStr.split(",\r\n\t\t\t"));
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
			if (index == SKIN_SET){
				_assetXMLLoaded[EYEBROW_SET] = true;
				_assetXMLLoaded[MOUTH_SET] = true;
				populateVectorContainer(EYEBROW_SET);
				populateVectorContainer(MOUTH_SET);
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
				if (part != TOOL_SET){
					for (var item:int = 0; item<_assetPartsLocationArray[part].length;item++){
						_jockeyPartContainerArray[part][item] = new Vector.<Mesh>;
						for (var inst:int = 0; inst < _instanceCount+1; inst++){
							_jockeyPartContainerArray[part][item][inst] = null;
							_loaderArray[part][item] = null;
						}
					} 
				} else {
					_jockeyPartContainerArray[part] = new Vector.<Vector.<Mesh>>();
					for (item = 0; item < _toolsLen; item++){
						_jockeyPartContainerArray[part][item] = new Vector.<Mesh>();
						for (inst = 0; inst < _instanceCount+1; inst++){
							_jockeyPartContainerArray[part][item][inst] = null;
						}
					} 
				}
			}
			if (part != TOOL_SET){
				for (item = 0; item<_texturePartsLocationArray[part].length;item++){
					_jockeyTextureContainerArray[part][item] = null;
				}
				
				for (item = 0; item<_decalsPartsLocationArray[part].length;item++){
					_jockeyDecalContainerArray[part][item] = null;
				}
				
			} else {
				for (item = 0; item<_decalsPartsLocationArray[part].length;item++){
					_toolsLoaderArray[TOOL_SET][item] = null;
				}
				_jockeyTextureContainerArray[part][0] = null;
				_jockeyTextureContainerArray[part][1] = null;
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
			_locRequestArray[part] = new URLRequest(_xmlLocations[part]);
			_locLoaderArray[part] = new URLLoader();
			_locXMLArray[part] = new XML();
			_locLoaderArray[part].load(_locRequestArray[part]);
			initXMLlisteners(part);
		}
		
		/**
		 * Event listeners for xml loader
		 */
		
		private function initXMLlisteners(part:int):void{
			_locLoaderArray[part].addEventListener(Event.COMPLETE, onLoaderComplete);
			_locLoaderArray[part].addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		// Under Construction
		/**
		 * Function to remove all available mesh assets in container.
		 */
		
		public function removeAllMeshAssets():void{
			for (var vect1:int = _jockeyPartContainerArray.length -1; vect1 >= 0; vect1--){
				for (var vect2:int = _jockeyPartContainerArray[vect1].length -1; vect2 >= 0; vect2--){
					for (var mesh:int = _jockeyPartContainerArray[vect1][vect2].length -1; mesh >= 0; mesh--){
						
						
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
			for (var loader:int = 0; loader<_locLoaderArray.length; loader++){
				if (evt.currentTarget == _locLoaderArray[loader]){
					_locXMLArray[loader] = new XML(evt.target.data);
					initElementLocs(loader);
					_xmlLoadedArray[loader] = true;
					params.partType = loader;
					break;
				}
			}
			_dispatcher.dispatchEvent(new JockeyEvent(JockeyEvent.XML_LOADED,params));
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
		
		public static function getInstance():JockeyGR{
			return _instance;
		}
	}
}