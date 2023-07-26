
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

blocksImage = LoadImage("blocks.png")
blocksSprite = CreateSprite(blocksImage)
SetSpritePosition(blocksSprite, 64, 64)

camera as Camera
camera.speed = 0.1

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
    
    Camera_Update(camera)
    
    Sync()
loop
