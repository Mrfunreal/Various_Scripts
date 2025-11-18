# This python script batch generates QC files based on a prefab and DMX/SMD/OBJ names.
#-----------------------------------------------------------------------------------------------------------------------------
# Usage: 
# 1. Place this script into the folder where your QC's should be generated to.
# 2. Same folder as this script must have a "!PRE.qci", as well as a folder named "SMD"
#  - The SMD folder should have all the DMX/SMD/OBJ model files.
#  - The content of !PRE.qci is the prefab qc. All qc files generated will be exactly the same.
#  - Every occurance of SMD_NAME_HERE in the !PRE.qci will be swapped for whatever names the DMX/SMD/OBJ model files have.
#  - The $modelname line will be sanatized to only be lowercase, alphanumerical, and underscore (_) instead of spaces.
# 3. Run this script to get QC files that have the same name as the model files.
# 
#-----------------------------------------------------------------------------------------------------------------------------
# Random example .qci file where "SMD_NAME_HERE" is being replaced with the /dmx/smd/obj file names.
# 
# $pushd smd
#    $ModelName    "custom_models/SMD_NAME_HERE"
#    $Model        "model"       "SMD_NAME_HERE" //using " only because filenames might have spaces for some of you...
#    $Sequence     "model"       "SMD_NAME_HERE"
#    $include      shared.qci
# $popd
#-----------------------------------------------------------------------------------------------------------------------------

import os
import re

# Supported extensions in order of preference
preferred_order = ['.dmx', '.smd', '.obj']  # first match wins

parent_folder = os.path.dirname(os.path.abspath(__file__))
smd_folder = os.path.join(parent_folder, "SMD")
pre_qc_file = os.path.join(parent_folder, "!PRE.qci")

# Read template
with open(pre_qc_file, "r") as f:
    template_content = f.readlines()

# Build a dict to handle preferred file per basename
files_dict = {}

for file in os.listdir(smd_folder):
    ext = os.path.splitext(file)[1].lower()
    name = os.path.splitext(file)[0]
    if ext in preferred_order:
        # If this basename exists, check preference
        if name in files_dict:
            existing_ext = os.path.splitext(files_dict[name])[1].lower()
            if preferred_order.index(ext) < preferred_order.index(existing_ext):
                files_dict[name] = file  # prefer higher priority
        else:
            files_dict[name] = file

# Loop through the chosen files
for smd_name, chosen_file in files_dict.items():
    qc_filename = os.path.join(parent_folder, f"{smd_name}.qc")
    if os.path.exists(qc_filename):
        print(f"Skipping existing QC: {qc_filename}")
        continue

    new_lines = []
    for line in template_content:
        line = line.replace("SMD_NAME_HERE", smd_name)

        if "$ModelName" in line:
            parts = line.split("$ModelName", 1)
            prefix = parts[0] + "$ModelName "
            model_path = parts[1].strip()
            cleaned_path = re.sub(r"[^a-z0-9_/]", "", model_path.replace(" ", "_").lower())
            line = prefix + cleaned_path + "\n"

        new_lines.append(line)

    with open(qc_filename, "w") as qc_file:
        qc_file.writelines(new_lines)
    print(f"Created QC: {qc_filename}")
