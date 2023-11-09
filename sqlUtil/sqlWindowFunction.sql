-- Window Function
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- �׽�Ʈ �غ� �� �ִ� ���

create table dept(
    deptno number(10) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values (10, '�λ���');
insert into dept values (20, '�ѹ���');
insert into dept values (30, 'IT��');
create table EMP(
    empno number(10) primary key,
    ename varchar2(20),
    deptno number(10),
    mgr number(10),
    job varchar2(20),
    sal number(10)
);
insert into emp values(1000, '�Ӻ���Ʈ', 20, null, 'CLERK', 800);
insert into emp values(1001, '��������', 30, 1000, 'SALESMAN', 1600);
insert into emp values(1002, '����', 30, 1000, 'SALESMAN', 1250);
insert into emp values(1003, '�������', 20, 1000, 'MANAGER', 2975);
insert into emp values(1004, '����', 30, 1000, 'SALESMAN', 1250);
insert into emp values(1005, '����', 30, 1001, 'MANAGER', 2850);
insert into emp values(1006, '����', 10, 1001, 'MANAGER', 2450);
insert into emp values(1007, '����', 20, 1006, 'PRESIDENT', 5000);
insert into emp values(1008, '���', 30, 1002, 'SALESMAN', 1500);
insert into emp values(1009, '����', 20, 1002, 'CLERK', 1100);
insert into emp values(1010, '��Ȳ', 30, 1001, 'CLERK', 950);
insert into emp values(1011, '����', 20, 1000, 'ANALYST', 3000);
insert into emp values(1012, '��������', 10, 1000, 'CLERK', 1300);

-- <window function>
---- ��� �� ���� ���踦 �����ϱ� ���� �����Ǵ� �Լ�
---- ����, �հ�, ���, �� ��ġ ���� ������ �� ����.
-- window �Լ� ����
---- arguments(�μ�) : ������ �Լ��� ���� 0~N���� �μ��� ����
---- partition by : ��ü ������ ���ؿ� ���� �ұ׷����� ����
---- order by : � �׸� ���� ����
---- windowing : �� ������ ������ ����, rows�� ������ ����� �� ���̰� range�� ������ ���� ���� ����
-- windowing
---- rows : �κ������� ������ ũ�⸦ ������ ������ ���� ������ ����
---- range : ������ �ּҿ� ���� �� ������ ����
---- between~and : �������� ���۰� ���� ��ġ�� ����
---- unbounded preceding : �������� ���� ��ġ�� ù ��° ������ �ǹ�
---- unbounded following : ������ ������ ��ġ�� ������ ������ �ǹ�
---- current row : ������ ���� ��ġ�� ���� ������ �ǹ�
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

-- <���� �Լ�(RANK Function)>
-- ���� ���� ������ �Լ�
---- RANK : Ư���׸� �� ��Ƽ�ǿ� ���� ������ ���, ������ ������ ������ ���� �ο�
---- DENSE_RANK : ������ ������ �ϳ��� �Ǽ��� ���
---- ROW_NUMBER : ������ ������ ���� ������ ������ �ο�
select ename, sal,
    rank() over (order by sal desc) ALL_RANK, -- sal�� ����� ����ϰ� ������������ ��ȸ
    rank() over (partition by job order by sal desc) JOB_RANK  -- job���� ��Ƽ���� �����, job�� ���� ��ȸ
from emp;

select ename, sal,
    rank() over (order by sal desc) ALL_RANK,
    dense_rank() over (order by sal desc) DENSE_RANK -- ������ ������ �ϳ��� �Ǽ��� �ν��Ͽ� ��ȸ
from emp;

select ename, sal,
    rank() over (order by sal desc) ALL_RANK,
    row_number() over (order by sal desc) ROW_NUMBER
from emp;

-- <���� �Լ�(aggregate function)>
---- ������ �Լ��� ����
-- ���� ���� ������ �Լ�
---- sum : ��Ƽ�� ���� �հ踦 ���
---- avg : ��Ƽ�� ���� ����� ���
---- count : ��Ƽ�� ���� �� ���� ���
---- max�� min : ��Ƽ�� ���� �ִ񰪰� �ּڰ��� ���
select ename, sal,
    sum(sal) over (partition by mgr) SUM_MGR
    from emp;

-- <�� ���� ���� �Լ�>
---- ���� ���� ���� ������ ����ϰų����� ���� ���� ���� �࿡ ����� �� ����.
---- Ư�� ��ġ�� ���� ����� �� ����.
-- �� ���� ���� ������ �Լ�
---- first_value : ��Ƽ�ǿ��� ���� ó�� ������ ���� ����, min�Լ��� ����� ���� ����� ���� �� ����
---- last_value : ��Ƽ�ǿ��� ���� ���߿� ������ ���� ����, max �Լ��� ����� ���� ����� ���� �� ����.
---- lag : ���� ���� ������ ��.
---- lead : �����쿡�� Ư�� ��ġ�� ���� ������ ��, �⺻���� 1
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
    
-- <���� ���� �Լ�>
---- ���� �����, ������ �����, ��Ƽ���� N������ ������ ��� ���� ��ȸ�� �� ����.
-- ���� ���� ������ �Լ�
---- cume_dist : ��Ƽ�� ��ü �Ǽ����� ���� �ຸ�� �۰ų� ���� �Ǽ��� ���� ���� ������� ��ȸ �Ѵ�, ���� ������ ��ġ�� 0~1 ������ ���� ����.
---- percent_rank : ��Ƽ�ǿ��� ���� ���� ���� ���� 0���� ���� �ʰ� ���� ���� 1�� �Ͽ� ���� �ƴ� ���� ������ ������� ��ȸ
---- ntile : ��Ƽ�Ǻ��� ��ü �Ǽ��� argument ������ n����� ����� ��ȸ
---- ratio_to_report : ��Ƽ�� ���� ��ü sum(Į��)�� ���� �� �� Į������ ������� �Ҽ������� ��ȸ
select deptno, ename, sal,
    percent_rank() over (partition by deptno order by sal desc) as PERCENT_SAL
from emp;

select deptno, ename, sal,
    ntile(4) over(order by sal desc) as N_TILE
    from emp; -- 4���� ����������, 4��� ���� ���� ��� �ϳ��� ���� ��