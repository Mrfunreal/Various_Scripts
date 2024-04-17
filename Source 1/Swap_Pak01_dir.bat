::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	This bat file swaps the pak01_dir.vpk files from the original to a modified one.													::
::	For example when you modified all .res files in the vpk to be a "rez". You can't play online unless you use default pak01_dir.vpk.	::
::																																		::
::	Usage: Make a copy of ALL default pak01_dir.vpk files and rename them to "pak01_dir.vpk.Bak" Just adding a .bak.					::
::	Do whatever modifications you want to the one you haven't renamed yet.																::
::																																		::
::	Set the "Gamepath" on line 13 to where your Left4dead2.exe is located																::
::	Running this wile will check whether vpk.custom or vpk.bak is exists .																::
::	If Vpk.Custom exists, it means the default packs are used. So it'll swap to using the custom ones.									::
::	If Vpk.Bak exists, You're currently using the custom ones, so it'll swich back to default.											::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 SET Gamepath=D:\Programme\Steam\steamapps\common\Left 4 Dead 2
 
cls
@echo off
:start
if exist "%Gamepath%\left4dead2\pak01_dir.vpk.custom"	Goto LoadEdit 
if exist "%Gamepath%\left4dead2\pak01_dir.vpk.bak"		Goto LoadOrig

:LoadOrig 
echo Loading Default Pak01_dir.vpk...
::Rename the MODIFIED pack to vpk.custom, to let us know they're modded.
ren  "%Gamepath%\left4dead2\pak01_dir.vpk"				pak01_dir.vpk.custom
ren  "%Gamepath%\left4dead2_dlc1\pak01_dir.vpk"			pak01_dir.vpk.custom
ren  "%Gamepath%\left4dead2_dlc2\pak01_dir.vpk"    		pak01_dir.vpk.custom
ren  "%Gamepath%\left4dead2_dlc3\pak01_dir.vpk"    		pak01_dir.vpk.custom
ren  "%Gamepath%\update\pak01_dir.vpk"             		pak01_dir.vpk.custom
timeout /t 1 /nobreak >nul
::Renaming the ORIGINAL from vpk.bak to vpk.	
ren  "%Gamepath%\left4dead2\pak01_dir.vpk.bak"			pak01_dir.vpk
ren  "%Gamepath%\left4dead2_dlc1\pak01_dir.vpk.bak"		pak01_dir.vpk
ren  "%Gamepath%\left4dead2_dlc2\pak01_dir.vpk.bak" 	pak01_dir.vpk
ren  "%Gamepath%\left4dead2_dlc3\pak01_dir.vpk.bak" 	pak01_dir.vpk
ren  "%Gamepath%\update\pak01_dir.vpk.bak"          	pak01_dir.vpk
echo [32mDefault Pak01_dir.vpk loaded
timeout /t 2 /nobreak >nul
goto end

:LoadEdit
echo Loading Modified Pak01_dir.vpk...
::Renames the ORIGINAL to backup
ren  "%Gamepath%\left4dead2\pak01_dir.vpk"				pak01_dir.vpk.Bak
ren  "%Gamepath%\left4dead2_dlc1\pak01_dir.vpk"			pak01_dir.vpk.Bak
ren  "%Gamepath%\left4dead2_dlc2\pak01_dir.vpk"    		pak01_dir.vpk.Bak
ren  "%Gamepath%\left4dead2_dlc3\pak01_dir.vpk"    		pak01_dir.vpk.Bak
ren  "%Gamepath%\update\pak01_dir.vpk"             		pak01_dir.vpk.Bak
timeout /t 1 /nobreak >nul
::Renames the MODIFIED from unreadable, to readable
ren  "%Gamepath%\left4dead2\pak01_dir.vpk.custom"		pak01_dir.vpk
ren  "%Gamepath%\left4dead2_dlc1\pak01_dir.vpk.custom" 	pak01_dir.vpk
ren  "%Gamepath%\left4dead2_dlc2\pak01_dir.vpk.custom" 	pak01_dir.vpk
ren  "%Gamepath%\left4dead2_dlc3\pak01_dir.vpk.custom" 	pak01_dir.vpk
ren  "%Gamepath%\update\pak01_dir.vpk.custom"          	pak01_dir.vpk
echo [33mModified Pak01_dir.vpk loaded
timeout /t 2 /nobreak >nul
goto end

:error
echo Sum Ting Wong
echo Wi Tu Lo
echo Ho Lee Fuk
echo Bang Ding Ow

:end
