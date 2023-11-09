-- Table Partition
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

-- <Partition ���>
---- ��Ƽ���� ��뷮�� ���̺��� �������� ������ ���Ͽ� �и��ؼ� �����Ѵ�.
---- ���̺��� �����Ͱ� ���������� �и��� ������ ���Ͽ� ����Ǹ� �Է�, ����, ����, ��ȸ ������ ���ȴ�.
---- ��Ƽ���� ������ ��Ƽ�� ���� ���������� ������ �� �ִ�. ��, ��Ƽ�� ���� ����ϰ� ������ �����ϸ� ��Ƽ�� ���� �ε��� ������ ����
---- ��Ƽ���� oracle db�� ���� ���� ������ ���̺� �����̽� �� �̵��� ����
---- �����͸� ��ȸ�� �� �������� ������ �ٿ��� ������ ����Ŵ

-- <Range Partition>
---- ���̺��� Į�� �߿��� ���� ������ �������� ���� ���� ��Ƽ������ �����͸� ������ �����ϴ� ��

-- <List Partition>
---- Ư�� ���� �������� �����ϴ� ���

-- <Hash Partition>
---- db ���� �ý����� ���������� �ؽ� �Լ��� ����ؼ� �����͸� ������.
---- ��������� db ���� �ý����� �˾Ƽ� �����ϰ� �����ϴ� ��
---- ����� Hash Partition �̿ܿ��� Composite Partition�� �ִµ�, Composite Partition�� ���� ���� ��Ƽ�� ����� ������ ����ϴ� ��

-- <��Ƽ�� �ε���>
---- 4���� ������ �ε����� ������. ��, ��Ƽ�� Ű�� ����� �ε����� ����� Prefixed Index�� �ش� ��Ƽ�Ǹ� ����ϴ� Local Index ������ ��������.
---- Oracle db�� Grobal Non-Prefixed�� �������� ����.
-- ��Ƽ�� �ε���
---- Global Index : ���� ���� ��Ƽ�ǿ��� �ϳ��� �ε����� ���
---- Local Index : �ش� ��Ƽ�� ���� ������ �ε����� ���
---- Prefixed Index : ��Ƽ�� Ű�� �ε��� Ű�� ����
---- Non Prefixed Index : ��Ƽ�� Ű�� �ε��� Ű�� �ٸ�