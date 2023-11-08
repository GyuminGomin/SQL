-- DCL (Data Control Language)

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

-- <GRANT>
---- grant문은 db 사용자에게 권한을 부여함.
---- db 사용을 위해서는 권한이 필요하며 연결, 입력, 수정, 삭제, 조회를 할 수 있음.
-- privileges(권한)
---- select : 지정된 테이블에 대해 select 권한을 부여한다.
---- insert : 지정된 테이블에 대해 insert 권한을 부여한다.
---- update : 지정된 테이블에 대해 update 권한을 부여한다.
---- delete : 지정된 테이블에 대해 delete 권한을 부여한다.
---- references : 지정된 테이블을 참조하는 제약조건을 생성하는 권한을 부여한다.
---- alter : 지정된 테이블에 대해 수정할 수 있는 권한을 부여한다.
---- index : 지정된 테이블에 대해 인덱스를 생성할 수 있는 권한을 부여한다.
---- all : 테이블에 대한 모든 권한을 부여한다.
-- create user c##gyumin identified by "1234"; (oracle 12c 버전 부터는 아이디 앞에 c##을 붙여줘야 에러 안뜸)
grant select, insert, update, delete
    on emp
    to c##gyumin;
    
-- with grant option과 admin option
---- with grant option : 특정 사용자에게 권한을 부여할 수 있는 권한을 부여한다.
---- 권한을 A 사용자가 B에 부여하고 B가 다시 C를 부여한 후에 권한을 취소하면(Reboke) 모든 권한이 회수된다.
---- with admin option : 테이블에 대한 모든 권한을 부여한다.
---- 권한을 A 사용자가 B에 부여하고 B가 다시 C에 부여한 후에 권한을 취소(Revoke)하면 B 사용자 권한만 취소된다.
grant select, insert, update, delete
    on emp
    to c##gyumin with grant option;

-- <REBOKE 문>
---- db 사용자에게 부여된 권한을 회수한다.
---- revoke privileges on object from user;



