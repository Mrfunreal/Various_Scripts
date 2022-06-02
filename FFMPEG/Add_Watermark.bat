:: This bat file adds a watermark (or any overlay) to the entire video.
:: Just drag and drop a video onto this bat and pick your choices.

:: DEFINE THE WATERMARK IMAGES HERE
set watermark_2k=G:/Pictures/Modding/Watermark_2k.png
set watermark_4k=G:/Pictures/Modding/Watermark_4k.png

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
echo  1.  2K watermark
echo  2.  4K Watermark
echo.

set /p op=[91m[1/2]?: [92m 

if "%op%"=="2" GOTO 4k
if "%op%"=="1" GOTO 2k

:2k
ffmpeg.exe -i %1 -i "%watermark_2k%" -filter_complex "overlay=0:0" "%~dpn1_watermark.mp4"
goto exit

:4k
ffmpeg.exe -i %1 -i "%watermark_4k%" -filter_complex "overlay=0:0" "%~dpn1_watermark.mp4"
goto exit

:exit
exit
