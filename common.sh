#!/bin/bash
function askY() {
    read answer
    if [[ "$answer" =~ ^(y|yes|YES|Yes)$ ]]; then
        #echo -e "[PHW]I will ${myRED}reboot system${myNC} after successfuly complete script"
        myAnswer=y
    else
        #echo -e "[PHW]I understand your answer as ${myRED}No${myNC}"
        myAnswer=n
    fi
}
