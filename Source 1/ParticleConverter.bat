::This file is used to convert particles from new games to old games.
::Required for porting csgo or portal2 particles to hl2 or l4d2.
::Set the location of your game your'e porting from (dmxconv_new) and then Hl2 (dmxconv_old) to make sure any game can load the particle.
:: if you don't have hl2, just use the game you are porting to. 


@echo off

::Game locations that have the DMXconvert you want to use. Just main game folder.
SET dmxconv_new=F:\Programme\SteamLibrary\steamapps\common\Counter-Strike Global Offensive
SET dmxconv_old=F:\Programme\SteamLibrary\steamapps\common\Half-Life 2

if exist %1 goto start else goto error
:error
echo Porting Particles from new games to old games (Csgo to Hl2) requires you to convert the pcf type.
echo In this specific case "Binary 5 PCF 2" to "Binary 2 PCF 1"
echo.
echo You must use the new game's DMXConvert to turn the particle to raw text file. (DMX/PCF Keyvalues2)
echo Once that is done, the old game's DMXConvert turns that raw text into the desired Binary and PCF version.
echo.
echo [91mBefore you can convert anything:[0m
echo open this bat file in a notepad and set the "dmxconv_new" and "dmxconv_old" values.
echo.
echo Simply drag and drop your particle onto this bat file. It will convert to Keyvalues 2, wait five seconds and then convert to Binary 2 PCF 1
echo [91m it will close automatically.[95m
pause>nul

::Don't change anything below here
:start
"%dmxconv_new%\bin\dmxconvert.exe"	-i %1 -of pcf -oe keyvalues2 
timeout 5
"%dmxconv_old%\bin\dmxconvert.exe"	-i %1 -of pcf -oe binary 
