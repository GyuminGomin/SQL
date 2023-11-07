-- DML (Data Manipulation Language) (group by문, having문, 내장형 함수)

drop table dept;
drop table emp;
select * from dept;
select * from emp; -- 테스트 해볼 수 있는 행들

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
insert into emp values(102, '조조', 3000, '1000', sysdate);
insert into emp values(103, '세종대왕', 4000, '1001', sysdate);
insert into emp values(104, '맹자', 5000, '1000', sysdate);
insert into emp values(105, '공자', 6000, '1001', sysdate);

-- <group by문>
select deptno, sum(sal)
    from emp
    group by deptno;
-- <having 문>
select deptno, sum(sal)
    from emp
    group by deptno
    having sum(sal) > 10000;
-- 집계 함수 종류
---- count() : 행 수 조회
select count(*)
    from emp;
    
alter table emp
    add (mgr number(10) default 1);
update emp
    set mgr = null
    where empno=105;
select count(mgr)
    from emp; -- null 값을 제외한 행 갯수 출력
---- sum() : 합계 조회
---- avg() : 평균 조회
---- max()와 min() : 최댓값과 최솟값을 계산
---- stddev() : 표준편차 계산
---- variance() : 분산을 계산

-- group by 사용 예제
---- 부서별, 관리자별 급여 평균 계산
select deptno, mgr, avg(sal)
    from emp
    group by deptno, mgr;
---- 직업별, 급여합계 중에 급여합계가 10000이상인 직업
alter table emp
    add (job varchar2(20));
update emp
    set job='무직';
update emp
    set job='sysAdmin'
    where empno <= 102;
update emp
    set job='developer'
    where empno >= 103;
select job, sum(sal)
    from emp
    group by job
    having sum(sal) >= 10000;
---- 사원번호 100~103번의 부서별 급여 합계
select deptno, sum(sal)
    from emp
    where empno between 100 and 103
    group by deptno;
    
-- <select문 실행 순서>
---- from, where, group by, having, select, order by순으로 진행

-- <명시적 형 변환(수동)과 암시적 형변환(자동)>
---- to_number(문자열) : 문자열을 숫자로 변환
---- to_char(숫자 혹은 날짜, [format]) : 숫자 혹은 날짜를 지정된 Format의 문자로 변환
---- to_date(문자열, format) : 문자열을 지정된 format의 날짜형으로 변환
select *
    from emp
    where empno='100'; -- 암시적 형변환 시행

-- <내장형 함수(Built-in Function)>
-- dual 테이블
---- oracle db에 의해 자동으로 생성되는 테이블
---- oracle db 사용자가 임시로 사용할 수 있는 테이블로 내장형 함수를 실행할 때도 사용할 수 있음
---- oracle db의 모든 사용자가 사용할 수 있음.
desc dual;

-- 내장형 함수의 종류
---- dual 테이블에 문자형 내장형 함수를 사용하면 다음과 같음.
---- ASCII 함수는 문자에 대한 ASCII 코드 값을 알려줌.
---- SUBSTR 함수는 지정된 위치의 문자열을 자르는 함수고 LENGTH 함수, LEN 함수는 문자열의 길이를 계산함.
---- LTRIM 함수를 사용하면 문자열의 왼쪽 공백을 자를 수 있음.
---- 함수 중첩 사용도 가능 (LENGTH(LTRIM(' ABC')))
select ascii('a'), substr('abc',1,2), length('A BC'), ltrim(' ABC') ,length(ltrim(' ABC')) -- substr에서 1,2는 1번째 위치부터 2개를 자른다는 의미
    from dual;
-- 문자열 함수
---- ascii(문자) : 문자 혹은 숫자를 ascii 코드값으로 변환
---- chr/char(ascii 코드값) : ascii 코드값을 문자로 변환, 오라클은 chr 사용, ms-sql,mysql은 char 사용
---- substr(문자열, m,n) : 문자열에서 m번째 위치부터 n개를 자른다.
---- concat(문자열1, 문자열2) : 문자열1번과 문자열2번을 결합, oracle은 '||' my-sql은 '+'를 사용 가능
---- lower(문자열) : 영문자를 소문자로 변환
---- upper(문자열) : 영문자를 대문자로 변환
---- length 혹은 len(문자열) : 공백을 포함해서 문자열의 길이를 알려줌.
---- ltrim(문자열, 지정문자) : 왼쪽에서 지정된 문자를 삭제, 지정된 문자를 생략하면 공백을 삭제
---- rtrim(문자열, 지정문자) : 오른쪽에서 지정된 문자를 삭제, 지정된 문자를 생략하면 공백을 삭제
---- trim(문자열, 지정문자) : 양쪽에서 지정된 문자를 삭제, 지정된 문자를 생략하면 공백을 삭제

-- 날짜형 함수(oracle db)
---- sysdate : 오늘의 날짜를 날짜 타입으로 알려줌
---- extract(year from sysdate) : 날짜에서 년,월(month),일(day)을 조회
select sysdate, extract(year from sysdate), to_char(sysdate, 'YYYYMMDD')
    from dual;

-- 숫자형 함수
---- abs(숫자) : 절댓값을 돌려줌
---- sign(숫자) : 양수,0,음수를 구별
---- mod(숫자1, 숫자2) : 숫자1을 숫자2로 나누어 나머지를 계산, %를 사용해도 됨.
---- ceil/ceiling(숫자) : 숫자보다 크거나 같은 최소의 정수를 돌려줌.
---- floor(숫자) : 숫자보다작거나 같은 최대의 정수를 돌려줌.
---- round(숫자, m) : 소수점 m 자리에서 반올림, m의 기본값은 0임
---- trunc(숫자, m) : 소수점 m 자리에서 절삭, m의 기본값은 0임
select abs(-1), sign(10), mod(4, 2), ceil(10.9), floor(10.1), round(10.222,1)
    from dual;

-- <DECODE와 CASE문>
-- decode 문
---- decode문으로 if문을 구현 가능. 즉, 특정 조건이 참이면 A, 거짓이면 B로 응답
select decode (empno, 100, 'TRUE', 'FALSE')
    from emp;

-- case 문
---- case문은 if~then ~else-end의 프로그래밍 언어처럼 조건문을 사용할 수 있음. 조건을 when구에서 사용해 참이면 then, 거짓이면 else구가 실행
select case
    when empno = 100 then 'A'
    when empno = 101 then 'B'
    else 'C'
end
    from emp;
    
-- <ROWNUM과 ROWID>
-- rownum (Oracle은 rownum 사용, sql server는 top문 사용, mysql은 limit구 사용)
------ ex. sql server : select top(10) from emp;  mysql : select * from emp limit 10;
---- rownum은 oracle db의 select문 결과에 대해 논리적인 일련번호를 부여함.
---- rownum은 조회되는 행 수를 제한할 때 많이 사용
---- rownum은 화면에 데이터를 출력할 때 부여되는 논리적 순번임. 만약 rownum을 사용해 페이지 단위 출력을 하기 위해선 인라인 뷰(inline view)를 사용해야 함.
---- inline view는 select문에서 from절에 사용되는 서브쿼리를 의미함. ex. select * from (select * from emp) a;
select * from emp
    where rownum <= 1; -- 한 행 조회
select *
    from (select rownum list, ename
            from emp)
    where list <= 5;

select *
    from (select rownum list, ename
            from emp)
    where list between 5 and 10;

-- rowid
---- rowid는 oracle db내에서 데이터를 구분할 수 있는 유일한 값
---- rowid는 "select rowid, empno from emp"와 같은 select문으로 확인 가능
---- rowid를 통해 데이터가 어떤 데이터 파일, 어느 블록에 저장되어 있는지 알 수 있음
-- rowid 구조
/* 
구조          | 길이    | 설명
오브젝트 번호     1~6     오브젝트 별로 유일한 값을 가지고 있으며, 해당 오브젝트가 속해 있는 값임.
상대 파일 번호    7~9     테이블스페이스에 속해 있는 데이터 파일에 대한 상대 파일번호임.
블록 번호       10~15    데이터 파일 내부에서 어느 블록에 데이터가 있는지 알려줌.
데이터 번호      16~18   데이터 블록에 데이터가 저장되어 있는 순서를 의미함.
*/
select rowid, ename
from emp;

-- <with 구문>
---- with구문은 서브쿼리를 사용해 임시 테이블이나 뷰처럼 사용할 수 있는 구문임.
---- 서브쿼리 블록에 별칭을 지정할 수 있음.
---- 옵티마이저는 sql을 인라인 뷰나 임시 테이블로 판단함.
with viewdata as
    (select * from emp 
    union all
    select * from emp)
select * from viewdata where empno = 100;
    
-- quiz
---- emp 테이블에서 with구문을 사용해 부서번호(deptno)가 1001인 것의 임시 테이블을 만들고 조회하시오.
with w_emp as
    (select * from emp where deptno = '1001')
select * from w_emp;