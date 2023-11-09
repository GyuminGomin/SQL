-- join
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- 테스트 해볼 수 있는 행들

create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '인사팀');
insert into dept values ('1001', '총무팀');
insert into dept values ('1002', 'IT팀');
create table EMP(
    empno number(10),
    ename varchar2(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date default sysdate,
    constraint emppk primary key(empno)
/*    constraint deptfk foreign key(deptno)
                    references dept(deptno) -- dept 테이블의 deptno칼럼
                    on delete cascade -- 자신이 참조하고 있는 테이블의 데이터가 삭제되면 자동으로 자신도 삭제 (참조 무결성 준수가능)
*/
);
insert into emp values(100, '임베스트', 1000, '1000', sysdate);
insert into emp values(101, '을지문덕', 2500, '1001', sysdate);
insert into emp values(102, '조조', 3000, '1002', sysdate);
insert into emp values(103, '세종대왕', 4500, '1000', sysdate);
insert into emp values(104, '맹자', 5000, '1001', sysdate);
insert into emp values(105, '공자', 6500, '1002', sysdate);

-- <EquiJoin>
---- 해시조인은 equi join만 사용 가능
select * from emp, dept
    where emp.deptno = dept.deptno;

select * from emp, dept
    where emp.deptno = dept.deptno
        and emp.ename like '임%'
    order by ename;

-- <InnerJoin>
select * from emp
    inner join dept on emp.deptno = dept.deptno;
    
select * from emp
    inner join dept on emp.deptno = dept.deptno
        and emp.ename like '임%'
    order by ename;

-- <Intersect 연산>
---- 두 개의 테이블에서 교집합 조회
select deptno from emp
    intersect
select deptno from dept;

-- <Non-EQUI(비등가) Join>
---- =를 사용하지 않고, >, <, >=, <= 등을 사용

-- <OUTER JOIN>
---- 두 개의 테이블 간 교집합(EQUI JOIN)을 조회하고 한쪽 테이블에만 있는 데이터도 포함시켜 조회
---- Oracle db에선 OUTER JOIN할 때, (+)기호를 사용 가능
select * from dept, emp
    where emp.deptno (+)= dept.deptno;
-- LEFT OUTER JOIN과 RIGHT OUTER JOIN
---- LEFT OUTER JOIN은 두 개의 테이블에서 같은 것을 조회하고 왼쪽 테이블에만 있는 것을 포함해서 조회
insert into dept values ('1003', '관리팀');
select * from dept
    left outer join emp
        on emp.deptno = dept.deptno;
---- RIGHT OUTER JOIN은 두 개의 테이블에서 같은 것을 조회하고 오른쪽 테이블에만 있는 것을 포함해서 조회
insert into emp values (106, '유비', 7600, '1004', sysdate);
select * from dept
    right outer join emp
        on emp.deptno = dept.deptno;

-- CROSS JOIN
---- 조인 조건구 없이 2개의 테이블을 하나로 조인
---- 조인구가 없기 때문에 카테시안 곱(곱집합)이 발생한다.
---- 예를 들어, 행 14개있는 테이블과 행 4개 있는 테이블을 조인하면 14x4 = 56개의 행이 조회
select * from emp cross join dept;
