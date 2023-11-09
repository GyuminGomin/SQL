-- Group Function

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

-- <ROLLUP>
---- rollup�� group by�� Į���� ���ؼ� subtotal�� ����� �ش�.
---- rollup�� �� �� group by���� Į���� �� �� �̻� ���� ������ ���� ����� �޶�����.
select decode(deptno, null, '��ü�հ�', deptno), -- deptno�� null�̸� '��ü�հ�' ���ڸ� ���
    sum(sal) 
    from emp
    group by rollup(deptno); -- rollup�� ����ϸ� �μ��� �հ� �� ��ü�հ谡 ���ȴ�.
---- ���� ���� deptno�� ���� group by�� �޿��հ踦 ����ϰ� �μ��� ��ü�հ踦 �߰��ؼ� ����ߴ�. ��, rollup�� deptno�� ���� ���� group by�ʹ� �ٸ��� �μ��� ��ü�հ踦 ����ϰ� ��.
---- decode���� ��ü�հ踦 ��ȸ�� �� '��ü�հ�'��� ���ڸ� ����ϱ� ���� ���. decode���� ����ؼ� deptno�� null�� ������ '��ü�հ�' �ٸ��� deptno�� ���
select deptno, job, sum(sal)
    from emp
    group by rollup(deptno, job);
---- �μ���, ������ rollup�� �����ϸ� �μ��� �հ�, ������ �հ�, ��ü�հ谡 ��� ��ȸ�ȴ�.
---- rollup���� ����Ǵ� Į������ Subtotal�� ����� ��.

-- <Grouping �Լ�>
---- rollup, cube, grouping sets���� �����Ǵ� �հ谪�� �����ϱ� ���� ������� �Լ�
---- ���� ���, �Ұ�, �հ� ���� ���Ǹ� grouping �Լ��� 1�� ��ȯ�ϰ� �׷��� ������ 0�� ��ȯ
select deptno, grouping(deptno), job, grouping(job), sum(sal)
    from emp 
    group by rollup(deptno, job);

select deptno, decode(grouping(deptno), 1, '��ü�հ�') TOT, job,
    decode(grouping(job), 1, '�μ��հ�') T_DEPT, sum(sal)
    from emp
    group by rollup(deptno, job);

-- <GROUPING SETS �Լ�>
---- grouping sets �Լ��� group by�� ������ Į���� ������ ������� �پ��� �Ұ踦 ���� �� ����. (��, ���������� ��� ó����)
select deptno, job, sum(sal)
    from emp
    group by grouping sets(deptno, job);

-- <CUBE �Լ�>
---- cube �Լ��� ������ Į���� ���� ���� ������ ��� ���踦 �����.
---- ������ ���踦 ������ �پ��ϰ� �����͸� �м� ����
---- ���� ���, �μ��� ������ CUBE�� ����ϸ� �μ��� �հ�, ������ �հ�, �μ��� ������ �հ�, ��ü �հ谡 ��ȸ�� (������ �� �ִ� ����� ���� ��� ���յǴ� ��)
select deptno, job, sum(sal)
    from emp
    group by cube(deptno, job);