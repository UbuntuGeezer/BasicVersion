#!/bin/bash
# GetLatestCfg.sh - Get latest Basic configuration filename.
# 8/10/25.	wmk.
#
# Usage. bash  GetLatestCfg.sh
#
# Entry. user in BasicVersion (Lenovo) branch 
#
# Exit. environment var *basiccfg is latest configuration.
#
# Dependencies. BasicVersion/config.sh.CB1.basic.<version> file(s) exist.
#
# Modification History.
# ---------------------
# 8/10/25.	wmk.	original; adapted from Tutoring.
#
#	Environment vars:
if [ -z "$TODAY" ];then
. ~/sysprocs/SetToday.sh -v
fi
#procbodyhere
pushd ./ > /dev/null
projpath=$folderbase/Basic/BasicVersion
cd $projpath
ls config.sh.CB1.basic\.*.*.* > $TEMP_PATH/configlist.txt
# using '.' as separator, config is fields 5, 6, 7
gawk -F "." -f $projpath/awklatestcfg.txt  $TEMP_PATH/configlist.txt > $TEMP_PATH/configlist.tmp
#gawk -F "." 'BEGIN{cnt=0}END{ncnt=asort(configs,consrtd);for(i=0;i<=ncnt;i++)print consrtd[i]}{configs[cnt]=$5 "." $6 "." $7;cnt++}'  $TEMP_PATH/configlist.txt > $TEMP_PATH/configlist.tmp
wc -l $TEMP_PATH/configlist.tmp | gawk '{print "lncnt=" $1}' > $TEMP_PATH/lncnt.sh;chmod +x $TEMP_PATH/lncnt.sh;. $TEMP_PATH/lncnt.sh
gawk -v cnt=$lncnt '{if(NR == cnt)print "basiccfg=" $1;;}' $TEMP_PATH/configlist.tmp > basiccfg.sh;chmod +x basiccfg.sh
. ./basiccfg.sh
echo "$basiccfg (*basiccfg) is latest Basic configuration."
popd > /dev/null
#endprocbody
echo "  GetLatestCfg complete."
~/sysprocs/LOGMSG "  GetLatestCfg complete."
# end GetLatestCfg.sh
