
/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	main.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

#include "includes.agc"

/*

	CONSTANTS

*/

/*

	FUNCTIONS
	
*/

/*

	MAIN PROGRAM

*/

InitEngine()

/*

	TESTS --uncomment below to run tests.

*/
//Test_Camera_Utility()
//IDGenerator_TestUtility()
//Grid_TestUtility()
GridPathfinding_TestUtility()

do
    Print( ScreenFPS() )
    
    Sync()
loop
