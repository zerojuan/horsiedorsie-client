﻿package com.away3d.materials.utils{	import com.away3d.core.base.*;	import com.away3d.containers.*;		import flash.geom.*;	import flash.utils.*;		/**	* Class remaps the uvs of an Object3D for a given orientation:	* projection strings = "front", "back", "top", "bottom", "left","right", "cylindricalX", "cylindricalY", "cylindricalZ", "spherical" or "spherical2"	*/		public class Projector	{		private static var _width:Number;		private static var _height:Number;		private static var _depth:Number;		private static var _offsetW:Number;		private static var _offsetH:Number;		private static var _offsetD:Number;		private static var _orientation:String;		private static var _selection:Array;		private static var _center:Vector3D;		private static var _vn:Vector3D;		private static var _ve:Vector3D;		private static var _vp:Vector3D;		private static var _crp:Vector3D;		private static const PI:Number = 3.141592653589793;		private static const DOUBLEPI:Number = (3.141592653589793 * 2);				/**		*  Applies the mapping to the Object3D object according to string orientation		* @param	 orientation	String. Defines the way the map will be projected onto the Object3D. orientation value  can be: "front", "back", "top", "bottom", "left", "right", "cylindricalX", "cylindricalY", "cylindricalZ", "spherical" or "spherical2"		* Cylindrical axis: X, 1,0,0 cylinder is done on yz plane. Y, 0,1,0 on xz plan and Z on xy.		* Because we use triangles, cylindrical and spherical projection have a correction to ensure no face is offsetted more than .7		* @param	 object3d		Object3d. The Object3D to remap.		* @param	 selection		Array. An array of booleans that defines if vertexes must be considered for the bounds. Applicable only if Object3D is type Mesh.		* @ For instance: projecting only 1 faces on a mesh composed of two faces [false, false, false, true, true, true]. In this case only uvs of face 2 would be altered, and projection would be based only on this vertexes bounds.		* vo0, vo1, v02 are considered for bounderies, and only if true the uv's will be altered. Allowing random selection for a custom editor UV editor.		* 'spherical' projects the vertexes of the mesh while 'spherical2', projects the faces normals.		* @param	 forceBounds. Boolean. In some cases the bounds of an object are not refreshed for perf reasons. Passing this boolean forces the calculation. Applies only when array selection is not passed.		*/		public static function project(orientation:String, object3d:Object3D, selection:Array = null, forceBounds:Boolean = false):void		{			_orientation = orientation.toLowerCase();						var minX:Number = Infinity;			var minY:Number = Infinity;			var minZ:Number = Infinity;			var maxX:Number = -Infinity;			var maxY:Number = -Infinity;			var maxZ:Number = -Infinity;						_selection = selection;						var i:int;						var f:Face;			var index:int = 0;			var m:Mesh = object3d as Mesh;						if(!object3d is Mesh || selection == null){				_selection = null;				if(forceBounds){					for(i = 0;i<m.faces.length;++i){						f = m.faces[i];						minX = Math.min(f.v0.x, f.v1.x,f.v2.x, minX);						minY = Math.min(f.v0.y, f.v1.y,f.v2.y, minY);						minZ = Math.min(f.v0.z, f.v1.z,f.v2.z, minZ);						maxX = Math.max(f.v0.x,f.v1.x,f.v2.x, maxX);						maxY = Math.max(f.v0.y,f.v1.y,f.v2.y, maxY);						maxZ = Math.max(f.v0.z,f.v1.z,f.v2.z, maxZ);					}				} else{										minX = object3d.minX;					minY = object3d.minY;					minZ = object3d.minZ;					maxX = object3d.maxX;					maxY = object3d.maxY;					maxZ = object3d.maxZ;				}							} else{ 				for(i = 0;i<m.faces.length;++i){					f = m.faces[i];					index = i*3;					if(_selection[index] != null){						if(_selection[index]){							minX = Math.min(f.v0.x, minX);							minY = Math.min(f.v0.y, minY);							minZ = Math.min(f.v0.z, minZ);							maxX = Math.max(f.v0.x, maxX);							maxY = Math.max(f.v0.y, maxY);							maxZ = Math.max(f.v0.z, maxZ);						}						index ++;						if(_selection[index]){							minX = Math.min(f.v1.x, minX);							minY = Math.min(f.v1.y, minY);							minZ = Math.min(f.v1.z, minZ);							maxX = Math.max(f.v1.x, maxX);							maxY = Math.max(f.v1.y, maxY);							maxZ = Math.max(f.v1.z, maxZ);						}						index ++;						if(_selection[index]){							minX = Math.min(f.v2.x, minX);							minY = Math.min(f.v2.y, minY);							minZ = Math.min(f.v2.z, minZ);							maxX = Math.max(f.v2.x, maxX);							maxY = Math.max(f.v2.y, maxY);							maxZ = Math.max(f.v2.z, maxZ);						}					} else {						break;					}									}			}						if(_orientation == "front" || _orientation == "back" || _orientation == "cylindricalx"){				_width = maxX - minX;				_height = maxY - minY;				_depth = maxZ - minZ;				_offsetW = (minX>0)? -minX : Math.abs(minX);				_offsetH= (minY>0)? -minY : Math.abs(minY);				_offsetD= (minZ>0)? -minZ : Math.abs(minZ);				}						if(_orientation == "left" || _orientation == "right" || _orientation == "cylindricalz"){				_width = maxZ - minZ;				_height = maxY - minY;				_depth = maxX - minX;				_offsetW = (minZ>0)? -minZ : Math.abs(minZ);				_offsetH= (minY>0)? -minY : Math.abs(minY);				_offsetD= (minX>0)? -minX : Math.abs(minX);				}						if(_orientation == "top" || _orientation == "bottom" || _orientation == "cylindricaly"){				_width = maxX - minX;				_height = maxZ - minZ;				_depth = maxY - minY;				_offsetW = (minX>0)? -minX : Math.abs(minX);				_offsetH= (minZ>0)? -minZ : Math.abs(minZ);				_offsetD= (minY>0)? -minY : Math.abs(minY);				}						if(_orientation == "spherical"){				if(!_center){					_center = new Vector3D();					_vn = new Vector3D(0,-1,0);					_ve = new Vector3D(.9,0,.1);					_ve.normalize();					_vp = new Vector3D();					_crp = new Vector3D();								}				 				_center.x = .1;				_center.y = .1;				_center.z = .1;			}						parse(object3d);		}				private static function parse(object3d:Object3D):void		{			 			if(object3d is ObjectContainer3D){							var obj:ObjectContainer3D = (object3d as ObjectContainer3D);							for(var i:int =0;i<obj.children.length;++i){										if(obj.children[i] is ObjectContainer3D){						parse(obj.children[i]);					} else if(obj.children[i] is Mesh){						remapMesh( obj.children[i] as Mesh);					}				}							} else if (object3d is Mesh){				remapMesh( object3d as Mesh);			}			 		}				private static function remapMesh(mesh:Mesh):void		{			if(_orientation.indexOf("spherical") != -1)				remapSpherical(mesh);			else if(_orientation.indexOf("cylindrical") != -1)				remapCylindrical(mesh);			else				remapLinear(mesh);		}				private static function averageNormals(v:Vertex, n:Vector3D, fn:Vector3D, mesh:Mesh):Vector3D		{			n.x = 0;			n.y = 0;			n.z = 0;			var count:int = 0;			var f:Face;			var norm:Vector3D;			 			for(var i:int = 0;i<mesh.faces.length;++i){				f = mesh.faces[i];				if((f.v0.x == v.x && f.v0.y == v.y && f.v0.z == v.z) || (f.v1.x == v.x && f.v1.y == v.y && f.v1.z == v.z )|| (f.v2.x == v.x && f.v2.y == v.y && f.v2.z == v.z)){					norm = f.normal;					n.x += norm.x;					n.y += norm.y;					n.z += norm.z;					count++;				}			}			 			n.x /= count;			n.y /= count;			n.z /= count;						n.normalize();			 			return n;		}		 				private static function remapSpherical(mesh:Mesh):void		{			var i:int;			var f:Face;			var fn:Vector3D;			var nv:Vector3D = new Vector3D();			var uvs:Array;			var spherical:Boolean = (_orientation == "spherical")? true : false;						if(spherical){				var dico:Dictionary = new Dictionary();				var nVs:Array;			}						var boundingRadius:Number = mesh.boundingRadius;						if(_selection != null){								var index:int = 0;												for(i = 0;i<mesh.faces.length;++i){					f = mesh.faces[i];					index = i*3;					fn = f.normal;					 					if(_selection[index] != null && _selection[index]){												if(spherical){							if(dico[f.uv0] == null){								dico[f.uv0] = 1;								uvs = projectVertex(f.v0 , boundingRadius);								f.uv0.u = uvs[0];								f.uv0.v = uvs[1];							}						} else {							nv = averageNormals(f.v0, nv, fn, mesh);							f.uv0.u = (nv.x+1)*.5;							f.uv0.v = 1-((nv.y+1)*.5);						}  					}										index++;					if(_selection[index] != null && _selection[index]){												if(spherical){							if(dico[f.uv1] == null){								dico[f.uv1] = 1;								uvs = projectVertex(f.v1, boundingRadius);								f.uv1.u = uvs[0];								f.uv1.v = uvs[1];							}						} else {							nv = averageNormals(f.v1, nv, fn, mesh);							f.uv1.u = (nv.x+1)*.5;							f.uv1.v = 1-((nv.y+1)*.5);						}					}										index++;					if(_selection[index] != null && _selection[index]){												if(spherical){							if(dico[f.uv2] == null){								dico[f.uv2] = 1;								uvs = projectVertex(f.v2, boundingRadius);								f.uv2.u = uvs[0];								f.uv2.v = uvs[1];							}						} else {							nv = averageNormals(f.v2, nv, fn, mesh);							f.uv2.u = (nv.x+1)*.5;							f.uv2.v = 1-((nv.y+1)*.5);						}					}										if(spherical){						nVs = correctSpherical(f.uv0, f.uv1, f.uv2);						f.uv0 = nVs[0];						f.uv1 = nVs[1];						f.uv2 = nVs[2];					}									}							} else{								for(i = 0;i<mesh.faces.length;++i){					f = mesh.faces[i];										if(spherical){						if(dico[f.uv0] == null){							dico[f.uv0] = 1;							uvs = projectVertex(f.v0, boundingRadius);							f.uv0.u = uvs[0];							f.uv0.v = uvs[1];						}					} else {						fn = f.normal;						nv = averageNormals(f.v0, nv, fn, mesh);						f.uv0.u = (nv.x+1)*.5;						f.uv0.v = 1-((nv.y+1)*.5);					}										if(spherical){						if(dico[f.uv1] == null){							dico[f.uv1] = 1;							uvs = projectVertex(f.v1, boundingRadius);							f.uv1.u = uvs[0];							f.uv1.v = uvs[1];						}					} else {						nv = averageNormals(f.v1, nv, fn, mesh);						f.uv1.u = (nv.x+1)*.5;						f.uv1.v = 1-((nv.y+1)*.5);					}					 					if(spherical){						if(dico[f.uv2] == null){							dico[f.uv2] = 1;							uvs = projectVertex(f.v2, boundingRadius);							f.uv2.u = uvs[0];							f.uv2.v = uvs[1];						}					} else {						nv = averageNormals(f.v2, nv, fn, mesh);						f.uv2.u = (nv.x+1)*.5;						f.uv2.v = 1-((nv.y+1)*.5);					}										if(spherical){						nVs = correctSpherical(f.uv0, f.uv1, f.uv2);						f.uv0 = nVs[0];						f.uv1 = nVs[1];						f.uv2 = nVs[2];					}									}							}					}				//fix for triangle issue since code is more suitable for pixel based applications		private static function correctSpherical(uv0:UV, uv1:UV, uv2:UV):Array		{			var maxu:Number = Math.max(uv0.u,uv1.u,uv2.u);			var minu:Number = Math.min(uv0.u,uv1.u,uv2.u);			 			if(maxu-minu > 0.2){				if(uv0.u<.25 && uv1.u<.25){					uv2 = new UV(1-uv2.u, uv2.v);				} else if(uv1.u<.25 && uv2.u<.25){					uv0 = new UV(1-uv0.u, uv0.v);								} else if(uv0.u<.25 && uv2.u<.25){					uv1 = new UV(1-uv1.u, uv1.v);								} else if(uv0.u>.75 && uv1.u>.75){					uv2 = new UV(1-uv2.u, uv2.v);									} else if(uv1.u>.75 && uv2.u>.75){					uv0 = new UV(1-uv0.u, uv0.v);					 				} else if(uv0.u>.75 && uv2.u>.75){					uv1 = new UV(1-uv1.u, uv1.v);				}			}						return [uv0,uv1,uv2];		}				private static function projectVertex(vertex:Vertex, boundingRadius:Number):Array		{			var _dir:Vector3D = new Vector3D(vertex.x , vertex.y, vertex.z);						var _clone:Vector3D = new Vector3D();			 			var dist:Number = _dir.subtract(_center).length;			var rad:Number = boundingRadius+100;			var distrest:Number = rad-dist+100;			 			_dir.normalize();			 			_clone.x = _center.x + (_dir.x*distrest);			_clone.y = _center.y + (_dir.y*distrest);			_clone.z = _center.z + (_dir.z*distrest);			 			_vp.x = Math.ceil((_center.x - _clone.x ) * rad);			_vp.y = Math.ceil((_center.y - _clone.y) * rad);			_vp.z = Math.ceil((_center.z - _clone.z) * rad);			 			_vp.normalize();			 			var phi:Number = Math.acos( -_vn.dotProduct(_vp) );						var v:Number = phi / PI;						var theta:Number = Math.acos( _vp.dotProduct(_ve) / Math.sin(phi) ) / DOUBLEPI; 			var u:Number;			 			_crp = _ve.crossProduct(_vn);						if (_crp.dotProduct(_vp) < 0)				u = 1 - theta;			else				u = theta;									return [u,v];		}				private static function remapCylindrical(mesh:Mesh):void		{			var i:int;			var f:Face;			var index:int = 0;			//* Cylindrical axis: X, 1,0,0 cylinder is done on yz plane. Y, 0,1,0 on xz plan and Z on xy.			if(_selection != null){				for(i = 0;i<mesh.faces.length;++i){					f = mesh.faces[i];					index = i*3;					if(_selection[index] != null && _selection[index]){						 switch(_orientation){														case "cylindricalx":								if(_selection[index] != null && _selection[index]){									f.uv0.u = (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;									f.uv0.v = (PI + Math.atan2( f.v0.y, f.v0.z))/DOUBLEPI;								}								index++;								if(_selection[index] != null && _selection[index]){									f.uv1.u = (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;									f.uv1.v = (PI + Math.atan2( f.v1.y, f.v1.z))/DOUBLEPI;								}								index++;								if(_selection[index] != null && _selection[index]){									f.uv2.u = (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;									f.uv2.v = (PI + Math.atan2(f.v2.y, f.v2.z))/DOUBLEPI;								}								break;															case "cylindricaly":								if(_selection[index] != null && _selection[index]){									f.uv0.u = (f.v0.y+_offsetD+mesh.scenePosition.y)/_depth;									f.uv0.v = (PI + Math.atan2(f.v0.x, f.v0.z))/DOUBLEPI;								}								index++;								if(_selection[index] != null && _selection[index]){									f.uv1.u = (f.v1.y+_offsetD+mesh.scenePosition.y)/_depth;									f.uv1.v = (PI + Math.atan2(f.v1.x, f.v1.z))/DOUBLEPI;								}								index++;								if(_selection[index] != null && _selection[index]){									f.uv2.u = (f.v2.y+_offsetD+mesh.scenePosition.y)/_depth;									f.uv2.v = (PI + Math.atan2(f.v2.x, f.v2.z))/DOUBLEPI;								}								break;															case "cylindricalz":								if(_selection[index] != null && _selection[index]){									f.uv0.u = (f.v0.z+_offsetW+mesh.scenePosition.z)/_width;									f.uv0.v = (PI + Math.atan2(f.v0.y, f.v0.x))/DOUBLEPI;								}								index++;								if(_selection[index] != null && _selection[index]){									f.uv1.u = (f.v1.z+_offsetW+mesh.scenePosition.z)/_width;									f.uv1.v = (PI + Math.atan2(f.v1.y, f.v1.x))/DOUBLEPI;								}								index++;								if(_selection[index] != null && _selection[index]){									f.uv2.u = (f.v2.z+_offsetW+mesh.scenePosition.z)/_width;									f.uv2.v = (PI + Math.atan2(f.v2.y, f.v2.x))/DOUBLEPI;								}								break;						}						correctCylindrical(mesh, f);					}				}			} else{				for(i = 0;i<mesh.faces.length;++i){					f = mesh.faces[i];					switch(_orientation){												case "cylindricalx":							f.uv0.u = (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv0.v = (PI + Math.atan2( f.v0.y, f.v0.z))/DOUBLEPI;							f.uv1.u = (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv1.v = (PI + Math.atan2( f.v1.y, f.v1.z))/DOUBLEPI;							f.uv2.u = (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv2.v = (PI + Math.atan2(f.v2.y, f.v2.z))/DOUBLEPI;							break;													case "cylindricaly":							f.uv0.u = (f.v0.y+_offsetD+mesh.scenePosition.y)/_depth;							f.uv0.v = (PI + Math.atan2(f.v0.x, f.v0.z))/DOUBLEPI;							f.uv1.u = (f.v1.y+_offsetD+mesh.scenePosition.y)/_depth;							f.uv1.v = (PI + Math.atan2(f.v1.x, f.v1.z))/DOUBLEPI;							f.uv2.u = (f.v2.y+_offsetD+mesh.scenePosition.y)/_depth;							f.uv2.v = (PI + Math.atan2(f.v2.x, f.v2.z))/DOUBLEPI;							break;													case "cylindricalz":							f.uv0.u = (f.v0.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv0.v = (PI + Math.atan2(f.v0.y, f.v0.x))/DOUBLEPI;							f.uv1.u = (f.v1.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv1.v = (PI + Math.atan2(f.v1.y, f.v1.x))/DOUBLEPI;							f.uv2.u = (f.v2.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv2.v = (PI + Math.atan2(f.v2.y, f.v2.x))/DOUBLEPI;							break;					}					correctCylindrical(mesh, f);				}			}		}				private static function correctCylindrical(mesh:Mesh, f:Face):void		{			//because we are not using pixels, some extremity faces can overlap the rotation 0. causing uv's v of a face to be >.8 and smaller than .25 on same face.			//it's just a trick that prevents in most cases to remap few faces by hand. Comment this handler if you want exact cylindrical coordinates			if(f.uv0.v <.3 && (f.uv1.v>.7 || f.uv2.v>.7))				f.uv0.v = 1;						if(f.uv1.v <.3 &&  (f.uv0.v>.7 || f.uv2.v>.7))				f.uv1.v = 1;						if(f.uv2.v <.3 &&  (f.uv0.v>.7 || f.uv1.v>.7))				f.uv2.v = 1;										if(f.uv0.v >.7 && (f.uv1.v<.3 || f.uv2.v<.3))				f.uv0.v = 0;						if(f.uv1.v >.7 &&  (f.uv0.v<.3 || f.uv2.v<.3))				f.uv1.v = 0;						if(f.uv2.v >.7 &&  (f.uv0.v<.3 || f.uv1.v<.3))				f.uv2.v = 0;				 		}				private static function remapLinear(mesh:Mesh):void		{			var i:int;			var f:Face;			var index:int = 0;						if(_selection != null){				for(i = 0;i<mesh.faces.length;++i){					f = mesh.faces[i];					index = i*3;					switch(_orientation){						case "front":							if(_selection[index] != null && _selection[index]){								f.uv0.u = (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv1.u = (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv2.u = (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							}							break;													case "back":							if(_selection[index] != null && _selection[index]){								f.uv0.u = 1-(f.v0.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv1.u = 1-(f.v1.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv2.u = 1-(f.v2.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							}							break;													case "right":							if(_selection[index] != null && _selection[index]){								f.uv0.u = (f.v0.z+_offsetW+mesh.scenePosition.z)/_width;								f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv1.u = (f.v1.z+_offsetW+mesh.scenePosition.z)/_width;								f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv2.u = (f.v2.z+_offsetW+mesh.scenePosition.z)/_width;								f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							}							break;													case "left":							if(_selection[index] != null && _selection[index]){								f.uv0.u = 1-(f.v0.z+_offsetW+mesh.scenePosition.z)/_width;								f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv1.u = 1-(f.v1.z+_offsetW+mesh.scenePosition.z)/_width;								f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv2.u = 1-(f.v2.z+_offsetW+mesh.scenePosition.z)/_width;								f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							}							break;													case "top":							if(_selection[index] != null && _selection[index]){								f.uv0.u = (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv0.v = 1- (f.v0.z+_offsetH+mesh.scenePosition.z)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv1.u = (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv1.v = 1-(f.v1.z+_offsetH+mesh.scenePosition.z)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv2.u = (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv2.v = 1-(f.v2.z+_offsetH+mesh.scenePosition.z)/_height;							}							break;													case "bottom":							if(_selection[index] != null && _selection[index]){								f.uv0.u = 1- (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv0.v = 1- (f.v0.z+_offsetH+mesh.scenePosition.z)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv1.u = 1- (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv1.v = 1-(f.v1.z+_offsetH+mesh.scenePosition.z)/_height;							}							index++;							if(_selection[index] != null && _selection[index]){								f.uv2.u = 1- (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;								f.uv2.v = 1-(f.v2.z+_offsetH+mesh.scenePosition.z)/_height;							}							break;											}									}									 } else {			   			   			   				for(i = 0;i<mesh.faces.length;++i){					f = mesh.faces[i];					switch(_orientation){						case "front":							f.uv0.u = (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv1.u = (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv2.u = (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;														break;													case "back":							f.uv0.u = 1-(f.v0.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv1.u = 1-(f.v1.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv2.u = 1-(f.v2.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							break;												case "right":							f.uv0.u = (f.v0.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv1.u = (f.v1.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv2.u = (f.v2.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							break;													case "left":							f.uv0.u = 1-(f.v0.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv0.v = 1- (f.v0.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv1.u = 1-(f.v1.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv1.v = 1-(f.v1.y+_offsetH+mesh.scenePosition.y)/_height;							f.uv2.u = 1-(f.v2.z+_offsetW+mesh.scenePosition.z)/_width;							f.uv2.v = 1-(f.v2.y+_offsetH+mesh.scenePosition.y)/_height;							break;													case "top":							f.uv0.u = (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv0.v = 1- (f.v0.z+_offsetH+mesh.scenePosition.z)/_height;							f.uv1.u = (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv1.v = 1-(f.v1.z+_offsetH+mesh.scenePosition.z)/_height;							f.uv2.u = (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv2.v = 1-(f.v2.z+_offsetH+mesh.scenePosition.z)/_height;							break;													case "bottom":							f.uv0.u = 1- (f.v0.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv0.v = 1- (f.v0.z+_offsetH+mesh.scenePosition.z)/_height;							f.uv1.u = 1- (f.v1.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv1.v = 1-(f.v1.z+_offsetH+mesh.scenePosition.z)/_height;							f.uv2.u = 1- (f.v2.x+_offsetW+mesh.scenePosition.x)/_width;							f.uv2.v = 1-(f.v2.z+_offsetH+mesh.scenePosition.z)/_height;							break;											}									}							}					}					}}