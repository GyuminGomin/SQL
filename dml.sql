-- DML (Data Manipulation Language)

-- <insert��>
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- �׽�Ʈ �غ� �� �ִ� ���
-- insert��
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