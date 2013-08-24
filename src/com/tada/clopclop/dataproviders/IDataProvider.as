package com.tada.clopclop.dataproviders
{
	import com.tada.clopclop.datamodels.IDBModel;

	/**
	 * DataProviders are loaded during preload phase.
	 * Use this to get the data
	 */
	public interface IDataProvider{
		/**
		 * Boolean check, if the data for this provider is ready
		 */
		function get isReady():Boolean;
		/**
		 * Returns a model containing the id
		 */
		function getModelById(id:Number):IDBModel;
		/**
		 * Get the models with the same value of the specific category
		 */
		function getModelsByCategory(arr:Array):Array;
	}
}