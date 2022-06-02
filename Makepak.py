#This Python script packs multi chunck VPK files four Source 1 Engine. 
#Usage:
# 1. Put this python script in the ROOT folder of your game (Or a Mods folder, if you're modding a game like L4D1 or Portal 2)
# 2. change the vpk_path to whatever your game uses.
# 3. Run this Python script. 
#  - It will read all folders defined in target_folders and look for all files defined in file_types.
#  - Once all files are found, i will create a multi chunk VPK file setup.
#  - Consecutive uses will delete all existing VPK files, because without doing so, the multi chunk system breaks because of stale files in the _000.vpk
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#What folders to look for, and pack into the pak01 vpk set.
target_folders = [ "materials", "models", "resource", "scripts", "media", "missions", "particles", "scripts", "maps", "expressions", "scenes" ]
#What files to look for, in the aforementioned folders.
file_types = [ "vmt", "vtf", "mdl", "phy", "vtx", "vvd", "ani", "pcf", "vcd", "txt", "res", "vfont", "cur", "dat" , "bik", "mov", "bsp", "nav", "lst", "lmp", "vfe", "nut", "nuc" ]
#which vpk.exe to use. do not use \! CHANGE THIS TO YOUR VPK.EXE LOCATION
vpk_path = "F:/Programme/SteamLibrary/steamapps/common/left 4 dead/bin/vpk.exe"
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#Script Begins Here. 
#Do not edit anything here except the "pak01" on the very last line.

#FIRST DELETES LEFTOVER VPK FILES
import os
directory = "."

files_in_directory = os.listdir(directory)
filtered_files = [file for file in files_in_directory if file.endswith(".vpk")]
for file in filtered_files:
	path_to_file = os.path.join(directory, file)
	os.remove(path_to_file)

#PACKING STUFF
import os,subprocess
from os.path import join
response_path = join(os.getcwd(),"vpk_list.txt")

out = open(response_path,'w')
len_cd = len(os.getcwd()) + 1

for user_folder in target_folders:
	for root, dirs, files in os.walk(join(os.getcwd(),user_folder)):
		for file in files:
			if len(file_types) and file.rsplit(".")[-1] in file_types:
				out.write(os.path.join(root[len_cd:].replace("/","\\"),file) + "\n")

out.close()

#the "pak01" here specifies the multi-chunk vpk names. Could be changed to "pak02" or "hl2_textures", or whatever
subprocess.call([vpk_path, "-M", "a", "pak01", "@" + response_path])
