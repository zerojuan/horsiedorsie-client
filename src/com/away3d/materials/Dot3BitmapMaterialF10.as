﻿package com.away3d.materials{	import com.away3d.arcane;	import com.away3d.containers.*;	import com.away3d.core.base.*;	import com.away3d.lights.*;		import flash.display.*;	import flash.filters.*;	import flash.geom.*;		use namespace arcane;		/**	 * Bitmap material with DOT3 shading.	 */	public class Dot3BitmapMaterialF10 extends BitmapMaterial	{		/** @private */        arcane override function updateMaterial(source:Object3D, view:View3D):void        {        	for each (_directional in source.scene.directionalLights) {        		if (!_directional.diffuseTransform[source] || !_directional.normalMatrixDiffuseTransform[source] || view._updatedObjects[source]) {					_directional.setDiffuseTransform(source);					_directional.setNormalMatrixDiffuseTransform(source);										var diffuseMatrix:Array = _directional.normalMatrixDiffuseTransform[source].matrix;					_normalShader.data.diffuseMatrixR.value = [diffuseMatrix[0], diffuseMatrix[5], diffuseMatrix[10], 0];					_normalShader.data.diffuseMatrixG.value = [diffuseMatrix[1], diffuseMatrix[6], diffuseMatrix[11], 0];					_normalShader.data.diffuseMatrixB.value = [diffuseMatrix[2], diffuseMatrix[7], diffuseMatrix[12], 0];					_normalShader.data.diffuseMatrixO.value = [diffuseMatrix[4]/255, diffuseMatrix[9]/255, diffuseMatrix[14]/255, 1];					_normalShader.data.ambientMatrixO.value = [_directional._red*_directional.ambient*_directional.brightness, _directional._green*_directional.ambient*_directional.brightness, _directional._blue*_directional.ambient*_directional.brightness, 1];					_bitmapDirty = true;        		}        		        		if (!_directional.specularTransform[source] || !_directional.specularTransform[source][view] || !_directional.normalMatrixSpecularTransform[source] || !_directional.normalMatrixSpecularTransform[source][view] || view._updatedObjects[source] || view.updated) {        			_directional.setSpecularTransform(source, view);        			_directional.setNormalMatrixSpecularTransform(source, view, _specular, _shininess);        			        			var specularMatrix:Array = _directional.normalMatrixSpecularTransform[source][view].matrix;					_normalShader.data.specularMatrixR.value = [specularMatrix[0], specularMatrix[5], specularMatrix[10], 0];					_normalShader.data.specularMatrixG.value = [specularMatrix[1], specularMatrix[6], specularMatrix[11], 0];					_normalShader.data.specularMatrixB.value = [specularMatrix[2], specularMatrix[7], specularMatrix[12], 0];					_normalShader.data.specularMatrixO.value = [specularMatrix[4]/255, specularMatrix[9]/255, specularMatrix[14]/255, 1];        			_bitmapDirty = true;        		}        	}        	        	super.updateMaterial(source, view);        }        		private var _shininess:Number;		private var _specular:uint;		private var _normalMap:BitmapData;		private var _normalVector:Vector.<Number>;		private var _normalShader:Shader;		private var _normalFilter:ShaderFilter;		private var _directional:DirectionalLight3D;		private var _zeroPoint:Point = new Point();				[Embed(source="../pbks/normalMapping.pbj",mimeType="application/octet-stream")]    	private var NormalShader:Class;    		    	/**    	 * Updates the texture bitmapData with the colortransform determined from the <code>color</code> and <code>alpha</code> properties.    	 *     	 * @see color    	 * @see alpha    	 * @see setColorTransform()    	 */        protected override function updateRenderBitmap():void        {        	_bitmapDirty = false;         	        	if (_colorTransform) {	        	if (!_bitmap.transparent && _alpha != 1) {	                _renderBitmap = new BitmapData(_bitmap.width, _bitmap.height, true);	                _renderBitmap.draw(_bitmap);	            } else {	        		_renderBitmap = _bitmap.clone();	           }	            _renderBitmap.colorTransform(_renderBitmap.rect, _colorTransform);	        } else {	        	_renderBitmap = _bitmap.clone();	        }	        	        _normalShader.data.src.input = _renderBitmap;	        	        _renderBitmap.applyFilter(_renderBitmap, _renderBitmap.rect, _zeroPoint, _normalFilter);	        	        invalidateFaces();        }				private function getVectorNMap():Vector.<Number>		{			var i:int = _normalMap.height;			var w:int = _normalMap.width;			var v:Vector.<Number> = new Vector.<Number>(w*i*4);			var j:int;			var pixel:int;			var pixelValue:int;			var rValue:Number;			var gValue:Number;			var bValue:Number;			var mod:Number;						//normalise map			while (i--) {				j = w;				while (j--) {					//get values					pixelValue = _normalMap.getPixel32(j, i);					rValue = ((pixelValue & 0x00FF0000) >> 16)- 127;					gValue = ((pixelValue & 0x0000FF00) >> 8) - 127;					bValue = ((pixelValue & 0x000000FF)) - 127;										//calculate modulus					mod = Math.sqrt(rValue*rValue + gValue*gValue + bValue*bValue)*2;										//set normalised values					pixel = i*w*4 + j*4;					v[pixel]     = rValue/mod + 0.5;					v[pixel + 1] = gValue/mod + 0.5;					v[pixel + 2] = bValue/mod + 0.5;					v[pixel + 3] = 1;				}			}						return v;		}				/**		 * The exponential dropoff value used for specular highlights.		 */		public function get shininess():Number		{			return _shininess;		}				public function set shininess(val:Number):void		{			_shininess = val;            //_specularPhongShader.shininess = val;		}				/**		 * Coefficient for specular light level.		 */		public function get specular():uint		{			return _specular;		}				public function set specular(val:uint):void		{			_specular = val;            //_specularPhongShader.specular = val;		}                /**        * Returns the bitmapData object being used as the material normal map.        */		public function get normalMap():BitmapData		{			return _normalMap;		}				public function set normalMap(n_map:BitmapData):void		{			_normalMap = normalMap;						if(_normalVector != null)				_normalVector = null;						_normalVector = getVectorNMap();			 			_normalShader.data.normalmap.width = _normalMap.width;			_normalShader.data.normalmap.height = _normalMap.height;			_normalShader.data.normalmap.input = _normalVector;			 		}				/**		 * Creates a new <code>Dot3BitmapMaterial</code> object.		 * 		 * @param	bitmap				The bitmapData object to be used as the material's texture.		 * @param	normalMap			The bitmapData object to be used as the material's DOT3 map.		 * @param	init	[optional]	An initialisation object for specifying default instance properties.		 */		public function Dot3BitmapMaterialF10(bitmap:BitmapData, normalMap:BitmapData, init:Object = null)		{			super(bitmap, init);			_normalMap = normalMap;			_normalVector = getVectorNMap();						_normalShader = new Shader(new NormalShader());			_normalShader.data.normalmap.width = _normalMap.width;			_normalShader.data.normalmap.height = _normalMap.height;			_normalShader.data.normalmap.input = _normalVector;						_normalFilter = new ShaderFilter(_normalShader);						_shininess = ini.getNumber("shininess", 20);			_specular = ini.getColor("specular", 0xFFFFFF);		}		 	}}