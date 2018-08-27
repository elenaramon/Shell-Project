#! /bin/bash

#funzione che permette di iniziare in background il processo "recorder.bash" se non già in esecuzione
function startRecorder {

  #controlla se recorder è n esecuzione in background
  if [ $(pgrep -fc "recorder.bash") -eq "0" ];
  then
    #esecuzione del processo "recorder.bash" in background
    bash recorder.bash &
    echo -e "\nProcesso iniziato in background"
  fi

}

#funzione che permette di uccidere/terminare il processo "recorder.bash" se in esecuzione in background
function killRecorder {

  #controlla se uno o più recorder sono in esecuzione in background
  if [ $(pgrep -fc "recorder.bash") -ge "1" ];
  then
    #viene ucciso il processo
    kill -SIGPIPE $(pgrep -f "recorder.bash")
    echo -e "\nProcesso ucciso"
  fi
}

#funzione che fa eseguire il processo "query.bash"
function startQuery {
  bash query.bash
}

#funzione che verifica la quantità di spazio occupata dai file report*
#se questa supera una soglia impostata questi vengono cancellati
function checkSpace {
  bash checkSpace.bash
}

#ciclo while per il menu
while true;
do

  #stampa a video delle opzioni selezionabili del menu
  echo -e "\nMonitoraggio server. Comandi disponibili:"
  echo -e "1) Inizia monitoraggio"
  echo -e "2) Ferma monitoraggio"
  echo -e "3) Stampa info utilizzo"
  echo -e "4) Chiudi"
  echo -e "5) Controlla spazio occupato dai report"

  read -p "Inserisci numero comando [1-5]:" number

  #analizza l'input dell'utente
  case $number in
    1) startRecorder;;
    2) killRecorder;;
    3) startQuery;;
    4) exit;;
    5) checkSpace;;
    *) echo -e "\nComando non riconosciuto. Riprova.";;
  esac
done
