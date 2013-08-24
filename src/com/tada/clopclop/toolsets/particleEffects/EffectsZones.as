package com.tada.clopclop.toolsets.particleEffects
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import org.flintparticles.threeD.geom.Point3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.renderers.Camera;
	import org.flintparticles.threeD.zones.BitmapDataZone;
	import org.flintparticles.threeD.zones.BoxZone;
	import org.flintparticles.threeD.zones.ConeZone;
	import org.flintparticles.threeD.zones.CylinderZone;
	import org.flintparticles.threeD.zones.DiscZone;
	import org.flintparticles.threeD.zones.FrustrumZone;
	import org.flintparticles.threeD.zones.GreyscaleZone;
	import org.flintparticles.threeD.zones.LineZone;
	import org.flintparticles.threeD.zones.MultiZone;
	import org.flintparticles.threeD.zones.ParallelogramZone;
	import org.flintparticles.threeD.zones.PointZone;
	import org.flintparticles.threeD.zones.SphereZone;
	
	/**
	 * Author: Hedrick David
	 * Description: Used to add zones to a multizone with 
	 * preset values for particle effects.
	 * Engines or external library dependencies: Flint Particle Engine and Away3D 
	 */
	
	public class EffectsZones extends MultiZone
	{
		public static const BITMAPDATA_ZONE:String = "bitmapDataZone";
		public static const BOX_ZONE:String = "boxZone";
		public static const CONE_ZONE:String = "coneZone";
		public static const CYLINDER_ZONE:String = "cylinderZone";
		public static const DISC_ZONE:String = "discZone";
		public static const FRUSTRUM_ZONE:String = "frustrumZone";
		public static const GREYSCALE_ZONE:String = "greyScaleZone";
		public static const LINE_ZONE:String = "lineZone";
		public static const PARALLELOGRAM_ZONE:String = "parallelogramZone";
		public static const POINT_ZONE:String = "pointZone";
		public static const SPHERE_ZONE:String = "sphereZone";
		
		// zone variables
		private var _bitmapDataZones:BitmapDataZone;
		private var _boxZone:BoxZone;
		private var _coneZone:ConeZone;
		private var _cylinderZone:CylinderZone;
		private var _discZone:DiscZone;
		private var _frustrumZone:FrustrumZone;
		private var _greyScaleZone:GreyscaleZone;
		private var _lineZone:LineZone;
		private var _parallelogramZone:ParallelogramZone;
		private var _pointZone:PointZone;
		private var _sphereZone:SphereZone;
		
		public function EffectsZones()
		{
			
		}

		public function addEffectsZoneByType (zoneType:String):void{
			switch (zoneType){
				case EffectsZones.BITMAPDATA_ZONE:
					addBitmapZone();
					break;
				case EffectsZones.BOX_ZONE:
					addBoxZone();
					break;
				case EffectsZones.CONE_ZONE:
					addConeZone();
					break;
				case EffectsZones.CYLINDER_ZONE:
					addCylinderZone();
					break;
				case EffectsZones.DISC_ZONE:
					addDiskZone();
					break;
				case EffectsZones.FRUSTRUM_ZONE:
					addFrustrumZone();
					break;
				case EffectsZones.GREYSCALE_ZONE:
					addCylinderZone();
					break;
				case EffectsZones.LINE_ZONE:
					addLineZone();
					break;
				case EffectsZones.PARALLELOGRAM_ZONE:
					addParallelogramZone();
					break;
				case EffectsZones.POINT_ZONE:
					addPointZone();
					break;
				case EffectsZones.SPHERE_ZONE:
					addSphereZone();
					break;
			}
		}
		
		// remove zones by type
		public function removeEffectsZone(zoneType:String):void{
			switch (zoneType){
				case EffectsZones.BITMAPDATA_ZONE:
					removeZone(_bitmapDataZones);
					_bitmapDataZones= null;
					break;
				case EffectsZones.BOX_ZONE:
					removeZone(_boxZone);
					_boxZone = null;
					break;
				case EffectsZones.CONE_ZONE:
					removeZone(_coneZone);
					_coneZone = null;
					break;
				case EffectsZones.CYLINDER_ZONE:
					removeZone(_cylinderZone);
					_cylinderZone = null;
					break;
				case EffectsZones.DISC_ZONE:
					removeZone(_discZone);
					_discZone = null;
					break;
				case EffectsZones.FRUSTRUM_ZONE:
					removeZone(_frustrumZone);
					_frustrumZone = null;
					break;
				case EffectsZones.GREYSCALE_ZONE:
					removeZone(_greyScaleZone);
					_greyScaleZone = null;
					break;
				case EffectsZones.LINE_ZONE:
					removeZone(_lineZone);
					_lineZone = null;
					break;
				case EffectsZones.PARALLELOGRAM_ZONE:
					removeZone(_parallelogramZone);
					_parallelogramZone = null;
					break;
				case EffectsZones.POINT_ZONE:
					removeZone(_pointZone);
					_pointZone = null;
					break;
				case EffectsZones.SPHERE_ZONE:
					removeZone(_sphereZone);
					_sphereZone = null;
					break;
			}
		}
		
		public function removeAllEffectsZone ():void{
			removeZone(_bitmapDataZones);
			removeZone(_boxZone);
			removeZone(_coneZone);
			removeZone(_cylinderZone);
			removeZone(_discZone);
			removeZone(_frustrumZone);
			removeZone(_greyScaleZone);
			removeZone(_lineZone);
			removeZone(_parallelogramZone);
			removeZone(_pointZone);
			removeZone(_sphereZone);
			emptyZoneVariables();
		}
		
		private function emptyZoneVariables():void{
			_bitmapDataZones = null;
			_boxZone= null;
			_coneZone= null;
			_cylinderZone= null;
			_discZone= null;
			_frustrumZone= null;
			_greyScaleZone= null;
			_lineZone= null;
			_parallelogramZone= null;
			_pointZone= null;
			_sphereZone= null;
		}
		
		/*
		 * Add separate zones. Created to have default and preset properties for each zones
		 * as needed.
		 */ 
		
		public function addConeZone(apex:Point3D = null, axis:Vector3D = null, angle:Number = 30, height:Number = 40, truncatedHeight:Number = 50):void{
			if (apex == null){
				apex = new Point3D (0,0,0);
			}
			if (axis == null){
				axis == new Vector3D (0,1,0);
			}
			_coneZone = new ConeZone (apex, axis, angle, height, truncatedHeight); 
			addZone(_coneZone);
		}

		public function addBitmapZone(bitmapData:BitmapData = null, corner:Point3D = null, top:Vector3D = null, left:Vector3D =null):void{
			_bitmapDataZones = new BitmapDataZone(bitmapData,corner, top, left);
			addZone(_bitmapDataZones);
		}
		
		public function addBoxZone(width:Number = 0, height:Number = 0, depth:Number =0, center:Point3D = null, upAxis:Vector3D = null, depthAxis:Vector3D = null):void{
			_boxZone = new BoxZone (width, height, depth, center, upAxis, depthAxis);
			addZone(_boxZone);
		}
		
		public function addCylinderZone (center:Point3D = null, axis:Vector3D = null, length:Number = 0, outerRadius:Number =0,innerRadius:Number = 0):void{
			_cylinderZone = new CylinderZone (center, axis, length, outerRadius, innerRadius);
			addZone (_cylinderZone);
		}
		
		public function addDiskZone (center:Point3D = null, normal:Vector3D = null, outerRadius:Number =0,innerRadius:Number = 0):void{
			_discZone = new DiscZone (center, normal,  outerRadius, innerRadius);
			addZone (_discZone);
		}
		
		public function addFrustrumZone (camera:Camera = null, viewRect:Rectangle = null):void{
			_frustrumZone = new FrustrumZone (camera, viewRect);
			addZone (_frustrumZone);
			
		}
		
		public function addGreyScaleZone (bitmapData:BitmapData = null, corner:Point3D = null, top:Vector3D = null, left:Vector3D =null):void{
			_greyScaleZone = new GreyscaleZone (bitmapData,corner, top, left);
			addZone (_greyScaleZone);
		}
		
		public function addLineZone (start:Point3D = null, end:Point3D = null):void{
			if (start == null){
				start = new Point3D(-10,0,0);
			}
			if (end == null){
				end = new Point3D (10,0,0);
			}
			_lineZone = new LineZone (start, end);
			addZone (_lineZone);
		}
		
		public function addParallelogramZone (corner:Point3D = null, side1:Vector3D = null, side2:Vector3D = null):void{
			_parallelogramZone = new ParallelogramZone (corner, side1, side2);
			addZone (_parallelogramZone);
		}
		
		public function addPointZone (point:Point3D = null):void{
			if (point == null){
				point = new Point3D (0,0,0);
			}
			_pointZone = new PointZone (point);
			addZone (_pointZone);
		}
		
		public function addSphereZone (center:Point3D = null, outerRadius:Number =20,innerRadius:Number = 20):void{
			if (center == null){
				center = new Point3D (0,0,0);
			}
			_sphereZone = new SphereZone (center, outerRadius, innerRadius);
			addZone (_sphereZone);
		}
	}
}