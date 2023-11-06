-- DDL (Data Definition Language) [����, ����, ����, ��]

-- <���̺� ����>
-- �⺻���� ���̺� ����
create table EMP(
    empno number(10) primary key,
    ename varchar2(20),
    sal number(6)
);
DESC EMP;
DROP table EMP;

-- �������� ���
create table EMP(
    empno number(10),
    enmae varchar2(20),
    sal number(10,2) default 0, -- (10,2) : �Ҽ��� 2° �ڸ����� ����
    deptno varchar2(4) not null,
    createdate date default sysdate, -- sysdate : (���� ��¥ ��,��,��)
    constraint emppk primary key(empno) -- constraint : �⺻Ű ����
);
DROP table EMP;
create table DEPT( -- �μ�
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
                    references dept(deptno)); -- dept ���̺��� deptnoĮ��
DROP Table dept, EMP;

-- ���̺� ������ CASCADE ���
create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept values ('1000', '�λ���');
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
delete from dept where deptno = '1000';
select * from emp;

-- <���̺� ����>
-- ���̺� �� ����
alter table emp
    rename to new_emp;

-- Į�� �߰�
alter table new_emp
    add (age number(2) default 1);
    
-- Į�� ����
alter table new_emp
    modify (ename varchar2(40) not null);
    
-- Į�� ����
alter table new_emp
    drop column age;
    
-- Į���� ����
alter table new_emp
    rename column ename to new_ename;
    
-- <���̺� ����>
drop talbe new_emp;
drop table emp cascade constraint; -- �ܷ�Ű�� ������ �����̺� ���̺�� ���õ� ������׵� ������ �� ���

-- <�� ������ ����>
-- ��� ���̺�κ��� ������ ������ ���̺� (���� �����͸� ���� ���� �ʰ�, ���̺��� �����ؼ� ���ϴ� Į������ ��ȸ�� �� �ְ� ��.)
-- ��� ������ ��ųʸ�(Data Dictionary)�� SQL�� ���·� �����ϵ� ���� �ÿ� ������.
-- Ư¡
---- 1. ������ ���̺��� ����Ǹ� �䵵 ����
---- 2. ���� �˻��� ������ ���̺�� �����ϰ� �� �� ������, �信 ���� �Է�, ����, �������� ������ ����.
---- 3. Ư�� Į���� ��ȸ���Ѽ� ���ȼ��� ����Ŵ.
---- 4. �ѹ� ������ ��� ������ �� ����, ������ ���ϸ� ���� �� ������ؾ� ��.
---- 5. ALTER���� ����ؼ� �並 ������ �� ����.
create view t_emp as
    select * from new_emp;
select * from t_emp;
drop view t_emp;
-- ����
---- 1. Ư�� Į���� ��ȸ�� �� �ֱ� ������ ���� ����� ����.
---- 2. ������ ������ ������.
---- 3. select���� ��������.
---- 4. �ϳ��� ���̺� ���� ���� �並 ������ �� ����.
-- ����
---- 1. ��� �������� �ε����� ���� �� ����.
---- 2. ����, ����, ���� ������ �����
---- 3. ������ ������ ������ �� ����.
drop table new_emp;
drop table dept;