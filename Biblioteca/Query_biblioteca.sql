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
