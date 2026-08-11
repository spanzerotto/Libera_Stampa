


-- issue definition

CREATE TABLE issue (
	pk_issue INTEGER,
	date NVARCHAR(50),
	issue_number INTEGER,
	rubrica_all VARCHAR(50),
	note_fuori_rubrica VARCHAR(512),
	notizie_fatti_storici VARCHAR(256),
	note VARCHAR(128),
	note_varie NVARCHAR(128),
	fk_periodical INTEGER,
	CONSTRAINT ISSUE_PK PRIMARY KEY (pk_issue),
	CONSTRAINT issue_periodical_FK FOREIGN KEY (fk_periodical) REFERENCES periodical(pk_periodical)
);



--DELETE FROM issue;
--DELETE FROM sqlite_sequence WHERE name = 'issue';

/*
 * Import from csv: numeri to Issue
 * 
 * 
 */



select 
from contributi c 
	left join article a on a.da;

	
	
drop table article;	
CREATE TABLE article (
	pk_article INTEGER PRIMARY KEY,
	fk_issue INTEGER,
	article_pages text,
	article_title TEXT,
	article_type TEXT,
	article_signature TEXT,
	notes TEXT,
	form_and_graphical_features TEXT,
	fk_contributi_import integer
);	


/* 
 * errore nelle date dei numeri :
 * 1945-01-29; 1945-03-30; 1945-05-03
 * e degli articoli: 1947-09-13 x 4
 * 
 */

UPDATE contributi set date = '1946-09-13'
WHERE date = '1947-09-13';





SELECT i.issue_number, 
i.date, 
c.date d_article,
c.page,
c.article_title, 
c.article_signature, 
c.article_type, 
c.extra_notes,
c.form_and_graphical_features,
c.pk_contributi 
from contributi c left join issue i 
on trim(c.date)=trim(i.date)
order by i.issue_number;






--insert into article (
fk_issue,
article_pages,
article_title, 
article_signature, 
article_type, 
notes,
form_and_graphical_features,
fk_contributi_import 
)
SELECT i.pk_issue,
c.page,
c.article_title, 
c.article_signature, 
c.article_type, 
c.extra_notes,
c.form_and_graphical_features,
c.pk_contributi 
from contributi c, issue i 
where c.date=i.date
order by i.issue_number;


-- aggiungere colonna fk_article a contributi e riempire come segue
-- al fine di avere il n. dell'articolo

SELECT a.pk_article, c.fk_article 
from article a, contributi c 
where a.fk_contributi_import = c.pk_contributi ;


--update contributi set fk_article = a.pk_article
from article a
where a.fk_contributi_import = pk_contributi ;





CREATE TABLE author_name (
	pk_author_name INTEGER PRIMARY KEY,
	fk_article INTEGER,
	fk_person INTEGER,
	fk_organisation INTEGER,
	name_as_published TEXT,
	name_of_real_author TEXT,
	definition TEXT,
	type TEXT,
	notes TEXT
);	


DELETE FROM author_name ;
DELETE FROM sqlite_sequence WHERE name = 'author_name';


select a.pk_article, 
case 
	when length(a.article_signature) > 0
	then a.article_signature
	else 'anonimo'
end author_name
from article a 


--INSERT into author_name (fk_article, name_as_published )
select a.pk_article, 
case 
	when length(a.article_signature) > 0
	then a.article_signature
	else 'anonimo'
end author_name
from article a ;


SELECT an.name_as_published, count(*) as num
from author_name an 
group by an.name_as_published 
order by num desc;


CREATE TABLE person (
	pk_person INTEGER PRIMARY KEY,
	name text,
	date_birth TEXT,
	date_death TEXT,
	gender TEXT,
	definition TEXT
	notes TEXT,
	fk_birth_place INTEGER,
	CONSTRAINT person_geographical_place_FK FOREIGN KEY (fk_birth_place) REFERENCES geographical_place(pk_geographical_place)
);




-- add authors as persons
select an.fk_person, an.name_as_published 
from author_name an 
where an.name_as_published like '%Frey%';

update author_name set fk_person = 1
where name_as_published like '%Frey%';



select an.fk_person, an.name_as_published 
from author_name an 
where an.name_as_published like '%Borlen%';

update author_name set fk_person = 2
where name_as_published like '%Borlen%';

select an.fk_person, an.name_as_published 
from author_name an 
where an.name_as_published like '%Salat%';

update author_name set fk_person = 3
where name_as_published like '%Salat%';




/*
 * Geographical Place
 */

CREATE TABLE geographical_place (
	pk_geographical_place INTEGER PRIMARY KEY,
	name text,
	country TEXT,
	longitude numeric,
	latitude numeric,
	description TEXT
	notes TEXT
);	


/*
 * Organisation
 */

CREATE TABLE organisation (
	pk_organisation INTEGER PRIMARY KEY,
	name text,
	date_creation TEXT,
	date_dissolution TEXT,
	definition TEXT
	notes TEXT,
	fk_based_in_place INTEGER,
	CONSTRAINT organisation_geographical_place_FK FOREIGN KEY (fk_based_in_place) REFERENCES geographical_place(pk_geographical_place)
);

drop table role;
CREATE TABLE role (
	pk_role INTEGER PRIMARY KEY,
	role_type TEXT,
	begin_date text,
	end_date text,
	description TEXT,
	notes TEXT,
	fk_organisation INTEGER,
	fk_person INTEGER,
	FOREIGN KEY (fk_organisation) REFERENCES organisation (pk_organisation)
	FOREIGN KEY (fk_person) REFERENCES person(pk_person)
	
);	






/*
 * Periodical
 */

--DROP TABLE periodical;
CREATE TABLE periodical (
	pk_periodical INTEGER PRIMARY KEY,
	name TEXT,
	type_periodical TEXT,
	definition TEXT, 
	begin_date TEXT,
	end_date TEXT,
	notes TEXT
);	

-- aggiunto pk Libera Stampa a issue
-- update issue set fk_periodical = 1;


CREATE TABLE relation (
	pk_relation INTEGER PRIMARY KEY,
	relation_type TEXT,
	description TEXT,
	begin_date text,
	end_date text,
	notes TEXT,
	fk_organisation INTEGER,
	fk_periodical INTEGER,
	FOREIGN KEY (fk_organisation) REFERENCES organisation (pk_organisation)
	FOREIGN KEY (fk_periodical) REFERENCES periodical(pk_periodical)
	
);	




CREATE TABLE work (
	pk_work INTEGER PRIMARY KEY,
	name TEXT,
	type_work TEXT,
	description TEXT, 
	publication_date TEXT,
	notes TEXT
);	

DROP TABLE work_mention;
CREATE TABLE work_mention (
	pk_work_mention INTEGER PRIMARY KEY,
	work_author TEXT,
	work_title TEXT,
	work_type TEXT,
	work_mention TEXT,
	work_publication_date TEXT,
	notes TEXT,
	fk_work INTEGER,
	fk_article INTEGER,
	fk_person INTEGER,
	FOREIGN KEY (fk_work) REFERENCES work (pk_work)
	FOREIGN KEY (fk_article) REFERENCES  issue (pk_issue)
	FOREIGN KEY (fk_person) REFERENCES  person(pk_person)
	
);	


-- ispezione: 37 senza opera
select * 
from contributi c
where 
	length(c.work_title)<2
	AND 
	length(c.work_author)<2;




-- non vuoti, con opera: 149
select c.fk_article, c.work_author,c.work_title, c.work_type, c.work_mention 
from contributi c
where 
	length(c.work_title) >1
	OR 
	length(c.work_author) >1;

-- nessun opera non ricavata
SELECT * 
from contributi c where c.pk_contributi not in (
select c.pk_contributi  
from contributi c
where 
	length(c.work_title)<2
	AND 
	length(c.work_author)<2
union
select c.pk_contributi 
from contributi c
where length(c.work_title) >1
	or
	length(c.work_author) >1);


--insert into work_mention(fk_article,  work_author,work_title, work_type, work_mention) 
select c.fk_article,  c.work_author, c.work_title, c.work_type, c.work_mention 
from contributi c
where 
	length(c.work_title) >1
	OR
	length(c.work_author) >1;

SELECT wm.work_author, wm.work_title, wm.work_type, wm.fk_article 
FROM work_mention wm
limit 10;

SELECT wm.work_author, wm.work_title, wm.work_type, a.article_signature, a.article_title 
FROM work_mention wm, article a 
where a.pk_article = wm.fk_article 
limit 30;

SELECT wm.work_author, wm.work_title, 'Numero menzioni: ' || count(*) AS num_menzioni
FROM work_mention wm
GROUP BY wm.work_author, wm.work_title 
ORDER BY num_menzioni DESC;

SELECT wm.work_author, wm.work_title, 'Numero menzioni: ' || count(*) AS num_menzioni
FROM work_mention wm
GROUP BY wm.work_author, wm.work_title 
ORDER BY count(*) DESC;


-- creazione delle opere SOLO DOVE C'È IL TITOLO
SELECT wm.work_author, wm.work_title,  wm.work_type, 'Numero menzioni: ' || count(*) AS num_menzioni
FROM work_mention wm
where length(wm.work_title)> 0
GROUP BY wm.work_author, wm.work_title,  wm.work_type 
ORDER BY count(*) DESC;



SELECT *
from "work" w ;

--insert into "work" (notes, name, type_work )
SELECT wm.work_author, wm.work_title,  wm.work_type
FROM work_mention wm
where length(wm.work_title)> 0
GROUP BY wm.work_author, wm.work_title,  wm.work_type 
ORDER BY wm.work_title ;


select wm.work_author, wm.work_title,  wm.work_type, w.name, w.notes 
from "work" w, work_mention wm 
where wm.work_author = w.notes 
and wm.work_title = w.name 
and wm.work_type = w.type_work; 

--update work_mention wm set fk_work = w.pk_work
from "work" w
where wm.work_author = w.notes 
and wm.work_title = w.name 
and wm.work_type = w.type_work; 


-- update work_mention SET fk_work = pk_work
from "work" w 
where work_author = w.notes 
and work_title  = w.name
and work_type = w.type_work;

select *
from work limit 10;


SELECT notes, count(*) as eff
from "work" w
group by notes
order by eff desc;




CREATE TABLE work_role (
	pk_work_role INTEGER PRIMARY KEY,
	role TEXT,
	description TEXT,
	notes TEXT,
	fk_work INTEGER,
	fk_person INTEGER,
	FOREIGN KEY (fk_work) REFERENCES work (pk_work)
	FOREIGN KEY (fk_person) REFERENCES person(pk_person)
	
);




/*
 * Inserzione degli autori
 * 
 * I nomi degli autori esistenti sono stati provvisoriamente 
 * inseriti nelle note della tabella *work*
 * 
 */




SELECT notes, count(*) as eff
from "work" w
--where notes like '%Frey%'
group by notes
order by eff desc;




-- add work authors as persons
select pk_work, 9, 'autore' 
from work where notes like '%Heming%';




--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 1, 'autore' 
from work where notes like '%Frey%';

--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 3, 'autore' 
from work where notes like '%Salat%';

--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 2, 'autore' 
from work where notes like '%Borlen%';

--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 6, 'autore' 
from work where notes like '%Picass%';

--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 7, 'autore' 
from work where notes like '%Scort%';

--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 8, 'autore' 
from work where notes like '%Gioil%';

--insert into work_role (fk_work, fk_person, "role" )
select pk_work, 9, 'autore' 
from work where notes like '%Heming%';
