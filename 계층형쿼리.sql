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
