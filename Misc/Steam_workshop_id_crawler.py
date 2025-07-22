# This python script crawls the steam workshop addon page for the addon name, if all you got is the addon ID.
# Simply copy the id's from your addonlist or whatever in here. 
# REQUIRES BEAUTIFULSOUP4 AND REQUESTS TO BE INSTALLED
# pip install requests beautifulsoup4


import requests
from bs4 import BeautifulSoup

# List your mod IDs here
mod_ids = [
    "403040832",
    "3402710930",
    "3317062976"
]

# Steam URL prefix
base_url = "https://steamcommunity.com/sharedfiles/filedetails/?id="

# Output file
output_file = "WorkshopModnames.txt"

# Function to get mod title
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

# Open output file
with open(output_file, "w", encoding="utf-8") as file:
    for mod_id in mod_ids:
        title = get_mod_title(mod_id)
        file.write(f"{title} - {mod_id}\n")
        print(f"{title} - {mod_id}")  # Also print to console
