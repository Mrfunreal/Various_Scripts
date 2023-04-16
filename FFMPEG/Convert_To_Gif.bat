:: This is used to convert videos to gif files.
:: Either trim the video time or convert to gif.
:: Pick Fps
:: Then pick what resolution.

@echo off
color 0a

if exist %1 goto start else goto error

:error
cls
echo.
echo =======================================================================================================
echo  [91m!!!!!!!![92m         This is a drag and drop process. Drag your MP4 onto this bat file.          [91m!!!!!!!![92m
echo =======================================================================================================
echo.
echo Press any key to exit
pause>nul

:start
echo.
echo  1.  Just convert to gif.
echo  2.  Trim and then convert to gif.
echo.

set /p op=[91m[1/2]? [92m 

if "%op%"=="2" GOTO convert_trim
if "%op%"=="1" GOTO convert

::-----------------------------------------------------------------------------------------------------------------------------------------------------
:convert
set /p FPS=[91mFPS= [92m 
echo.
echo  1.  75%% 2880:1620
echo  2.  50%% 1920:1080
echo  3.  25%% 960:540
echo  4.  10%% 384:216
echo.
set /p op=[91m[1/2/3/4]? [92m 
echo.

if "%op%"=="4" GOTO 10_notrim
if "%op%"=="3" GOTO 25_notrim
if "%op%"=="2" GOTO 50_notrim
if "%op%"=="1" GOTO 75_notrim

:10_notrim
ffmpeg -i %1 -vf "fps=%FPS%,scale=384:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_384.gif"
goto exit
:25_notrim
ffmpeg -i %1 -vf "fps=%FPS%,scale=960:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_960.gif"
goto exit
:50_notrim
ffmpeg -i %1 -vf "fps=%FPS%,scale=1920:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_1920.gif"
goto exit
:75_notrim
ffmpeg -i %1 -vf "fps=%FPS%,scale=2880:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_2880.gif"
goto exit
::-----------------------------------------------------------------------------------------------------------------------------------------------------

:convert_trim
echo.
set /p trimstart=[91mTrim Start Time HH:MM:SS=[92m	
set /p trimend=[91mTrim End Time HH:MM:SS=[92m		
echo.
set /p FPS=[91mFPS= [92m
echo.
echo  1.  75%% 2880:1620
echo  2.  50%% 1920:1080
echo  3.  25%% 960:540
echo  4.  10%% 384:216
echo.
set /p op=[91m[1/2/3/4]? [92m 
echo.

if "%op%"=="4" GOTO 10_trim
if "%op%"=="3" GOTO 25_trim
if "%op%"=="2" GOTO 50_trim
if "%op%"=="1" GOTO 75_trim

:10_trim
ffmpeg -i %1 -ss %trimstart% -to %trimend% -vf "fps=%FPS%,scale=384:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_384_Trimmed.gif"
goto exit
:25_trim
ffmpeg -i %1 -ss %trimstart% -to %trimend% -vf "fps=%FPS%,scale=960:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_960_Trimmed.gif"
goto exit
:50_trim
ffmpeg -i %1 -ss %trimstart% -to %trimend% -vf "fps=%FPS%,scale=1920:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_1920_Trimmed.gif"
goto exit
:75_trim
ffmpeg -i %1 -ss %trimstart% -to %trimend% -vf "fps=%FPS%,scale=2880:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%~dpn1_%FPS%-FPS_2880_Trimmed.gif"
goto exit

:exit
@exit
