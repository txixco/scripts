select	a.TABLESPACE_NAME, a.MBYTES mbytes, b.MBYTES mbytes_free, 
	round(((a.MBYTES-b.MBYTES)/a.MBYTES)*100,2) percent_used
from ( select TABLESPACE_NAME, sum(BYTES/1024/1024) MBYTES 
		from dba_data_files 
		group by TABLESPACE_NAME ) a,
	( select TABLESPACE_NAME, sum(BYTES/1024/1024) MBYTES
		from dba_free_space 
		group by TABLESPACE_NAME ) b
where a.TABLESPACE_NAME=b.TABLESPACE_NAME
--	and round(((a.BYTES-b.BYTES)/a.BYTES)*100,2) > 85
order by ((a.MBYTES-b.MBYTES)/a.MBYTES) desc
