drop schema if exists biblioteca cascade;
create schema biblioteca;
set search_path to biblioteca;
create domain str as varchar(50);
create domain s as char(1) check (value='M' or value='F');

create table generi(
nome str primary key,
sala char(1));

create table ex_socio (
nome varchar(255),
data_disdetta date
);

create table scrittore(
nome str primary key,
sesso s,
nazione str);

create table libro(
isbn str primary key,
titolo str,
autore str,
genere str,
foreign key(autore) references biblioteca.scrittore on delete restrict,
foreign key (genere) references generi(nome));

create table socio(
id_socio str primary key,
nome str,
sesso s,
eta integer);

create table ha_letto(
  socio str,
  isbn str,

  primary key(isbn,socio),
  foreign key (socio) references socio(id_socio) on delete cascade,
  foreign key (isbn) references libro(isbn) on delete cascade);

\copy generi from Genere.txt
\copy scrittore from Scrittore.txt
\copy libro from Libro.txt
\copy socio from Socio.txt
\copy ha_letto from Ha_letto.txt



-- Ottenere i nomi dei soci di sesso femminile che hanno letto qualche libro
--create or replace view soci_read(s) as select socio from ha_letto;
--select distinct id_socio from socio,soci_read where sesso='F' and id_socio in (soci_read.s);

--Determinare i titoli dei libri nella sala A
--Select titolo,sala from libro inner join generi on libro.genere=generi.nome where sala='A';

--Ottenere i titoli dei libri e la sala in cui sono collocati
Select titolo,sala from libro inner join generi on libro.genere=generi.nome;

--Ottenere i titoli dei libri e la sala in cui sono collocati, includendo le
--opere di cui non e’ possibile reperire la collocazione
Select titolo,sala from libro left join generi on libro.genere=generi.nome ; --SKILLZ
\echo Determinare i nomi delle coppie di soci della biblioteca che hanno letto
\echo uno stesso libro

\echo diversi soci stesso libro

create view has_read as select * from ha_letto; 
select distinct has_read.socio,ha_letto.socio,has_read.isbn from has_read,ha_letto where has_read.socio not in (ha_letto.socio) 
and ha_letto.isbn in (has_read.isbn) ;



create function archivia_socio() returns trigger as $BODY$
declare 
name varchar(255);
begin
	insert into ex_socio values (old.nome,current_date);
	
	return new;
end
$BODY$
LANGUAGE PLPGSQL;

create trigger archivia_socio after  delete on socio
for each row execute procedure archivia_socio();
