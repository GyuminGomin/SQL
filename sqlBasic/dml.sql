-- DML (Data Manipulation Language) (insert��, update��, delete��, select�� - alias,distinct,order by, where�� - null, in, between, like)

drop table dept;
drop table emp;
drop table dept_test;
select * from dept;
select * from emp; -- �׽�Ʈ �غ� �� �ִ� ���
desc dept;

create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '�λ���');
insert into dept values ('1001', '�ѹ���');
create table EMP(
    empno number(10),
    ename varchar2(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date default sysdate,
    constraint emppk primary key(empno),
    constraint deptfk foreign key(deptno)
                    references dept(deptno) -- dept ���̺��� deptnoĮ��
                    on delete cascade -- �ڽ��� �����ϰ� �ִ� ���̺��� �����Ͱ� �����Ǹ� �ڵ����� �ڽŵ� ���� (���� ���Ἲ �ؼ�����)
);
insert into emp values(100, '�Ӻ���Ʈ', 1000, '1000', sysdate);
insert into emp values(101, '��������', 2000, '1001', sysdate);

-- select ������ �Է�
create table dept_test(
    deptno varchar2(4) primary key,
    deptname varchar2(20) 
);
insert into dept_test
    select * from dept; -- dept ���̺��� ��� �����͸� ��ȸ��  dept_teble ���̺� �Է�

-- nologging ���
---- �����ͺ��̽��� �����͸� �Է��ϸ� �α����Ͽ� ������ �����.
---- check point��� �̺�Ʈ�� �߻��ϸ� �α������� �����͸� ������ ���Ͽ� ������.
---- Nologging �ɼ��� �α������� ����� �ּ�ȭ���� �Է� �� ������ ����Ű�� ���
---- Buffer Cache��� �޸� ������ �����ϰ� �����.
alter table dept nologging;

-- <update ��>
---- ���� empno = 100�� �����Ͱ� 2�����, 2���� �ٲ�
update emp
    set ename = '����'
    where empno = 100;

-- <delete ��>
---- ���� ������ �������� �ʴ´ٸ�, ��� �� �����Ͱ� ���� (�׷��� ���� �����Ѵٰ� �ؼ� ���̺��� �뷮�� �ʱ�ȭ ������ ����)
delete from emp
    where empno = 100;
delete from emp; -- ���̺��� �뷮 ���� x
truncate table emp; -- ���̺��� �뷮 ���� o ---- ���̺��� ��� ������ ����

-- <select ��>
insert into emp values(100, '�Ӻ���Ʈ', 1000, '1000', sysdate);

-- select �� ���
select *
from emp
where deptno = 1000;
select ename || '��' from emp; -- ename Į���� ��� �� �ڿ� '��'�� �ٿ��� ���

-- order by�� ����� ����
---- order by�� ������ �ϱ� ������, �뷮�� �����͸� �����ϰ� �Ǹ� db�� �޸𸮸� ���� ����ϰ� ��(��������)
---- oracle db�� �޸� ���ο� �Ҵ�� sort_area_size�� ����ϴµ�, ���� sort_area_size�� �۴ٸ�, �������� �߻�
---- default asc(��������)
select * from emp
    order by ename, sal desc;
    
-- index�� ����� ���� ȸ��
---- ������ db�� �޸𸮸� ���� ����ϹǷ�, �ε����� ����� ȸ�� ����
drop table emp;

create table emp(
    empno number(10) primary key,
    ename varchar2(20),
    sal number(10)
);
insert into emp values(1000, '�Ӻ���Ʈ', 20000);
insert into emp values(1001, '����', 20000);
insert into emp values(1002, '����', 20000);

select * from emp;
select /*+INDEX_DESC(a)*/ ---- �ε��� ��Ʈ 
    *
from emp a;
---- /*+ */(��Ƽ���� �ּ�)�� --+ (�̱۶��� �ּ�) ��� �ε��� ��Ʈ�� ��� ����
---- /*+ index({���̺� ��Ī �Ǵ� ���̺� ��} {�ε��� ��}) */
---- +�� ������ �Ϲ� �ּ��̶�� �����ϰ� �ƹ��� �̺�Ʈ�� ����

-- Distinct�� Alias
drop table emp;
drop table dept;
create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '�λ���');
insert into dept values ('1001', '�ѹ���');
create table EMP(
    empno number(10),
    ename varchar2(20),
    sal number(10,2) default 0,
    deptno varchar2(4) not null,
    createdate date default sysdate,
    constraint emppk primary key(empno),
    constraint deptfk foreign key(deptno)
                    references dept(deptno) -- dept ���̺��� deptnoĮ��
                    on delete cascade -- �ڽ��� �����ϰ� �ִ� ���̺��� �����Ͱ� �����Ǹ� �ڵ����� �ڽŵ� ���� (���� ���Ἲ �ؼ�����)
);
insert into emp values(100, '�Ӻ���Ʈ', 1000, '1000', sysdate);
insert into emp values(101, '��������', 2000, '1001', sysdate);
insert into emp values(102, '����', 2000, '1001', sysdate);
insert into emp values(103, '����', 2000, '1001', sysdate);

---- distinct���� Į���� �տ� ������ �ߺ��� �����͸� �� ���� ��ȸ�ϰ� ��.
select deptno from emp order by deptno;
select distinct deptno from emp order by deptno;
---- alias�� ���̺���̳� Į������ �ʹ� �� �����ϰ� �� �� ���
select ename as "�̸�" from emp a
where a.empno=100;

-- <Where�� ���>
-- where���� ����ϴ� ������
select * from emp
where empno = 101
    and sal >= 1000;

-- like�� ���
insert into emp values(105, 'test01', 3000, '1000', sysdate);
insert into emp values(106, 'test02', 3000, '1000', sysdate);

select * from emp
where ename like 'test%';
select * from emp
where ename like '%1';
select * from emp
where ename like '%est%';
select * from emp
where ename like 'test01';
select * from emp
where ename like 'test__';

-- between�� ���
select * from emp
where sal between 1000 and 2000; -- 1000�̻� 2000����

select * from emp
where sal not between 1000 and 2000; -- 1000�̸� 2000�ʰ�

-- in�� ���
---- in���� or�� �ǹ̸� ���� �־�, �ϳ��� ���Ǹ� �����ص� ���
alter table emp
    add (job varchar2(20) default '����');
update emp
    set job = 'clerk'
    where empno < 103;
update emp
    set job = 'manager'
    where empno = 105;
insert into emp values(104, '�������',5000,'1000',sysdate, '����');

select * from emp
where job in ('clerk', 'manager');

select * from emp
where (job, ename) in (('clerk','����'),('manager', 'test01'));

-- null�� ��ȸ
alter table emp
    add (mgr number(10));

select * from emp
where mgr is null;

update emp
    set mgr = 10000
    where empno = 104;

select * from emp
where mgr is not null;
---- null ���� �Լ�
-- nvl �Լ�(oracle) : null�̸� �ٸ� ������ �ٲٴ� �Լ� -> nvl(mgr,0)�� mgr Į���� null�̸� 0���� �ٲ۴�.
-- nvl2 �Լ�(oracle) : nvl �Լ��� decode �Լ��� �ϳ��� ���� �� -> nvl2(mgr, 1, 0)�� mgrĮ���� null�� �ƴϸ� 1��, null�̸� 0�� ��ȯ
-- nullif �Լ�(oracle, ms-sql, mysql) : �� ���� ���� ������ null��, ���� ������ ù��° ���� ��ȯ -> nullif(exp1, exp2)�� exp1�� exp2�� ������ null��, ���������� exp1�� ��ȯ
-- coalesce(oracle, ms-sql) : null�� �ƴ� ������ ���� ���� ��ȯ -> coalesce(exp1, exp2, exp3, ...)�� exp1�� null�� �ƴϸ� exp1�� ����, �׷��� ������ �� ���� ���� null ���θ� �Ǵ��Ͽ� ���� ��ȯ
    
