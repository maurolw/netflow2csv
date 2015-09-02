#/bin/bash

TMP="Split-$2-$1"
mkdir $TMP
echo "split"
editcap -i $1 $2 ./$TMP/result

#softflowd
cp changeColumn.py ./$TMP/
cd $TMP

nfcapd -p 12345 -l ./ &

PID=$!

for f in result*
do
  softflowd -n localhost:12345 -r $f  
done

until [ "$(ls -l nfcapd.* | wc -l)" -gt 1 ]; do
  sleep 1
done

# kill nfcapd

echo "read dump"
  nfdump -r nfcapd.2* -o "fmt:%ts,%sa,%da,%pkt,%byt,%td,%sp,%dp,%flg,%pr" >> step1.csv

kill $PID

#elimina l'header
  sed -i '1d' step1.csv

#Elimina le ultime righe che contengono i riepiloghi
  head -n -4 step1.csv >> step2.csv

#elimina gli spazi multipli
  sed -r -i 's/\s+/ /g' step2.csv

#elimina gli spazi tra le virgole
  sed -i 's/, /,/g' step2.csv

