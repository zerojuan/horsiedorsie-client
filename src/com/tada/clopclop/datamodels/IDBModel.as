package com.tada.clopclop.datamodels
{
	import com.away3d.loaders.Obj;

	public interface IDBModel{
		function fill(result:Object):void;
		function clone():IDBModel;
	}
}