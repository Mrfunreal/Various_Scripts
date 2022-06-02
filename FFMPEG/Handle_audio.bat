:: This FFMPEG script can rip the audio from a video, mute the audio in a video, and also separate audio and video into two separate files.
:: Just drag and drop a video onto this bat and pick your choices.

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
echo  1.  Keep only video.
echo  2.  Keep only audio
echo  3.  Separate audio and video.
echo.

set /p op=[91m[1/2/3]?: [92m 

if "%op%"=="3" GOTO av
if "%op%"=="2" GOTO a
if "%op%"=="1" GOTO v

:av
ffmpeg -i %1  -q:a 0 -map a "%~dpn1_AUDIO.mp3"
ffmpeg -i %1 -vcodec copy -an "%~dpn1_VIDEO.mp4"
goto exit
:a
ffmpeg -i %1  -q:a 0 -map a "%~dpn1_AUDIO.mp3"
goto exit
:v
ffmpeg -i %1 -vcodec copy -an "%~dpn1_VIDEO.mp4"
goto exit

:exit
@exit
