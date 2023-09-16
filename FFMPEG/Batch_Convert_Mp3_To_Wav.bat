:: This FFMPEG script can convert audio from MP3 or WAV
:: Drop this .bat into a folder full of MP3 files, double click it, an dwait to for it to finish.
:: It will delete all MP3 files when it's done.

for %%i in (*.mp3) do ffmpeg  -i "%%i" -ar 44100 "%%~ni.wav"
del  *.mp3
