-- Minus
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
insert into emp values(107, '유비', 7600, '1003', sysdate);

-- <차집합을 만드는 Minus>
---- 두 개의 테이블에서 차집합을 조회
---- MS-SQL에선 MINUS와 동일한 연산이 EXCEPT다.
select deptno from dept
    minus
select deptno from emp;