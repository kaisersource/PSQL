drop schema if exists ippica cascade;
create schema ippica;
set search_path to ippica;

create table fantino(
 nome varchar primary key,
 eta integer check (eta>=25));

create table cavallo(
nome varchar primary key,
eta integer,
scuderia varchar);

create table coppia(
pettorale integer check (pettorale between 1 and 25),
nazione varchar,
fantino varchar references fantino(nome) on delete cascade,
cavallo varchar references cavallo(nome) on delete cascade,
unique(fantino,cavallo),
primary key(pettorale,nazione));

create table gara(
giorno date primary key,
ippodromo varchar,
vinc_pett integer,
vinc_naz varchar,
	foreign key(vinc_pett,vinc_naz) references coppia(pettorale,nazione) on delete cascade);

insert into fantino values('Mario',25);
insert into fantino values('Luca',30);
insert into fantino values('Andrea',31);
insert into cavallo values('Berry',8,'Bianchi');
insert into cavallo values('Rock',9,'Bianchi');
insert into cavallo values('Flash',12,'Bianchi');
insert into cavallo values('Split',12,'Rossi');
insert into cavallo values('Wolverine',12,'Verdi');
insert into cavallo values('Steel',10,'Verdi');
insert into coppia values(1,'Italia','Mario','Berry');
insert into coppia values(3,'Italia','Mario','Steel');
insert into coppia values(5,'Italia','Mario', 'Wolverine');
insert into coppia values(6,'Italia','Mario', 'Split');
insert into coppia values(4,'Francia','Luca','Split');

insert into coppia values(6,'Germania','Andrea','Wolverine');
insert into gara values('1/06/2016','Capannelle',1,'Italia');
insert into gara values('2/07/2016','asd',4,'Francia');
insert into gara values('3/08/2016','Capannelle',6,'Germania');

\echo il nome e la scuderia dei cavalli che non hanno partecipato ad alcna gara ossia fatto parte di una coppia di gara

select nome,scuderia from cavallo
where nome not in(select cavallo.nome from cavallo,fantino,coppia where fantino.nome=coppia.fantino and cavallo.nome=coppia.cavallo);

\echo numero di cavalli partecipanti di ciascuna scuderia che gareggi con almeno due cavalli

select scuderia,count(scuderia) from cavallo,coppia 
where cavallo.nome=coppia.cavallo 
group by scuderia having count(distinct cavallo)>1;ù

\echo i fantini che durante la loro cariera hanno gareggiato con almeno un cavallo per ogni scuderia memorizzata nella base di dati
--inner join cavallo coppia
create view v as select * from coppia,cavallo where cavallo=nome;
--divisione hardcore mode
select distinct x.fantino from v as x where not exists(select * from cavallo y where not exists ( select * from v as z where x.fantino=z.fantino and y.scuderia=z.scuderia));


