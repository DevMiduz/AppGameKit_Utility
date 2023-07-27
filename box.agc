/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	box.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

#include "vector.agc"

/*

	TYPES
	
*/

type Box
	position as Vector2D // top-left
	size as integer
endtype

/*

	FUNCTIONS
	
*/

function Box_Create(x as integer, y as integer, size as integer)
	box as Box
	Box_Set(box, x, y, size)
endfunction box

function Box_Set(box ref as Box, x as integer, y as integer, size as integer)
	box.position.x = x
	box.position.y = y
	box.size = size
endfunction