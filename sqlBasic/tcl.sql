-- TCL (Transaction Control Language)


-- <Commit>
---- commit은 insert, update, delete문으로 변경한 데이터를 db에 반영한다.
---- 변경 이전 데이터는 잃어버린다. 즉, A 값을 B로 변경하고 commit을 하면 A 값은 잃어버리고 B에 반영한다.
---- 다른 모든 db 사용자는 변경된 data를 볼 수 있다.
---- commit이 완료되면 db 변경으로 인한 lock이 해제된다.
---- commit이 완료되면 다른 모든 db 사용자는 변경된 데이터를 조작할 수 있다.
---- commit을 실행하면 하나의 트랜잭션 과정을 종료한다.

/*
connect c##gyumin/1234

update emp set ename = '임베스트' where empno=100;

commit;
*/

-- <RollBack>
---- roleback을 실행하면 데이터에 대한 변경 사용을 모두 취소하고 트랜잭션을 종료
---- insert, update, delete 문의 작업을 모두 취소한다. 단, 이전에 commit한 곳까지만 복구한다.
---- rollback을 실행하면 lock이 해제되고 다른 사용자도 데이터베이스 행을 조작할 수 있음.
/*
connect c##gyumin/1234

update emp set ename = '임베스트' where empno=100;

rollback;
*/

-- <SavePoint>
---- 트랜잭션을 작게 분할하여 관리하는 것으로 SAVEPOINT를 사용하면 지정된 위치 이후의 트랜잭션만 rollback 가능
---- savepoint 지정은 savepoint <savepoint명>을 실행
---- 지정된 savepoint까지만 데이터 변경을 취소하고 싶은 경우는 "rollback to <savepoint명>을 실행
---- rollback을 실행하면 savepoint와 관계없이 데이터의 모든 변경사항을 저장하지 않는다.
/*
connect c##gyumin/1234

savepoint t1;

update emp set ename = '임베스트' where empno=100;

savepoint t2;

update emp set ename = '관우' where empno=101;

select * from emp where empno in (101, 102);

rollback to t2;

select * from emp where empno in (101, 102);
*/

select 'LimBest', '' from dual
    union all
select '','기술사' from dual;
-- 위의 SQL을 변경해서 한 행에 출력되게 수정
select max(a), max(b) from
(select 'LimBest' a, '' b from dual
    union all
select '' a ,'기술사' b from dual);

