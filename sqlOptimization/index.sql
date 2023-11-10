-- index
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

-- <index scan>
-- �ε��� ���� ��ĵ
select * from emp where empno=1000;
-- �ε��� ���� ��ĵ
---- Ư�� ������ ��ȸ�ϴ� where���� ����� ��� �߻� (LIKE, BETWEEN) if ������ ���� ���� ��� �ε��� ��ü�� �������� �ʰ� TABLE FULL SCAN�� �� �� ����.
---- �ε��� ���� ��ĵ�� �ε����� Leaf Block�� Ư�� ������ ��ĵ�� ��
select empno from emp
    where empno >= 1000;
-- �ε��� ��ü ��ĵ
---- Index Full Scan�� �ε������� �˻��Ǵ� �ε��� Ű�� ���� ��� Leaf Block�� ó������ ������ ��ü�� �о� ���δ�.
select ename, sal from emp
    where ename like '%' and sal > 0;
---- �ϴ� ���δ� ��ü ��ĵ���� ���� (�������� ���� ��� �׷���)

-- <���� ��ȹ>
select * from emp, dept
    where emp.deptno = dept.deptno
        and emp.deptno = 10;
   
-- <Optimizer Join>     
-- Nested Loop ����
---- �ϳ��� ���̺��� �����͸� ���� ã�� �� ���� ���̺��� �����ϴ� ������� ����
---- ���� ��ȸ�Ǵ� ���̺��� Outer Table �̶��ϰ� �״��� ��ȸ�Ǵ� ���̺��� Inner Table�̶�� ��.
---- �ܺ� ���̺�(���� ���̺�)�� ũ�Ⱑ ���� ���� ���� ã�� ���� �߿���. (��ĵ�Ǵ� ������ ���̱� ����)
---- Random Access�� �߻��ϴµ�, ���� �߻��Ǹ� ���� ������ �߻��Ѵ�.
select /*+ ordered use_nl(b) */ *
    from emp a, dept b
    where a.deptno = b.deptno
        and a.deptno = 10; -- nested join�� ����Ϸ��� use_n(���� l) ���� 1�� �ƴ�

-- Sort Merge ����
---- Sort Merge ������ �� ���� ���̺��� SORT_AREA��� �޸� ������ ��� �ε��ϰ� SORT�� ����
---- �� ���� ���̺� ���� SORT�� �Ϸ�Ǹ� �� ���� ���̺��� ������.
---- ������ �߻��ϱ� ������ ������ ���� �������� ���� ����
---- ���� �����;��� �ʹ� ������ ������ �ӽ� �������� �����. �ӽ� ������ ��ũ�� �ֱ� ������ ������ �ް��� ����
select /*+ ordered use_merge(b) */ *
    from emp a, dept b
    where a.deptno = b.deptno
        and a.deptno = 10;
        
-- Hash ����
---- �� ���� ���̺� �� ���� ���̺��� HASH �޸𸮿� �ε��ϰ� �� ���� ���̺��� ���� Ű�� ����� �ؽ� ���̺��� ����
---- �ؽ� �Լ��� ����� �ּҸ� ����ϰ� �ش� �ּҸ� ����� ���̺��� �����ϱ� ������ CPU ������ ���� ���
---- ���� ���̺��� ����� �޸𸮿� �ε��Ǵ� ũ�⿩�� ��
select /*+ ordered use_hash(b) */ *
    from emp a, dept b
    where a.deptno = b.deptno
        and a.deptno = 10;
