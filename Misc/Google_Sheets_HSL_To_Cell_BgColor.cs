// Written by MrFunreal
// this script reads the color values of a HSL table in a google sheets and calculates it to rgb, to which to tint the cells K and L
// the first number, hue, is multiplied by 3.6, for the weird system that forza uses to work
// in forza, all color sliders are 0.00-1.00. But Hue would need 0-360. hence the multiplication to get a value like 0.53 to 190.8
// the script automatically ignores the decimals and the L and R. So it interprets "0.53 R" simply as "53". so all the calculations work, without rewriting the sheet.

// usage: in google sheets, add the script (Extensions - Apps script). 
// make a new script and add this entire thang.
// in the spreadsheet, make sure the columns D E F are Hue, Saturation, and Brightness of prirmary color,
// while columns G H I are Hue, Saturation, and Brightness or secondary color.
// to run it, click on "custom - Set Preview Colors in column K and L"
// The color in column K is preview of primary color while L is preview of secondary. If no secondary color exists it writes out "None"

// the script does one line after another, top down. But it will take a while and the script WILL exceed the allowed time.
// thanks to that, you gotta copy the bottom lines it has not yet made colors for into a new sheet and generate all colors for those and continuously copy over the color previews every five or so minutes.
// SINCE THIS SCRIPT WORKS TOP DOWN, YOU MAY NEED TO ADD NEW COLORS TO THE TOP OF THE SHEET, GENERATE THE FEW NEW COLORS AND THEN RE-SORT THE ENTIRE SHEET BY BRAND NAME!

// Column numbers for the Primary Color HSL values (Columns D, E, F)
var hColumn1 = 4; // Column D for Hue
var sColumn1 = 5; // Column E for Saturation
var lColumn1 = 6; // Column F for Lightness (brightness)
var resultColumn1 = 10; // Column K for the result of the Primary Color

// Column numbers for the Secondary Color HSL values (Columns G, H, I)
var hColumn2 = 7;  // Column G for Hue
var sColumn2 = 8; // Column H for Saturation
var lColumn2 = 9; // Column I for Lightness (brightness)
var resultColumn2 = 11; // Column L for the result of the Secondary Color

var ui = SpreadsheetApp.getUi();
var sheet = SpreadsheetApp.getActiveSheet();

// Setup Buttons
function onOpen() {
  ui.createMenu('Custom')
  .addItem('Set Preview Colors in column K and L', 'setBackground')
  .addToUi();
}

// Function to parse the value and ignore any suffix and special characters
function parseValue(value) {
  if (typeof value === 'string') {
    // Remove non-numeric characters (except for decimal point)
    value = value.replace(/[^0-9.]/g, ''); 
  }
  
  // Parse as float and remove the decimal point for percentage calculations
  value = value.replace('.', ''); // Ignore the decimal point
  return parseInt(value); // Convert cleaned string to integer
}

// Set background for all cells in the vertical range based on both HSL sets
function setBackground() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getActiveSheet();
  var lastRow = sheet.getLastRow();

  // Loop through each row in the HSL columns
  for (var row = 1; row <= lastRow; row++) {
    // Handle the Primary Color HSL values (Columns 4, 5, 6 -> Result in Column 10)
    var h1 = parseValue(sheet.getRange(row, hColumn1).getValue()) * 3.6; // Multiply H by 3.6
    var s1 = parseValue(sheet.getRange(row, sColumn1).getValue());
    var l1 = parseValue(sheet.getRange(row, lColumn1).getValue());

    if (!isNaN(h1) && !isNaN(s1) && !isNaN(l1)) { // Check for valid numbers
      var rgb1 = hslToRgb(h1, s1 / 100, l1 / 100);
      sheet.getRange(row, resultColumn1).setBackgroundRGB(rgb1[0], rgb1[1], rgb1[2]);
      sheet.getRange(row, resultColumn1).setFontStyle("normal").setValue(""); // Clear "none" text
    } else {
      // Set background to white and display "none" in italics
      sheet.getRange(row, resultColumn1).setBackground("white").setFontStyle("italic").setValue("none");
    }

    // Handle the Secondary Color HSL values (Columns 7, 8, 9 -> Result in Column 11)
    var h2 = parseValue(sheet.getRange(row, hColumn2).getValue()) * 3.6; // Multiply H by 3.6
    var s2 = parseValue(sheet.getRange(row, sColumn2).getValue());
    var l2 = parseValue(sheet.getRange(row, lColumn2).getValue());

    if (!isNaN(h2) && !isNaN(s2) && !isNaN(l2)) { // Check for valid numbers
      var rgb2 = hslToRgb(h2, s2 / 100, l2 / 100);
      sheet.getRange(row, resultColumn2).setBackgroundRGB(rgb2[0], rgb2[1], rgb2[2]);
      sheet.getRange(row, resultColumn2).setFontStyle("normal").setValue(""); // Clear "none" text
    } else {
      // Set background to white and display "none" in italics
      sheet.getRange(row, resultColumn2).setBackground("white").setFontStyle("italic").setValue("none");
    }
  }
}

// Helper function to convert HSL to RGB
function hslToRgb(h, s, l) {
  var c = (1 - Math.abs(2 * l - 1)) * s;
  var hp = h / 60.0;
  var x = c * (1 - Math.abs((hp % 2) - 1));
  var rgb1;
  if (isNaN(h)) rgb1 = [0, 0, 0];
  else if (hp <= 1) rgb1 = [c, x, 0];
  else if (hp <= 2) rgb1 = [x, c, 0];
  else if (hp <= 3) rgb1 = [0, c, x];
  else if (hp <= 4) rgb1 = [0, x, c];
  else if (hp <= 5) rgb1 = [x, 0, c];
  else if (hp <= 6) rgb1 = [c, 0, x];
  var m = l - c * 0.5;
  return [
    Math.round(255 * (rgb1[0] + m)),
    Math.round(255 * (rgb1[1] + m)),
    Math.round(255 * (rgb1[2] + m))
  ];
}
