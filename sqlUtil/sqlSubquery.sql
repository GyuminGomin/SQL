-- ��������(Subquery)
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
-- <Main query�� Subquery>
---- Subquery�� SELECT�� ���� �ٽ� SELECT���� ����ϴ� SQL���̴�.
---- Subquery�� ���´� FROM���� SELECT���� ����ϴ� �ζ��� ��(Inline View)�� SELECT���� Subquery�� ����ϴ� ��Į�� ��������(Scala Subquery) ���� �ִ�.
---- where���� select���� ����ϸ� �������� ��� �Ѵ�.
select *
    from emp
    where deptno =
        (select deptno 
            from dept
            where deptno = 10);
---- from���� select���� ����Ͽ� ������ ���̺��� ����� ȿ���� ���� �� �ִ�. (inline view)
select *
    from (select rownum num, ename
            from emp) a
    where num < 5;

-- <���� �� ���������� ���� �� ��������>
---- ���������� ��ȯ�ϴ� �� ���� �� ���� �Ͱ� ���� ���� �Ϳ� ���� ���� �� ���������� ��Ƽ �� ���������� �з��ȴ�.
---- ���� �� ���������� �� �ϳ��� �ุ ��ȯ�ϴ� ���������� �� ������(=, <, <=, >=, <>)�� �����.
---- ���� �� ���������� ���� ���� ���� ��ȯ�ϴ� ������ IN, ANY, ALL, EXISTS�� ����ؾ� �Ѵ�.
-- �������� ����(��ȯ ��)
---- ���� �� �������� : ���������� �����ϸ� �� ����� �ݵ�� �� �ุ ��ȸ�ȴ�.
---- ���� �� �������� : ���������� �����ϸ� �� ����� ���� ���� ���� ��ȸ�ȴ�.

-- <���� �� Subquery>
-- ���� �� �� ������
---- IN(Subquery) : Main query�� �������� Subquery�� ��� �� �ϳ��� �����ϸ� ���� �ȴ�.(OR ����)
---- ALL(Subquery) : Main query�� Subquery�� ����� ��� �����ϸ� ���� �ȴ�.
    ---- < ALL : �ּڰ��� ��ȯ
    ---- > ALL : �ִ��� ��ȯ
---- ANY(Subquery) : Main query�� �������� Subquery�� ��� �� �ϳ� �̻� �����ϸ� ���� �ȴ�.
    ---- < ANY : �ϳ��� ũ�� �Ǹ� ���� �ȴ�.
    ---- > ANY : �ϳ��� �۰� �Ǹ� ���� �ȴ�.
---- EXISTS(Subquery) : Main query�� Subquery�� ����� �ϳ��� �����ϸ� ���� �ȴ�.
-- IN
select ename, deptname, sal
    from emp, dept
    where emp.deptno = dept.deptno
        and emp.empno in 
            (select empno from emp
                where sal > 2000);
-- ALL
select *
    from emp
        where deptno <= ALL (20, 30);
select *
    from emp
        where deptno >= ALL (20, 30);
-- EXISTS
select ename, deptname, sal
    from emp, dept
    where emp.deptno = dept.deptno
        and exists (select 1
                        from emp
                        where sal > 2000);

-- <Scala Subquery>
---- �ݵ�� �� ��� �� �÷��� ��ȯ�ϴ� ��������
---- ���� ���� ���� ��ȯ�Ǹ� ���� �߻�
select ename as "�̸�", sal as "�޿�",
    (select avg(sal) from emp) as "��ձ޿�"
    from emp
    where empno = 1000;
---- ���� �޿��� ��ȸ�� ��, ��� �޿��� ���� ����Ͽ� ��ȸ�Ѵ�.

-- <Correlated Subquery>
---- Main Query ���� Į���� ����ϴ� Subquery�� �ǹ�
select *
    from emp a
    where a.deptno =
        (select deptno from dept b
            where b.deptno = a.deptno);