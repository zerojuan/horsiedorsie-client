package com.tada.clopclop.toolsets.particleEffects
{
	import com.away3d.core.utils.Color;
	
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.ColorChange;
	import org.flintparticles.common.actions.Fade;
	import org.flintparticles.common.actions.ScaleImage;
	import org.flintparticles.common.counters.Random;
	import org.flintparticles.common.counters.SineCounter;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.displayObjects.RadialDot;
	import org.flintparticles.common.initializers.AlphaInit;
	import org.flintparticles.common.initializers.ColorInit;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.ScaleImagesInit;
	import org.flintparticles.threeD.actions.Accelerate;
	import org.flintparticles.threeD.actions.LinearDrag;
	import org.flintparticles.threeD.actions.Move;
	import org.flintparticles.threeD.actions.RandomDrift;
	import org.flintparticles.threeD.actions.ScaleAll;
	import org.flintparticles.threeD.away3d.initializers.A3DDisplayObjectClass;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Point3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.initializers.FaceAxis;
	import org.flintparticles.threeD.initializers.RotateVelocity;
	import org.flintparticles.threeD.initializers.Rotation;
	import org.flintparticles.threeD.initializers.RotationAbsolute;
	import org.flintparticles.threeD.initializers.ScaleAllInit;
	import org.flintparticles.threeD.initializers.ScaleAllsInit;
	import org.flintparticles.threeD.initializers.Velocity;
	import org.flintparticles.threeD.zones.BitmapDataZone;
	import org.flintparticles.threeD.zones.BoxZone;
	import org.flintparticles.threeD.zones.ConeZone;
	import org.flintparticles.threeD.zones.MultiZone;

	/**
	 * Author: Hedrick David
	 * Description: Used to create smoke effects.
	 * Engines or external library dependencies: Flint Particle Engine and Away3D 
	 */
	
	public class Smoke extends Emitter3D
	{
		// actions
		private var _acceleration:Accelerate;
		private var _scaleImage:ScaleImage;
		private var _age:Age;
		private var _move:Move;
		private var _linearDrag:LinearDrag;
		private var _colorChange:ColorChange;
		private var _fade:Fade;
		private var _randomDrift:RandomDrift;
		private var _zone:EffectsZones;
		
		public function Smoke(_zoneType:String = "pointZone")
		{	
			initActions();
			
			// default counter
			counter = new Steady(5);
			
			_zone = new EffectsZones();
			
			// set default zone
			_zone.addConeZone();
			
			// set initializer
			addInitializer(new ScaleImagesInit (new Array(1,7,10,15)));
			addInitializer(new AlphaInit (0));
			addInitializer(new Lifetime (1,2.5)); 
			addInitializer(new Velocity (_zone as MultiZone));
			addInitializer(new A3DDisplayObjectClass (RadialDot,6)); 
			
			// add initial actions
			addAction(_age); 
			addAction(_move);
			addAction(_linearDrag); 
			addAction(_scaleImage); 
			addAction(_colorChange);
			addAction(_fade); 
			addAction(_randomDrift); 
			addAction(_acceleration);
		}
		
		public function get zone():EffectsZones{
			return _zone;
		}
		
		// initialize basic actions
		private function initActions():void{
			_acceleration = new Accelerate(new Vector3D(0,5,0));
			_scaleImage = new ScaleImage (1,15);
			_age = new Age();
			_move = new Move();
			_linearDrag = new LinearDrag(0.01);
			_colorChange = new ColorChange(0xFF222222,0x00FFFFFF);
			_fade = new Fade ( .5, 0 );
			_randomDrift = new RandomDrift( 15, 15, 15 );
		}
		
		// set smoke drag effect
		public function drag(value:Number):void{
			removeAction(_linearDrag);
			_linearDrag.drag = value;
			addAction(_linearDrag);
		}
		
		// set the scale of the particle from it's birth up to its death
		public function lifeScale(minValue:Number, maxValue:Number):void{
			removeAction(_linearDrag);
			_scaleImage.startScale = minValue;
			_scaleImage.endScale = maxValue;
			addAction(_scaleImage);
		}
		
		// change the color of the particle from it's birth up to its death
		public function changeColor(startColor:uint, endColor:uint):void{
			removeAction(_colorChange);
			_colorChange.startColor = startColor;
			_colorChange.endColor = endColor;
			addAction(_colorChange);
		}
	
		// change the alpha of the particle from it's birth up to its death
		public function fade(startAlpha:Number, endAlpha:Number):void{
			removeAction(_fade);
			_fade.startAlpha = startAlpha;
			_fade.endAlpha = endAlpha;
			addAction(_fade);
		}
		
		// change the drifting randomization points of the particle
		public function drift(driftX:Number, driftY:Number, driftZ:Number):void{
			removeAction(_randomDrift);
			_randomDrift.driftX = driftX;
			_randomDrift.driftY = driftY;
			_randomDrift.driftZ = driftZ;
			addAction(_randomDrift);	
		}
		
		// change the acceleration of the particles
		public function acceleration (X:Number = 0, Y:Number = 0, Z:Number = 0):void{
			removeAction(_acceleration);
			_acceleration.x = X;
			_acceleration.y = Y;
			_acceleration.z = Z;
			addAction(_acceleration);
		}
	}
}