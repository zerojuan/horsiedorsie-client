﻿package com.away3d.primitives{	import com.away3d.arcane;	import com.away3d.core.base.*;	import com.away3d.materials.*;	use namespace arcane;		/**	* Creates a 3D arrow primitive.	*/ 	public class Arrow extends AbstractPrimitive	{		private var _width:Number;		private var _height:Number;		private var _tailwidth:Number;		private var _taillength:Number;		private var _thickness:Number;		private var _sideMaterial:Material;		private var _bottomMaterial:Material;		private var _yUp:Boolean;				private function buildArrow():void		{			var htw:Number = _tailwidth*.5;			var hw:Number = _width*.5;						var v0:Vertex = createVertex(0,0,0); 			var v1:Vertex = createVertex(hw,0,_height-_taillength); 			var v2:Vertex = createVertex( (_tailwidth>0 && _taillength>0)? hw-(hw-htw) : 0 , 0, _height-_taillength);			var v3:Vertex;						var uv0:UV = createUV(.5, 0);			var uv1:UV;			var uv2:UV;			 			if(_thickness > 0)				var edgeslist:Array = [v0, v1, v2];						if( _tailwidth>0 && _taillength>0){								v3 = createVertex(hw-(hw-htw), 0,_height); 				var v4:Vertex = createVertex(0, 0,_height);				var v5:Vertex = createVertex(0, 0, _height-_taillength);				var v2i:Vertex = createVertex(-v2.x,v2.y,v2.z);				var v6:Vertex = createVertex(-v1.x,v1.y,v1.z);				var v7:Vertex = createVertex(-v3.x,v3.y,v3.z);				 				uv1 = createUV( 1 , (_height-_taillength) /_height);				uv2 = createUV(.5+( ((v2.x*2)/_width)*.5), uv1.v);				var uv2i:UV = createUV(1-uv2.u, uv2.v);				var uv3:UV = createUV(uv2.u, 1);								var uv4:UV = createUV(.5, 1);				var uv5:UV = createUV(.5 , uv1.v);			  				addFace(createFace(v0, v1, v2, null, uv0, uv1, uv2));				addFace(createFace(v0, v2, v5, null, uv0, uv2, uv5));				addFace(createFace(v5, v2, v3, null, uv5, uv2, uv3));				addFace(createFace(v4, v5, v3, null, uv4, uv5, uv3));				addFace(createFace(v6,v0, v2i , null,createUV(0,uv1.v),  uv0, uv2i));				addFace(createFace(v2i, v0, createVertex(-v5.x,v5.y,v5.z), null, createUV(1-uv2.u, uv1.v), uv0, uv5));				addFace(createFace(v4,v2i, v5, null,  uv4, uv2i, uv5));				addFace(createFace(v7, v2i, v4, null, createUV(1-uv3.u,uv3.v), uv2i, uv4 ) );								if(_thickness > 0)					edgeslist.push(v3, v4, v7, v2i, v6);					 			} else {								uv1 = createUV( 1 ,1 );				uv2 = createUV(.5, 1);				addFace(createFace(v0, v1, v2, null, uv0, uv1, uv2));				v3 = createVertex(-v1.x,v1.y,v1.z);				addFace(createFace(v0, v2, v3, null, uv0, uv2, createUV(0,1)));								if(_thickness > 0)					edgeslist.push(v3);			}			 			//thickness			if(_thickness > 0){				var f:Face;				var facecount:int = faces.length;				var vertcount:int = vertices.length;				var ht:Number = _thickness*.5;								for(var i:int = 0;i<vertcount;++i){					vertices[i].y += ht;				}								edgeslist.push(v0);				var edgeslist2:Array = [];				var v:Vertex;				for(i = 0;i<edgeslist.length;++i){					v = edgeslist[i];					edgeslist2.push(createVertex(v.x, -v.y, v.z));				}				var uvs:Array = [];				var dists:Array = [];				var dist:Number;				//distances for u spread				var totaldist:Number = 0;				for(i = 0;i<edgeslist.length-1;++i){					dist = getDistance(edgeslist[i], edgeslist[i+1]);					totaldist+= dist;					dists.push(dist);				}				dist = 0;				for(i = 0;i<edgeslist.length;++i){					uvs.push(createUV(dist/totaldist,1));					dist+=dists[i];				}								for(i = 0;i<edgeslist.length-1;++i){					v0 = edgeslist2[i]; 					v1 = edgeslist[i]; 					v2 = edgeslist[i+1]; 					v3 = edgeslist2[i+1]; 										uv0 = createUV(uvs[i].u,0); 					uv1 = uvs[i]; 					uv2 = uvs[i+1]; 					uv3 = createUV(uvs[i+1].u,0);										addFace(createFace(v1, v0, v2, _sideMaterial, uv1, uv0, uv2));					addFace(createFace(v2, v0, v3, _sideMaterial, uv2, uv0, uv3));				}								edgeslist = edgeslist2 = uvs = dists = null;								for(i = 0;i<facecount;++i){					f = faces[i];					addFace(createFace(createVertex(f.v1.x, -f.v1.y,f.v1.z),												createVertex(f.v0.x, -f.v0.y,f.v0.z),												createVertex(f.v2.x, -f.v2.y,f.v2.z), _bottomMaterial,												createUV(1- f.uv1.u, f.uv1.v),												createUV(1- f.uv0.u, f.uv0.v),												createUV(1- f.uv2.u, f.uv2.v) ));				}				 			}		}				private  function getDistance(v0:Vertex, v1:Vertex):Number		{			return Math.sqrt((v0.x - v1.x) * (v0.x - v1.x) + (v0.z - v1.z) * (v0.z - v1.z));		}				/**		 * Defines the width of the arrow. Defaults to 100.		 */		public function get width():Number		{			return _width;		}				public function set width(val:Number):void		{			if (_width == val)				return;						_width = val;			_primitiveDirty = true;		}				/**		 * Defines the extrusion thickness of the arrow		 */		public function get thickness():Number		{			return _thickness;		}				public function set thickness(val:Number):void		{			if (_thickness == val)				return;						_thickness = (val < 0)? 0 : val;						_primitiveDirty = true;		}				/**		 * Defines if thickness is set, a material for the extruded sides of the Arrow object.		 * If none is provided, Arrow material is used instead. Default is null.		 */		public function get sideMaterial():Material		{			return _sideMaterial;		}				public function set sideMaterial(mat:Material):void		{			_sideMaterial = mat;			_primitiveDirty = true;		}				/**		 * Optional material for bottom plane of the Arrow 		 */		public function get bottomMaterial():Material		{			return _bottomMaterial;		}				public function set bottomMaterial(mat:Material):void		{			_bottomMaterial = mat;			_primitiveDirty = true;		}				/**		 * Defines the height of the arrow. Default is 100.		 */		public function get height():Number		{			return _height;		}				public function set height(val:Number):void		{			if (_height == val)				return;						_height = val;			_primitiveDirty = true;		}				/**		 * Defines the width of the tail. if no tailHeight is set higher than 0, no tail is generated. Default is 0;		 */		public function get tailWidth():Number		{			return _tailwidth;		}				public function set tailWidth(val:Number):void		{			if (_tailwidth == val)				return;						_tailwidth = (val < 0)? 0 : Math.min(_width, val);							_primitiveDirty = true;		}				/**		 * Defines the length of the tail. if no tailWidth is set higher than 0, no tail is generated. Default is 0;		 * note that the length of the tail do not increase the height of the arrow. The length cannot exceed the height of the arrow.		 */		public function get tailLength():Number		{			return _taillength;		}				public function set tailLength(val:Number):void		{			if (_taillength == val)				return;						_taillength = (val < 0)? 0 : val;						_primitiveDirty = true;		}				/**		 * Defines whether the coordinates of the plane points use a yUp orientation (true) or a zUp orientation (false). Defaults is true.		 */		public function get yUp():Boolean		{			return _yUp;		}				public function set yUp(val:Boolean):void		{			if (_yUp == val)				return;						_yUp = val;			_primitiveDirty = true;		}				/**		 * Creates a new <code>Arrow</code> object.		 *		 * @param	init			[optional]	An initialisation object for specifying default instance properties.		 * properties are: width, height, tailWidth, tailLength, thickness , (sideMaterial if thickness is set), optional bottomMaterial and Yup. 		 */		public function Arrow(init:Object = null)		{			super(init);			_width = ini.getNumber("width", 100, {min:0});			_height = ini.getNumber("height", 100, {min:0});			_tailwidth = ini.getNumber("tailWidth", 0, {min:0, max:_width});			_taillength = ini.getNumber("tailLength", 0, {min:0, max:_height});			_thickness = ini.getNumber("thickness", 0, {min:0});			_sideMaterial = ini.getMaterial("sideMaterial");			_bottomMaterial = ini.getMaterial("bottomMaterial");			_yUp = ini.getBoolean("yUp", true);						buildPrimitive();			type = "Arrow";			url = "primitive";		}				/**		 * @inheritDoc		 */		protected override function buildPrimitive():void    	{    		super.buildPrimitive();			buildArrow();		}	}}