-- Table Partition
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

-- <Partition 기능>
---- 파티션은 대용량의 테이블을 여러개의 데이터 파일에 분리해서 저장한다.
---- 테이블의 데이터가 물리적으로 분리된 데이터 파일에 저장되면 입력, 수정, 삭제, 조회 성능이 향상된다.
---- 파티션은 각각의 파티션 별로 독립적으로 관리될 수 있다. 즉, 파티션 별로 백업하고 복구가 가능하면 파티션 전용 인덱스 생성도 가능
---- 파티션은 oracle db의 논리적 관리 단위인 테이블 스페이스 간 이동이 가능
---- 데이터를 조회할 때 데이터의 범위를 줄여서 성능을 향상시킴

-- <Range Partition>
---- 테이블의 칼럼 중에서 값의 범위를 기준으로 여러 개의 파티션으로 데이터를 나누어 저장하는 것

-- <List Partition>
---- 특정 값을 기준으로 분할하는 방법

-- <Hash Partition>
---- db 관리 시스템이 내부적으로 해시 함수를 사용해서 데이터를 분할함.
---- 결과적으로 db 관리 시스템이 알아서 분할하고 관리하는 것
---- 참고로 Hash Partition 이외에도 Composite Partition이 있는데, Composite Partition은 여러 개의 파티션 기법을 조합해 사용하는 것

-- <파티션 인덱스>
---- 4가지 유형의 인덱스를 제공함. 즉, 파티션 키를 사용해 인덱스를 만드는 Prefixed Index와 해당 파티션만 사용하는 Local Index 등으로 나누어짐.
---- Oracle db는 Grobal Non-Prefixed를 지원하지 않음.
-- 파티션 인덱스
---- Global Index : 여러 개의 파티션에서 하나의 인덱스를 사용
---- Local Index : 해당 파티션 별로 각자의 인덱스를 사용
---- Prefixed Index : 파티션 키와 인덱스 키가 동일
---- Non Prefixed Index : 파티션 키와 인덱스 키가 다름