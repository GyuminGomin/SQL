-- index
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- 테스트 해볼 수 있는 행들

create table dept(
    deptno number(10) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values (10, '인사팀');
insert into dept values (20, '총무팀');
insert into dept values (30, 'IT팀');
create table EMP(
    empno number(10) primary key,
    ename varchar2(20),
    deptno number(10),
    mgr number(10),
    job varchar2(20),
    sal number(10)
);
insert into emp values(1000, '임베스트', 20, null, 'CLERK', 800);
insert into emp values(1001, '을지문덕', 30, 1000, 'SALESMAN', 1600);
insert into emp values(1002, '조조', 30, 1000, 'SALESMAN', 1250);
insert into emp values(1003, '세종대왕', 20, 1000, 'MANAGER', 2975);
insert into emp values(1004, '맹자', 30, 1000, 'SALESMAN', 1250);
insert into emp values(1005, '공자', 30, 1001, 'MANAGER', 2850);
insert into emp values(1006, '유비', 10, 1001, 'MANAGER', 2450);
insert into emp values(1007, '관우', 20, 1006, 'PRESIDENT', 5000);
insert into emp values(1008, '장비', 30, 1002, 'SALESMAN', 1500);
insert into emp values(1009, '이이', 20, 1002, 'CLERK', 1100);
insert into emp values(1010, '이황', 30, 1001, 'CLERK', 950);
insert into emp values(1011, '현종', 20, 1000, 'ANALYST', 3000);
insert into emp values(1012, '광개토대왕', 10, 1000, 'CLERK', 1300);

-- <index scan>
-- 인덱스 유일 스캔
select * from emp where empno=1000;
-- 인덱스 범위 스캔
---- 특정 범위를 조회하는 where문을 사용할 경우 발생 (LIKE, BETWEEN) if 데이터 양이 적은 경우 인덱스 자체를 실행하지 않고 TABLE FULL SCAN이 될 수 있음.
---- 인덱스 범위 스캔은 인덱스의 Leaf Block의 특정 범위를 스캔한 것
select empno from emp
    where empno >= 1000;
-- 인덱스 전체 스캔
---- Index Full Scan은 인덱스에서 검색되는 인덱스 키가 많은 경우 Leaf Block의 처음부터 끝까지 전체를 읽어 들인다.
select ename, sal from emp
    where ename like '%' and sal > 0;
---- 일단 전부다 전체 스캔으로 나옴 (데이터의 양이 적어서 그런듯)

-- <실행 계획>
select * from emp, dept
    where emp.deptno = dept.deptno
        and emp.deptno = 10;
   
-- <Optimizer Join>     
-- Nested Loop 조인
---- 하나의 테이블에서 데이터를 먼저 찾고 그 다음 테이블을 조인하는 방식으로 실행
---- 먼저 조회되는 테이블을 Outer Table 이라하고 그다음 조회되는 테이블을 Inner Table이라고 함.
---- 외부 테이블(선행 테이블)의 크기가 작은 것을 먼저 찾는 것이 중요함. (스캔되는 범위를 줄이기 위해)
---- Random Access가 발생하는데, 많이 발생되면 성능 지연이 발생한다.
select /*+ ordered use_nl(b) */ *
    from emp a, dept b
    where a.deptno = b.deptno
        and a.deptno = 10; -- nested join을 사용하려면 use_n(영어 l) 숫자 1이 아님

-- Sort Merge 조인
---- Sort Merge 조인은 두 개의 테이블을 SORT_AREA라는 메모리 공간에 모두 로딩하고 SORT를 수행
---- 두 개의 테이블에 대해 SORT가 완료되면 두 개의 테이블을 병합함.
---- 정렬이 발생하기 때문에 데이터 양이 많아지면 성능 저하
---- 정렬 데이터양이 너무 많으면 정렬은 임시 영역에서 수행됨. 임시 영역은 디스크에 있기 때문에 성능이 급격히 저하
select /*+ ordered use_merge(b) */ *
    from emp a, dept b
    where a.deptno = b.deptno
        and a.deptno = 10;
        
-- Hash 조인
---- 두 개의 테이블 중 작은 테이블을 HASH 메모리에 로딩하고 두 개의 테이블의 조인 키를 사용해 해시 테이블을 생성
---- 해시 함수를 사용해 주소를 계산하고 해당 주소를 사용해 테이블을 조인하기 때문에 CPU 연산을 많이 사용
---- 선행 테이블이 충분히 메모리에 로딩되는 크기여야 함
select /*+ ordered use_hash(b) */ *
    from emp a, dept b
    where a.deptno = b.deptno
        and a.deptno = 10;
