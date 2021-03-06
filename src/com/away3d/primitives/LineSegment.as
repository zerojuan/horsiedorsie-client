﻿package com.away3d.primitives
{
    import com.away3d.core.base.*;
    
    import flash.geom.*;
    
    /**
    * Creates a 3d line segment.
    */ 
    public class LineSegment extends Mesh
    {
        private var _segment:Segment;
		
		/**
		 * Defines the starting vertex.
		 */
        public function get start():Vertex
        {
            return _segment.v0;
			//TBD: get vertex for segments>1
        }

        public function set start(value:Vertex):void
        {
			recalc(value,p2);
        }
		
		/**
		 * Defines the ending vertex.
		 */
        public function get end():Vertex
        {
            return _segment.v1;
			//TBD: get vertex for segments>1
        }
		
        public function set end(value:Vertex):void
        {
            recalc(p1,value);
        }
		
		private var i:int;
		private var lsegments:Number;
		public var p1:Vector3D;
		public var p2:Vector3D;
		private var newsegmentstart:Vertex;
		private var newsegmentend:Vertex;
		
		/**
		 * Recalculate start and end Vertex positions 
		 */
		private function recalc(vp1:*,vp2:*):void
        {
			p1=new Vector3D(vp1["x"],vp1["y"],vp1["z"]);
			p2=new Vector3D(vp2["x"],vp2["y"],vp2["z"]);

            if(lsegments>1){
				var _index:int = segments.length;
    			while (_index--)
    				removeSegment(segments[_index]);
				
				var difx:Number;
				var dify:Number;
				var difz:Number;
			
				difx=(p1.x-p2.x)/lsegments;
				dify=(p1.y-p2.y)/lsegments;
				difz=(p1.z-p2.z)/lsegments;
			
				for (i = 1; i <= lsegments; ++i)
            		{
						newsegmentstart=new Vertex(p1.x-(difx*(i)), p1.y-(dify*(i)), p1.z-(difz*(i)));
						newsegmentend=new Vertex(p2.x+(difx*(lsegments-(i-1))), p2.y+(dify*(lsegments-(i-1))), p2.z+(difz*(lsegments-(i-1))));
						_segment = new Segment(newsegmentstart, newsegmentend);
             			addSegment(_segment);
					}
			}else{
				_segment.v0.setValue(p1.x, p1.y, p1.z);
				_segment.v1.setValue(p2.x, p2.y, p2.z);
			}
        }
		
		/**
		 * Creates a new <code>LineSegment</code> object.
		 *
		 * @param	init			[optional]	An initialisation object for specifying default instance properties.
		 */
        public function LineSegment(init:Object = null)
        {
            super(init);
			var edge:Number = ini.getNumber("edge", 100, {min:0}) / 2;
			lsegments = ini.getNumber("segments", 1, {min:1});
			p1 = ini.getPosition("start") || new Vector3D(-edge, 0, 0);
			p2 = ini.getPosition("end") || new Vector3D(edge, 0, 0);
			
			if(lsegments>1){
				recalc(p1,p2);
			}else{
				_segment = new Segment(new Vertex(p1.x, p1.y, p1.z), new Vertex(p2.x, p2.y, p2.z));
             	addSegment(_segment);
			}
			
			type = "LineSegment";
        	url = "primitive";
        }
    
    }
}
