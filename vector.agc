/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	vector.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	TYPES
	
*/

type Vector2D
	x as integer
	y as integer
endtype

/*

	FUNCTIONS
	
*/


function Vector2D_CreateVector(x as integer, y as integer)
	vector as Vector2D
	Vector2D_SetVector(vector, x, y)
endfunction vector

function Vector2D_SetVector(vector ref as Vector2D, x as integer, y as integer)
	vector.x = x
	vector.y = y
endfunction