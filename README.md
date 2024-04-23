# Project Name
simple-scan-ocr-creator
See `part2.sh` for the impementation of this

## Description
Provide post processing to gnome simple-scan scanning software to overlay text onto scanned images that are saved in pdf.  This allow us to select text from scans where othewise they would be just images.

## Requirements
* simple-scan `which simple-scan` ... I know it runs in gnome (tested), it may run in other windowing environments (untested)
* zenity `which zenity` .  If you don't have it, google it & install it.
  - Displays confirmation of successfull process completion in the form of an alert at the end of processing.
* ocrmypdf `which ocrmypdf`  If you don't have it, google it & install it.

## Usage
Supply this script as the post processor script in the simple-scan preferences. Scan your document.  When you go to save it, you will supply a file name.  After you click save, and it is successfully saved, simple-scan will call this script.

Your specified file name will appear in the folder where you save it except it will be prefixed with YYYY-MM-DD   If you want to have it convert the pdf to text as well, uncomment out the line commented out in the script.  If you do you will need to install pdf2txt also.




