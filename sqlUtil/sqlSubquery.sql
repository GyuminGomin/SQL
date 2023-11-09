-- 서브쿼리(Subquery)
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
-- <Main query와 Subquery>
---- Subquery는 SELECT문 내에 다시 SELECT문을 사용하는 SQL문이다.
---- Subquery의 형태는 FROM구에 SELECT문을 사용하는 인라인 뷰(Inline View)와 SELECT문에 Subquery를 사용하는 스칼라 서브쿼리(Scala Subquery) 등이 있다.
---- where구에 select문을 사용하면 서브쿼리 라고 한다.
select *
    from emp
    where deptno =
        (select deptno 
            from dept
            where deptno = 10);
---- from구에 select문을 사용하여 가상의 테이블을 만드는 효과를 얻을 수 있다. (inline view)
select *
    from (select rownum num, ename
            from emp) a
    where num < 5;

-- <단일 행 서브쿼리와 다중 행 서브쿼리>
---- 서브쿼리는 반환하는 행 수가 한 개인 것과 여러 개인 것에 따라 단일 행 서브쿼리와 멀티 행 서브쿼리로 분류된다.
---- 단일 행 서브쿼리는 단 하나의 행만 반환하는 서브쿼리로 비교 연산자(=, <, <=, >=, <>)를 사용함.
---- 다중 행 서브쿼리는 여러 개의 행을 반환하는 것으로 IN, ANY, ALL, EXISTS를 사용해야 한다.
-- 서브쿼리 종류(반환 행)
---- 단일 행 서브쿼리 : 서브쿼리를 실행하면 그 결과는 반드시 한 행만 조회된다.
---- 다중 행 서브쿼리 : 서브쿼리를 실행하면 그 결과는 여러 개의 행이 조회된다.

-- <다중 행 Subquery>
-- 다중 행 비교 연산자
---- IN(Subquery) : Main query의 비교조건이 Subquery의 결과 중 하나만 동일하면 참이 된다.(OR 조건)
---- ALL(Subquery) : Main query와 Subquery의 결과가 모두 동일하면 참이 된다.
    ---- < ALL : 최솟값을 반환
    ---- > ALL : 최댓값을 반환
---- ANY(Subquery) : Main query의 비교조건이 Subquery의 결과 중 하나 이상 동일하면 참이 된다.
    ---- < ANY : 하나라도 크게 되면 참이 된다.
    ---- > ANY : 하나라도 작게 되면 참이 된다.
---- EXISTS(Subquery) : Main query와 Subquery의 결과가 하나라도 존재하면 참이 된다.
-- IN
select ename, deptname, sal
    from emp, dept
    where emp.deptno = dept.deptno
        and emp.empno in 
            (select empno from emp
                where sal > 2000);
-- ALL
select *
    from emp
        where deptno <= ALL (20, 30);
select *
    from emp
        where deptno >= ALL (20, 30);
-- EXISTS
select ename, deptname, sal
    from emp, dept
    where emp.deptno = dept.deptno
        and exists (select 1
                        from emp
                        where sal > 2000);

-- <Scala Subquery>
---- 반드시 한 행과 한 컬럼만 반환하는 서브쿼리
---- 만약 여러 행이 반환되면 오류 발생
select ename as "이름", sal as "급여",
    (select avg(sal) from emp) as "평균급여"
    from emp
    where empno = 1000;
---- 직원 급여를 조회할 때, 평균 급여를 같이 계산하여 조회한다.

-- <Correlated Subquery>
---- Main Query 내의 칼럼을 사용하는 Subquery를 의미
select *
    from emp a
    where a.deptno =
        (select deptno from dept b
            where b.deptno = a.deptno);