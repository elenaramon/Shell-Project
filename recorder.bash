#! /bin/bash

SLEEPTIME=60s
#tutti i report creati vengono inseriti in una cartella apposita che viene creata se non esistente
mkdir -p reports

#il processo "entra" nella cartella reports in modo tale che non sia necessario spostare il file alla fine della creazione
cd reports

while true;
do
  #creazione del nome del file, il quale deve contenere report_annomesegiorno_oraminutisecondi.csv
  filename=report\_$(date +%Y%m%d_%H%M%S).csv
  documento=""
  #ciclo while per la sistemazione dello start > 24h e del command
  while read line;
  do

    if [ $(echo $line | cut -d ';' -f3 | wc -c) != "4" ];
    then

      userPidCommand="$(echo $line | cut -d ';' -f1,2,5);"
      startTime="$(echo $line | cut -d ';' -f3,4)"
      documento="$documento$(echo "$userPidCommand$startTime\n")"

    else

      userPidCommand="$(echo $line | cut -d ';' -f1,2,6);"
      start="$(echo $line | cut -d ';' -f3,4 | tr -s ';' ' ');"
      ptime="$(echo $line | cut -d ';' -f5)"
      documento="$documento$(echo "$userPidCommand$start$ptime\n")"

    fi

  done <<< "$(ps --no-headers -eo "user:32,pid,start,time,command" | tr -s ' ' ';' | cut -d ';' -f1-6)"

  echo "$(echo -e "$documento" | tr -s '\n')" > "$filename"

  sleep $SLEEPTIME

done
