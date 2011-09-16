package org.flixel.system;

import org.flixel.FlxObject;
import org.flixel.FlxTilemap;

/**
 * A simple helper object for <code>FlxTilemap</code> that helps expand collision opportunities and control.
 * You can use <code>FlxTilemap.setTileProperties()</code> to alter the collision properties and
 * callback functions and filters for this object to do things like one-way tiles or whatever.
 */
class FlxTile extends FlxObject
{
	/**
	 * This function is called whenever an object hits a tile of this type.
	 * This function should take the form <code>myFunction(Tile:FlxTile,Object:FlxObject):void</code>.
	 * Defaults to null, set through <code>FlxTilemap.setTileProperties()</code>.
	 */
	public var callbackFunction:Dynamic/*FlxTile->FlxObject->Void*/;
	/**
	 * Each tile can store its own filter class for their callback functions.
	 * That is, the callback will only be triggered if an object with a class
	 * type matching the filter touched it.
	 * Defaults to null, set through <code>FlxTilemap.setTileProperties()</code>.
	 */
	public var filter:Class<Dynamic>;
	/**
	 * A reference to the tilemap this tile object belongs to.
	 */
	public var tilemap:FlxTilemap;
	/**
	 * The index of this tile type in the core map data.
	 * For example, if your map only has 16 kinds of tiles in it,
	 * this number is usually between 0 and 15.
	 */
	#if flash
	public var index:UInt;
	#else
	public var index:Int;
	#end
	/**
	 * The current map index of this tile object at this moment.
	 * You can think of tile objects as moving around the tilemap helping with collisions.
	 * This value is only reliable and useful if used from the callback function.
	 */
	#if flash
	public var mapIndex:UInt;
	#else
	public var mapIndex:Int;
	#end
	
	/**
	 * Instantiate this new tile object.  This is usually called from <code>FlxTilemap.loadMap()</code>.
	 * @param Tilemap			A reference to the tilemap object creating the tile.
	 * @param Index				The actual core map data index for this tile type.
	 * @param Width				The width of the tile.
	 * @param Height			The height of the tile.
	 * @param Visible			Whether the tile is visible or not.
	 * @param AllowCollisions	The collision flags for the object.  By default this value is ANY or NONE depending on the parameters sent to loadMap().
	 */
	public function new(	Tilemap:FlxTilemap, 
							#if flash
							Index:UInt, 
							#else
							Index:Int, 
							#end
							Width:Float, Height:Float, Visible:Bool, 
							#if flash
							AllowCollisions:UInt
							#else
							AllowCollisions:Int
							#end
							)
	{
		super(0, 0, Width, Height);
		immovable = true;
		moves = false;
		callbackFunction = null;
		filter = null;
		
		tilemap = Tilemap;
		index = Index;
		visible = Visible;
		allowCollisions = AllowCollisions;
		
		mapIndex = 0;
	}
	
	/**
	 * Clean up memory.
	 */
	override public function destroy():Void
	{
		super.destroy();
		callbackFunction = null;
		tilemap = null;
	}
}