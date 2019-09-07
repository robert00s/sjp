#!/bin/bash
#Skrypt pobiera ze strony sjp.pl liste hasel, ktore posiadaja definicje

#jako parametr nalezy podać nazwe pliku wyjsciowego
plik_wyjsciowy=$1

if [ -z "$plik_wyjsciowy" ]; then
    echo "Brak zdefionowanego pliku wyjsciowego"
    echo "Uruchom ./lista_hasel.sh sjp.csv"
    exit 
fi

# Nalezy recznie odczytac ze strony internetowej
# https://sjp.pl/slownik/lp.phtml?f_mn=2&page=1
end_page=3200
for i in $(seq 1 $end_page); do
  curl -s https://sjp.pl/slownik/lp.phtml?f_mn=2\&page=$i | grep -oP "(?<=<tr><td><a href=)[^<]*" | cut -d '>' -f 2 >> ${plik_wyjsciowy}
  echo "przetworzono strone: $i"
done
