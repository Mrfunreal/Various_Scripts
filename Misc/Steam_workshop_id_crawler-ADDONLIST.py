# This python script lets you check the names of all addons in your addonlist.
# Change the ADDONLIST_PATH on line 13 to your own directory
# This is only needed for debugging mods, getting a list of all mods you have and checkign one after another

import requests
from bs4 import BeautifulSoup
import os
import platform
import subprocess
import re

# === SETTINGS === CHANGE THE FOLDERPATH TO YOUR L4D2 FOLDER!!!!!
ADDONLIST_PATH = r"D:\Programme\Steam\steamapps\common\Left 4 Dead 2\left4dead2\addonlist.txt"
WRITE_TO_FILE = True
OUTPUT_FILE = "!!_WorkshopModnames.txt"
OPEN_AFTER_CREATE = True

base_url = "https://steamcommunity.com/sharedfiles/filedetails/?id="

def get_mod_title(mod_id):
    url = base_url + mod_id
    try:
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        title_tag = soup.find(class_="workshopItemTitle")
        if title_tag:
            return title_tag.text.strip()
        else:
            return "Title Not Found"
    except Exception as e:
        return f"Error: {e}"

def parse_addonlist(path):
    entries = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("//"):
                continue
            match = re.search(r'workshop\\(\d+)\.vpk', line, re.IGNORECASE)
            if match:
                entries.append(("workshop", match.group(1)))
            else:
                match_local = re.search(r'"([^"]+\.vpk)"', line)
                if match_local:
                    entries.append(("local", match_local.group(1)))
    return entries

entries = parse_addonlist(ADDONLIST_PATH)

results = []
for entry_type, value in entries:
    if entry_type == "workshop":
        title = get_mod_title(value)
        line = f"(Workshop)\t{title}\t[{value}]"
    else:
        line = f"(Local)\t\t{value}"
    results.append(line)
    print(line)

if WRITE_TO_FILE:
    with open(OUTPUT_FILE, "w", encoding="utf-8") as file:
        for line in results:
            file.write(line + "\n")
    print(f"\nResults saved to {OUTPUT_FILE}.")

    def open_file(filepath):
        try:
            if platform.system() == 'Windows':
                os.startfile(filepath)
            elif platform.system() == 'Darwin':
                subprocess.call(['open', filepath])
            else:
                subprocess.call(['xdg-open', filepath])
        except Exception as e:
            print(f"Could not open file automatically: {e}")

    if OPEN_AFTER_CREATE:
        open_file(OUTPUT_FILE)
        exit()
else:
    print("\nWRITE_TO_FILE is set to False. No file was saved.")

if not OPEN_AFTER_CREATE:
    input("\nPress Enter to exit...")
