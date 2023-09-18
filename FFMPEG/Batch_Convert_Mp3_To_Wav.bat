:: This FFMPEG script Batch converts MP3 to Wav.
:: Drop this .bat into a folder full of MP3 files, double click it, and wait to for it to finish.
:: It will delete all MP3 files when it's done.
:: It will remain open with a printed list of all files inside the folder. Should you want to copy the list of names for something.

for %%i in (*.mp3) do ffmpeg  -i "%%i" -ar 44100 "%%~ni.wav"
del  *.mp3
dir /s /b /o:gn
pause
