/*
 * This file documents the creation of the views
 * allowing data exploration and verification
 */



-- view allowing to inspect work roles
drop view v_work_role;
create view v_work_role AS
select p.name as person, wr."role", w.name work, w.publication_date 
from "work" w, work_role wr, person p
where p.pk_person = wr.fk_person 
and w.pk_work = wr.fk_work;

-- inspect view works with authors
select *
from v_work_role;





SELECT distinct p.name person_name, an.name_as_published, a.article_title,
	wm.work_title, w.name, wm.work_mention
FROM article a 
	left join author_name an on an.fk_article = a.pk_article
	left join person p on p.pk_person = an.fk_person 
	left join work_mention wm on wm.fk_article = a.pk_article 
	left join "work" w on w.pk_work = wm.fk_work 
;