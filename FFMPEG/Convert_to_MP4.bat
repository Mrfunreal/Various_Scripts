@echo off
color 0a

if exist %1 goto start else goto error

:error
cls
echo.
echo ========================================================================================================
echo  [91m!!!!!!!![92m         This is a drag and drop process. Drag your media onto this bat file.          [91m!!!!!!!![92m
echo ========================================================================================================
echo.
echo Press any key to exit
pause>nul

:start
echo.
echo  1.  Video to MP4
echo  2.  Gif to MP4
echo.

set /p op=[91m[1/2]?: [92m 
echo.

if "%op%"=="2" GOTO gif
if "%op%"=="1" GOTO vid

:gif
ffmpeg -f gif -i %1  -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "%~dpn1.mp4" -y
goto exit
:vid
ffmpeg -i %1  %~dpn1.mp4
goto exit
:exit
@exit
