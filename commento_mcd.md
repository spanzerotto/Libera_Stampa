


## Periodical

### Descrizione
Il periodico , Libera Stampa o altro. Pubblica a cadenza regolare dei numeri contenenti articoli.

### Proprietà
Name, type (quotidiano, rivista, ...) description (tema, soggetto, argomento, ...), begin date, end date, notes, 


## Relation

### Descrizione
Esprime la relazione fra periodico e organizzazione in un preciso lasso di tempo (ad esempio in casi di un organo ufficiale di un partito o di un'assocciazione) o più semplicemente lega il periodico alla propria redazione.

### Proprietà
Description (tipo di relazione), begin date, end date, notes


## Organisation

### Descrizione
Organizzazione che raggruppa persone per una ragione specifica. Può essere un partito politico, una casa editrice, un'ente scolastico (università), un'assocciazione, un circolo letterario ma anche la redazione di un giornale.

### Proprietà
Name, date creation, date dissolution, definition 


## Issue

### Descrizione
Il numero del giornale o di altro tipo di periodico
Ogni articolo è pubblicato in un periodico, n à 1.

### Proprietà
Date, issue n° (il numero dell'annata in corso del giornale), rubrica all (indica se è presente la rubrica culturale-letteraria in quello specifico numero), note fuori rubrica (contributi di tema culturale pubblicati fuori dalla rubrica), notizie fatti storici (si riportano notizie di attualità pubblicate nel numero particolarmente impattanti), note


## Article

### Descrizione
Articolo pubblicato su uno/più periodico/i. Se un articolo è ripubblicato va ricreato in intero, con lo stesso autore ecc. e si aggiunge la primary key della pubblicazione precedente nel nuovo articolo, relazione *has former publication*, che in precedenza è stato pubblicato in tale altro articolo.

### Proprietà
Title, article pages, type, article signature, notes, form and graphical features (nota particolarità grafiche/ d'impaginazione)


## Work_mention

### Descrizione
Esprime la relazione fra articolo e opera d'arte menzionata nello stesso. 
Da sopprimere la colonna *work_author* una volta creati i vari autori e verificati i dati, così come *work_publication_date* e *work_type* (già presenti nella classe Work).
In alternativa trasformare la colonna *work_author* in *author_as_mentioned* (come già nel MCD2 su draw.io) così da lasciare indicazione del nome con cui l'autore ha pubblicato, che non sempre corrisponde al nome anagrafico (ad esempio Franco Fortini, pseudonimo di Franco Lattes) ma che non sono presenti nella classe *author_name* in quanto NON sono autori di nessun articolo.

Questo è già stato fatto sul titolo dell'opera.

### Proprietà
Work author (da sopprimere),work type (da sopprimere), work mention (definisce in che misura l'opera d'arte è menzionata: per intero, come nel caso di poesie brevi o fotografie di quadri, o parzialmente, ecc), work publication date (da sopprimere), notes.

## Work

### Descrizione
Opera artistica.

### Proprietà
Name, type (definisce quale tipo di arte: letteraria, musicale, scultorea, pittorica, ...), description, publication date, notes


## Work role

### Descrizione
Esprime la relazione esistente fra persona e opera d'arte.
Può esistere anche una relazione fra opera d'arte e organizzazione (es. libro pubblicato da una casa editrice, o poesia scritta per un partito): aggiungere la colonna *fk_organistaion* ?

### Proprietà
Role, description, notes


## Role

### Descrizione
Esprime la relazione che lega una persona ad un'organizzazione.

### Proprietà
Role type, begin date, end date, description, notes


## Person

### Descrizione
Essere umano

### Proprietà
Name, date birth, date death, gender, definition


## Author name

### Descrizione
Lega l'articolo al proprio autore (persona o organizzazione)

### Proprietà
Name as published , notes on author, definition, type, notes


## Geographical place

### Descrizione
Preciso luogo geografico sulla terra, luogo fisico trovabile sulla mappa

### Proprietà
Name, country, longitude, latitude, notes