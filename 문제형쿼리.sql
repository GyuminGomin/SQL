drop table test1;

create table test1
(
�μ�id number(10),
�μ��ڵ� number(10),
�����μ��ڵ� number(10)
);

insert into test1 values(10,50,0);
insert into test1 values(20,400,50);
insert into test1 values(30,150,400);
insert into test1 values(40,200,150);
insert into test1 values(50,250,200);

select *
from test1
where �μ��ڵ� = 400
start with �μ��ڵ� = 50
connect by prior �μ��ڵ� = �����μ��ڵ�;

-- connect by prior �ڽ� = �θ� : �θ𿡼����� �ڽ����� (������)
-- connect by prior �θ� = �ڽ� : �ڽĿ������� �θ�� (������)


create table test2 
(
    JOB_ID varchar(20),
    SALARY number(10)
);

insert into test2 values ('manager', 1300);
insert into test2 values ('manager', 1500);
insert into test2 values ('manager', 1900);
insert into test2 values ('helper', 1000);
insert into test2 values ('helper', 1500);
insert into test2 values ('helper', 2500);

select *
    from (select job_id, max(salary) from test2
            group by job_id
            union all
          select job_id, min(salary) from test2
            group by job_id
            );
-- �׷� ������� ������, ������ �ٸ���.

drop table test3;
create table test3
(
    col1 number(10)
);
insert into test3 values (0);
insert into test3 values (null);
insert into test3 values (0);
insert into test3 values (null);
insert into test3 values (0);
insert into test3 values (null);

select case a.col1 when null then -1 else 0 end as data from test3 a;


drop table test4;
create table test4
(
    ncol1 number(10),
    ncol2 number(10),
    ncol3 varchar2(10),
    ncol4 varchar2(10)
);

insert into test4 values (1, null, 'a', null);
insert into test4 values (2, 1, 'b', 'a');
insert into test4 values (4, 2, 'd', 'b');
insert into test4 values (5, 4, 'e', 'd');
insert into test4 values (3, 5, 'c', 'a');

select *
    from test4
    start with ncol3 = 'b'
    connect by prior ncol1 = ncol2
        and prior ncol3 = 'b';

select *
    from test4
    start with ncol3 = 'b'
    connect by prior ncol1 = ncol2
        and prior ncol4 = 'b';
        
create table test5
(
    ProductName varchar(10),
    ProductCode varChar(10),
    Price number(10)
);

insert into test5 values ('����', 'A001', 2002);
insert into test5 values ('�����', 'D001', 2000);
insert into test5 values ('å', 'G001', 3020);
insert into test5 values ('����', 'B001', 4000);
insert into test5 values ('�����', 'E001', 5100);
insert into test5 values ('����', 'C001',22000);
insert into test5 values ('å', 'H001', 7100);
insert into test5 values ('�����', 'F001', 8020);

select ProductName, sum(price)
    from test5
--    where ProductName = '����'
    group by rollup(productName);

select ProductName, sum(price)
    from test5
    group by grouping sets(productName, ());


create table test6
    (
    	col1 varchar2(10),
    	col2 varchar2(10),
    	col3 number(10)
    );

insert into test6 values('A', null, 1);
insert into test6 values('B', 'A', 2);
insert into test6 values('C', 'A', 3);
insert into test6 values('D', 'B', 4);

select * from test6
where col3 = 1
start with col3=3
connect by col1 = prior col2;

create table test7
    (
    	BAN number(10),
    	name varchar2(10)
    );
insert into test7 values(1, '조조');
insert into test7 values(1, '조조');
insert into test7 values(1, '조조');
insert into test7 values(2, '여포');
insert into test7 values(2, '유비');
insert into test7 values(3, '관우');
insert into test7 values(3, '관우');

select ban, count(1) as result
from test7
group by ban;

create table test8
    (
    	memberID number(10),
    	Name varchar2(10)
    );

insert into test8 values(null, '조조');
insert into test8 values(2, '여포');
insert into test8 values(3, '관우');
insert into test8 values(4, '장비');
insert into test8 values(5, '조운');
insert into test8 values(null, '유비');


create table test20 (col1 number(10));
insert into test20 values(1);
insert into test20 values(4);
savepoint sv1;
update test20 set col1=8 where col1=2;
savepoint sv1;
delete test20 where col1 >=2;
rollback to sv1;
insert into test20 values(3);
select max(col1) from test20;