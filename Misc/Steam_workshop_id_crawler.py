# This python script crawls the steam workshop addon page for the addon name, if all you got is the addon ID.
# Simply copy the id's from your addonlist or whatever in here. 
# REQUIRES BEAUTIFULSOUP4 AND REQUESTS TO BE INSTALLED
# pip install requests beautifulsoup4

import requests
from bs4 import BeautifulSoup
import os
import platform
import subprocess

# === ID'S GO HERE ===
mod_ids = [
    "403040832",
    "3402710930",
    "3317062976"
]
# === SETTINGS ===
WRITE_TO_FILE = True                    # Set to False to disable writing to a text file
OUTPUT_FILE = "WorkshopModnames.txt"    # Name of file to create, if True
OPEN_AFTER_CREATE = True                # If True: opens file and exits | If False: keeps CMD window open
# == IGNORE BELOW HERE ===
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

results = []
for mod_id in mod_ids:
    title = get_mod_title(mod_id)
    line = f"{mod_id}	- {title}"
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
