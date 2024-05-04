::Simple bat script that copies whatever file you drop onto it to another server, then deletes it from where it came.

@echo off
set TO=FolderPathHere

XCOPY "%~1" "%TO%" /Y /S 
timeout 1 >nul
del "%~1"
exit
