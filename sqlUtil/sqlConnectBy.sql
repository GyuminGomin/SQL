-- sqlConnectBy
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- �׽�Ʈ �غ� �� �ִ� ���

create table dept(
    deptno number(10) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '�λ���');
insert into dept values ('1001', '�ѹ���');
insert into dept values ('1002', 'IT��');
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

-- <Connect By>
---- Tree ������ ������ ���Ǹ� �����ϴ� ������ START WITH���� ���� ������ �ǹ��ϰ� Connect by prior�� ���� ���� root ���κ��� ���� ����� ���Ǹ� ����
---- ������ ��ȸ���� Max(level)���� �̿��Ͽ� �ִ� ���� ���� ���� �� ����. ��, ������ �������� ������ LeafNode�� ���� ���� ����.
select max(level)
    from system.emp
    start with mgr is null
    connect by prior empno = mgr;
    
select level, empno, mgr, ename
    from emp
    start with mgr is null
    connect by prior empno = mgr;
---- ���� ������ empno�� mgr Į�� ��� �����ȣ�� �ԷµǾ� �ִ�.
---- ������ mgr�� ������ �����ȣ�� ���� �ִ�. �� 1000���� 1001, 1002�� ������� �����Ѵ�.

---- ������ ��ȸ ����� ��Ȯ�� ���� ���� LPAD �Լ��� ��� ����
select level, lpad(' ',4 * (level -1) ) ||empno, mgr, connect_by_isleaf
    from emp
    start with mgr is null
    connect by prior empno = mgr;
    
-- connect by Ű����
---- level : �˻� �׸��� ���̸� �ǹ��Ѵ�. ��, ������������ ���� ���� ������ 1�� �ȴ�.
---- connect_by_root : ���� �������� ���� �ֻ��� ���� ǥ���Ѵ�.
---- connect_by_isleaf : ���� �������� ���� �������� ǥ���Ѵ�.
---- sys_connect_by_path : ���� ������ ��ü ���� ��θ� ǥ���Ѵ�.
---- nocycle : ��ȯ ������ �߻����������� �����ȴ�.
---- connect_by_iscycle : ��ȯ ���� �߻� ������ ǥ���Ѵ�.

---- connect by���� ������ ��ȸ�� ������ ��ȸ�� �ִ�. ������ ��ȸ�� �θ� ����Ƽ�κ��� �ڽ� ����Ƽ�� ã�ư��� �˻��� �ǹ��ϰ�, ������ ��ȸ�� �ڽ� ����Ƽ�κ��� �θ� ����Ƽ�� ã�ư��� �˻��̴�.

-- ������ ��ȸ
---- start with ���� : ���� ������ ���� ��ġ�� �����ϴ� ���̴�.
---- prior �ڽ� = �θ� : �θ𿡼� �ڽĹ������� �˻��� �����ϴ� ������ �����̴�.
---- prior �θ� = �ڽ� : �ڽĿ��� �θ�������� �˻��� �����ϴ� ������ �����̴�.
---- nocycle : �����͸� �����ϸ鼭 �̹� ��ȸ�� �����͸� �ٽ� ��ȸ�ϸ� cycle�� �����ȴ�. �̶� nocycle�� ����Ŭ�� �߻����� �ʰ� �Ѵ�.
---- order siblings by Į���� : ������ level�� ������� ���̿��� ������ �����Ѵ�.
select level, lpad(' ', 4*(level-1)) || empno, mgr, connect_by_isleaf isleaf
    from emp
    start with mgr is null
    connect by prior empno = mgr;
select level, lpad(' ', 4*(level-1)) || empno, mgr, connect_by_isleaf isleaf
    from emp
    start with empno = 1007
    connect by prior mgr = empno;