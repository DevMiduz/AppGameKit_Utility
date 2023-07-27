/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	grid_pathfinding.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

#include "grid.agc"

/*

	CONSTANTS

*/

#constant TILE_OPEN = 0
#constant TILE_CLOSED = 1
#constant TILE_IMPASSIBLE = 2


/*

	TYPES
	
*/


/*

	FUNCTIONS
	
*/

/*

	-- PATHFINDING FUNCTIONS

*/



/*

	-- TILEDATA FUNCTIONS

*/

function GridPathfinding_InitTileData(grid ref as Grid, tileDataArray ref as TileData[])
	tile as Tile
	row as Row
	
	for rowIndex = 0 to grid.rows.length
		row = grid.rows[rowIndex]
		for colIndex = 0 to row.tiles.length
			tile = row.tiles[colIndex]
			tileDataArray.insert(TileData_Create(tile.id, TILE_OPEN, -1))
		next colIndex
	next rowIndex
	
	tileDataArray.sort()
endfunction

function GridPathfinding_GetTileData(tileDataArray ref as TileData[], tileData ref as TileData, id as integer)
	index = tileDataArray.find(id)
	
	if(index <> -1)
		tileData = tileDataArray[index]
	endif
	
endfunction index

function GridPathfinding_InsertOrUpdateTileData(tileDataArray ref as TileData[], tileData as TileData)
	index = tileDataArray.find(tileData.tileId)
	
	if(index <> -1)
		tileDataArray[index] = tileData
	else
		tileDataArray.insert(tileData)
		tileDataArray.sort()
	endif
	
endfunction

function GridPathFinding_FindTileDataFromWorldPosition(grid ref as Grid, tileDataArray ref as TileData[], worldPos as Vector2D)
	tileData as TileData
	tile as Tile
	
	tileData.tileId = -1
	
	tile = Grid_GetTileFromWorldPosition(grid, worldPos)
	GridPathfinding_GetTileData(tileDataArray, tileData, tile.id)
endfunction tileData

function GridPathFinding_FindTileDataFromGridPosition(grid ref as Grid, tileDataArray ref as TileData[], gridPos as Vector2D)
	tileData as TileData
	tile as Tile
	
	tileData.tileId = -1
	
	tile = Grid_GetTileFromGridPosition(grid, gridPos)
	GridPathfinding_GetTileData(tileDataArray, tileData, tile.id)
endfunction tileData

function GridPathfinding_DebugTileData(tileDataArray ref as TileData[])
	tileData as TileData
	output as String
	
	for i = 0 to tileDataArray.length
		tileData = tileDataArray[i]
		output = "tileData: " + tileData.toJson()
		Log(output)
	next i
endfunction

/*

	TEST_FUNCTIONS
	
*/

function GridPathfinding_TestUtility()	
	
	
	grid as Grid
	gridExpander as GridExpander
	tileDataArray as TileData[]
	
	grid = Grid_Create(8, Vector2D_CreateVector(0, 0))
	
	do
	    Print( ScreenFPS() )
	    
	    if(GetRawKeyPressed(32))
	    		inc gridExpander.eastOffset
	    		inc gridExpander.westOffset
	    		inc gridExpander.northOffset
	    		inc gridExpander.southOffset
	    		GridExpander_ExpandGrid(grid, gridExpander)
	    		GridPathfinding_InitTileData(grid, tileDataArray)
	    		GridPathfinding_DebugTileData(tileDataArray)
	    endif
	    
	    Sync()
	loop
	
endfunction