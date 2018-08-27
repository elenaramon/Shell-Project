#! /bin/bash

#Questso script permette di verificare il contenuto dei file creati da "recorder.bash",
#in particolare stampa le occorrenze di ogni utente nel file creato più recentemente
#e le occorrenze in tutti i file di uno user specificato dall'utente

#controlliamo se la cartella "reports" esiste
if [ -d reports ];
then

  cd reports
  #controlliamo la presenza di file "report"
  if [ $(ls | grep -c report) = "0" ];
  then
    echo -e "\nNon ci sono report su cui eseguire il controllo!"
  else

    ###########
    #esecuzione prima funzione
    echo -e "\n1) Il numero di processi nel report più recente"
    filename=$(ls | grep report | sort -r | head -n1)

    #stampa a video il nome del file preso in considerazione
    echo -e "\nLast report: $filename"
    #ciclo while che legge per righe il file che viene passato come input
    while read line;
    do
      number=$(cut -d ';' -f1 $filename | grep -c $line)
      echo -e "$line: $number"
    done <<< "$(cut -d ';' -f1 $filename | sort -u)"

    ############
    #esecuzione seconda funzione
    echo -e "\n2) Il numero di processi in ogni report presente"
    read -p  "Inserire utente: " user
    user2=$(echo $user | cut -d ' ' -f1)
    #controlla che l'input dell'utente non sia null
    if [ -n "$user2" ];
    then
      #ciclo while che legge per righe il file che viene passato come input al done
      while read line;
      do
        number=$(cut -d ';' -f1 $line | grep -wc $user2)
        echo -e "report: $line processi $number"
      done <<< "$(ls -t | grep report)"
    fi
  fi
else
  echo -e "\nNon ci sono report su cui eseguire il controllo"
fi
