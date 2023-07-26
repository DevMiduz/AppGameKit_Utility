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
#include "id_generator.agc"

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

	FUNCTIONS
	
*/

function Grid_Create(tileSize as integer, center as Vector2D)
	grid as Grid 
	Grid_CreateRef(grid, tileSize, center)
endfunction grid

function Grid_CreateRef(grid ref as Grid, tileSize as integer, center as Vector2D)
	grid.id = IDGenerator_GenerateNewID(GLOBAL_ID_GENERATOR)
	grid.tileSize = tileSize
	grid.center = center
	grid.tiles[0,0] = Tile_Create(Vector2D_CreateVector(0,0))
endfunction

function Tile_Create(gridPosition as Vector2D)
	tile as Tile
	Tile_CreateRef(tile, gridPosition)
endfunction tile

function Tile_CreateRef(tile ref as Tile, gridPosition as Vector2D)
	tile.id = IDGenerator_GenerateNewID(GLOBAL_ID_GENERATOR)
	tile.gridPosition = gridPosition
endfunction

/*

	TEST_FUNCTIONS
	
*/

function Grid_TestUtility()	
	
	do
	    Print( ScreenFPS() )
	    
	    if(GetRawKeyPressed(32))
	    		
	    endif
	    
	    Sync()
	loop
endfunction