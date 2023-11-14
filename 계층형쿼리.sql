drop table test1;

create table test1
(
부서id number(10),
부서코드 number(10),
상위부서코드 number(10)
);

insert into test1 values(10,50,0);
insert into test1 values(20,400,50);
insert into test1 values(30,150,400);
insert into test1 values(40,200,150);
insert into test1 values(50,250,200);

select *
from test1
where 부서코드 = 400
start with 부서코드 = 50
connect by prior 부서코드 = 상위부서코드;

-- connect by prior 자식 = 부모 : 부모에서부터 자식으로 (순방향)
-- connect by prior 부모 = 자식 : 자식에서부터 부모로 (역방향)


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
-- 그래 결과값이 같지만, 순서가 다르다.
