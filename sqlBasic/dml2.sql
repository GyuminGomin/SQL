-- DML (Data Manipulation Language) (group by��, having��, ������ �Լ�)

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

-- <group by��>
select deptno, sum(sal)
    from emp
    group by deptno;
-- <having ��>
select deptno, sum(sal)
    from emp
    group by deptno
    having sum(sal) > 10000;
-- ���� �Լ� ����
---- count() : �� �� ��ȸ
select count(*)
    from emp;
    
alter table emp
    add (mgr number(10) default 1);
update emp
    set mgr = null
    where empno=105;
select count(mgr)
    from emp; -- null ���� ������ �� ���� ���
---- sum() : �հ� ��ȸ
---- avg() : ��� ��ȸ
---- max()�� min() : �ִ񰪰� �ּڰ��� ���
---- stddev() : ǥ������ ���
---- variance() : �л��� ���

-- group by ��� ����
---- �μ���, �����ں� �޿� ��� ���
select deptno, mgr, avg(sal)
    from emp
    group by deptno, mgr;
---- ������, �޿��հ� �߿� �޿��հ谡 10000�̻��� ����
alter table emp
    add (job varchar2(20));
update emp
    set job='����';
update emp
    set job='sysAdmin'
    where empno <= 102;
update emp
    set job='developer'
    where empno >= 103;
select job, sum(sal)
    from emp
    group by job
    having sum(sal) >= 10000;
---- �����ȣ 100~103���� �μ��� �޿� �հ�
select deptno, sum(sal)
    from emp
    where empno between 100 and 103
    group by deptno;
    
-- <select�� ���� ����>
---- from, where, group by, having, select, order by������ ����

-- <����� �� ��ȯ(����)�� �Ͻ��� ����ȯ(�ڵ�)>
---- to_number(���ڿ�) : ���ڿ��� ���ڷ� ��ȯ
---- to_char(���� Ȥ�� ��¥, [format]) : ���� Ȥ�� ��¥�� ������ Format�� ���ڷ� ��ȯ
---- to_date(���ڿ�, format) : ���ڿ��� ������ format�� ��¥������ ��ȯ
select *
    from emp
    where empno='100'; -- �Ͻ��� ����ȯ ����

-- <������ �Լ�(Built-in Function)>
-- dual ���̺�
---- oracle db�� ���� �ڵ����� �����Ǵ� ���̺�
---- oracle db ����ڰ� �ӽ÷� ����� �� �ִ� ���̺�� ������ �Լ��� ������ ���� ����� �� ����
---- oracle db�� ��� ����ڰ� ����� �� ����.
desc dual;

-- ������ �Լ��� ����
---- dual ���̺� ������ ������ �Լ��� ����ϸ� ������ ����.
---- ASCII �Լ��� ���ڿ� ���� ASCII �ڵ� ���� �˷���.
---- SUBSTR �Լ��� ������ ��ġ�� ���ڿ��� �ڸ��� �Լ��� LENGTH �Լ�, LEN �Լ��� ���ڿ��� ���̸� �����.
---- LTRIM �Լ��� ����ϸ� ���ڿ��� ���� ������ �ڸ� �� ����.
---- �Լ� ��ø ��뵵 ���� (LENGTH(LTRIM(' ABC')))
select ascii('a'), substr('abc',1,2), length('A BC'), ltrim(' ABC') ,length(ltrim(' ABC')) -- substr���� 1,2�� 1��° ��ġ���� 2���� �ڸ��ٴ� �ǹ�
    from dual;
-- ���ڿ� �Լ�
---- ascii(����) : ���� Ȥ�� ���ڸ� ascii �ڵ尪���� ��ȯ
---- chr/char(ascii �ڵ尪) : ascii �ڵ尪�� ���ڷ� ��ȯ, ����Ŭ�� chr ���, ms-sql,mysql�� char ���
---- substr(���ڿ�, m,n) : ���ڿ����� m��° ��ġ���� n���� �ڸ���.
---- concat(���ڿ�1, ���ڿ�2) : ���ڿ�1���� ���ڿ�2���� ����, oracle�� '||' my-sql�� '+'�� ��� ����
---- lower(���ڿ�) : �����ڸ� �ҹ��ڷ� ��ȯ
---- upper(���ڿ�) : �����ڸ� �빮�ڷ� ��ȯ
---- length Ȥ�� len(���ڿ�) : ������ �����ؼ� ���ڿ��� ���̸� �˷���.
---- ltrim(���ڿ�, ��������) : ���ʿ��� ������ ���ڸ� ����, ������ ���ڸ� �����ϸ� ������ ����
---- rtrim(���ڿ�, ��������) : �����ʿ��� ������ ���ڸ� ����, ������ ���ڸ� �����ϸ� ������ ����
---- trim(���ڿ�, ��������) : ���ʿ��� ������ ���ڸ� ����, ������ ���ڸ� �����ϸ� ������ ����

-- ��¥�� �Լ�(oracle db)
---- sysdate : ������ ��¥�� ��¥ Ÿ������ �˷���
---- extract(year from sysdate) : ��¥���� ��,��(month),��(day)�� ��ȸ
select sysdate, extract(year from sysdate), to_char(sysdate, 'YYYYMMDD')
    from dual;

-- ������ �Լ�
---- abs(����) : ������ ������
---- sign(����) : ���,0,������ ����
---- mod(����1, ����2) : ����1�� ����2�� ������ �������� ���, %�� ����ص� ��.
---- ceil/ceiling(����) : ���ں��� ũ�ų� ���� �ּ��� ������ ������.
---- floor(����) : ���ں����۰ų� ���� �ִ��� ������ ������.
---- round(����, m) : �Ҽ��� m �ڸ����� �ݿø�, m�� �⺻���� 0��
---- trunc(����, m) : �Ҽ��� m �ڸ����� ����, m�� �⺻���� 0��
select abs(-1), sign(10), mod(4, 2), ceil(10.9), floor(10.1), round(10.222,1)
    from dual;

-- <DECODE�� CASE��>
-- decode ��
---- decode������ if���� ���� ����. ��, Ư�� ������ ���̸� A, �����̸� B�� ����
select decode (empno, 100, 'TRUE', 'FALSE')
    from emp;

-- case ��
---- case���� if~then ~else-end�� ���α׷��� ���ó�� ���ǹ��� ����� �� ����. ������ when������ ����� ���̸� then, �����̸� else���� ����
select case
    when empno = 100 then 'A'
    when empno = 101 then 'B'
    else 'C'
end
    from emp;
    
-- <ROWNUM�� ROWID>
-- rownum (Oracle�� rownum ���, sql server�� top�� ���, mysql�� limit�� ���)
------ ex. sql server : select top(10) from emp;  mysql : select * from emp limit 10;
---- rownum�� oracle db�� select�� ����� ���� ������ �Ϸù�ȣ�� �ο���.
---- rownum�� ��ȸ�Ǵ� �� ���� ������ �� ���� ���
---- rownum�� ȭ�鿡 �����͸� ����� �� �ο��Ǵ� ���� ������. ���� rownum�� ����� ������ ���� ����� �ϱ� ���ؼ� �ζ��� ��(inline view)�� ����ؾ� ��.
---- inline view�� select������ from���� ���Ǵ� ���������� �ǹ���. ex. select * from (select * from emp) a;
select * from emp
    where rownum <= 1; -- �� �� ��ȸ
select *
    from (select rownum list, ename
            from emp)
    where list <= 5;

select *
    from (select rownum list, ename
            from emp)
    where list between 5 and 10;

-- rowid
---- rowid�� oracle db������ �����͸� ������ �� �ִ� ������ ��
---- rowid�� "select rowid, empno from emp"�� ���� select������ Ȯ�� ����
---- rowid�� ���� �����Ͱ� � ������ ����, ��� ��Ͽ� ����Ǿ� �ִ��� �� �� ����
-- rowid ����
/* 
����          | ����    | ����
������Ʈ ��ȣ     1~6     ������Ʈ ���� ������ ���� ������ ������, �ش� ������Ʈ�� ���� �ִ� ����.
��� ���� ��ȣ    7~9     ���̺����̽��� ���� �ִ� ������ ���Ͽ� ���� ��� ���Ϲ�ȣ��.
��� ��ȣ       10~15    ������ ���� ���ο��� ��� ��Ͽ� �����Ͱ� �ִ��� �˷���.
������ ��ȣ      16~18   ������ ��Ͽ� �����Ͱ� ����Ǿ� �ִ� ������ �ǹ���.
*/
select rowid, ename
from emp;

-- <with ����>
---- with������ ���������� ����� �ӽ� ���̺��̳� ��ó�� ����� �� �ִ� ������.
---- �������� ��Ͽ� ��Ī�� ������ �� ����.
---- ��Ƽ�������� sql�� �ζ��� �䳪 �ӽ� ���̺�� �Ǵ���.
with viewdata as
    (select * from emp 
    union all
    select * from emp)
select * from viewdata where empno = 100;
    
-- quiz
---- emp ���̺��� with������ ����� �μ���ȣ(deptno)�� 1001�� ���� �ӽ� ���̺��� ����� ��ȸ�Ͻÿ�.
with w_emp as
    (select * from emp where deptno = '1001')
select * from w_emp;