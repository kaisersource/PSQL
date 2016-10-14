create schema cinema;
set search_path to cinema;

create table persona(
id_persona int,
nome char not null,
cognome char not null,
primary key(id_persona));

create table film(
id_film int,
id_regista int default null references(persona),
titolo char(19),
genere char(20),
anno int check (anno > 0 or anno = NULL),
primary key(id_film));

create table partecipazione(
id_attore int references persona(id_persona),
id_film int references film(id_film),
ruolo char(20),
primary key(id_attore, id_film));

create table cinema(
id_cinema int,                               
nome char(20) not null,
indirizzo char(20),
primary key(id_cinema));

create table proiezione(
id_cinema int references cinema(id_cinema),  
id_film int references film(id_film),
giorno date,
primary key(id_cinema,id_film,giorno));

insert into cinema values (02, 'S. Angelo', 'Via Lucia');
insert into cinema values (01, 'Zenith', 'Via Bonfigli');
insert into cinema values (03, 'clarici', 'Corso');
insert into cinema values (04, 'multiplex', 'Centova');
