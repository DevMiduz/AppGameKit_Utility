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

function GridPathfinding_UpdatePathDistances(grid ref as Grid, tileDataArray ref as TileData[], startTile ref as Tile)
	// maxTicks can be used to limit the distance that is checked.
	// but may impact lower powered devices AI functioning correctly.
	maxTicks as integer = 200
	ticks as integer
	
	visited as integer[]
	toVisit as Tile[]
	currentTile as Tile
	currentTileData as TileData
	
	GridPathfinding_GetTileData(tileDataArray, currentTileData, startTile.id)
	currentTileData.distance = 0
	GridPathfinding_InsertOrUpdateTileData(tileDataArray, currentTileData)
	
	toVisit.insert(startTile)
	
	distance as integer
	
	while(toVisit.length > -1 and ticks <= maxTicks)
		currentTile = toVisit[0]
		GridPathfinding_GetTileData(tileDataArray, currentTileData, currentTile.id)
		toVisit.remove(0)
		
		if(GridPathfinding_HasTileBeenVisited(currentTile.id, grid, visited) = -1)
			visited.insert(currentTile.id)
			visited.sort()
			GridPathfinding_FindTileNeighbours(grid, tileDataArray, currentTile, currentTileData, toVisit, visited)
			inc ticks
		endif
	endwhile
	
endfunction

function GridPathfinding_FindTileNeighbours(grid ref as Grid, tileDataArray ref as TileData[], tile ref as Tile, tileData ref as TileData, toVisit ref as Tile[], visited ref as integer[])
	neighbourTile as Tile
	neighbourTileData as TileData
	
	if(Grid_IsGridPositionWithinGrid(grid, tile.gridPosition) = -1) then exitfunction
	
	// LEFT
	
	if(Grid_IsGridPositionWithinGrid(grid, Vector2D_CreateVector(tile.gridPosition.x - 1, tile.gridPosition.y)) <> -1)
		Grid_GetTileFromGridPosition(grid, neighbourTile, Vector2D_CreateVector(tile.gridPosition.x - 1, tile.gridPosition.y))
		GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			neighbourTileData.distance = tileData.distance + 1
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif
	
	// UP
	if(Grid_IsGridPositionWithinGrid(grid, Vector2D_CreateVector(tile.gridPosition.x, tile.gridPosition.y - 1)) <> -1)
		Grid_GetTileFromGridPosition(grid, neighbourTile, Vector2D_CreateVector(tile.gridPosition.x, tile.gridPosition.y - 1))
		GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			neighbourTileData.distance = tileData.distance + 1
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif
	
	// RIGHT
	if(Grid_IsGridPositionWithinGrid(grid, Vector2D_CreateVector(tile.gridPosition.x + 1, tile.gridPosition.y)) <> -1)
		Grid_GetTileFromGridPosition(grid, neighbourTile, Vector2D_CreateVector(tile.gridPosition.x + 1, tile.gridPosition.y))
		GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			neighbourTileData.distance = tileData.distance + 1
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif

	// DOWN
	if(Grid_IsGridPositionWithinGrid(grid, Vector2D_CreateVector(tile.gridPosition.x, tile.gridPosition.y + 1)) <> -1)
		Grid_GetTileFromGridPosition(grid, neighbourTile, Vector2D_CreateVector(tile.gridPosition.x, tile.gridPosition.y + 1))
		GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			neighbourTileData.distance = tileData.distance + 1 
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif

endfunction

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

function GridPathfinding_FindTileDataFromWorldPosition(grid ref as Grid, tileDataArray ref as TileData[], tileData ref as TileData, worldPos as Vector2D)
	tile as Tile
	
	tileData.tileId = -1
	
	if(Grid_GetTileFromWorldPosition(grid, tile, worldPos) = -1) then exitfunction -1
	if(GridPathfinding_GetTileData(tileDataArray, tileData, tile.id) = -1) then exitfunction -1
endfunction 1

function GridPathfinding_FindTileDataFromGridPosition(grid ref as Grid, tileDataArray ref as TileData[], gridPos as Vector2D)
	tileData as TileData
	tile as Tile
	
	tileData.tileId = -1
	
	if(Grid_GetTileFromGridPosition(grid, tile, gridPos) = -1) then exitfunction -1
	if(GridPathfinding_GetTileData(tileDataArray, tileData, tile.id) = -1) then exitfunction -1
endfunction 1

function GridPathfinding_ResetTileDataDistances(tileDataArray ref as TileData[])
	for i = 0 to tileDataArray.length
		tileDataArray[i].distance = -1
	next i
endfunction

function GridPathfinding_IsTileOpen(tileData ref as TileData)
	if(tileData.status = TILE_OPEN) then exitfunction 1
endfunction -1

function GridPathfinding_IsTileImpassible(tileData ref as TileData)
	if(tileData.status = TILE_IMPASSIBLE) then exitfunction 1
endfunction -1

function GridPathfinding_HasTileBeenVisited(tileId as integer, grid ref as Grid, visited ref as integer[])	
	if(visited.find(tileId) <> -1) then exitfunction 1
endfunction -1

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

function GridPathfinding_RandomiseTileData(tileDataArray ref as TileData[])
	for i = 0 to tileDataArray.length
		tileDataArray[i].status = Random(0, 2)
	next i
endfunction

function GridPathfinding_DrawGrid(grid ref as Grid, tileDataArray ref as TileData[])
	tile as Tile
	tileData as TileData
	position as Vector2D
	
	for rowIndex = 0 to grid.rows.length
		for colIndex = 0 to grid.rows[rowIndex].tiles.length
			tile = Grid_GetTileFromGridIndex(grid, Vector2D_CreateVector(colIndex, rowIndex))
			GridPathfinding_GetTileData(tileDataArray, tileData, tile.id)
			
			if(tileData.status = TILE_OPEN)
				color = MakeColor( 255, 255, 255 )
			elseif(tileData.status = TILE_CLOSED)
				color = MakeColor( 0, 0, 255 )
			elseif(tileData.status = TILE_IMPASSIBLE)
				color = MakeColor( 255, 0, 0 )
			endif
			
			
			position = Grid_GetTileWorldPosition(grid, tile.gridPosition.x, tile.gridPosition.y)
			DrawBox(position.x, position.y, position.x + grid.tileSize, position.y + grid.tileSize, color, color, color, color, 0)
			
			if(GetTextExists(tileData.distanceText) = 0)
				tileData.distanceText = CreateText(str(tileData.distance))
			endif
			
			SetTextString(tileData.distanceText, str(tileData.distance))
			SetTextPosition(tileData.distanceText, position.x, position.y)
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, tileData)
			
		next colIndex
	next rowIndex
endfunction

function GridPathfinding_InitGrid(grid ref as Grid, GridExpander ref as GridExpander, tileDataArray ref as TileData[])
	
	grid = Grid_Create(8, Vector2D_CreateVector(0, 0))
	
	gridExpander.eastOffset = 10
	gridExpander.westOffset = 10
	gridExpander.northOffset = 0
	gridExpander.southOffset = 11
	
	GridExpander_ExpandGrid(grid, gridExpander)
	GridPathfinding_InitTileData(grid, tileDataArray)
	GridPathfinding_DebugTileData(tileDataArray)
	
endfunction

global blocksImage as integer
blocksImage = LoadImage("pathfinding_blocks.png")

function GridPathfinding_TestUtility()	
	
	
	grid as Grid
	gridExpander as GridExpander
	tileDataArray as TileData[]
	
	GridPathfinding_InitGrid(grid, GridExpander, tileDataArray)
	
	do
	    Print( ScreenFPS() )
	    
	    GridPathfinding_DrawGrid(grid, tileDataArray)
	    
	    if(GetRawKeyPressed(32))
	    		inc gridExpander.eastOffset
	    		inc gridExpander.westOffset
	    		inc gridExpander.northOffset
	    		inc gridExpander.southOffset
	    		GridExpander_ExpandGrid(grid, gridExpander)
	    		GridPathfinding_InitTileData(grid, tileDataArray)
	    		GridPathfinding_DebugTileData(tileDataArray)
	    endif
	     
	    if(GetRawKeyPressed(13))
	    		GridPathfinding_RandomiseTileData(tileDataArray)
	   	endif
	    
	    
	    if(GetPointerPressed())
			GridPathfinding_ResetTileDataDistances(tileDataArray)
			
			tile as Tile
			if(Grid_GetTileFromWorldPosition(grid, tile, Vector2D_CreateVector(GetPointerX(), GetPointerY())) <> -1)
				GridPathfinding_UpdatePathDistances(grid, tileDataArray, tile)
				GridPathfinding_DebugTileData(tileDataArray)
			endif
    		endif
    		
	    
	    Sync()
	loop
	
endfunction