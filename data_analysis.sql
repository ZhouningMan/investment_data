###select all the ceos that are public company
select cc.ceo, cr.rank, cc.company, cc.ticker, cc.industry
from ceo_rating cr, ceo_compensation cc
where cr.year = 2017 and upper(cr.name) = upper(cc.ceo)
order by cr.rank asc;

###select ceos that are not employed by s&p 500 companies based on ceo name
select cr.name, cr.rank, cr.employer
from ceo_rating cr
where cr.year = 2017 and upper(name) not in (select distinct upper(ceo) from ceo_compensation )
order by cr.rank asc;
