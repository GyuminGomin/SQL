-- join
drop table dept;
drop table emp;
select * from dept;
select * from emp; -- �׽�Ʈ �غ� �� �ִ� ���

create table dept(
    deptno varchar2(4) primary key,
    deptname varchar2(20));
insert into dept(deptno, deptname) values ('1000', '�λ���');
insert into dept values ('1001', '�ѹ���');
insert into dept values ('1002', 'IT��');
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
insert into emp values(101, '��������', 2500, '1001', sysdate);
insert into emp values(102, '����', 3000, '1002', sysdate);
insert into emp values(103, '�������', 4500, '1000', sysdate);
insert into emp values(104, '����', 5000, '1001', sysdate);
insert into emp values(105, '����', 6500, '1002', sysdate);

-- <EquiJoin>
select * from emp, dept
    where emp.deptno = dept.deptno;

select * from emp, dept
    where emp.deptno = dept.deptno
        and emp.ename like '��%'
    order by ename;

-- <InnerJoin>
select * from emp inner join