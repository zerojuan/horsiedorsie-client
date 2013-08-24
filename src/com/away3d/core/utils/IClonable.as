package com.away3d.core.utils
{
	import com.away3d.core.base.*;
	
    /** Interface for object that can be cloned */
    public interface IClonable
    {
        function clone(object:Object3D = null):Object3D;
    }
}
