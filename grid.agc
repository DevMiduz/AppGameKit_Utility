/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	grid.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	INCLUDES
	
*/

#include "vector.agc"

/*

	TYPES
	
*/
type Grid
	id as integer
	tileSize as integer
	center as Vector2D
	tiles as Tile[0,0]
	gridData as GridData
endtype

type Tile
	id as integer
	gridPosition as Vector2D
	tileData as TileData
endtype

/*
	Having separate data classes will mean it's easier to customise the grid and tile system without having to touch the inner workings.
*/

type GridData
	id as integer
endtype

type TileData
	status as integer
	distance as integer
endtype

type GridExpander
	northOffset as integer
	eastOffset as integer
	southOffset as integer
	westOffset as integer
endtype

/*
	The grid and tiles should be kept basic.
	A seperate array could hold the extra information
	for example a distances array could exist within the pathfinder
		TileData: tileId, Distance, 
		
	Either hold the TileData Directly or have a seperate array with it in.
*/

/*

function initGrid(grid ref as Grid)
	id as integer
	
	grid.tiles.length = grid.width
	
	for gx = 0 to grid.width
		grid.tiles[gx].length = grid.height
		for gy = 0 to grid.height
			tile as Tile
			
			tile.id = id
			tile.gx = gx
			tile.gy = gy
			tile.px = gx * grid.tileSize
			tile.py = gy * grid.tileSize
			tile.status = TILE_OPEN
			tile.distance = -1
			
			tile.sprite = CreateSprite(blocksImage)
			SetSpritePosition(tile.sprite, tile.px, tile.py)
			SetSpriteAnimation(tile.sprite, 8, 8, 4)
			PlaySprite(tile.sprite, 0)
			
			tile.distanceText = CreateText(str(tile.distance))
			SetTextPosition(tile.distanceText, tile.px, tile.py)
			
			if(Random(0, 8) = 0) 
				tile.status = TILE_IMPASSIBLE
				PlaySprite(tile.sprite, 0, 0, 4, 4)
			endif
			
			grid.tiles[gx, gy] = tile
			inc id
		next gy
	next gx
	
endfunction

*/


/*

	FUNCTIONS
	
*/

function Grid_Create(id as integer, tileSize as integer, center as Vector2D, gridData as GridData)
	grid as Grid 
	Grid_CreateRef(grid, id, tileSize, center, gridData)
endfunction grid


function Grid_CreateRef(grid ref as Grid, id as integer, tileSize as integer, center as Vector2D, gridData as GridData)
	grid.id = id
	grid.tileSize = tileSize
	grid.center = center
	grid.gridData = gridData
	
	//use the grid expander to expand the grid
	//the id system probably won't be viable with the GridExpander
	//due to find relting upon sort.
	//We would more than likely have to re-id the grid each time.
	//x and y index will have to be used
	//There again the id could be anything. It is only an idenfifier which could be used in a seperate array.
	//The seperate array could also contain the indexes
	
	
	//grid.tiles[0,0] = Tile_Create(0, Vector2D_CreateVector(0,0),)
endfunction

function Tile_Create(id as integer, gridPosition as Vector2D, tileData as TileData)
	tile as Tile
	Tile_CreateRef(tile, id, gridPosition, tileData)
endfunction tile

function Tile_CreateRef(tile ref as Tile, id as integer, gridPosition as Vector2D, tileData as TileData)
	
endfunction

/*

	TEST_FUNCTIONS
	
*/