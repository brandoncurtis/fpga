# Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.

XIL_ARG_=$_
SETTINGS_FILE=.settings64.sh
XIL_SCRIPT_LOC="/opt/xilinx/14.7/ISE_DS"
if [ $# != 0 ]; then
   # The first argument is the location of Xilinx Installation.
   # Don't detect the installation location.
   XIL_SCRIPT_LOC="$1"
else
   #  XIL_SCRIPT_LOC should point to script location
   if [ "$0" == "ksh" ]; then
      XIL_SCRIPT_LOC_TMP_UNI=`readlink -f ${XIL_ARG_}`
   else
      XIL_SCRIPT_LOC_TMP_UNI=$BASH_SOURCE
   fi
   XIL_SCRIPT_LOC_TMP_UNI=${XIL_SCRIPT_LOC_TMP_UNI%/*}
   if [ "$XIL_SCRIPT_LOC_TMP_UNI" != "" ]; then
      if [ "$XIL_SCRIPT_LOC_TMP_UNI" == "settings64.sh" ]; then
         XIL_SCRIPT_LOC_TMP_UNI="./"
      fi
      XIL_SCRIPT_LOC_TMP_UNI=`readlink -f ${XIL_SCRIPT_LOC_TMP_UNI}`
      #if [ $? == 0 ]; then ### BEGIN BC EDIT
      #   XIL_SCRIPT_LOC=${XIL_SCRIPT_LOC_TMP_UNI}
      #fi  ### END BC EDIT
   fi
   unset XIL_SCRIPT_LOC_TMP_UNI
fi


xlnxInstLocList=""

xlnxInstLocList="${xlnxInstLocList} common"
xlnxInstLocList="${xlnxInstLocList} EDK"
xlnxInstLocList="${xlnxInstLocList} PlanAhead"
xlnxInstLocList="${xlnxInstLocList} ISE"
XIL_SCRIPT_LOC_TMP_UNI=${XIL_SCRIPT_LOC}
for i in $xlnxInstLocList
do
	d="${XIL_SCRIPT_LOC_TMP_UNI}/$i"
	sfn="$d/$SETTINGS_FILE"
	if [ -e  "$sfn" ]; then
		echo . "$sfn" "$d"
		. "$sfn" "$d"
	fi
done

### BEGIN BC EDIT - this does not make a lot of sense to me...
unset common
unset newLst
unset sfn
unset d
unset i
unset XIL_ARG_
unset XIL_SCRIPT_LOC
unset XIL_SCRIPT_LOC_TMP_UNI
### END BC EDIT
