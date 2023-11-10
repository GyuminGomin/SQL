-- DML (Data Manipulation Language) (insert문, update문, delete문, select문 - alias,distinct,order by, where문 - null, in, between, like)

drop table dept;
drop table emp;
drop table dept_test;
select * from dept;
select * from emp; -- 테스트 해볼 수 있는 행들
desc dept;

create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '인사팀');
insert into dept values ('1001', '총무팀');
create table EMP(
    empno number(10),
    ename varchar2(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date default sysdate,
    constraint emppk primary key(empno),
    constraint deptfk foreign key(deptno)
                    references dept(deptno) -- dept 테이블의 deptno칼럼
                    on delete cascade -- 자신이 참조하고 있는 테이블의 데이터가 삭제되면 자동으로 자신도 삭제 (참조 무결성 준수가능)
);
insert into emp values(100, '임베스트', 1000, '1000', sysdate);
insert into emp values(101, '을지문덕', 2000, '1001', sysdate);

-- select 문으로 입력
create table dept_test(
    deptno varchar2(4) primary key,
    deptname varchar2(20) 
);
insert into dept_test
    select * from dept; -- dept 테이블의 모든 데이터를 조회해  dept_teble 테이블에 입력

-- nologging 사용
---- 데이터베이스에 데이터를 입력하면 로그파일에 정보를 기록함.
---- check point라는 이벤트가 발생하면 로그파일의 데이터를 데이터 파일에 저장함.
---- Nologging 옵션은 로그파일의 기록을 최소화시켜 입력 시 성능을 향상시키는 방법
---- Buffer Cache라는 메모리 영역을 생략하고 기록함.
alter table dept nologging;

-- <update 문>
---- 만약 empno = 100인 데이터가 2개라면, 2개다 바뀜
update emp
    set ename = '조조'
    where empno = 100;

-- <delete 문>
---- 만약 조건을 지정하지 않는다면, 모든 행 데이터가 삭제 (그러나 행을 삭제한다고 해서 테이블의 용량이 초기화 되지는 않음)
delete from emp
    where empno = 100;
delete from emp; -- 테이블의 용량 감소 x
truncate table emp; -- 테이블의 용량 감소 o ---- 테이블의 모든 데이터 삭제

-- <select 문>
insert into emp values(100, '임베스트', 1000, '1000', sysdate);

-- select 문 사용
select *
from emp
where deptno = 1000;
select ename || '님' from emp; -- ename 칼럼의 모든 행 뒤에 '님'을 붙여서 출력

-- order by를 사용한 정렬
---- order by는 정렬을 하기 때문에, 대량의 데이터를 정렬하게 되면 db의 메모리를 많이 사용하게 됨(성능저하)
---- oracle db는 메모리 내부에 할당된 sort_area_size를 사용하는데, 만약 sort_area_size가 작다면, 성능저하 발생
---- default asc(오름차순)
select * from emp
    order by ename, sal desc;
    
-- index를 사용한 정렬 회피
---- 정렬은 db의 메모리를 많이 사용하므로, 인덱스를 사용해 회피 가능
drop table emp;

create table emp(
    empno number(10) primary key,
    ename varchar2(20),
    sal number(10)
);
insert into emp values(1000, '임베스트', 20000);
insert into emp values(1001, '조조', 20000);
insert into emp values(1002, '관우', 20000);

select * from emp;
select /*+INDEX_DESC(a)*/ ---- 인덱스 힌트 
    *
from emp a;
---- /*+ */(멀티라인 주석)과 --+ (싱글라인 주석) 모두 인덱스 힌트를 사용 가능
---- /*+ index({테이블 별칭 또는 테이블 명} {인덱스 명}) */
---- +가 없으면 일반 주석이라고 간주하고 아무런 이벤트가 없음

-- Distinct와 Alias
drop table emp;
drop table dept;
create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '인사팀');
insert into dept values ('1001', '총무팀');
create table EMP(
    empno number(10),
    ename varchar2(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date default sysdate,
    constraint emppk primary key(empno),
    constraint deptfk foreign key(deptno)
                    references dept(deptno) -- dept 테이블의 deptno칼럼
                    on delete cascade -- 자신이 참조하고 있는 테이블의 데이터가 삭제되면 자동으로 자신도 삭제 (참조 무결성 준수가능)
);
insert into emp values(100, '임베스트', 1000, '1000', sysdate);
insert into emp values(101, '을지문덕', 2000, '1001', sysdate);
insert into emp values(102, '조조', 2000, '1001', sysdate);
insert into emp values(103, '유비', 2000, '1001', sysdate);

---- distinct문은 칼럼명 앞에 지정해 중복된 데이터를 한 번만 조회하게 함.
select deptno from emp order by deptno;
select distinct deptno from emp order by deptno;
---- alias는 테이블명이나 칼럼명이 너무 길어서 간략하게 할 때 사용
select ename as "이름" from emp a
where a.empno=100;

-- <Where문 사용>
-- where문이 사용하는 연산자
select * from emp
where empno = 101
    and sal >= 1000;

-- like문 사용
insert into emp values(105, 'test01', 3000, '1000', sysdate);
insert into emp values(106, 'test02', 3000, '1000', sysdate);

select * from emp
where ename like 'test%';
select * from emp
where ename like '%1';
select * from emp
where ename like '%est%';
select * from emp
where ename like 'test01';
select * from emp
where ename like 'test__';

-- between문 사용
select * from emp
where sal between 1000 and 2000; -- 1000이상 2000이하

select * from emp
where sal not between 1000 and 2000; -- 1000미만 2000초과

-- in문 사용
---- in문은 or의 의미를 갖고 있어, 하나의 조건만 만족해도 출력
alter table emp
    add (job varchar2(20) default '무직');
update emp
    set job = 'clerk'
    where empno < 103;
update emp
    set job = 'manager'
    where empno = 105;
insert into emp values(104, '세종대왕',5000,'1000',sysdate, '무직');

select * from emp
where job in ('clerk', 'manager');

select * from emp
where (job, ename) in (('clerk','조조'),('manager', 'test01'));

-- null값 조회
alter table emp
    add (mgr number(10));

select * from emp
where mgr is null;

update emp
    set mgr = 10000
    where empno = 104;

select * from emp
where mgr is not null;
---- null 관련 함수
-- nvl 함수(oracle) : null이면 다른 값으로 바꾸는 함수 -> nvl(mgr,0)은 mgr 칼럼이 null이면 0으로 바꾼다.
-- nvl2 함수(oracle) : nvl 함수와 decode 함수를 하나로 만든 것 -> nvl2(mgr, 1, 0)은 mgr칼럼이 null이 아니면 1을, null이면 0을 반환
-- nullif 함수(oracle, ms-sql, mysql) : 두 개의 값이 같으면 null을, 같지 않으면 첫번째 값을 반환 -> nullif(exp1, exp2)은 exp1과 exp2가 같으면 null을, 같지않으면 exp1을 반환
-- coalesce(oracle, ms-sql) : null이 아닌 최초의 인자 값을 반환 -> coalesce(exp1, exp2, exp3, ...)은 exp1이 null이 아니면 exp1의 값을, 그렇지 않으면 그 뒤의 값의 null 여부를 판단하여 값을 반환
    
