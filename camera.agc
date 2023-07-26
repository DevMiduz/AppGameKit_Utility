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

	TYPES
	
*/

type Camera
	id as integer
	x as integer
	y as integer
	srcX as integer
	srcY as integer
	destX as integer
	destY as integer
	movePerc as float
	centered as integer
	speed as float
endtype

/*

	FUNCTIONS
	
*/

function Camera_Update(camera ref as Camera)
	camera.movePerc = camera.movePerc + camera.speed
	camera.x = Camera_Lerp(camera.x, camera.destX, camera.movePerc)
	camera.y = Camera_Lerp(camera.y, camera.destY, camera.movePerc)
	SetViewOffset(camera.x, camera.y)
endfunction

// Move
function Camera_Move(camera ref as Camera, x as integer, y as integer)
	camera.srcX = camera.x
	camera.srcY = camera.y
	camera.destX = camera.x + x
	camera.destY = camera.y + y
	camera.movePerc = 0.1
endfunction

// Speed

// Set
function Camera_SetPosition(camera ref as Camera, x as integer, y as integer)
	
endfunction

Function Camera_Lerp(src as float, dest as float, decimal as float)
	result as float
	
	if(decimal < 1.0)
    		result = src * ( 1 - decimal ) + dest * decimal
    	else
    		result = dest
    	endif
    	
EndFunction result