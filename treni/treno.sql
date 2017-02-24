drop schema if exists treni cascade;
create schema treni;
set search_path to treni;

create table citta(
nome varchar(255) primary key,
numero_abitanti integer,
nazione varchar(255)
  );

  create table stazione(
cod_stazione integer primary key,
nome varchar(255) unique,
categoria varchar(255),
citta varchar(255) references citta(nome));

create table treno(
  cod_treno integer primary key,
  orario_partenza time,
  stazione_partenza varchar(255) not null references stazione(nome) on delete restrict,
  orario_arrivo time,
  stazione_arrivo varchar(255) not null references stazione(nome) on delete restrict,
  azienda varchar(255)
  );

create table percorso(
treno integer references treno(cod_treno) on delete cascade,
citta varchar(255) references citta(nome) on delete cascade,
primary key(treno,citta)
);

insert into citta values('Perugia','100000','Italia');
insert into citta values('Bologna','200000','Italia');
insert into citta values('Roma','5000000','Italia');
insert into stazione values(1,'Termini','A','Roma');
insert into stazione values(2,'Tiburtina','B','Roma');
insert into stazione values(3,'Fontivegge','B','Perugia');
insert into stazione values(4,'Bologna Centrale','B','Bologna');
insert into treno values(1,'05:00','Termini','05:10','Tiburtina','Kimbo');
insert into treno values(2,'07:00','Bologna Centrale','10:15','Fontivegge','Kimbo');
insert into treno values(3,'10:00','Fontivegge','12:10','Termini','Kimbo');
insert into treno values(4,'10:00','Tiburtina','12:20','Fontivegge','Kimbo');
insert into treno values(5,'11:00','Termini','13:10','Fontivegge','Mocassino');
insert into percorso values(1,'Roma');
insert into percorso values(2,'Bologna');
insert into percorso values(3,'Perugia');
--Determinare i treni  che arrivano in una stazione situata a Perugia oppure che partono da una stazione di roma
--select treno.codice from treno,stazione where (stazione_arrivo=nome and Citta='Perugia') or (stazione_partenza=nome and Citta='Roma');
--Determinare i treni che non partono da una stazione di bologna bologna
--Vista che determina i treni che partono da una stazione di bologna
--create view bologna as select cod_treno from treno,stazione where (stazione_partenza=nome and Citta='Bologna');
--Treni eccetto cod treno
--select treno.cod_treno from treno,bologna where treno.cod_treno not in (bologna.cod_treno);
--determinare le aziende ferroviarie che hanno una partenza da ogni stazione
--determinare le aziende ferroviarie che non hanno una partenza da nessuna stazione
alter table citta add numstazioni integer;

select distinct x.azienda from treno as x 
where not exists(select * from stazione AS y 
where not exists(select * from treno as z 
where z.azienda=x.azienda and z.stazione_partenza=y.nome));

create function no_station() returns trigger as $body$
declare
r record;
y varchar(255);
x integer;
begin
  for r in select citta,count(cod_stazione) as n from stazione group by citta
  loop 
	update citta set numstazioni=r.n where citta.nome=r.citta;
	end loop;
return new;
end
$body$
language plpgsql;
create trigger no_station after insert on stazione
for each row execute procedure no_station();
