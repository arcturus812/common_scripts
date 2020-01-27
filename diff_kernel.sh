#!/bin/bash
. ./common.sh --source-only
ENV_TARGET=env_kernel.rc
source $ENV_TARGET &&
    echo -e "[PHW]ENV sourced ${myGR}$ENV_TARGET${myNC}"

find $KERNEL_ORIGIN $KERNEL_HOME -type f -not -name '*.[ch]' > excludes &&
    echo -e "[PHW]kernel exclude list extracted"

diff -wbur $KERNEL_ORIGIN $KERNEL_HOME -X excludes |grep -v Only |grep -v Binary > coretime_kernel.patch &&
    echo -e "[PHW]kernel diff successed"

