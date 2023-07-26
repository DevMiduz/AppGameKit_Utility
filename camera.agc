/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	camera.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

/*

	TYPES
	
*/

type Camera
	id as integer
	x as integer
	y as integer
	centered as integer
endtype

/*

	FUNCTIONS
	
*/

function Camera_Create(x as integer, y as integer, centered as integer)
	camera as Camera
	Camera_CreateRef(camera, x, y, centered)
endfunction camera

function Camera_CreateRef(camera ref as Camera, x as integer, y as integer, centered as integer)
	camera.centered = centered
	Camera_SetPosition(camera, x, y)
endfunction

function Camera_Move(camera ref as Camera, x as integer, y as integer)
	camera.x = camera.x + x
	camera.y = camera.y + y
	Camera_Update(camera)
endfunction

function Camera_SetPosition(camera ref as Camera, x as integer, y as integer)
	camera.x = x
	camera.y = y
	Camera_Update(camera)
endfunction

function Camera_Update(camera ref as Camera)
	if(camera.centered = 1)
		setViewOffset( camera.x - (GetVirtualWidth() / 2), camera.y - (GetVirtualHeight() / 2) )
	else
		SetViewOffset(camera.x, camera.y)
	endif
endfunction

/*

	TEST_FUNCTIONS
	
*/
function Test_Camera_Utility()
	blocksImage = LoadImage("blocks.png")
	blocksSprite = CreateSprite(blocksImage)
	SetSpritePositionByOffset(blocksSprite, 0, 0)

	camera as Camera
	camera = Camera_Create(0, 0, 1)
	
	do
	    Print( ScreenFPS() )
	    
	    if(GetRawKeyState(37) = 1)
	    		Camera_Move(camera, -1, 0)
	    endif
	    
	    if(GetRawKeyState(38) = 1)
	    		Camera_Move(camera, 0, -1)
	    endif
	    
	    if(GetRawKeyState(39) = 1)
	    		Camera_Move(camera, 1, 0)
	    endif
	    
	    if(GetRawKeyState(40) = 1)
	    		Camera_Move(camera, 0, 1)
	    endif
	    
	    Sync()
	loop
endfunction
