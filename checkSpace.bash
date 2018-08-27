#! /bin/bash

MAXSPACE="30"

#controlliamo se la cartella "reports" esiste, altrimenti vuol dire che non ci sono report
if [ -d reports ];
then
  #entra nella cartella in cui sono contenuti i report
  cd reports

  #eseguiamo un ciclo while
  #prima condizione: controlla che ci siano ancora dei file all'interno della cartella da eliminare
  #seconda condizione: controlla che lo spazio occupato dai file sia inferiore uguale alla soglia predisposta
  while [ $(ls | grep -c report) != "0" ] && [ $(du -c report* | tail -n1 | cut -f1) -ge $MAXSPACE ];
  do
    #esegue una rimozione forzata del file creato meno di recente
    rm -f $(ls | grep report | sort -r | tail -n1)
  done
else
  echo -e "\nNon ci sono report da eliminare"
fi
