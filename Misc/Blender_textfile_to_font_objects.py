
import bpy
import os

#------------------------------------------------------------------------------------------------------------
#   This python script turns a text file list into multiple text objects.
#   Every new line in your imported text turns into a new object.
#   This was made with chatgpt, ngl. Couldn't be asked making it myself.
#------------------------------------------------------------------------------------------------------------
#   TEXT_FILE       = The text file containing the text you want.
#   TEMPLATE_NAME   = a premade text object in blender, whose font, scale and other settings to copy.
#   VERTICAL_OFFSET = vertical offset of each line, in blender units.
#------------------------------------------------------------------------------------------------------------

TEXT_FILE = r"F:\Modding\L4D2_Mapping\TUMTaRA\!SOURCE\Models\Ci_Names.txt"
TEMPLATE_NAME = "!!FONT_TEMPLATE"
VERTICAL_OFFSET = 2.5

# -----------------------------
# Get template
# -----------------------------
template = bpy.data.objects.get(TEMPLATE_NAME)

if template is None:
    raise Exception(f"Template '{TEMPLATE_NAME}' not found.")

if template.type != 'FONT':
    raise Exception(f"'{TEMPLATE_NAME}' is not a Text object.")

template_data = template.data

# Starting position
start_location = template.location.copy()

# -----------------------------
# Read names
# -----------------------------
with open(TEXT_FILE, "r", encoding="utf-8") as f:
    names = [line.strip() for line in f if line.strip()]

# -----------------------------
# Create text objects
# -----------------------------
for i, name in enumerate(names):

    # Create new text datablock
    text_data = bpy.data.curves.new(name=name, type='FONT')

    # Copy all font settings
    text_data.body = name

    text_data.font = template_data.font
    text_data.font_bold = template_data.font_bold
    text_data.font_italic = template_data.font_italic
    text_data.font_bold_italic = template_data.font_bold_italic

    text_data.size = template_data.size
    text_data.space_character = template_data.space_character
    text_data.space_word = template_data.space_word
    text_data.space_line = template_data.space_line

    text_data.offset_x = template_data.offset_x
    text_data.offset_y = template_data.offset_y

    text_data.shear = template_data.shear

    text_data.align_x = template_data.align_x
    text_data.align_y = template_data.align_y

    text_data.extrude = template_data.extrude
    text_data.bevel_depth = template_data.bevel_depth
    text_data.bevel_resolution = template_data.bevel_resolution
    text_data.resolution_u = template_data.resolution_u

    # Create object
    obj = bpy.data.objects.new(name, text_data)

    # Copy transform
    from mathutils import Vector

    obj.location = start_location + Vector((0, 0, -i * VERTICAL_OFFSET))
    obj.rotation_euler = template.rotation_euler.copy()
    obj.scale = template.scale.copy()

    # Copy materials
    obj.data.materials.clear()
    for mat in template.data.materials:
        obj.data.materials.append(mat)

    # Link to same collection(s) as template
    for coll in template.users_collection:
        coll.objects.link(obj)
