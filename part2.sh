#!/usr/bin/env bash
# Prefer env bash seeking over an explicit path
# https://stackoverflow.com/questions/16365130/what-is-the-difference-between-usr-bin-env-bash-and-usr-bin-bash



# Automation Task
# Task Description:
#  ++  OCR my scanned PDF's.  I want to be able to select text from PDF's I've scanned.

# Step 1: Identify the repetitive task to be automated:
#  ++  It repeats for every scan

# Step 2: Design and implement the automation script
#   <step2>

# initial concept taken from:
# https://gitlab.gnome.org/GNOME/simple-scan/-/blob/db90d5b188267b6377305d36b6199f196902e263/src/simple-scan-postprocessing.sh

##### See set documentation in the bash man page ...
# man bash | grep -A 115 ' set \['
########
# set +m = disable bash job control builtins (fg, bg, &)
# set -e = exit on error
# set -x = debug = echo each command to stdout as it is executed
#######
set +m -e -x
##### we need some method to pop a dialog on error to indicate to the user (me)
##### that some error has occured with procesing this scan so that it can be corrected


###################################################
# ~~~~  New features / todo  ~~~~
# * Detect if file name is already yyyy-mm-dd prefixed and if so DO NOT RENAME it
#
###################################################



# log stdout & stderr
# https://unix.stackexchange.com/questions/61931/redirect-all-subsequent-commands-stderr-using-exec
> "/tmp/simple-scan.log"
exec >> >(tee "/tmp/simple-scan.log") 2>&1

# Arguments
mime_type="$1"
keep_original="$2"
scan_file="$3"  # full path to the scanned file
remainder="${@:4}"  # these are hard coded for all scans and thus worthless

if [ "$mime_type" == "application/pdf" ];then
	# filename drudgery
	today=`date '+%Y-%m-%d'`   ## WE MIGHT WANT TO PROMPT FOR THIS ##
	d=`dirname "$scan_file"`  # dir
	fne=`basename "$scan_file"` # file n(and) extension
	e=${fne##*.} # extension
	f=${fne%.*} # file without extension

	orig="$d/${today}_${f}_orig.${e}"
	ocr_file="$d/${today}_${f}.${e}"
	txt_file="$d/${today}_${f}.txt"
	# rename scan_file to include date and _orig suffix
	mv "$scan_file" "$orig"
	# --remove-background is currently broken/disabled in ocrmypdf
	#ocrmypdf --clean --remove-background "$orig" "$scan_file"
	# Note: the ocr'd version does not contain the _orig suffix
	ocrmypdf "$orig" "$ocr_file"
        ### commenting out for now, it works, just not using it. it can be batched in the future if needed.
	# for future full text search of docs
	#cp <(pdf2txt "$ocr_file") "$txt_file"   # maybe make one of those worthless args a gen_text arg flag...
	[ "$keep_original" == "false" ] && rm "$orig"
fi

# if we got here there were no errors
zenity --info --text="Process Completed Successfully"


# </step2>




# Step 3: Test the automation script
#  ++ This is triggered by simple-scan upon completion of each scan.  This script is provided to it's post processing hook.

# Step 4: Document the development process
# Placeholder for documentation
# ++  see README.md