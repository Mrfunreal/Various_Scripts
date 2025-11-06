# This script adjusts all Xypos and Ypos values of a hud's .res file.
# Useful for when you want to move multiple hud items all at once.
# Create a file named "HUD_Original.txt" in the same folder as this script, then paste the section of your hud you want to alter.
# Run this python script and then decide the offsets you want to modify all values by.
# After the script is done, it will create "HUD_Adjusted.txt" containing your modified hud, ready to be pasted back into the script.

import re
import time

INPUT_FILE = "HUD_Original.txt"
OUTPUT_FILE = "HUD_Adjusted.txt"

def adjust_positions(text, x_offset=0, y_offset=0):
    def replace_xpos(match):
        value = int(match.group(1))
        return f'"xpos"\t\t"{value + x_offset}"'
    def replace_ypos(match):
        value = int(match.group(1))
        return f'"ypos"\t\t"{value + y_offset}"'

    text = re.sub(r'"xpos"\s*"(-?\d+)"', replace_xpos, text)
    text = re.sub(r'"ypos"\s*"(-?\d+)"', replace_ypos, text)
    return text


def main():
    try:
        with open(INPUT_FILE, "r", encoding="utf-8") as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: couldn't find '{INPUT_FILE}'. Make sure the file exists in this folder.")
        time.sleep(3)
        return

    try:
        x_offset = int(input("Enter X offset (Horizontal. Positive is right, negative is left.") or 0)
        y_offset = int(input("Enter Y offset (Vertical. Positive is down, negative is up..): ") or 0)
    except ValueError:
        print("Offsets must be numbers. Try again.")
        time.sleep(3)
        return

    result = adjust_positions(content, x_offset, y_offset)

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(result)

    print(f"\nDone. Output saved to '{OUTPUT_FILE}'.")
    print("Closing in 3 seconds...")
    time.sleep(3)


if __name__ == "__main__":
    main()
