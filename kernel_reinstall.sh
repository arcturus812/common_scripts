#!/bin/bash
. ./common.sh --source-only
ENV_TARGET=env_kernel.rc
myAnswer=n
source $ENV_TARGET &&
    echo -e "[PHW]ENV sourced ${myGR}$ENV_TARGET${myNC}"
CUR_DIR=`pwd`
echo -e "build target: $KERNEL_HOME"
echo -e "[PHW]Enable automotive ${myRED}REBOOT?${myNC} Yes/No"
askY

cd $KERNEL_HOME &&
    echo -e "[PHW]move dir into ${myBL}$KERNEL_HOME${myNC}"

# cd $KERNEL_ORIGIN &&
#     echo -e "[PHW]move dir into ${myBL}$KERNEL_ORIGIN${myNC}"

make -j$(nproc) | tee build.log &&
    make modules_install -j$(nproc) | tee module_install.log &&
    make install -j$(nproc) | tee install.log&&
    echo -e "[PHW]${myGR}SUCCESS${myNC} to kernel install" &&
    update-grub2 > /dev/null &&
    echo -e "[PHW]${myGR}SUCCESS${myNC} to grub2-update"

if [[ $? != 0 ]]; then
    echo -e "[PHW]${myRED}FAIL${myNC} to kernel install" &&
        cd $CUR_DIR
else
    if [ "$myAnswer" == "y" ]; then
        echo -e "After 5 second, reboot will proceed"
        sleep 5
        reboot
    fi
fi
