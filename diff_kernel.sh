#!/bin/bash
. ./common.sh --source-only
ENV_TARGET=env_kernel.rc
DATE=`date +%Y%m%d%H%M`
OUTPUT="./kernel_patches/kernel_$DATE.patch"
source $ENV_TARGET &&
    echo -e "[PHW]ENV sourced ${myGR}$ENV_TARGET${myNC}"

find $KERNEL_ORIGIN $KERNEL_HOME -type f -not -name '*.[ch]' > excludes &&
    echo -e "[PHW]kernel exclude list extracted"

diff -wbur $KERNEL_ORIGIN $KERNEL_HOME -X excludes |grep -v Only |grep -v Binary > $OUTPUT &&
    echo -e "[PHW]kernel diff successed"

PATCH_SIZE=`stat --printf="%s" $OUTPUT`
if [ $PATCH_SIZE -eq 0 ]
then
    echo -e "[PHW]nothing changed, remove patch file"
    rm -rf $OUTPUT
fi


