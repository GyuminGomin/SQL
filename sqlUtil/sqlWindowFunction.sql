-- Window Function
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

-- <window function>
---- 행과 행 간의 관계를 정의하기 위해 제공되는 함수
---- 순위, 합계, 평균, 행 위치 등을 조작할 수 있음.
-- window 함수 구조
---- arguments(인수) : 윈도우 함수에 따라 0~N개의 인수를 설정
---- partition by : 전체 집합을 기준에 의해 소그룹으로 나눔
---- order by : 어떤 항목에 대해 정렬
---- windowing : 행 기준의 범위를 정함, rows는 물리적 결과의 행 수이고 range는 논리적인 값에 의한 범위
-- windowing
---- rows : 부분집합인 윈도우 크기를 물리적 단위로 행의 집합을 지정
---- range : 논리적인 주소에 의해 행 집합을 지정
---- between~and : 윈도우의 시작과 끝의 위치를 지정
---- unbounded preceding : 윈도우의 시작 위치가 첫 번째 행임을 의미
---- unbounded following : 윈도우 마지막 위치가 마지막 행임을 의미
---- current row : 윈도우 시작 위치가 현재 행임을 의미
select empno, ename, sal, 
    sum(sal) over (order by sal
                    rows between unbounded preceding
                        and unbounded following) TOTSAL
    from emp;

select empno, ename, sal,
    sum(sal) over (order by sal
                    rows between unbounded preceding
                        and current row) TOTSAL
    from emp;

select empno, ename, sal,
    sum(sal) over (order by sal
                    rows between current row
                        and unbounded following) TOTSAL
    from emp;

-- <순위 함수(RANK Function)>
-- 순위 관련 윈도우 함수
---- RANK : 특정항목 및 파티션에 대해 순위를 계산, 동일한 순위는 동일한 값이 부여
---- DENSE_RANK : 동일한 순위를 하나의 건수로 계산
---- ROW_NUMBER : 동일한 순위에 대해 고유의 순위를 부여
select ename, sal,
    rank() over (order by sal desc) ALL_RANK, -- sal로 등수를 계산하고 내림차순으로 조회
    rank() over (partition by job order by sal desc) JOB_RANK  -- job으로 파티션을 만들고, job별 순위 조회
from emp;

select ename, sal,
    rank() over (order by sal desc) ALL_RANK,
    dense_rank() over (order by sal desc) DENSE_RANK -- 동일한 순위는 하나의 건수로 인식하여 조회
from emp;

select ename, sal,
    rank() over (order by sal desc) ALL_RANK,
    row_number() over (order by sal desc) ROW_NUMBER
from emp;

-- <집계 함수(aggregate function)>
---- 윈도우 함수를 제공
-- 집계 관련 윈도우 함수
---- sum : 파티션 별로 합계를 계산
---- avg : 파티션 별로 평균을 계산
---- count : 파티션 별로 행 수를 계산
---- max와 min : 파티션 별로 최댓값과 최솟값을 계산
select ename, sal,
    sum(sal) over (partition by mgr) SUM_MGR
    from emp;

-- <행 순서 관련 함수>
---- 상위 행의 값을 하위에 출력하거나하위 행의 값을 상위 행에 출력할 수 있음.
---- 특정 위치의 행을 출력할 수 있음.
-- 행 순서 관련 윈도우 함수
---- first_value : 파티션에서 가장 처음 나오는 값을 구함, min함수를 사용해 같은 결과를 구할 수 있음
---- last_value : 파티션에서 가장 나중에 나오는 값을 구함, max 함수를 사용해 같은 결과를 구할 수 있음.
---- lag : 이전 행을 가지고 옴.
---- lead : 윈도우에서 특정 위치의 행을 가지고 옴, 기본값은 1
select deptno, ename, sal,
    first_value(ename) over (partition by deptno order by sal desc rows unbounded preceding) as DEPT_A
    from emp;

select deptno, ename, sal,
    last_value(ename) over (partition by deptno order by sal desc rows between current row and unbounded following) as DEPT_A
    from emp;

select deptno, ename, sal,
    lag(sal) over (order by sal desc) as PRE_SAL
    from emp;

select deptno, ename, sal,
    lead(sal, 2) over (order by sal desc) as PRE_SAL
    from emp;
    
-- <비율 관련 함수>
---- 누적 백분율, 순서별 백분율, 파티션을 N분으로 분할한 결과 등을 조회할 수 있음.
-- 비율 관련 윈도우 함수
---- cume_dist : 파티션 전체 건수에서 현재 행보다 작거나 같은 건수에 대한 누적 백분율을 조회 한다, 누적 분포상에 위치를 0~1 사이의 값을 가짐.
---- percent_rank : 파티션에서 제일 먼저 나온 것을 0으로 제일 늦게 나온 것을 1로 하여 값이 아닌 행의 순서별 백분율을 조회
---- ntile : 파티션별로 전체 건수를 argument 값으로 n등분한 결과를 조회
---- ratio_to_report : 파티션 내에 전체 sum(칼럼)에 대한 행 별 칼럼값의 백분율을 소수점까지 조회
select deptno, ename, sal,
    percent_rank() over (partition by deptno order by sal desc) as PERCENT_SAL
from emp;

select deptno, ename, sal,
    ntile(4) over(order by sal desc) as N_TILE
    from emp; -- 4개로 분할하지만, 4등분 되지 않을 경우 하나씩 빼는 것