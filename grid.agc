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
	rows as Row[]
endtype

type Row
	tiles as Tile[]
endtype

type Tile
	id as integer
	gridPosition as Vector2D
endtype

/*
	Having separate data classes will mean it's easier to customise the grid and tile system without having to touch the inner workings.
*/

type GridData
	gridId as integer
endtype

type RowData
	rowId as integer
endtype

type TileData
	tileId as integer
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

	FUNCTIONS
	
*/

/*

	-- GRID FUNCTIONS

*/
function Grid_Create(tileSize as integer, center as Vector2D)
	grid as Grid 
	Grid_CreateRef(grid, tileSize, center)
endfunction grid

function Grid_CreateRef(grid ref as Grid, tileSize as integer, center as Vector2D)
	grid.id = IDGenerator_GenerateNewID(GLOBAL_ID_GENERATOR)
	grid.tileSize = tileSize
	grid.center = center
	grid.rows.insert(Row_Create())
	grid.rows[0].tiles.insert(Tile_Create(Vector2D_CreateVector(0,0)))
endfunction

function Grid_GetTopLeftPosition(grid ref as Grid)
	
endfunction grid.rows[0].tiles[0].gridPosition

function Grid_GetBottomRightPosition(grid ref as Grid)
	
endfunction grid.rows[grid.rows.length].tiles[grid.rows[grid.rows.length].tiles.length].gridPosition

function Grid_GetTilePositionFromWorldPosition(grid ref as Grid, worldPos as Vector2D)
	tilePos as Vector2D
	
	if(worldPos.x < 0)
		tilePos.x = ((worldPos.x - (grid.tileSize - 1))  / grid.tileSize)
	else
		tilePos.x = ((worldPos.x)  / grid.tileSize)
	endif
	
	if(worldPos.y < 0)
		tilePos.y = ((worldPos.y - (grid.tileSize - 1)) / grid.tileSize)
	else
		tilePos.y = ((worldPos.y) / grid.tileSize)
	endif
endfunction tilePos

function Grid_GetTileFromWorldPosition(grid ref as Grid, worldPos as Vector2D)
	gridPos as Vector2D
	tile as Tile
	
	gridPos = Grid_GetTilePositionFromWorldPosition(grid, worldPos)
	tile = Grid_GetTileFromGridPosition(grid, gridPos)
	
endfunction tile

function Grid_GetTileFromGridPosition(grid ref as Grid, gridPos as Vector2D)
	tile as Tile
	tile = grid.rows[gridPos.y].tiles[gridPos.x]
endfunction tile

function Grid_GetTileWorldPosition(grid ref as Grid, x as integer, y as integer)
	position as Vector2D
	position = Vector2D_CreateVector(grid.center.x + (x * grid.tileSize), grid.center.y + (y * grid.tileSize))
endfunction position

function Grid_IsWorldPositionWithinGrid(grid ref as Grid, position as Vector2D)
	topLeft as Vector2D
	bottomRight as Vector2D
	
	topLeft = Grid_GetTopLeftPosition(grid)
	bottomRight = Grid_GetBottomRightPosition(grid)
	
	if(position.x < topLeft.x * grid.tileSize or position.x > bottomRight.x * grid.tileSize) then exitfunction -1
	if(position.y < topLeft.y * grid.tileSize or position.y > bottomRight.y * grid.tileSize) then exitfunction -1
endfunction 1

function Grid_IsGridPositionWithinGrid(grid ref as Grid, position as Vector2D)
	topLeft as Vector2D
	bottomRight as Vector2D
	
	topLeft = Grid_GetTopLeftPosition(grid)
	bottomRight = Grid_GetBottomRightPosition(grid)
	
	if(position.x < topLeft.x or position.x > bottomRight.x + grid.tileSize) then exitfunction -1
	if(position.y < topLeft.y or position.y > bottomRight.y + grid.tileSize) then exitfunction -1
endfunction 1

function Grid_GetTileCenterByIndex(grid ref as Grid, x as integer, y as integer)
	position as Vector2D
	position = Vector2D_CreateVector(grid.center.x + (x * grid.tileSize) + (grid.tileSize / 2), grid.center.y + (y * grid.tileSize) + (grid.tileSize / 2) )
endfunction position

function Grid_GetTileIndexesInBox(grid ref as Grid, box as Box)
	tileIndexes as Vector2D[]
	
	indexSize as integer 
	indexSize = box.size / grid.tileSize
	
	if(mod(box.size, grid.tileSize) <> 0)
		inc indexSize
	endif
	
	position as Vector2D
	
	for i = 0 to indexSize - 1
		
		position.x = box.position.x + (grid.tileSize * i) 
			
		for j = 0 to indexSize - 1

			position.y = box.position.y + (grid.tileSize * j)
			
			tileIndexes.insert(Grid_GetTilePositionFromWorldPosition(grid, position))
		next j
	next i
	
	for i = 0 to tileIndexes.length
		Log(str(tileIndexes[i].x) + "," + str(tileIndexes[i].y))
	next i
	
endfunction indexSize

function Grid_Debug(grid ref as Grid)
	output as String
	
	for rowIndex = 0 to grid.rows.length
		output = str(rowIndex) + " => "
		
		for colIndex = 0 to grid.rows[rowIndex].tiles.length
			output = output + "|id:" + str(grid.rows[rowIndex].tiles[colIndex].id) + ",x:" + str(grid.rows[rowIndex].tiles[colIndex].gridPosition.x) + ",y:" + str(grid.rows[rowIndex].tiles[colIndex].gridPosition.y) + "|"
		next colIndex
		
		Log(output)
	next rowIndex
endfunction

/*

	-- ROW FUNCTIONS

*/

function Row_Create()
	row as Row
	Row_CreateRef(row)
endfunction row

function Row_CreateRef(row ref as Row)
	
endfunction

/*

	-- TILE FUNCTIONS

*/

function Tile_Create(gridPosition as Vector2D)
	tile as Tile
	Tile_CreateRef(tile, gridPosition)
endfunction tile

function Tile_CreateRef(tile ref as Tile, gridPosition as Vector2D)
	tile.id = IDGenerator_GenerateNewID(GLOBAL_ID_GENERATOR)
	tile.gridPosition = gridPosition
endfunction

/*

	-- GRID EXPANDER FUNCTIONS

*/

function GridExpander_ExpandGrid(grid ref as Grid, expander ref as GridExpander)
	topLeftTile as Tile
	bottomRightTile as Tile
	
	topLeftTile = grid.rows[0].tiles[0]
	bottomRightTile = grid.rows[grid.rows.length].tiles[grid.rows[grid.rows.length].tiles.length]
	
	for i = bottomRightTile.gridPosition.y + 1 to expander.southOffset
		GridExpander_PushBackRow(grid)
	next
	
	for i = abs(topLeftTile.gridPosition.y) + 1 to expander.northOffset
		GridExpander_PushFrontRow(grid)
	next i
	
	for i = bottomRightTile.gridPosition.x + 1 to expander.eastOffset
		GridExpander_PushBackColumn(grid)
	next i
	
	for i = abs(topLeftTile.gridPosition.x) + 1 to expander.westOffset
		GridExpander_PushFrontColumn(grid)
	next i
	
endfunction

function GridExpander_PushFrontRow(grid ref as Grid)
	tile as Tile
	row as Row
	
	row.tiles.length = grid.rows[0].tiles.length
	
	for i = 0 to row.tiles.length
		x = grid.rows[0].tiles[i].gridPosition.x
		y = grid.rows[0].tiles[i].gridPosition.y - 1
		
		tile = Tile_Create(Vector2D_CreateVector(x, y))
		row.tiles[i] = tile
	next i
	
	grid.rows.insert(row, 0)
endfunction

function GridExpander_PushBackRow(grid ref as Grid)
	tile as Tile
	row as Row
	
	row.tiles.length = grid.rows[grid.rows.length].tiles.length
	
	for i = 0 to row.tiles.length
		x = grid.rows[grid.rows.length].tiles[i].gridPosition.x
		y = grid.rows[grid.rows.length].tiles[grid.rows[grid.rows.length].tiles.length].gridPosition.y + 1
		
		tile = Tile_Create(Vector2D_CreateVector(x, y))
		row.tiles[i] = tile
	next i
	
	grid.rows.insert(row)
endfunction

function GridExpander_PushFrontColumn(grid ref as Grid)
	tile as Tile
	
	for i = 0 to grid.rows.length
		x = grid.rows[i].tiles[0].gridPosition.x - 1
		y = grid.rows[i].tiles[0].gridPosition.y
		
		tile = Tile_Create(Vector2D_CreateVector(x, y))
		grid.rows[i].tiles.insert(tile, 0)
	next i
endfunction

function GridExpander_PushBackColumn(grid ref as Grid)
	tile as Tile
	
	for i = 0 to grid.rows.length
		x = grid.rows[i].tiles[grid.rows[i].tiles.length].gridPosition.x + 1
		y = grid.rows[i].tiles[grid.rows[i].tiles.length].gridPosition.y
		
		tile = Tile_Create(Vector2D_CreateVector(x, y))
		grid.rows[i].tiles.insert(tile)
	next i
endfunction

/*

	-- GRID DATA FUNCTIONS

*/

function GridData_Create(gridId as integer)
	gridData as GridData
	GridData_Set(gridData, gridId)
endfunction gridData

function GridData_Set(gridData ref as GridData, gridId as integer)
	GridData.gridId = gridId
endfunction

/*

	-- ROW DATA FUNCTIONS

*/

function RowData_Create(rowId as integer)
	rowData as RowData
	RowData_Set(rowData, rowId)
endfunction rowData

function RowData_Set(rowData ref as RowData, rowId as integer)
	RowData.rowId = rowId
endfunction


/*

	-- TILE DATA FUNCTIONS

*/

function TileData_Create(tileId as integer, status as integer, distance as integer)
	tileData as TileData
	TileData_Set(tileData, tileId, status, distance)
endfunction tileData

function TileData_Set(tileData ref as TileData, tileId as integer, status as integer, distance as integer)
	TileData.tileId = tileId
	TileData.status = status
	TileData.distance = distance
endfunction

/*

	TEST_FUNCTIONS
	
*/

function Grid_TestUtility()	
	
	grid as Grid
	gridExpander as GridExpander
	
	grid = Grid_Create(8, Vector2D_CreateVector(0, 0))
	
	do
	    Print( ScreenFPS() )
	    
	    if(GetRawKeyPressed(32))
	    		inc gridExpander.eastOffset
	    		inc gridExpander.westOffset
	    		inc gridExpander.northOffset
	    		inc gridExpander.southOffset
	    		GridExpander_ExpandGrid(grid, gridExpander)
	    		Grid_Debug(grid)
	    endif
	    
	    Sync()
	loop
endfunction