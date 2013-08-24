package com.tada.clopclop.world
{
	import com.tada.engine.rendering.SwfVectorCache;
	import com.tada.engine.resource.SWFResource;
	import com.tada.utils.debug.Logger;

	public class BitmapAnimationManager{
		
		public static function get instance():BitmapAnimationManager{
			if(_instance == null){
				_allowInstantiation = true;
				_instance = new BitmapAnimationManager();
				_allowInstantiation = false;
			}
			
			return _instance;
		}
		
		public function BitmapAnimationManager(){
			if(!_allowInstantiation){
				throw new Error("Tried to instatiate another instance of singleton class BitmapAnimationManager");
			}
			
			_vectorCacheList = [];
		}
		
		public function getVectorCache(swfFile:String, state:int):SwfVectorCache{
			return _vectorCacheList[swfFile+state];
		}
		
		public function addToVectorCache(swfFile:String, swfResource:SWFResource):void{
			var vectorCache:SwfVectorCache = _vectorCacheList[swfFile+"1"]; 
			if(vectorCache != null){
				Logger.info(this, "addToVectorCache", "VectorCache:"+ swfFile +" already exists, no need to add again");
			}else{
				_addToVectorCache(swfFile, swfResource);
			}
		}
		
		private function _addToVectorCache(swfFile:String, swfResource:SWFResource):void{
			var constructionBitmapCache:SwfVectorCache = new SwfVectorCache();
			var normalBitmapCache:SwfVectorCache = new SwfVectorCache();
			var rotatedBitmapCache:SwfVectorCache = new SwfVectorCache();
			var fallingBitmapCache:SwfVectorCache = new SwfVectorCache();
			
			constructionBitmapCache.swf = swfResource;
			if(constructionBitmapCache.clipExists("Construction")){
				constructionBitmapCache.clipName = "Construction";
				_vectorCacheList[swfFile+"0"] = constructionBitmapCache;
			}
			
			normalBitmapCache.swf = swfResource;
			if(normalBitmapCache.clipExists("Normal")){
				normalBitmapCache.clipName = "Normal";
				_vectorCacheList[swfFile+"1"] = normalBitmapCache;
			}else{
				throw new Error(swfResource.filename + " doesn't have a class named Normal. That class is required");
			}
			
			rotatedBitmapCache.swf = swfResource;
			if(rotatedBitmapCache.clipExists("Rotated")){
				rotatedBitmapCache.clipName = "Rotated";
				_vectorCacheList[swfFile+"2"] = rotatedBitmapCache;
			}
			
			fallingBitmapCache.swf = swfResource;
			if(fallingBitmapCache.clipExists("Falling")){
				fallingBitmapCache.clipName = "Falling";
				Logger.print(this, "FALLING EXISTS!");
				_vectorCacheList[swfFile+"3"] = fallingBitmapCache;
			}else{
				Logger.print(this, "FALLING DOESN'T EXIST!");
			}
		}
		
		[ArrayElementType("SwfVectorCache")]
		private var _vectorCacheList:Array;
		
		private static var _instance:BitmapAnimationManager;
		private static var _allowInstantiation:Boolean;
	}
}