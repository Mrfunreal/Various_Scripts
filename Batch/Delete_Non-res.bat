:: This bat file deletes all files except .res and .bat. Then it deletes all empty folders.
::You can edit the ".res .bat" part on line 6 to determine which filetype(s) to KEEP.

@echo off
::deleting all but .res and .bat
for /f "delims=" %%F in ('dir /b /a-d ^| findstr /vile ".res .bat"') do del "%%F"
::deleting all empty folders.
for /f "delims=|" %%a in ('dir/b/s/ad-s-l^|sort/r') do rd "%%a" 2>nul
