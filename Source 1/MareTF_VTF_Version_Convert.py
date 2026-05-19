#=========================================================================================================================================
#	This Python script makes use of MareTF to change VTF Version of many files at once.
#	Dedicated unitaskers like "VtfVer" and "Easy-VTF-Converter" exist. So why use MareTF? 
#	Because MareTF is a Multitasker that does a whole lot more than just version changes. 
#	Besides, "VtfVer" prints endless errors unless you remember to tick a box every time, and "Easy-VTF-Converter" only works on Win10.
#=========================================================================================================================================

#	Location of MareTF.exe (https://github.com/craftablescience/MareTF)
MARETF_EXE = r"F:\Programme\MareTf\maretf.exe"

#	VTF Version to change to. Affects ALL textures in the dragged folder.
VTF_VERSION = "7.4"

#=========================================================================================================================================
#	Learn more about the differnces between version: https://developer.valvesoftware.com/wiki/VTF_(Valve_Texture_Format)#Versions
#	Do not change anything below here!
#=========================================================================================================================================

import os
import subprocess

def process_vtf(file_path):
    cmd = [
        MARETF_EXE,
        "edit",
        file_path,
        "-o",
        file_path,
        "--set-version",
        VTF_VERSION,
        "--remove-kvd-resource",
        "--no-pretty-formatting",
        "-y",
        "--verbose"
    ]
    subprocess.run(cmd)

def main():
    print("\n\033[96m======================================================================================================================")
    print(f"Drop a folder here (or paste a folder path) to convert \033[91mall\033[96m VTF files to version \033[93m{VTF_VERSION}\033[96m.")
    print("Subfolders will be processed automatically.")
    print("Change 'VTF_VERSION' in this script to select a different target version.")
    print("======================================================================================================================\n")
    folder = input("> \033[0m").strip('"')

    if not os.path.isdir(folder):
        print("\n\033[91m======================================================================================================================")
        print("Invalid entry. Use a folder next time.")
        print("Press Enter to exit...")
        input("======================================================================================================================")
        return

    for root, _, files in os.walk(folder):
        for f in files:
            if f.lower().endswith(".vtf"):
                process_vtf(os.path.join(root, f))

    print("\n\033[96mDone")
    input("Press Enter to exit...")

if __name__ == "__main__":
    main()
