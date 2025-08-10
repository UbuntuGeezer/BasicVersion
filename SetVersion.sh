#!/bin/bash
# SetVersion.sh - Set current Basic version of specified type in branch.
#	8/10/25.	wmk.
#
# Usage. bash   SetVersion.sh -h|<branch> [-f]
#
#	-h = only display SetVersion shell help
#	<branch> = branch name (master, Lenovo, HPChrome)
#
# Dependencies. The following files contain the build levels for each:
#	CurrVersion = current main Basic version
#
#	-f = force set even if no CurrVersion changes
#
# Modification History.
# ---------------------
# 8/10/25.	wmk.	original; adapted from TerVer86777.
#
# P1=-h|<branch>, [P2=-f]
#
P1=$1
P2=${2,,}
# -h option code
if [ "${P1:0:1}" == "-" ];then
 option=${P1,,}
 if [ "$option" == "-h" ];then
  printf "%s\n" "SetVersion - Set current Basic version in branch."
  printf "%s\n" "SetVersion.sh -h|<branch> [-f]"
  printf "%s\n" ""
  printf "%s\n" "  -h = only display SetVersion shell help"
  printf "%s\n" "  <branch> = branch name (master, Lenovo, HPPavilion2, HPChrome)"
  printf "%s\n" "  -f = (optional) force change"
  printf "%s\n" ""
  printf "%s\n" "Results: <branch> CurrVersion set to CurVersion."
  printf "%s\n" ""
  exit 0
 else
  printf "%s" "SetVersion.sh -h|<branch> [-f]"
  printf "%s\n" " unrecognized option '$P1' - exiting."
  exit 1
 fi		# have -h
fi	# have -
if [ -z "$P1" ];then
  printf "%s" "SetVersion.sh -h|<branch> [-f]"
  printf "%s\n" " missing parameter(s) - abandoned."
 exit 1
fi
forceit=0
if [ ! -z "$P2" ];then
 if [ "$P2" == "-f" ];then
  forceit=1
 else
  echo "SetVersion -h|<branch> [-f] unrecognized option $P3 - abandoned."
  exit 1
 fi		# P2 = -f
fi	# P2 specified
if [ $forceit -eq 0 ];then
 git st > $TEMP_PATH/gitstatus.txt
 grep -e "CurrVersion" $TEMP_PATH/gitstatus.txt > $TEMP_PATH/results.txt
 if ! test -s $TEMP_PATH/results.txt;then
  if [ "$P1" != "master" ];then
   echo "no CurrVersion changes - SetVersion exiting."
   exit 0
  fi	# not *master
 fi
fi		#end forceit 
    mawk '{print "export curr_ver=" $0}' CurrVersion > curr_ver.sh;chmod +x curr_ver.sh
	. ./curr_ver.sh
mawk '{print "export curr_ver=" $0}' CurrVersion > curr_ver.sh;chmod +x curr_ver.sh
. ./curr_ver.sh
case "$P1" in
"Lenovo")
  git co $P1
 ;;
"HPPavilion2")
  git co $P1
 ;;
"HPChrome")
  git co $P1
 ;;
"master")		# set update *master branch and set version tag.
  # switch to *master if not already there.
  git br > $TEMP_PATH/branches.txt
  grep -e "\*.*master" $TEMP_PATH/branches.txt
  if [ $? -ne 0 ];then
   git co master
  fi
  # determine if CurrVersion file changed.
  changed=0
  git st > $TEMP_PATH/changes.txt
  grep -e "CurrVersion" $TEMP_PATH/changes.txt
  if [ $? -eq 0 ];then changed=1;fi
  # check if no Version file changes.
  if [ $changed -eq 0 ];then
   if [ $forceit -eq 0 ];then
    echo " no CurrVersion file changes - exiting."
   else
     git add .
     git ci -m "forced *master update $TODAY1"
     git tag -l > $TEMP_PATH/tags.txt
     grep -e "$TODAY1" $TEMP_PATH/tags.txt > /dev/null
     if [ $? -eq 0 ];then
      echo "  tag $TODAY1 already exists; tag not added."
     else
      git tag -a -m "master tagged with $TODAY1." $TODAY1 HEAD
     fi # end tag defined
     echo " ** Be sure to 'push' origin master **"
   fi	# end force change
   exit 0
  fi	# end no CurrVersion changes
  # at least 1 ..Version file changed.
  # use git add to update with all changes, then add tags.
  grep -e "$BASIC_$curr_ver" $TEMP_PATH/tags.txt > /dev/null
  if [ $? -eq 0 ];then
   echo "  tag BASIC_$curr_ver already exists; tag not added."
  else
   git tag -a -m "master tagged with BASIC_$curr_ver." BASIC_$curr_ver HEAD
  fi # end tag defined
  # use git add to update with all changes, then add tags.
  git add .
  git ci -m "*master branch updated."
  git log -n 1 | mawk  -f awkgetcommit.txt > $TEMP_PATH/currcommit.sh
  chmod +x $TEMP_PATH/currcommit.sh;. $TEMP_PATH/currcommit.sh
  echo "current commit is: '$curr_commit'"
  # add additional tags for changed modules.
  if [ $changed -ne 0 ];then
    mawk '{print "export curr_ver=" $0}' CurrVersion > curr_ver.sh;chmod +x curr_ver.sh
	. ./curr_ver.sh
    git tag -a -m "master tagged with BASIC$curr_ver." BASIC$curr_ver HEAD
  fi
# ---- common code for all but *master -----
# Note: the 'cp code below should use the *SYSID after the .sh instead
# of being hardwired to 'HP2.
if [ "$P1" != "master" ];then
    git co master -- CurrVersion
	# set BASIC_BUILD environment var
    mawk -F "=" \
   '{if($1 ~ "export BASIC_BUILD")print $1 "=" ENVIRON["curr_ver"];else print$0}'\
     config.sh.$SYSID.basic > $TEMP_PATH/newconfig.sh
    cp -pv config.sh.$SYSID.basic config.sh.$SYSID.basic.bak
	#  cp -pv $TEMP_PATH/newconfig.sh config.sh.$SYSID.basic
    mawk \
    '{if($2 ~ "-----.*") {print $0;print"# " ENVIRON["TODAY1"] ".\twmk.\tset BASIC_BUILD to " ENVIRON["curr_ver"] "."}else print}' $TEMP_PATH/newconfig.sh > config.sh.$SYSID.basic
    git add .
    git ci -m "*$P1 updated to $curr_ver."
    git tag -l > $TEMP_PATH/tags.txt
    grep -e "BASIC$curr_ver" $TEMP_PATH/tags.txt > /dev/null
    if [ $? -eq 0 ];then
     printf "%s\n" "  tag BASIC$curr_ver already exists; tag not added."
    else
     git tag -a -m "$P1 updated to BASIC$curr_ver." BASIC$curr_ver HEAD
    fi
fi	# if not *master
# end SetVersion
