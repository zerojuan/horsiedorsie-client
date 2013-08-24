package com.tada.clopclop.toolsets.character.jockey.sets
{
	import com.away3d.animators.VertexAnimator;
	
	/**
	 * Author: Hedrick David
	 * 
	 * Base class for the jockey sets
	 */
	
	public interface JockeyCharacterSets
	{
		
		/**
		 * Sets the texture based on the textureType set.
		 * 
		 * @params1:textureType - set the texture index. Use the constant values in
		 * this character set for reference.
		 */
		
		function changeTexture (textureType:int):void;
		
		/**
		 * Changes the mesh of the character set based on the int set.
		 * 
		 * @params1:meshType - set the mesh index. Use the constant values in
		 * this character set for reference.
		 */
		
		function changeMesh (meshType:int):void;
		
		/**
		 * Getter function to return the vertexAnimator variable of the mesh
		 * used to control the animation of the specific character set.
		 */
		
		function get vertexAnimator():VertexAnimator;
		
		/**
		 * Sets the visibility of the mesh.
		 */
		
		function visible (visibility:Boolean):void;
		
		/**
		 * Sets the alpha of the mesh. Use sparingly, since
		 * the use of ownCanvas properties can cause undesirable effects
		 * in viewing when the character set is integrated with other mesh. 
		 */
		
		function alpha (alpha:Number):void;
		
		/**
		 * Return the value that specifies whether the asset has been loaded. 
		 */
		
		function get assetLoaded():Boolean;
		
		/**
		 * Getter function that returns the index value of the current texture
		 * for reference.
		 */
		
		function get textureIndex():int;
		
		/**
		 * Sets the indexes to its default or initial values.
		 * Use only when initializing.
		 */
		
		function setInitialIndexes():void;
		
		/**
		 * Getter function that returns the index value of the current mesh
		 * for reference.
		 */
		
		function get meshIndex():int;
		
		/**
		 * Setter function that sets the visibility of the current mesh.
		 */
		
		function set visibility (value:Boolean):void;
		
		/**
		 * Getter function that returns the state of the visibility of the 
		 * current mesh for reference.
		 */
		
		function get visibility ():Boolean;
	}
}