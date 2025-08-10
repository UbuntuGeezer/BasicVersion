#!/bin/bash
# IncCyc.sh - Increment cycle in specified version.
#	8/10/25.	wmk.
#.
# Usage. bash   IncCyc.sh [-h]
#
#	-h = only display IncCyc shell help
#
# Entry.
#	CurrVersion = current main Basic build level
#
# Modification History.
# ---------------------
# 8/10/25.	wmk.	original code.
#
# [$P1=-h]
#
P1=${1,,}
# -h option code
if [ "${P1:0:1}" == "-" ];then
 option=${P1,,}
 if [ "$option" == "-h" ];then
  printf "%s\n" "IncCyc - Increment cycle in specified version."
  printf "%s\n" "IncCyc.sh [-h]"
  printf "%s\n" ""
  printf "%s\n" "  -h = (optional) only display IncCyc shell help"
  printf "%s\n" ""
  printf "%s\n" "Results: Curr__Version of specified type updated."
  printf "%s\n" ""
  exit 0
 else
  printf "%s\n" "IncCyc [-h] unrecognized option '$P1' - exiting."
  exit 1
 fi		# have -h
fi	# have -
 mawk -F "." '{print $1 "." $2 "." ($3+1)}' CurrVersion > $TEMP_PATH/NewVersion
cp -pv CurrVersion CurrVersion.bak
cp -pv $TEMP_PATH/NewVersion CurrVersion
echo "ver.rev.cyc cyc updated in CurrVersion."
printf "%s" "Incremented Basic version = "
cat CurrVersion
# end IncCyc
