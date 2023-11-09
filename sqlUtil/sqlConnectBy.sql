-- sqlConnectBy
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- 테스트 해볼 수 있는 행들

create table dept(
    deptno number(10) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '인사팀');
insert into dept values ('1001', '총무팀');
insert into dept values ('1002', 'IT팀');
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

-- <Connect By>
---- Tree 형태의 구조로 질의를 수행하는 것으로 START WITH구는 시작 조건을 의미하고 Connect by prior는 조인 조건 root 노드로부터 하위 노드의 질의를 수행
---- 계층형 조회에서 Max(level)값을 이용하여 최대 계층 수를 구할 수 있음. 즉, 계층형 구조에서 마지막 LeafNode의 계층 값을 구함.
select max(level)
    from system.emp
    start with mgr is null
    connect by prior empno = mgr;
    
select level, empno, mgr, ename
    from emp
    start with mgr is null
    connect by prior empno = mgr;
---- 위의 예에서 empno과 mgr 칼럼 모두 사원번호가 입력되어 있다.
---- 하지만 mgr은 관리자 사원번호를 갖고 있다. 즉 1000번은 1001, 1002의 사원등을 관리한다.

---- 계층형 조회 결과를 명확히 보기 위해 LPAD 함수를 사용 가능
select level, lpad(' ',4 * (level -1) ) ||empno, mgr, connect_by_isleaf
    from emp
    start with mgr is null
    connect by prior empno = mgr;
    
-- connect by 키워드
---- level : 검색 항목의 깊이를 의미한다. 즉, 계층구조에서 가장 상위 레벨이 1이 된다.
---- connect_by_root : 계층 구조에서 가장 최상위 값을 표시한다.
---- connect_by_isleaf : 계층 구조에서 가장 최하위를 표시한다.
---- sys_connect_by_path : 계층 구조의 전체 전개 경로를 표시한다.
---- nocycle : 순환 구조가 발생지점까지만 전개된다.
---- connect_by_iscycle : 순환 구조 발생 지점을 표시한다.

---- connect by구는 순방향 조회와 역방향 조회가 있다. 순방향 조회는 부모 엔터티로부터 자식 엔터티를 찾아가는 검색을 의미하고, 역방향 조회는 자식 엔터티로부터 부모 엔터티를 찾아가는 검색이다.

-- 계층형 조회
---- start with 구문 : 계층 전개의 시작 위치를 지정하는 것이다.
---- prior 자식 = 부모 : 부모에서 자식방향으로 검색을 수행하는 순방향 전개이다.
---- prior 부모 = 자식 : 자식에서 부모방향으로 검색을 수행하는 역방향 전개이다.
---- nocycle : 데이터를 전개하면서 이미 조회된 데이터를 다시 조회하면 cycle이 형성된다. 이때 nocycle은 사이클이 발생되지 않게 한다.
---- order siblings by 칼럼명 : 동일한 level인 형제노드 사이에서 정렬을 수행한다.
select level, lpad(' ', 4*(level-1)) || empno, mgr, connect_by_isleaf isleaf
    from emp
    start with mgr is null
    connect by prior empno = mgr;
select level, lpad(' ', 4*(level-1)) || empno, mgr, connect_by_isleaf isleaf
    from emp
    start with empno = 1007
    connect by prior mgr = empno;