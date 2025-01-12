@echo off
:: This file creates a text file listing everything inside a vpk (including muli-chunk like pak01_dir.vpk) by dragging a vpk file onto it.
:: Create a .bat file literally anywhere on your pc with all of this text as content.
:: Then set the Bin folder direction of your game below.
Set Gamedir=F:\Programme\SteamLibrary\steamapps\common\Half-Life 2\bin

:: Once that GameDir is set, drag and drop any vpk file onto it to get a text file of the same name, with a "_Content" suffix next to the vpk file you used.

:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	DO NOT CHANGE ANYTHING BELOW!
::	Extract the file name without path or extension.
for %%F in (%1) do set OutputFile=%%~nF_Content.txt

::	Redirect output to the dynamically named log file.
"%Gamedir%\vpk.exe" l %1 > "%OutputFile%"
type "%OutputFile%"
