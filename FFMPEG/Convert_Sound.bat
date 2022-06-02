:: This FFMPEG script can convert audio to MP3 or WAV
:: Just drag and drop a video onto this bat and pick your choices.
@echo off
color 0a

if exist %1 goto start else goto error

:error
cls
echo.
echo =======================================================================================================
echo  [91m!!!!!!!![92m         This is a drag and drop process. Drag your Audio onto this bat file.          [91m!!!!!!!![92m
echo =======================================================================================================
echo.
echo Press any key to exit
pause>nul

:start
echo.
echo Warning, This trims the short silence at the beginning of a sound. 
echo Therefore, this should not be used for converting gun sounds in games.
echo  1.  To MP3
echo  2.  To WAV 
echo.

set /p op=[91m[1/2]? [92m 
if "%op%"=="2" GOTO WAV
if "%op%"=="1" GOTO MP3

:wav
ffmpeg -ss 00:00:00 -i "%1"  %~dpn1.wav
goto exit

:mp3
ffmpeg -ss 00:00:00 -i "%1"  %~dpn1.mp3
goto exit

:exit
@exit
