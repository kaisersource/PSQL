set search_path to ippica;
create or replace function controlla() returns trigger as $body$


--capienza <=500 livello nazionali è lecito
--capienza >=1000 livello internazionali è lecito
declare
r record;
begin
for  r in select * from ippodromo,gara where ippodromo.nome=gara.ippodromo and livello='nazionali'
loop
	if new.capienza>500 then
        raise exception ' capienza non lecite per gare nazionali';
	
end if;
end loop;

for r in select * from ippodromo,gara where ippodromo.nome=gara.ippodromo and livello='internazionali'
loop
	if distinct new.capienza<1000  then
       	 raise exception ' capienza non lecite per gare internazionali';
end if;
end loop;
return new;
end;

$body$
language plpgsql;
drop trigger if exists t on ippodromo cascade;
create trigger t before insert on Ippodromo
for each row execute procedure controlla();

