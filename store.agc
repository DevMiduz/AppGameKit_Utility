/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	store.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	TYPES
	
*/

type Store
	example as Example
endtype

type Example
	changed as integer
endtype

/*

	FUNCTIONS
	
*/

global store as Store

function Store_Example_Changed(example ref as Example, changed as integer)
	example.changed = changed
endfunction