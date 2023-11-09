-- Group Function

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

-- <ROLLUP>
---- rollup은 group by의 칼럼에 대해서 subtotal을 만들어 준다.
---- rollup을 할 때 group by구에 칼럼이 두 개 이상 오면 순서에 따라서 결과가 달라진다.
select decode(deptno, null, '전체합계', deptno), -- deptno가 null이면 '전체합계' 문자를 출력
    sum(sal) 
    from emp
    group by rollup(deptno); -- rollup을 사용하면 부서별 합계 및 전체합계가 계산된다.
---- 위의 예는 deptno에 대해 group by로 급여합계를 계산하고 부서별 전체합계를 추가해서 계산했다. 즉, rollup은 deptno에 대해 기존 group by와는 다르게 부서별 전체합계를 계산하게 됨.
---- decode문은 전체합계를 조회할 때 '전체합계'라는 문자를 출력하기 위해 사용. decode문을 사용해서 deptno가 null과 같으면 '전체합계' 다르면 deptno을 출력
select deptno, job, sum(sal)
    from emp
    group by rollup(deptno, job);
---- 부서별, 직업별 rollup을 실행하면 부서별 합계, 직업별 합계, 전체합계가 모두 조회된다.
---- rollup으로 실행되는 칼럼별로 Subtotal을 만들어 줌.

-- <Grouping 함수>
---- rollup, cube, grouping sets에서 생성되는 합계값을 구분하기 위해 만들어진 함수
---- 예를 들어, 소계, 합계 등이 계산되면 grouping 함수는 1을 반환하고 그렇지 않으면 0을 반환
select deptno, grouping(deptno), job, grouping(job), sum(sal)
    from emp 
    group by rollup(deptno, job);

select deptno, decode(grouping(deptno), 1, '전체합계') TOT, job,
    decode(grouping(job), 1, '부서합계') T_DEPT, sum(sal)
    from emp
    group by rollup(deptno, job);

-- <GROUPING SETS 함수>
---- grouping sets 함수는 group by에 나오는 칼럼의 순서와 관계없이 다양한 소계를 만들 수 있음. (즉, 개별적으로 모두 처리함)
select deptno, job, sum(sal)
    from emp
    group by grouping sets(deptno, job);

-- <CUBE 함수>
---- cube 함수에 제시한 칼럼에 대해 결합 가능한 모든 집계를 계산함.
---- 다차원 집계를 제공해 다양하게 데이터를 분석 가능
---- 예를 들어, 부서와 직업을 CUBE로 사용하면 부서별 합계, 직업별 합계, 부서별 직업별 합계, 전체 합계가 조회됨 (조합할 수 있는 경우의 수가 모두 조합되는 것)
select deptno, job, sum(sal)
    from emp
    group by cube(deptno, job);