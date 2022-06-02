   ::This bat file extracts cubemap files from Source 1 Engine BSP map files.
   
   @echo off
    ::Base settings of where the game and its bin folder is
    SET Binpath=D:\programme\steam\steamapps\common\left 4 dead 2\bin
    SET gameinfopath=D:\programme\steam\steamapps\common\left 4 dead 2\left4dead2
    
    ::BSP file names. Used for both "deletecubemaps" and "extractcubemaps". 
    ::Assuming you added cubemaps, compiled the map just for the cubemaps and now want to transfer them from the "cubemap only" map into your "Final" compile map.
    ::Uncomment the additional listings if you want to work on multiple files at once.
    SET bspname1=mapname1_witout_extension
::  SET bspname2=mapname2_witout_extension
::  SET bspname3=mapname3_witout_extension
::  SET bspname4=mapname4_witout_extension
::  SET bspname5=mapname5_witout_extension
 
    ::BSP file location of which the cubemaps should be DELETED (Deletes all embedded VTF files!!!).
    SET bsp_location_todelete=D:\Programme\Steam\steamapps\common\Left 4 Dead 2\!!CUSTOM_CONTENT\Hardly_Rain\maps
    ::BSP file location of which the cubemaps should be EXTRACTED FROM.
    SET bsp_location_toextract=D:\programme\steam\steamapps\common\left 4 dead 2\left4dead2\maps
    ::pick where the cubemaps get extracted. Creates a foldername called "MAPNAME_cubemaps" in the picked folder.
    SET Cubemap_ectract_location=D:\programme\steam\steamapps\common\left 4 dead 2\!!CUSTOM_CONTENT\Hardly_Rain\maps
 
    ::Deletes cubemaps from all the BSP files listed in "bsp_location_todelete"
    "%Binpath%\bspzip.exe" -deletecubemaps "%bsp_location_todelete%\%bspname1%.bsp"  -game "%gameinfopath%" 
::  "%Binpath%\bspzip.exe" -deletecubemaps "%bsp_location_todelete%\%bspname2%.bsp"  -game "%gameinfopath%" 
::  "%Binpath%\bspzip.exe" -deletecubemaps "%bsp_location_todelete%\%bspname3%.bsp"  -game "%gameinfopath%" 
::  "%Binpath%\bspzip.exe" -deletecubemaps "%bsp_location_todelete%\%bspname4%.bsp"  -game "%gameinfopath%" 
::  "%Binpath%\bspzip.exe" -deletecubemaps "%bsp_location_todelete%\%bspname5%.bsp"  -game "%gameinfopath%" 
 
    ::Extracts cubemaps from all the BSP files listed in "bsp_location_toextract", and puts them into the folder specified in "Cubemap_ectract_location"
    "%Binpath%\bspzip.exe" -extractcubemaps  "%bsp_location_toextract%\%bspname1%.bsp"  "%Cubemap_ectract_location%\%bspname1%_cubemaps"
::  "%Binpath%\bspzip.exe" -extractcubemaps  "%bsp_location_toextract%\%bspname2%.bsp"  "%Cubemap_ectract_location%\%bspname2%_cubemaps"
::  "%Binpath%\bspzip.exe" -extractcubemaps  "%bsp_location_toextract%\%bspname3%.bsp"  "%Cubemap_ectract_location%\%bspname3%_cubemaps"
::  "%Binpath%\bspzip.exe" -extractcubemaps  "%bsp_location_toextract%\%bspname4%.bsp"  "%Cubemap_ectract_location%\%bspname4%_cubemaps"
::  "%Binpath%\bspzip.exe" -extractcubemaps  "%bsp_location_toextract%\%bspname5%.bsp"  "%Cubemap_ectract_location%\%bspname5%_cubemaps"
 
    
    echo.
    echo.
    echo.
    echo Cubemaps extracted to %Cubemap_ectract_location%
    echo.
    echo You can use VIDE to import cubemaps to another map.
    echo Use the PACKFILE LUMP EDITOR tool to load a map which had its cubemaps deleted,
    echo press the ADD button and select all cubemap vtf files you just extracted.
    echo When it pompts you to pick a folder; CANCEL.
    echo A new window appears, asking you for a new relative path
    echo delete everything BEFORE the last "materials"
    echo you should only have "materials\maps\%bspname1%" (or any other mapname) in that text window
    echo Press OKAY and save the map.
    echo.
    
pause
