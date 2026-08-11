


SELECT trim(a.work_author) as author, count(*) as numb
FROM article a 
group by trim(a.work_author)
order BY numb desc;

SELECT trim(a.work_author) as author, 
	trim(a.work_title) as title,
count(*) as numb
FROM article a 
group by trim(a.work_author),trim(a.work_title)
order BY numb desc;



--insert into work_mention (
	work_author,
	work_title,
	work_type,
	work_mention)
select work_author, work_title, work_type, work_mention
from contributi;
	
-- ho dovuto 'inventare' il n° dell'articolo, il legame essendo esplicitamente 
-- assente, ma implicito nell'ordine
--update work_mention set fk_article = pk_work_mention;

select *
FROM work_mention;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
SELECT trim(a.work_title) as author, count(*) as numb
FROM article a 
where a.work_author LIKE '%frey'
group by trim(a.work_title)
order BY numb desc;


SELECT trim(a.article_signature ) as signature, count(*) as numb
FROM article a 
--where a.article_signature LIKE '%frey'
group by trim(a.article_signature )
order BY numb desc;















