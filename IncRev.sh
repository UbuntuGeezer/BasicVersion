#!/bin/bash
# IncRev.sh - Increment Basic revision in CurrentVersion.
#	8/10/25.	wmk.
#
# Usage. bash   IncRev.sh [-h]
#
#	-h = (optional) only display IncRev.sh help
#
# Entry.
#	CurrVersion = current Basic main build level
#
# Modification History.
# ---------------------
# 8/10/25.	wmk.	original code; adapted from AcctngVersion.
#
# Notes. When the revision level is advanced, the cycle number automatically
# returns to 0.
#
# [P1=-h]
#
P1=${1,,}
# -h option code
if [ "${P1:0:1}" == "-" ];then
 option=${P1,,}
 if [ "$option" == "-h" ];then
  printf "%s\n" "IncRev - Increment revision in CurrVersion."
  printf "%s\n" "IncRev.sh [-h]"
  printf "%s\n" ""
  printf "%s\n" "  -h = only display IncRev shell help"
  printf "%s\n" ""
  printf "%s\n" "Results: CurrVersion updated."
  printf "%s\n" ""
  exit 0
 else
  printf "%s\n" "IncRev [-h] unrecognized option '$P1' - exiting."
  exit 1
 fi		# have -h
fi	# have -
mawk -F "." '{print $1 "." ($2+1) ".0"}' CurrVersion > $TEMP_PATH/NewVersion
cp -pv CurrACVersion CurrVersion.bak
cp -pv $TEMP_PATH/NewVersion CurrVersion
printf "%s\n" "ver.rev.cyc rev updated in CurrVersion."
printf "%s" "Incremented Basic CurrVersion is "
cat CurrVersion
# end IncRev.sh
