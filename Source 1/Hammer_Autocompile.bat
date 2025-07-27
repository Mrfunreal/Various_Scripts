@echo off
cls
::	This is an autocompiler bat file for source engine.
::	Instead of using hammer to compile one map at a time, you can compile multiple automatically while hammer isn't needed.
::	Save this .bat file anywhere you want, define the SET commands in VARIABLES, pick compile settings and run this file.
::---------------------------------------------------------------VARIABLES---------------------------------------------------------------
::	Where the game executable is.
SET	Game_path=D:\programme\steam\steamapps\common\left 4 dead 2

::	Where the Gameinfo.txt is. Gameinfo is read for custom mounted content. Lights.rad also needs to be here, if you have one.
::	Could define custom folder, but the game moves the bsp after compiling cubemaps/stringtables.
::	Using the base folder is less confusing, as it won't force stale maps to be loaded.
SET	Gameinfo_path=left4dead2

::	Where your VMF files are.
SET	VMF_Location=F:\Modding\L4D2_Mapping\TUMTaRA\!SOURCE
::	List of maps to compile, separated by space, no file ending. 
Set	MAPLIST=tumtara_empty
::	MAPLIST=c1m1_hotel c1m2_streets c1m3_mall c1m4_atrium

::-----------------------------------------------------------COMPILE SETTINGS------------------------------------------------------------
::	Set up your own presets, then comment out the ones you do not want. Change back and forth if needed.
::	Tip: In Notepad++, you can do Shift+Alt+LMB to select vertically and them move the :: around.
::	Add your own presets if you want. It's exactly Like hammer's Expert compile window, just without UI.

::	VBSP: https://developer.valvesoftware.com/wiki/VBSP
::	VVIS: https://developer.valvesoftware.com/wiki/VVIS
::	VRAD: https://developer.valvesoftware.com/wiki/VRAD	

	::HDR FINAL PRESET
	SET vbsp_setting=-threads 22
	SET vvis_setting=-threads 22
	SET vrad_Setting=-threads 22 -hdr -TextureShadows -staticproplighting -StaticPropPolys -final
	
	::HDR FAST PRESET
::	SET vbsp_setting=-threads 22
::	SET vvis_setting=-threads 22 -fast
::	SET vrad_Setting=-threads 22 -hdr -textureshadows -StaticPropLighting -StaticPropPolys	

	::DIRTY FAST PRESET
::	SET vbsp_setting=-threads 22 
::	SET vvis_setting=-threads 22 -fast
::	SET vrad_Setting=-threads 22 -fast

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::: !!! DO NOT EDIT ANYTHING BELOW HERE !!! ::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::	Get current time, before compiling all maps.
set "start_time=%TIME: =0%"

::	Compile steps looped as many times as needed.
for %%i in (%MAPLIST%) do (

::	Calls for the current time to see when compile began. QOL for long batch compiles, like an entire campaign.
	call :EchoCurrentTime "%%i"

	echo. [93m 
	echo -------------------------------------------------------------------------------------------
	echo VBSP for %%i 
	echo -------------------------------------------------------------------------------------------
	call :EchoTitleVbsp "%%i"
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Gameinfo_path%" "%VMF_Location%\%%i.vmf"
	
	echo. [95m 
	echo -------------------------------------------------------------------------------------------
	echo VVIS for %%i 
	echo -------------------------------------------------------------------------------------------
	call :EchoTitleVvis "%%i"
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Gameinfo_path%" "%VMF_Location%\%%i.vmf"
	
	echo. [96m
	echo -------------------------------------------------------------------------------------------
	echo VRAD for %%i 
	echo -------------------------------------------------------------------------------------------
	call :EchoTitleVrad "%%i"
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Gameinfo_path%" "%VMF_Location%\%%i.vmf"
	
	echo. [92m
	echo -------------------------------------------------------------------------------------------
	echo COPY for %%i 
	xcopy "%VMF_Location%\%%i.bsp" "%Game_path%\%Gameinfo_path%\maps" /y
	echo -------------------------------------------------------------------------------------------
	echo.
)

:: All of this is just to calculate the time to see how long the entire compile of all maps took.

:: Capture current time after all compiles are done.
set "end_time=%TIME: =0%"

:: Parse start time into hours, minutes, seconds, hundredths
for /F "tokens=1-4 delims=:." %%a in ("%start_time%") do (
    set /A "start_h=1%%a-100"
    set /A "start_m=1%%b-100"
    set /A "start_s=1%%c-100"
)

:: Parse end time into hours, minutes, seconds, hundredths
for /F "tokens=1-4 delims=:." %%a in ("%end_time%") do (
    set /A "end_h=1%%a-100"
    set /A "end_m=1%%b-100"
    set /A "end_s=1%%c-100"
)

:: Convert start and mid time to total seconds
set /A "start_total=start_h*3600 + start_m*60 + start_s"
set /A "end_total=end_h*3600 + end_m*60 + end_s"

:: Calculate elapsed seconds
set /A "elapsed=end_total - start_total"

:: Calculate hours, minutes, and seconds from elapsed total seconds
set /A hours=elapsed / 3600
set /A minutes=(elapsed %% 3600) / 60
set /A seconds=elapsed %% 60

:: Format to always show two digits (e.g., 01:05:09)
if %hours% LSS 10 set hours=0%hours%
if %minutes% LSS 10 set minutes=0%minutes%
if %seconds% LSS 10 set seconds=0%seconds%

:: Extract only HH:MM:SS from start_time and end_time
set "start_hms=%start_time:~0,8%"
set "end_hms=%end_time:~0,8%"

::Finished text
Title Autocompiler Finished
echo.[33m:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :                                  Autocompiler Finished                                  :
echo :                        Begin Time: %start_hms% ^| End Time: %end_hms%                        :
echo :                              Total elapsed time: %hours%:%minutes%:%seconds%                               :
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.[0m
goto end

:end
timeout /t 99999 >nul
goto end

:: Getting "Current time" for each map that begins compiling.
:EchoCurrentTime
Echo.
echo [31m###########################################################################################
echo Beginning Compile for %1. Current Time: %time:~-11,2%:%time:~-8,2%:%time:~-5,2%
echo ###########################################################################################[0m
exit /b

:EchoTitleVbsp
Title Compiling %1 - VBSP - Began %time:~-11,2%:%time:~-8,2%:%time:~-5,2%
exit /b
:EchoTitleVvis
Title Compiling %1 - VVIS - Began %time:~-11,2%:%time:~-8,2%:%time:~-5,2%
exit /b
:EchoTitleVrad
Title Compiling %1 - VRAD - Began %time:~-11,2%:%time:~-8,2%:%time:~-5,2%
exit /b

