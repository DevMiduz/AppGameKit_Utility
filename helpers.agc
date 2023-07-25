/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	helper.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	TYPES
	
*/

/*

	FUNCTIONS
	
*/

/*
	EXAMPLE:
	For i = 0.0 To 1.0 Step 0.1
		
	    x_arr[count1] = Lerp(p1, p2, i)
	    y_arr[count1] = Lerp(p1, p2, i)
	     
	    Inc count1
	Next i#
*/

Function Lerp(p1 as float, p2 as float, i as float)
	result as float
    result = p1 * ( 1 - i ) + p2 * i
EndFunction result

/*
//https://forum.thegamecreators.com/thread/193427

//This will calculate how many points you need to make a line.
pointsneeded = sqrt( (posx1#-posx2#)^2 + (posy1#-posy2#)^2 )

//This will draw a line using one sprite.
posx1# = 20.0
posy1# = 20.0
posx2# = 80.0
posy2# = 80.0
 
global pensize = 2
global maxlines = 1
dim spritelines[ maxlines ]
spritelines[1] = createSprite ( 0 )
setSpriteSize ( spritelines[1] , pensize, pensize )
SetSpriteColor ( spritelines[1] , 255 , 255 , 255 , 255 )
SetSpritePosition( spritelines[1] , 1000 , 1000 )
setSpriteAngle ( spritelines[1] , 0 )
 
do
   // do line
   SetSpriteColor ( spritelines[1] , 128 , 128 ,128 , 255 )
   SetSpritePosition( spritelines[1] , posx1# , posy1# )
   dx = posx1#-posx2#
   dy = posy1#-posy2#
   di = sqrt( (dx)^2 + (dy)^2 ) // calc dist
   setSpriteSize ( spritelines[1] , pensize, di )
   SetSpriteOffset( spritelines[1] , 1 , 1 )
   sngAngle = aTanFull( dx , dy )
   setSpriteAngle ( spritelines[1] , sngAngle )
 Sync(  )
loop
*/