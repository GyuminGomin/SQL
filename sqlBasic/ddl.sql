-- DDL (Data Definition Language) [생성, 변경, 삭제, 뷰]

-- <테이블 생성>
-- 기본적인 테이블 생성
create table EMP(
    empno number(10) primary key,
    ename varchar2(20),
    sal number(6)
);
DESC EMP;
DROP table EMP;

-- 제약조건 사용
create table EMP(
    empno number(10),
    enmae varchar2(20),
    sal number(10,2) default 0, -- (10,2) : 소수점 2째 자리까지 저장
    deptno varchar2(4) not null,
    createdate date default sysdate, -- sysdate : (오늘 날짜 시,분,초)
    constraint emppk primary key(empno) -- constraint : 기본키 지정
);
DROP table EMP;
create table DEPT( -- 부서
    deptno varchar2(4) primary key, 
    deptname varchar2(20));
create table EMP(
    empno number(10),
    ename varchar2(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date default sysdate,
    constraint emppk primary key(empno),
    constraint deptfk foreign key(deptno)
                    references dept(deptno)); -- dept 테이블의 deptno칼럼
DROP Table dept, EMP;

-- 테이블 생성시 CASCADE 사용
create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept values ('1000', '인사팀');
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
delete from dept where deptno = '1000';
select * from emp;

-- <테이블 변경>
-- 테이블 명 변경
alter table emp
    rename to new_emp;

-- 칼럼 추가
alter table new_emp
    add (age number(2) default 1);
    
-- 칼럼 변경
alter table new_emp
    modify (ename varchar2(40) not null);
    
-- 칼럼 삭제
alter table new_emp
    drop column age;
    
-- 칼럼명 변경
alter table new_emp
    rename column ename to new_ename;
    
-- <테이블 삭제>
drop talbe new_emp;
drop table emp cascade constraint; -- 외래키로 참조한 슬레이브 테이블과 관련된 제약사항도 삭제할 때 사용

-- <뷰 생성과 삭제>
-- 뷰는 테이블로부터 유도된 가상의 테이블 (실제 데이터를 갖고 있지 않고, 테이블을 참조해서 원하는 칼럼만을 조회할 수 있게 함.)
-- 뷰는 데이터 딕셔너리(Data Dictionary)에 SQL문 형태로 저장하되 실행 시에 참조됨.
-- 특징
---- 1. 참조한 테이블이 변경되면 뷰도 변경
---- 2. 뷰의 검색은 참조한 테이블과 동일하게 할 수 있지만, 뷰에 대한 입력, 수정, 삭제에는 제약이 있음.
---- 3. 특정 칼럼만 조회시켜서 보안성을 향상시킴.
---- 4. 한번 생성된 뷰는 변경할 수 없고, 변경을 원하면 삭제 후 재생성해야 함.
---- 5. ALTER문을 사용해서 뷰를 변경할 수 없음.
create view t_emp as
    select * from new_emp;
select * from t_emp;
drop view t_emp;
-- 장점
---- 1. 특정 칼럼만 조회할 수 있기 때문에 보안 기능이 있음.
---- 2. 데이터 관리가 간단함.
---- 3. select문이 간단해짐.
---- 4. 하나의 테이블에 여러 개의 뷰를 생성할 수 있음.
-- 단점
---- 1. 뷰는 독자적인 인덱스를 만들 수 없음.
---- 2. 삽입, 수정, 삭제 연산이 제약됨
---- 3. 데이터 구조를 변경할 수 없음.
drop table new_emp;
drop table dept;