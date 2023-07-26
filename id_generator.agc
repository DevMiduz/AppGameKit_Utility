/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	id_generator.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_Utility
*	devmiduz@gmail.com
*/

/*

	INCLUDES
	
*/

/*

	CONSTANTS

*/

#constant CONST_ID_GENERATOR_GENERIC_TYPE = 0
#constant CONST_ID_GENERATOR_SPRITE_TYPE = 1
#constant CONST_ID_GENERATOR_IMAGE_TYPE = 2
#constant CONST_ID_GENERATOR_EDIT_BOX_TYPE = 3
#constant CONST_ID_GENERATOR_PARTICLES_TYPE = 4
#constant CONST_ID_GENERATOR_TEXT_TYPE = 5
#constant CONST_ID_GENERATOR_FONT_TYPE = 6
#constant CONST_ID_GENERATOR_TWEEN_TYPE = 7
#constant CONST_ID_GENERATOR_SOUND_TYPE = 8
#constant CONST_ID_GENERATOR_MUSIC_TYPE = 9
#constant CONST_ID_GENERATOR_MUSIC_OGG_TYPE = 10
#constant CONST_ID_GENERATOR_VIRTUAL_BUTTON_TYPE = 11
#constant CONST_ID_GENERATOR_SOCKET_TYPE = 12

/*

	GLOBALS

*/

global GLOBAL_ID_GENERATOR as IDGenerator

/*

	TYPES
	
*/
type IDGenerator
	prevId as integer
	nextId as integer
	freeIds as integer[]
endtype

/*

	FUNCTIONS
	
*/

function IDGenerator_GenerateNewID(idGenerator ref as IDGenerator)
	if(idGenerator.freeIds.length <> -1)
		tempId = idGenerator.freeIds[idGenerator.freeIds.length]
		idGenerator.freeIds.remove()
		exitfunction tempId
	endif
	
	nextId = IDGenerator_GenerateNextID(idGenerator)
endfunction nextId

function IDGenerator_GenerateNextID(idGenerator ref as IDGenerator)
	inc idGenerator.nextId
endfunction idGenerator.nextId

function IDGenerator_FreeID(idGenerator ref as IDGenerator, id as integer)
	idGenerator.freeIds.insert(id)
endfunction

function IDGenerator_Reset(idGenerator ref as IDGenerator) 
 	newIdGenerator as IDGenerator
 	idGenerator = newIdGenerator
endfunction

function IDGenerator_GenerateSpriteID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetSpriteExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateImageID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetImageExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateEditBoxID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetEditBoxExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateParticlesID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetParticlesExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateTextID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetTextExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateFontID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetFontExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateTweenID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetTweenExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateSoundID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetSoundExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateMusicID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetMusicExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateMusicOggID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetMusicExistsOGG(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateVirtualButtonID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetVirtualButtonExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateSocketID(idGenerator ref as IDGenerator)
	tempId = IDGenerator_GenerateNewID(IDGenerator)
	
	while(GetSocketExists(tempId) = 1)
		IDGenerator_FreeID(IDGenerator, tempId)
		tempId = IDGenerator_GenerateNextID(idGenerator)
	endwhile
	
endfunction tempId

function IDGenerator_GenerateIDByType(idGenerator ref as IDGenerator, idType as integer)
	tempId as integer
	
	select(idType)
		case CONST_ID_GENERATOR_GENERIC_TYPE:
			tempId = IDGenerator_GenerateNewID(idGenerator)
		endcase
		case CONST_ID_GENERATOR_SPRITE_TYPE:
			tempId = IDGenerator_GenerateSpriteID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_IMAGE_TYPE:
			tempId = IDGenerator_GenerateImageID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_EDIT_BOX_TYPE:
			tempId = IDGenerator_GenerateEditBoxID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_PARTICLES_TYPE:
			tempId = IDGenerator_GenerateParticlesID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_TEXT_TYPE:
			tempId = IDGenerator_GenerateTextID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_FONT_TYPE:
			tempId = IDGenerator_GenerateFontID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_TWEEN_TYPE:
			tempId = IDGenerator_GenerateTweenID(IDGenerator)
		endcase	
		case CONST_ID_GENERATOR_SOUND_TYPE:
			tempId = IDGenerator_GenerateSoundID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_MUSIC_TYPE:
			tempId = IDGenerator_GenerateMusicID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_MUSIC_OGG_TYPE:
			tempId = IDGenerator_GenerateMusicOggID(IDGenerator)
		endcase
		case CONST_ID_GENERATOR_VIRTUAL_BUTTON_TYPE:
			tempId = IDGenerator_GenerateVirtualButtonID(IDGenerator)
		endcase		
		case CONST_ID_GENERATOR_SOCKET_TYPE:
			tempId = IDGenerator_GenerateSocketID(IDGenerator)
		endcase										
	endselect
endfunction tempId

/*

	TEST_FUNCTIONS
	
*/

function IDGenerator_TestUtility()
	blocksImage = LoadImage("blocks.png")
	CreateSprite(1, blocksImage)
	
	do
	    Print( ScreenFPS() )
	    
	    if(GetRawKeyPressed(32))
	    		newId = IDGenerator_GenerateIDByType(GLOBAL_ID_GENERATOR, CONST_ID_GENERATOR_SPRITE_TYPE)
	    endif
	    
	    Sync()
	loop
endfunction
