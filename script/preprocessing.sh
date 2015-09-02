#/bin/bash

nfdump -r $1 -o "fmt:%ts,%sa,%da,%pkt,%byt,%td,%sp,%dp,%flg,%pr" >> step1.csv



#elimina l'header
  sed -i '1d' step1.csv

#Elimina le ultime righe che contengono i riepiloghi
  head -n -4 step1.csv >> step2.csv

#elimina gli spazi multipli
  sed -r -i 's/\s+/ /g' step2.csv

#elimina gli spazi tra le virgole
  sed -i 's/, /,/g' step2.csv

python changeColumn.py step2.csv $2.csv
