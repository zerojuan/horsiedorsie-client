package com.away3d.core.vos 
{
	import com.away3d.core.base.*;
	import com.away3d.materials.*;
	
	/**
	 * @author robbateman
	 */
	public class ElementVO 
	{
		public var commands:Vector.<String> = new Vector.<String>();
		
		public var vertices:Vector.<Vertex> = new Vector.<Vertex>();
		
		public var screenZ:Number;
		
		public var material:Material;
	}
}
