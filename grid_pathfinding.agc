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
	GridPathfinding_GetTileData(tileDataArray, currentTileData, currentTile.id)
	
	//Loop until required distance or until all tiles have been reached.
	currentTileData.distance = 0
	toVisit.insert(startTile)
	
	distance as integer
	
	while(toVisit.length > -1 and ticks <= maxTicks)
		currentTile = toVisit[0]
		toVisit.remove(0)
		
		if(GridPathfinding_HasTileBeenVisited(currentTile.id, grid, visited) = -1)
			visited.insert(currentTile.id)
			visited.sort()
			
			//SetTextString(currentTile.distanceText, str(currentTile.distance))
			
			GridPathfinding_FindTileNeighbours(grid, tileDataArray, currentTile, toVisit, visited)
			inc ticks
		endif
	endwhile
	
endfunction

function GridPathfinding_FindTileNeighbours(grid ref as Grid, tileDataArray ref as TileData[], tile ref as Tile, toVisit ref as Tile[], visited ref as integer[])
	neighbourTile as Tile
	neighbourTileData as TileData
	
	if(Grid_IsGridPositionWithinGrid(grid, tile.gridPosition) = -1) then exitfunction
	
	// LEFT
	neighbourTile = Grid_GetTileFromGridPosition(grid, Vector2D_CreateVector(tile.gridPosition.x - 1, tile.gridPosition.y))
	GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
	if(Grid_IsGridPositionWithinGrid(grid, neighbourTile.gridPosition) <> -1)
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			//update distance in grid data
			inc neighbourTileData.distance 
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif
	
	// UP
	neighbourTile = Grid_GetTileFromGridPosition(grid, Vector2D_CreateVector(tile.gridPosition.x, tile.gridPosition.y - 1))
	GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
	if(Grid_IsGridPositionWithinGrid(grid, neighbourTile.gridPosition) <> -1)
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			//update distance in grid data
			inc neighbourTileData.distance 
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif
	
	// RIGHT
	neighbourTile = Grid_GetTileFromGridPosition(grid, Vector2D_CreateVector(tile.gridPosition.x + 1, tile.gridPosition.y))
	GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
	if(Grid_IsGridPositionWithinGrid(grid, neighbourTile.gridPosition) <> -1)
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			//update distance in grid data
			inc neighbourTileData.distance 
			GridPathfinding_InsertOrUpdateTileData(tileDataArray, neighbourTileData)
			toVisit.insert(neighbourTile)
		endif
	endif

	// DOWN
	neighbourTile = Grid_GetTileFromGridPosition(grid, Vector2D_CreateVector(tile.gridPosition.x, tile.gridPosition.y + 1))
	GridPathfinding_GetTileData(tileDataArray, neighbourTileData, neighbourTile.id)
	
	if(Grid_IsGridPositionWithinGrid(grid, neighbourTile.gridPosition) <> -1)
		if(GridPathfinding_HasTileBeenVisited(neighbourTile.id, grid, visited) = -1 and GridPathfinding_IsTileImpassible(neighbourTileData) = -1)
			//update distance in grid data
			inc neighbourTileData.distance 
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

function GridPathfinding_FindTileDataFromWorldPosition(grid ref as Grid, tileDataArray ref as TileData[], worldPos as Vector2D)
	tileData as TileData
	tile as Tile
	
	tileData.tileId = -1
	
	tile = Grid_GetTileFromWorldPosition(grid, worldPos)
	GridPathfinding_GetTileData(tileDataArray, tileData, tile.id)
endfunction tileData

function GridPathfinding_FindTileDataFromGridPosition(grid ref as Grid, tileDataArray ref as TileData[], gridPos as Vector2D)
	tileData as TileData
	tile as Tile
	
	tileData.tileId = -1
	
	tile = Grid_GetTileFromGridPosition(grid, gridPos)
	GridPathfinding_GetTileData(tileDataArray, tileData, tile.id)
endfunction tileData

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

/*
function GridPathfinding_InitGrid(grid ref as Grid)
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
	    
	    /*
	    if(GetPointerPressed())
		    		tileX as integer
		    		tileY as integer
		    		
		    		tileX = GetPointerX() / gGrid.tileSize
		    		tileY = GetPointerY() / gGrid.tileSize
		    
				resetDistances(gGrid)
				pathfindingLoop(gGrid.tiles[tileX, tileY], gGrid)
    		endif
    		*/
	    
	    Sync()
	loop
	
endfunction