#!/usr/local/bin/bash
echo
read
FOUND=0
PREVPERIODSALLOWED=240
for I in $(seq 0 $PREVPERIODSALLOWED); do
    X=0;  
    ((X=$I*30));
    DT="$(date -r $((($(date +%s)-$X))))"
    GEN=$(cat /usr/local/etc/squid/totp.key | oathtool -N "$DT" -b --totp -)
    IN=$(echo $REPLY | sed 's/:.*$//g' | awk '{ print $1 }');
    if [ -z $IN ] || [ -z $GEN ]; then  
        FOUND=0
        break
    fi
    if [ ! ${#IN} -eq 6 ]; then
         FOUND=0
         break;
    fi
    if [ "$IN" == "$GEN" ]; then
         FOUND=1
         break
    fi;
done;
if [ $FOUND -eq 1 ]; then
        echo "OK";
else
        echo "ERR";
fi
