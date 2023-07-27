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

function pathfindingLoop(startTile ref as Tile, grid ref as Grid)
	// maxTicks can be used to limit the distance that is checked.
	// but may impact lower powered devices AI functioning correctly.
	maxTicks as integer = 200
	ticks as integer
	
	visited as integer[]
	toVisit as Tile[]
	currentTile as Tile
	
	//Loop until required distance or until all tiles have been reached.
	startTile.distance = 0
	toVisit.insert(startTile)
	
	distance as integer
	
	while(toVisit.length > -1 and ticks <= maxTicks)
		currentTile = toVisit[0]
		toVisit.remove(0)
		
		if(hasTileBeenVisited(currentTile, grid, visited) = -1)
			visited.insert(currentTile.id)
			visited.sort()
			
			SetTextString(currentTile.distanceText, str(currentTile.distance))
			
			findTileNeighbours(currentTile, grid, toVisit, visited)
			inc ticks
		endif
	endwhile
	
endfunction

function findTileNeighbours(tile ref as Tile, grid ref as Grid, toVisit ref as Tile[], visited ref as integer[])
	if(tile.gx > 0)
		//LEFT
		if(hasTileBeenVisited(grid.tiles[tile.gx - 1, tile.gy], grid, visited) = -1 and isTileImpassible(grid.tiles[tile.gx - 1, tile.gy]) = -1)
			grid.tiles[tile.gx - 1, tile.gy].distance = (tile.distance + 1)
			toVisit.insert(grid.tiles[tile.gx - 1, tile.gy])
		endif
	endif	
	
	if(tile.gy > 0)
		//UP
		if(hasTileBeenVisited(grid.tiles[tile.gx, tile.gy - 1], grid, visited) = -1 and isTileImpassible(grid.tiles[tile.gx, tile.gy - 1]) = -1) 
			grid.tiles[tile.gx, tile.gy - 1].distance = (tile.distance + 1)
			toVisit.insert(grid.tiles[tile.gx, tile.gy - 1])
		endif
	endif

	if(tile.gx < grid.width)
		//RIGHT
		if(hasTileBeenVisited(grid.tiles[tile.gx + 1, tile.gy], grid, visited) = -1 and isTileImpassible(grid.tiles[tile.gx + 1, tile.gy]) = -1) 
			grid.tiles[tile.gx + 1, tile.gy].distance = (tile.distance + 1)
			toVisit.insert(grid.tiles[tile.gx + 1, tile.gy])
		endif
		
	endif
	
	if(tile.gy < grid.height)
		//DOWN
		if(hasTileBeenVisited(grid.tiles[tile.gx, tile.gy + 1], grid, visited) = -1 and isTileImpassible(grid.tiles[tile.gx, tile.gy + 1]) = -1) 
			grid.tiles[tile.gx , tile.gy + 1].distance = (tile.distance + 1)
			toVisit.insert(grid.tiles[tile.gx, tile.gy + 1])
		endif
	endif
	
endfunction

function isTileOpen(tile ref as Tile)
	if(tile.status = TILE_OPEN) then exitfunction 1
endfunction -1

function isTileImpassible(tile ref as Tile)
	if(tile.status = TILE_IMPASSIBLE) then exitfunction 1
endfunction -1

function hasTileBeenVisited(tile ref as Tile, grid ref as Grid, visited ref as integer[])	
	if(visited.find(tile.id) <> -1) then exitfunction 1
endfunction -1
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

function GridPathFinding_ResetDistances(tileDataArray ref as TileData[])
	for i = 0 to tileDataArray.length
		tileDataArray[i].distance = -1
	next i
endfunction


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