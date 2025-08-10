#!/bin/bash
# IncVer.sh - Increment Basic subsystem version in CurrVersion.
#	8/10/25.	wmk.
#
# Usage. bash   IncVer.sh [-h]
#
#	-h = only display IncVer shell help
#
# Entry.
#	CurrVersion = current Basic build level
#
# Exit. vv.nn.mm 'vv' incremented, nn, mm set = 0 in ..Version file
#
# Modification History.
# ---------------------
# 8/10/25.	wmk.	original code. 
#
# Notes. When the version level is advanced, the revision and cycle numbers
# automatically return to 0.
#
# [P1=-h]
P1=${1,,}
# -h option code
if [ "${P1:0:1}" == "-" ];then
 option=${P1,,}
 if [ "$option" == "-h" ];then
  printf "%s\n" "IncVer - Increment version in specified type."
  printf "%s\n" "IncVer.sh -h"
  printf "%s\n" ""
  printf "%s\n" "  -h = (optional) only display IncVer shell help"
  exit 0
 else
  printf "%s" "IncVer.sh [-h]"
  printf "%s\n" " unrecognized option '$P1' - exiting."
  exit 1
 fi		# have -h
fi	# have -
mawk -F "." '{newver=$1+1;print newver ".0.0"}' CurrVersion > $TEMP_PATH/NewVersion
cp -pv CurrVersion CurrVersion.bak
cp -pv $TEMP_PATH/NewVersion CurrVersion
echo "ver.rev.cyc ver updated in CurrVersion."
printf "%s" "Incremented Basic CurrVersion is "
cat CurrVersion
# end IncVer.sh
