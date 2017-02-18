create schema biblioteca;
set search_path to biblioteca;
create domain str as varchar(50);
create domain s as char(1) check (value='M' or value='F');

create table scrittore(
nome str primary key,
sesso s,
nazione str);

create table libro(
isbn str primary key,
titolo str,
autore str,
genere str,
foreign key(autore) references biblioteca.scrittore on delete restrict);

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


create table generi(
nome str primary key,
sala char(1));
