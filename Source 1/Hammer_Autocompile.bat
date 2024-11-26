@echo off
cls
::	Autocompile bat file to batch compile multiple files.
::	SET the Game_path and Game_subfolder_name. Maps will compile into the Game_subfolder_name's "Maps" subfolder.
::	This bat file pauses when its done, so the CMD window can be used to read errors.
::	New map compiles start with a red box. VSBP is Yellow, VVIS is Purple, VRAD is Cyan, xcopy is Green. To easily see what step you're on.

:: TIP: Personally, I saved this .bat in a mapping folder where all my projects are, with a shortcut on the desktop.
::		I right click the shortcut to edit this file for my next project to compile multiple maps while i sleep or do chores.

	::Where the game executable is.
	SET Game_path=D:\programme\steam\steamapps\common\left 4 dead 2
	
	::Which subfolder of the above mentioned folder the maps will go to. Default is "left4dead2"
	::WARNING: THIS FOLDER REQUIRES A GAMEINFO! THIS GAMEINFO WILL ALSO NEED TO POINT TO CUSTOM CONTENT!!!
	::WARNING: MAKE SURE THIS STRING DOES NOT END WITH A SPACE!
	SET Game_subfolder_name=left4dead2
	
	::VMF Location and name, without extension. Add more maps or locations if you want, modify this file accordingly
	::Once a VMF is compiled, it will do the next listed VMF. If no VMF's are listed, the compile will end.
	SET VMF_Location=F:\Modding\L4D1_Mapping\the last stand
	SET VMF1_Name=c14m1_junkyard_l4d
	SET VMF2_name=
	SET VMF3_name=
	SET VMF4_name=
	SET VMF5_name=
	SET VMF6_name=
	SET VMF7_name=
	SET VMF8_name=
	SET VMF9_name=
	SET VMF10_name=
	
:: COMPILE SETTINGS. Work with comments to define which settings you would like to use.
:: Currently uses "Hdr Fast preset" as it is not commented out.
:: VBSP options https://developer.valvesoftware.com/wiki/VBSP
:: VVIS options https://developer.valvesoftware.com/wiki/VVIS
:: VRAD options https://developer.valvesoftware.com/wiki/VRAD	

	::HDR FINAL PRESET
::	SET vbsp_setting=-threads 22
::	SET vvis_setting=-threads 22
::	SET vrad_Setting=-threads 22 -hdr -TextureShadows -staticproplighting -StaticPropPolys -final
	
	::HDR FAST PRESET
	SET vbsp_setting=-threads 22
	SET vvis_setting=-threads 22 -fast
	SET vrad_Setting=-threads 22 -hdr -textureshadows -StaticPropLighting -StaticPropPolys	

	::DIRTY FAST PRESET
::	SET vbsp_setting=-threads 22 
::	SET vvis_setting=-threads 22 -fast
::	SET vrad_Setting=-threads 22 -fast

:: DO NOT EDIT ANYTHING BELOW HERE

	echo [101;93m Now compiling %VMF1_Name%[0m
	echo [93m VBSP for %VMF1_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF1_Name%.vmf"
	echo [95m VVIS for %VMF1_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF1_Name%.vmf"
	echo [96m VRAD for %VMF1_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF1_Name%.vmf"
	echo [92m COPY for %VMF1_Name% 
	xcopy "%VMF_Location%\%VMF1_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF2_name (goto map2) ELSE (goto Donezo)

	:Map2
	echo [101;93m Now compiling %VMF2_Name%[0m
	echo [93m VBSP for %VMF2_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF2_Name%.vmf"
	echo [95m VVIS for %VMF2_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF2_Name%.vmf"
	echo [96m VRAD for %VMF2_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF2_Name%.vmf"
	echo [92m COPY for %VMF2_Name% 
	xcopy "%VMF_Location%\%VMF2_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF3_name (goto map3) ELSE (goto Donezo)

	:Map3
	echo [101;93m Now compiling %VMF3_Name%[0m
	echo [93m VBSP for %VMF3_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF3_Name%.vmf"
	echo [95m VVIS for %VMF3_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF3_Name%.vmf"
	echo [96m VRAD for %VMF3_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF3_Name%.vmf"
	echo [92m COPY for %VMF3_Name% 
	xcopy "%VMF_Location%\%VMF3_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF4_name (goto map4) ELSE (goto Donezo)

	:Map4
	echo [101;93m Now compiling %VMF4_Name%[0m
	echo [93m VBSP for %VMF4_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF4_Name%.vmf"
	echo [95m VVIS for %VMF4_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF4_Name%.vmf"
	echo [96m VRAD for %VMF4_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF4_Name%.vmf"
	echo [92m COPY for %VMF4_Name% 
	xcopy "%VMF_Location%\%VMF4_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF5_name (goto map5) ELSE (goto Donezo)

	:Map5
	echo [101;93m Now compiling %VMF5_Name%[0m
	echo [93m VBSP for %VMF5_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF5_Name%.vmf"
	echo [95m VVIS for %VMF5_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF5_Name%.vmf"
	echo [96m VRAD for %VMF5_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF5_Name%.vmf"
	echo [92m COPY for %VMF5_Name% 
	xcopy "%VMF_Location%\%VMF5_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF6_name (goto map6) ELSE (goto Donezo)

	:Map6
	echo [101;93m Now compiling %VMF6_Name%[0m
	echo [93m VBSP for %VMF6_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF6_Name%.vmf"
	echo [95m VVIS for %VMF6_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF6_Name%.vmf"
	echo [96m VRAD for %VMF6_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF6_Name%.vmf"
	echo [92m COPY for %VMF6_Name% 
	xcopy "%VMF_Location%\%VMF6_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF7_name (goto map7) ELSE (goto Donezo)
	
	:Map7
	echo [101;93m Now compiling %VMF7_Name%[0m
	echo [93m VBSP for %VMF7_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF7_Name%.vmf"
	echo [95m VVIS for %VMF7_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF7_Name%.vmf"
	echo [96m VRAD for %VMF7_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF7_Name%.vmf"
	echo [92m COPY for %VMF7_Name% 
	xcopy "%VMF_Location%\%VMF7_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF8_name (goto map8) ELSE (goto Donezo)

	:Map8
	echo [101;93m Now compiling %VMF8_Name%[0m
	echo [93m VBSP for %VMF8_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF8_Name%.vmf"
	echo [95m VVIS for %VMF8_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF8_Name%.vmf"
	echo [96m VRAD for %VMF8_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF8_Name%.vmf"
	echo [92m COPY for %VMF8_Name% 
	xcopy "%VMF_Location%\%VMF8_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF9_name (goto map9) ELSE (goto Donezo)

	:Map9
	echo [101;93m Now compiling %VMF9_Name%[0m
	echo [93m VBSP for %VMF9_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF9_Name%.vmf"
	echo [95m VVIS for %VMF9_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF9_Name%.vmf"
	echo [96m VRAD for %VMF9_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF9_Name%.vmf"
	echo [92m COPY for %VMF9_Name% 
	xcopy "%VMF_Location%\%VMF9_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	IF DEFINED VMF10_name (goto map10) ELSE (goto Donezo)

	:Map10
	echo [101;93m Now compiling %VMF10_Name%[0m
	echo [93m VBSP for %VMF10_Name% 
	"%Game_path%\bin\vbsp.exe" %vbsp_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF10_Name%.vmf"
	echo [95m VVIS for %VMF10_Name% 
	"%Game_path%\bin\vvis.exe" %vvis_setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF10_Name%.vmf"
	echo [96m VRAD for %VMF10_Name% 
	"%Game_path%\bin\vrad.exe" %vrad_Setting% -game "%Game_path%\%Game_subfolder_name%" "%VMF_Location%\%VMF10_Name%.vmf"
	echo [92m COPY for %VMF10_Name% 
	xcopy "%VMF_Location%\%VMF10_Name%.bsp" "%Game_path%\%Game_subfolder_name%\maps" /y
	goto Donezo

:Donezo
::	Makes CMD stay open even if you press a key.
	echo.
	echo [93m///////////////////////////////////////////////////////////////////////////////
	echo ---------------------------------- All done! ----------------------------------
	echo ///////////////////////////////////////////////////////////////////////////////[0m
	echo.

	cmd /k
