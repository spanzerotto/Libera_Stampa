


-- issue definition

CREATE TABLE issue (
	pk_issue INTEGER PRIMARY KEY,
	date NVARCHAR(50),
	issue_number INTEGER,
	rubrica_all VARCHAR(50),
	note_fuori_rubrica VARCHAR(512),
	notizie_fatti_storici VARCHAR(256),
	note VARCHAR(128),
	note_varie NVARCHAR(128)
);

insert into issue (pk_issue,
	date,
	issue_number,
	rubrica_all,
	note_fuori_rubrica,
	notizie_fatti_storici,
	note ,
	note_varie) 
SELECT pk_issue,
	date,
	issue_number,
	rubrica_all,
	note_fuori_rubrica,
	notizie_fatti_storici,
	note ,
	note_varie
from issue_old io ;	
	
	
	
	
CREATE TABLE article (
	pk_article INTEGER PRIMARY KEY,
	fk_issue INTEGER,
	article_pages text,
	article_title TEXT,
	article_type TEXT,
	article_signature TEXT,
	work_author TEXT,
	work_title TEXT,
	work_type TEXT,
	work_mention TEXT,
	notes TEXT,
	form_and_graphical_features TEXT
);	





SELECT i.issue_number, i.date, 
c.page,
c.article_title, 
c.article_signature, 
c.article_type, 
c.work_author,
c.work_title,
c.work_type,
c.work_mention,
c.extra_notes,
c.form_and_graphical_features
from contributi c, issue i 
where c.date=i.date;

--insert into article (
fk_issue,
article_pages,
article_title, 
article_signature, 
article_type, 
work_author,
work_title,
work_type,
work_mention,
notes,
form_and_graphical_features
)
SELECT i.issue_number,
c.page,
c.article_title, 
c.article_signature, 
c.article_type, 
c.work_author,
c.work_title,
c.work_type,
c.work_mention,
c.extra_notes,
c.form_and_graphical_features
from contributi c, issue i 
where c.date=i.date;




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
	notes TEXT
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