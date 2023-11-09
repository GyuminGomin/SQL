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
    constraint emppk primary key(empno)
/*    constraint deptfk foreign key(deptno)
                    references dept(deptno) -- dept ���̺��� deptnoĮ��
                    on delete cascade -- �ڽ��� �����ϰ� �ִ� ���̺��� �����Ͱ� �����Ǹ� �ڵ����� �ڽŵ� ���� (���� ���Ἲ �ؼ�����)
*/
);
insert into emp values(100, '�Ӻ���Ʈ', 1000, '1000', sysdate);
insert into emp values(101, '��������', 2500, '1001', sysdate);
insert into emp values(102, '����', 3000, '1002', sysdate);
insert into emp values(103, '�������', 4500, '1000', sysdate);
insert into emp values(104, '����', 5000, '1001', sysdate);
insert into emp values(105, '����', 6500, '1002', sysdate);

-- <EquiJoin>
---- �ؽ������� equi join�� ��� ����
select * from emp, dept
    where emp.deptno = dept.deptno;

select * from emp, dept
    where emp.deptno = dept.deptno
        and emp.ename like '��%'
    order by ename;

-- <InnerJoin>
select * from emp
    inner join dept on emp.deptno = dept.deptno;
    
select * from emp
    inner join dept on emp.deptno = dept.deptno
        and emp.ename like '��%'
    order by ename;

-- <Intersect ����>
---- �� ���� ���̺��� ������ ��ȸ
select deptno from emp
    intersect
select deptno from dept;

-- <Non-EQUI(��) Join>
---- =�� ������� �ʰ�, >, <, >=, <= ���� ���

-- <OUTER JOIN>
---- �� ���� ���̺� �� ������(EQUI JOIN)�� ��ȸ�ϰ� ���� ���̺��� �ִ� �����͵� ���Խ��� ��ȸ
---- Oracle db���� OUTER JOIN�� ��, (+)��ȣ�� ��� ����
select * from dept, emp
    where emp.deptno (+)= dept.deptno;
-- LEFT OUTER JOIN�� RIGHT OUTER JOIN
---- LEFT OUTER JOIN�� �� ���� ���̺��� ���� ���� ��ȸ�ϰ� ���� ���̺��� �ִ� ���� �����ؼ� ��ȸ
insert into dept values ('1003', '������');
select * from dept
    left outer join emp
        on emp.deptno = dept.deptno;
---- RIGHT OUTER JOIN�� �� ���� ���̺��� ���� ���� ��ȸ�ϰ� ������ ���̺��� �ִ� ���� �����ؼ� ��ȸ
insert into emp values (106, '����', 7600, '1004', sysdate);
select * from dept
    right outer join emp
        on emp.deptno = dept.deptno;

-- CROSS JOIN
---- ���� ���Ǳ� ���� 2���� ���̺��� �ϳ��� ����
---- ���α��� ���� ������ ī�׽þ� ��(������)�� �߻��Ѵ�.
---- ���� ���, �� 14���ִ� ���̺�� �� 4�� �ִ� ���̺��� �����ϸ� 14x4 = 56���� ���� ��ȸ
select * from emp cross join dept;
