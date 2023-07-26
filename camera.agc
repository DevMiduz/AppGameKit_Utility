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
	
endfunction

Function Camera_Lerp(src as float, dest as float, decimal as float)
	result as float
	
	if(decimal < 1.0)
    		result = src * ( 1 - decimal ) + dest * decimal
    	else
    		result = dest
    	endif
    	
EndFunction result