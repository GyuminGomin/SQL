-- DCL (Data Control Language)

drop table dept;
drop table emp;
select * from dept;
select * from emp; -- �׽�Ʈ �غ� �� �ִ� ���

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
insert into emp values(102, '����', 3000, '1000', sysdate);
insert into emp values(103, '�������', 4000, '1001', sysdate);
insert into emp values(104, '����', 5000, '1000', sysdate);
insert into emp values(105, '����', 6000, '1001', sysdate);

-- <GRANT>
---- grant���� db ����ڿ��� ������ �ο���.
---- db ����� ���ؼ��� ������ �ʿ��ϸ� ����, �Է�, ����, ����, ��ȸ�� �� �� ����.
-- privileges(����)
---- select : ������ ���̺� ���� select ������ �ο��Ѵ�.
---- insert : ������ ���̺� ���� insert ������ �ο��Ѵ�.
---- update : ������ ���̺� ���� update ������ �ο��Ѵ�.
---- delete : ������ ���̺� ���� delete ������ �ο��Ѵ�.
---- references : ������ ���̺��� �����ϴ� ���������� �����ϴ� ������ �ο��Ѵ�.
---- alter : ������ ���̺� ���� ������ �� �ִ� ������ �ο��Ѵ�.
---- index : ������ ���̺� ���� �ε����� ������ �� �ִ� ������ �ο��Ѵ�.
---- all : ���̺� ���� ��� ������ �ο��Ѵ�.
-- create user c##gyumin identified by "1234"; (oracle 12c ���� ���ʹ� ���̵� �տ� c##�� �ٿ���� ���� �ȶ�)
grant select, insert, update, delete
    on emp
    to c##gyumin;
    
-- with grant option�� admin option
---- with grant option : Ư�� ����ڿ��� ������ �ο��� �� �ִ� ������ �ο��Ѵ�.
---- ������ A ����ڰ� B�� �ο��ϰ� B�� �ٽ� C�� �ο��� �Ŀ� ������ ����ϸ�(Reboke) ��� ������ ȸ���ȴ�.
---- with admin option : ���̺� ���� ��� ������ �ο��Ѵ�.
---- ������ A ����ڰ� B�� �ο��ϰ� B�� �ٽ� C�� �ο��� �Ŀ� ������ ���(Revoke)�ϸ� B ����� ���Ѹ� ��ҵȴ�.
grant select, insert, update, delete
    on emp
    to c##gyumin with grant option;

-- <REBOKE ��>
---- db ����ڿ��� �ο��� ������ ȸ���Ѵ�.
---- revoke privileges on object from user;



