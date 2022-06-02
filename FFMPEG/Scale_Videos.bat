: This FFMPEG script can scale video files.
: IT ASSUMES EVERY VIDEO FILE TO BE IN 3840x2160 RESOLUTION!
: IF YOU WANT TO MAKE THIS WORK FOR YOUR OWN SCREEN RESOLUTION YOU MUST MANUALLY CHANGE ALL SETTINGS!!
: Just drag and drop a video onto this bat and pick your choices.
: It first asks for Framerate you want, then asks for resolution.

@echo off
color 0a

if exist %1 goto start else goto error

:error
cls
echo.
echo =======================================================================================================
echo  [91m!!!!!!!![92m         This is a drag and drop process. Drag your Video onto this bat file.          [91m!!!!!!!![92m
echo =======================================================================================================
echo.
echo Press any key to exit
pause>nul

:start
echo.
echo  1.  60 FPS
echo  2.  30 FPS
echo.

set /p op=[91m[1/2]? [92m 
if "%op%"=="2" GOTO start_30
if "%op%"=="1" GOTO start_60


:start_30
echo.
echo  1.  75%% 2880:1620
echo  2.  50%% 1920:1080
echo  3.  25%% 960:540
echo.
set /p op=[91m[1/2/3]? [92m 
echo.

if "%op%"=="3" GOTO 25_30
if "%op%"=="2" GOTO 50_30
if "%op%"=="1" GOTO 75_30

:75_30
ffmpeg -i %1 -vf fps=30,scale=2880:1620 "%~dpn1_75_percent_30FPS.mp4"
goto exit
:50_30
ffmpeg -i %1 -vf fps=30,scale=1920:1080 "%~dpn1_50_percent_30FPS.mp4"
goto exit
:25_30
ffmpeg -i %1 -vf fps=30,scale=960:540 "%~dpn1_25_percent_30FPS.mp4"
goto exit

:start_60
echo.
echo  1.  75%% 2880:1620
echo  2.  50%% 1920:1080
echo  3.  25%% 960:540
echo.
set /p op=[91m[1/2/3]? [92m 
echo.

if "%op%"=="3" GOTO 25_60
if "%op%"=="2" GOTO 50_60
if "%op%"=="1" GOTO 75_60

:75_60
ffmpeg -i %1 -vf scale=2880:1620 "%~dpn1_75_percent.mp4"
goto exit
:50_60
ffmpeg -i %1 -vf scale=1920:1080 "%~dpn1_50_percent.mp4"
goto exit
:25_60
ffmpeg -i %1 -vf scale=960:540 "%~dpn1_25_percent.mp4"
goto exit

:exit
@exit
