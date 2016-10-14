drop schema if exist didattica cascade;

create schema didattica;

set schema didattica;

create table persona(
	id_persona integer primary key, 
	codice_fiscale varchar(11) unique check (char_length(codice_fiscale)=11), 
	nome varchar(30) not null, 
	cognome varchar(30) not null, 
	data_nascita date
);

create table corso(
	id_corso integer primary key, 
	id_insegnante integer references persona(id_persona), 
	sigla varchar(7) check (char_length(sigla)=7), 
	crediti integer check (crediti > 0)                       
);

create table frequenza(
	id_studente integer references persona(id_persona),
	id_corso integer references corso(id_corso),
	voto integer check (voto <= 30),
	primary key(id_studente, id_corso)
);

