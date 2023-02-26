#!/bin/sh
cat workers | while read line
do
    if [ "$line" = "-" ]; then
        echo "Skip $line"
    else
        ssh root@$line -n "rm -rf /Lab1_BD/ && mkdir /Lab1_BD/"
        echo "Copy data to $line"
        scp  /Lab1_BD/setup.py root@$line:/Lab1_BD/ && scp /Lab1_BD/manager root@$line:/Lab1_BD/ && scp /Lab1_BD/workers root@$line:/Lab1_BD/
        echo "Setup $line"
        ssh root@$line -n "cd /Lab1_BD/ && python3 setup.py && ntpdate time.nist.gov"
        echo "Finished config node $line"
    fi
done
