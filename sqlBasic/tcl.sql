-- TCL (Transaction Control Language)


-- <Commit>
---- commit�� insert, update, delete������ ������ �����͸� db�� �ݿ��Ѵ�.
---- ���� ���� �����ʹ� �Ҿ������. ��, A ���� B�� �����ϰ� commit�� �ϸ� A ���� �Ҿ������ B�� �ݿ��Ѵ�.
---- �ٸ� ��� db ����ڴ� ����� data�� �� �� �ִ�.
---- commit�� �Ϸ�Ǹ� db �������� ���� lock�� �����ȴ�.
---- commit�� �Ϸ�Ǹ� �ٸ� ��� db ����ڴ� ����� �����͸� ������ �� �ִ�.
---- commit�� �����ϸ� �ϳ��� Ʈ����� ������ �����Ѵ�.

/*
connect c##gyumin/1234

update emp set ename = '�Ӻ���Ʈ' where empno=100;

commit;
*/

-- <RollBack>
---- roleback�� �����ϸ� �����Ϳ� ���� ���� ����� ��� ����ϰ� Ʈ������� ����
---- insert, update, delete ���� �۾��� ��� ����Ѵ�. ��, ������ commit�� �������� �����Ѵ�.
---- rollback�� �����ϸ� lock�� �����ǰ� �ٸ� ����ڵ� �����ͺ��̽� ���� ������ �� ����.
/*
connect c##gyumin/1234

update emp set ename = '�Ӻ���Ʈ' where empno=100;

rollback;
*/

-- <SavePoint>
---- Ʈ������� �۰� �����Ͽ� �����ϴ� ������ SAVEPOINT�� ����ϸ� ������ ��ġ ������ Ʈ����Ǹ� rollback ����
---- savepoint ������ savepoint <savepoint��>�� ����
---- ������ savepoint������ ������ ������ ����ϰ� ���� ���� "rollback to <savepoint��>�� ����
---- rollback�� �����ϸ� savepoint�� ������� �������� ��� ��������� �������� �ʴ´�.
/*
connect c##gyumin/1234

savepoint t1;

update emp set ename = '�Ӻ���Ʈ' where empno=100;

savepoint t2;

update emp set ename = '����' where empno=101;

select * from emp where empno in (101, 102);

rollback to t2;

select * from emp where empno in (101, 102);
*/

select 'LimBest', '' from dual
    union all
select '','�����' from dual;
-- ���� SQL�� �����ؼ� �� �࿡ ��µǰ� ����
select max(a), max(b) from
(select 'LimBest' a, '' b from dual
    union all
select '' a ,'�����' b from dual);

