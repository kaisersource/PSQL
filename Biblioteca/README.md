
Si consideri il seguente schema relazionale relativo ad una porzione di un ipotetico
sistema di gestione di una biblioteca:
  • scrittore(nome, sesso, nazione)
  • libro(ISBN, titolo, autore, genere), dove l’attributo autore (resp. genere) e’ chiave esterna sulla relazione scrittore (resp. generi)
  • socio(id socio, nome, sesso, eta)
  • ha letto(ISBN,socio), dove l’attributo socio (resp. ISBN) e’ chiave esterna su socio (resp. libro).
  • generi(nome, sala)

(1) Si definisca uno script SQL per la generazione di uno schema biblioteca
che implementa lo schema relazionale proposto. Tale script dovra’ essere
composto da 2 parti principali: La prima, per cancellare le tabelle omonime
eventualmente presenti nella base di dati, la seconda per generare lo schema
definendo vincoli opportuni ed in particolare:
• Non si possono cancellare le informazioni su uno scrittore, se e’ presente
un libro dello stesso.
• Se si cancella/aggiorna un libro, le consultazioni ad esso relative vanno
cancellate/aggiornate in cascata
• Se un socio della sala di lettura viene aggiornato/cancellato, nelle con-
sultazioni ad esso relative l’attributo socio viene aggiornato/cancellato
in cascata
(2) Si popoli opportunamente lo schema generato utilizzando i dati nei file di
testo allegati all’esercizio.
(3) Si definiscano in SQL le seguenti interrogazioni:
(a) Ottenere i nomi dei soci di sesso femminile che hanno letto qualche
libro
(b) Determinare i titoli dei libri nella sala A
(c) Ottenere i titoli dei libri e la sala in cui sono collocati
(d) Ottenere i titoli dei libri e la sala in cui sono collocati, includendo le
opere di cui non e’ possibile reperire la collocazione
(e) Identificare i soci (i.e. elencarne gli id ) della biblioteca che hanno
letto almeno un libro nella sala A
(f) Determinare i nomi delle coppie di soci della biblioteca che hanno letto
uno stesso libro
(g) Elencare i nomi dei soci della biblioteca che hanno letto almeno un
libro nella sala A
(h) Determinare gli autori dei libri letti da almeno una donna
(i) Determinare i soci della biblioteca che non hanno mai letto un libro
situato nella sal B
(j) Determinare i soci della biblioteca che non hanno mai letto un libro
situato nella sal B, ma hanno letto qualche libro
(k) Determinare i titoli dei libri che si trovano nella stessa sala del libro
intitolato Ossi di Seppia
(l) Ottenere gli autori dei libri il cui titolo precede, nell’ordinamento
alfabetico, il titolo del libro con ISBN 88-55-55555-5
(m) Modificare l’interrogazione precedente in modo da ottenere solo gli
autori di libri letti da qualche socio
(n) Identificare i soci che hanno letto libri il cui ISBN e’ inferiore all’ISBN
di qualcuno dei libri nella sala B
(o) Ottenere i titoli e gli autori dei libri il cui ISBN sia superiore a qualcuno
degli ISBN dei libri letti da Clotilde Bianchi
(p) Ottenere le coppie di soci che hanno letto gli stessi libri
(q) Ottenere i nomi dei soci che hanno letto tutti i libri di poesia
(r) Ottenere i titoli dei libri letti da piu’ di un lettore
(s) Ottenere, per ciascun socio che abbia letto qualche libro, il numero di
libri letti
(t) Ottenere, per ciascun socio, il numero di libri letti da tale socio (in-
cludendo i soci che non hanno letto alcun libro)
(u) Identificare gli autori di cui e’ presente il maggior numero di libri
(v) Ottenere i nomi dei soci ed il numero dei libri letti dai soci che hanno
letto meno libri di Clotilde Bianchi
(w) Determinare l’autore preferito dai soci di sesso femminile (i.e. i cui
libri sono stati maggiormente letti)
(4) Si supponga di voler mantenere un’archivio storico dei soci della biblioteca,
e di aver creato a tale proposito un’opportuna tabella nella base di dati con
il seguente schema:
ex socio(nome, data disdetta)
Si defisca un trigger archivia socio, per memorizzare nella tabella ex socio
i clienti della biblioteca che disdettano il loro abbonamento (Si noti che
la data di disdetta puo’ essere ottenuta utilizzando la funzione di sistema
current date, che restituisce la data corrente).
(5) Si scriva un’applicazione Java che, caricando l’opportuno driver JDBC, si
connette al DB di riferimento e:
• Crea all’interno dello schema biblioteca giovani la tabella seguente
(imponendo i vincoli opportuni):
• libri teen(ISBN, titolo, autore)
• Popola la tabella creata sulla base dei dati presenti nello schema biblioteca:
In particolare, libro teen deve contenere i libri letti da almeno 2 teenagers
(soci di eta’ compresa tra 13 e 19 anni).
• Stampa sul file libri teen.txt il contenuto della tabella libri teen
