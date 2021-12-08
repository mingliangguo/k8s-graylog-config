
# Calculate the latest and earliest offsets, and provide the total # of messages in the topic (the difference):

#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'provide the name of a topic to get totals against'
    exit 0
fi

latest=`kafka-run-class kafka.tools.GetOffsetShell --broker-list $BROKER_LIST --topic $1 --time -1 --offsets 1 | awk -F ":" '{sum += $3} END {print sum}'`
earliest=`kafka-run-class kafka.tools.GetOffsetShell --broker-list $BROKER_LIST --topic $1 --time -2 --offsets 1 | awk -F ":" '{sum2 += $3} END {print sum2}'`
total=`expr $latest - $earliest`
echo Latest Total $latest
echo Earliest Total $earliest
echo InQueue Total $total
