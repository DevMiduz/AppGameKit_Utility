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
	movePerc as float
	centered as integer
	speed as float
endtype

/*

	FUNCTIONS
	
*/

// Move
function Camera_Move(camera ref as Camera, x as integer, y as integer)
	camera.x = camera.x + x
	camera.y = camera.y + y
	
	if(camera.centered = 1)
		setViewOffset( camera.x - (GetVirtualWidth() / 2), camera.y - (GetVirtualHeight() / 2) )
	else
		SetViewOffset(camera.x, camera.y)
	endif
endfunction

// Speed

// Set
function Camera_SetPosition(camera ref as Camera, x as integer, y as integer)
	camera.x = x
	camera.y = y
endfunction

function Camera_Lerp(src as float, dest as float, decimal as float)
	result as float
	
	if(decimal < 1.0)
    		result = src * ( 1 - decimal ) + dest * decimal
    	else
    		result = dest
    	endif
    	
EndFunction result

/*

	TEST_FUNCTIONS
	
*/
function Test_Camera_Utility()
	blocksImage = LoadImage("blocks.png")
	blocksSprite = CreateSprite(blocksImage)
	SetSpritePositionByOffset(blocksSprite, 0, 0)

	camera as Camera
	camera.centered = 1
	camera.speed = 0.01
	Camera_Move(camera, 0, 0)
	
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
