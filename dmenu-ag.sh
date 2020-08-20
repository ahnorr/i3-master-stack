#!/bin/bash
# use dmenu to excute command because perfomance
dmenuCommand="dmenu -i -c -l 10 -fn 'Hack' -p 'My Search:' "
command="./rofi-ag.sh | ${dmenuCommand}" 
status="2" 
result=" "

TMP_DIR="/tmp/rofi/${USER}/"
TMP_DIR="/tmp/rofi/${USER}/"
HIST_FILE="${TMP_DIR}/history.txt"


if [ ! -d "${TMP_DIR}" ]
then
	mkdir -p "${TMP_DIR}";
fi

while [[  "$result" != "exit" && ! -z "$result" ]] 
do
    agresult=$( eval "./rofi-ag.sh $result" )
    status=$?
    # echo "STATUS: ${status}"   
    if [[ "${status}" != "1" ]]; then
        result=$(eval "cat $HIST_FILE | ${dmenuCommand} ")
        if [[ ! -z "${result}" ]]; then
            printf -v result "%q\n" "$result"
        else
            result="exit"
        fi
    else
        result="exit"
    fi
done

if [[ $num_matches == 1 ]]; then
    ./rofi-ag.sh $result   
fi

# echo "done"
