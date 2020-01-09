#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cd ${DIR}/../connect
echo $PWD
for dir in $(ls -d *)
do
    if [ ! -d $dir ]
    then
        continue
    fi

    # check for ignored folders in scripts/tests-ignored.txt
    grep "$dir" ${DIR}/tests-ignored.txt > /dev/null
    if [ $? = 0 ]
    then
        echo "skipping $dir"
        continue
    fi

    cd $dir > /dev/null

    for script in *.sh
    do
        if [[ "$script" = "stop.sh" ]]
        then
            continue
        fi

        #filename="${script%.*}"
        ####
        ##
        echo "Executing $script in dir $dir"
        sh $script
        sh stop.sh
    done
    cd - > /dev/null
done