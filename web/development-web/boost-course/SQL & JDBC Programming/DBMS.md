## Intro
---

프로그램에서 다루는 데이터가 많이질수록, 그 데이터를 동시에 사용하는 사람이 많아질수록 데이터의 관리는 더욱이 어려워진다.

이러한 데이터를 쉽고 편하게 다룰 수 있도록 하기 위해 등작한 것이 DBMS이다.
<br>


어린이가 가지고 있는 책(정보)들을 데이터베이스라고 한다면, 그 책을 관리해주는 엄마는 DBMS라고 말할 수 있다.

### DB
---
데이터베이스는 여러 응용시스템들의 통합된 정보들을 저장하여 운영할 수 있는 공용데이터의 집합을 의미한다.

효율적으로 저장, 검색, 갱신할 수 있도록 데이터 집합들끼리 연관시키고 조직화되어야 한다.

### DB의 특성
---
-   실시간 접근성

    -   사용자의 요구를 즉시 처리할 수 있다.

-   계속적인 변화

    -   정확한 값을 유지하기 위해 삽입, 삭제, 수정 작업 등을 이용해 데이터를 지속적으로 갱신할 수 있다.

-   동시 공유성

    -   사용자마다 서로 다른 목적으로 사용하므로 동시에 여러 사람이 동일한 데이터에 접근하고 이용할 수 있다.

-   내용 참조

    -   저장한 데이터 레코드의 위치나 주소가 아닌 사용자가 요구하는 데이터의 내용, 즉 데이터 값에 따라 참조할 수 있어야 한다.

<br>

### DBMS
---

-   데이터베이스를 관리하는 소프트웨어
-   여러 응용 소프트웨어 또는 시스템이 동시에 DB에 접근하여 사용할 수 있게 한다.

**장점**

-   데이터 중복이 최소화된다.
-   데이터의 일관성 및 무결성 유지
-   데이터 보안 보장

**단점**

-   운영비가 비싸다
-   백업 및 복구에 대한 관리가 복잡
-   부분적 데이터베이스 손실이 정체 시스템을 정지

<br>

> mysql 실행방법

> brew services start mysql

> 재시작 : brew services restart mysql

SQL은 데이터를 보다 쉽게 검색하고 추가, 삭제, 수정 같은 조작을 할 수 있도록 고안된 컴퓨터 언어이다.

관계형 데이터베이스에서 데이터를 조작하고 쿼리하는 표준 수단이다.

DML : 데이터 조작을 위해 사용한다.
-   INSERT, UPDATE, DELETE, SELECT 등

DDL : 데이터베이스의 스키마를 정의하거나 조작하기 위해 사용한다.
-   CREATE, DROP, ALTER 등

DCL : 데이터를 제어하는 언어이다. 권한을 관리하고 보안, 무결성등을 정의한다.
-   GRANT, REVOKE 등

<br>

### DB 생성하기

`mysql -uroot -p` -> MySQL 관리자 계정 `root`로 DBMS에 접속하겠다는 의미.

`create database DB이름` :DB생성

![image](https://user-images.githubusercontent.com/33051018/77064340-aa7d6b80-6a22-11ea-900a-3e46fb43735e.png)

DB가 잘 만들어졌다면 사용자를 생성하고 권한을 부여해야한다.

해당 계정이 데이터베이스를 이용할 수 있도록 해야한다.

`grant all privileges on db이름.*to 계정이름@'%' identified by '암호';`

%는 어떠한 클라이언트에서도 모두 접근이 가능하다는 의미.

@'%' 대신 @localhost 이면 로컬에서만 접근이 가능한 것.

사용자 계정명은 `connectuser` , 암호는 `connect123!@#` 해당 사용자가 사용하는 디비는 `connectdb`로 계정을 생성하려면 아래와 같이 명령을 수행한다.

`grant all privileges on connectdb.* to connectuser@'%' identified by 'connect123!@#';`

mysql 8.x 버전 부터는 계정의 생성과 동시에 권한을 부여할 수 없다.
따라서, 계정을 생성한 이후에 권한을 부여한다.
```sql
mysql> create user 'connectuser'@'localhost' identified by 'connect123!@#';

mysql> grant all privileges on connectdb.* to 'connectuser'@'localhost';

mysql> flush privileges;
```

**데이터베이스 접속방법**

`mysql -h[호스트명] -u[DB계정명] -p [DB이름]`

실제 사용자가 생성한 계정이 잘 되었는지 확인하기 위해 직접 접속해본다.

`mysql -uconnectuser -p connectdb`

`show grants for [계정명]@[호스트]` : 권한 조회

<br>

### 테이블의 구성요소
-   테이블 : RDBMS의 기본적 저장구조 한 개 이상의 column과 1개 이상의 row로 구성

-   열(column) : 테이블 상에서의 단일 종류의 데이터를 나타냄, 특정 데이터 타입 및 크기를 가지고 있다.

-   행(Row) : Column들의 값 조합, 레코드라고 불림, 기본키(Public Key)에 의해 구분. 기본키는 중복을 허용하지 않으며 없어서는 안된다.

-   필드(Field) : Row와 Column의 교차점으로 Field는 데이터를 포함할 수 있고 없을 때는 NULL값을 갖는다.

![image](https://user-images.githubusercontent.com/33051018/77221947-06b2cd80-6b92-11ea-92cf-c846e644ca31.png)

`show tables`는 db의 테이블 목록을 보는 명령이다.

<br>

**테이블 구조를 확인하기 위한 DESCRIBE 명령**
table 구조를 확인하기 위해, `describe` 명령을 사용할 수 있다.
짧게 desc로 명령하여도 된다.
`EMPLOYEE` 테이블 구조를 살펴본다.

`desc EMPLOYEE;`

하나의 DBMS에는 여러 개의 데이터베이스를 생성하고, 각각의 데이터베이스를 사용할 수 있는 사용자를 추가할 수 있다.

### 데이터 조작어
select, insert, update ,delete

**select 칼럼명 from 테이블명;**

칼럼은 여러개를 동시에 볼 수 있는데 여러개를 지정할때는 `,`를 통해 나열한다.

어떠한 테이블을 조회하거나 조작을 하게 될 때 테이블 구조를 확인하는 일은 매우 중요하다.

테이블에 존재하는 칼럼들을 파악하기 위해서 는 `desc` 명령을 통해 조회한다.

![image](https://user-images.githubusercontent.com/33051018/77222233-c1dc6600-6b94-11ea-9fd1-d516e1053383.png)

`alias`를 통해 `deptno`를 사번으로 출력할 수 있다.

**concat 함수**
출력할 문자열을 합해서 출력해준다.
일반적으로 아는 concat과 같은 기능.

함수 또한 `alias`와 같이 응용하여 사용 가능.

```bash
mysql> select concat(empno, '-', deptno) as '사번-부서번호' from employee;
+---------------------+
| 사번-부서번호       |
+---------------------+
| 7782-10             |
| 7839-10             |
| 7934-10             |
| 7369-20             |
| 7566-20             |
| 7788-20             |
| 7876-20             |
| 7902-20             |
| 7499-30             |
| 7521-30             |
| 7654-30             |
| 7698-30             |
| 7844-30             |
| 7900-30             |
+---------------------+
14 rows in set (0.00 sec)
```

**DISTINCT** 키워드는 중복행을 제거한다.

```bash
mysql>  select deptno from employee;
+--------+
| deptno |
+--------+
|     10 |
|     10 |
|     10 |
|     20 |
|     20 |
|     20 |
|     20 |
|     20 |
|     30 |
|     30 |
|     30 |
|     30 |
|     30 |
|     30 |
+--------+
14 rows in set (0.00 sec)

mysql> select distinct deptno from employee;
+--------+
| deptno |
+--------+
|     10 |
|     20 |
|     30 |
+--------+
3 rows in set (0.00 sec)
```

#### 정렬 (order by)

```bash
mysql> select empno, name from employee;
+-------+--------+
| empno | name   |
+-------+--------+
|  7369 | SMITH  |
|  7499 | ALLEN  |
|  7521 | WARD   |
|  7566 | JONES  |
|  7654 | MARTIN |
|  7698 | BLAKE  |
|  7782 | CLARK  |
|  7788 | SCOTT  |
|  7839 | KING   |
|  7844 | TURNER |
|  7876 | ADAMS  |
|  7900 | JAMES  |
|  7902 | FORD   |
|  7934 | MILLER |
+-------+--------+
14 rows in set (0.00 sec)

mysql> select empno, name from employee order by name;
+-------+--------+
| empno | name   |
+-------+--------+
|  7876 | ADAMS  |
|  7499 | ALLEN  |
|  7698 | BLAKE  |
|  7782 | CLARK  |
|  7902 | FORD   |
|  7900 | JAMES  |
|  7566 | JONES  |
|  7839 | KING   |
|  7654 | MARTIN |
|  7934 | MILLER |
|  7788 | SCOTT  |
|  7369 | SMITH  |
|  7844 | TURNER |
|  7521 | WARD   |
+-------+--------+
14 rows in set (0.00 sec)
```

**select 칼럼명 from 테이블명 order by 정렬기준(칼럼명)**

기본적으로는 `ascending` 정렬로 진행한다.

만일 내림차순 정렬로 살펴보고 싶다면 `descending` -> `desc` 키워드를 넣어주면 된다.

```bash
mysql> select empno, name from employee order by name desc;
+-------+--------+
| empno | name   |
+-------+--------+
|  7521 | WARD   |
|  7844 | TURNER |
|  7369 | SMITH  |
|  7788 | SCOTT  |
|  7934 | MILLER |
|  7654 | MARTIN |
|  7839 | KING   |
|  7566 | JONES  |
|  7900 | JAMES  |
|  7902 | FORD   |
|  7782 | CLARK  |
|  7698 | BLAKE  |
|  7499 | ALLEN  |
|  7876 | ADAMS  |
+-------+--------+
14 rows in set (0.00 sec)
```

**예제**

`employee` 테이블에서 직원의 empno, name, job을 출력한다. 단 name을 기준으로 오름차순 정렬한다.
```bash
mysql> select empno, name, job from employee order by name;
+-------+--------+-----------+
| empno | name   | job       |
+-------+--------+-----------+
|  7876 | ADAMS  | CLERK     |
|  7499 | ALLEN  | SALESMAN  |
|  7698 | BLAKE  | MANAGER   |
|  7782 | CLARK  | MANAGER   |
|  7902 | FORD   | ANALYST   |
|  7900 | JAMES  | CLERK     |
|  7566 | JONES  | MANAGER   |
|  7839 | KING   | PRESIDENT |
|  7654 | MARTIN | SALESMAN  |
|  7934 | MILLER | CLERK     |
|  7788 | SCOTT  | ANALYST   |
|  7369 | SMITH  | CLERK     |
|  7844 | TURNER | SALESMAN  |
|  7521 | WARD   | SALESMAN  |
+-------+--------+-----------+
14 rows in set (0.01 sec)

mysql> select empno as 사번, name as 이름, job as 직업 from employee order by 이름;
+--------+--------+-----------+
| 사번   | 이름   | 직업      |
+--------+--------+-----------+
|   7876 | ADAMS  | CLERK     |
|   7499 | ALLEN  | SALESMAN  |
|   7698 | BLAKE  | MANAGER   |
|   7782 | CLARK  | MANAGER   |
|   7902 | FORD   | ANALYST   |
|   7900 | JAMES  | CLERK     |
|   7566 | JONES  | MANAGER   |
|   7839 | KING   | PRESIDENT |
|   7654 | MARTIN | SALESMAN  |
|   7934 | MILLER | CLERK     |
|   7788 | SCOTT  | ANALYST   |
|   7369 | SMITH  | CLERK     |
|   7844 | TURNER | SALESMAN  |
|   7521 | WARD   | SALESMAN  |
+--------+--------+-----------+
14 rows in set (0.00 sec)
```

<br>

### 데이터 정의어

테이블 생성

create table 테이블명 (
    필드명1 타입 [NULL | NOT NULL][DEFAULT ][AUTO_INCREMENT],
    필드명2 타입 [NULL | NOT NULL][DEFAULT ][AUTO_INCREMENT],
    필드명3 타입 [NULL | NOT NULL][DEFAULT ][AUTO_INCREMENT],
    .....
    PRIMARY KEY(필드명)
);

```bash
mysql> create table EMPLOYEE2(                                                           
    -> empno INTEGER NOT NULL PRIMARY KEY,                                            
    -> name VARCHAR(10),                                                         
    -> job VARCHAR(9),                                                             
    -> boss INTEGER,                                                                
    -> hiredate VARCHAR(12),                                                          
    -> salary DECIMAL(7, 2),                                                           
    -> comm DECIMAL(7, 2),                                                       
    -> deptno INTEGER);                                                        
Query OK, 0 rows affected (0.01 sec)
``` 

```bash
mysql> desc EMPLOYEE2;
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| empno    | int          | NO   | PRI | NULL    |       |
| name     | varchar(10)  | YES  |     | NULL    |       |
| job      | varchar(9)   | YES  |     | NULL    |       |
| boss     | int          | YES  |     | NULL    |       |
| hiredate | varchar(12)  | YES  |     | NULL    |       |
| salary   | decimal(7,2) | YES  |     | NULL    |       |
| comm     | decimal(7,2) | YES  |     | NULL    |       |
| deptno   | int          | YES  |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+
8 rows in set (0.01 sec)

mysql> desc employee;
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| empno    | int          | NO   | PRI | NULL    |       |
| name     | varchar(10)  | YES  |     | NULL    |       |
| job      | varchar(9)   | YES  |     | NULL    |       |
| boss     | int          | YES  | MUL | NULL    |       |
| hiredate | varchar(12)  | YES  |     | NULL    |       |
| salary   | decimal(7,2) | YES  |     | NULL    |       |
| comm     | decimal(7,2) | YES  |     | NULL    |       |
| deptno   | int          | YES  | MUL | NULL    |       |
+----------+--------------+------+-----+---------+-------+
8 rows in set (0.00 sec)
```
```bash
mysql> create table book(
    -> isbn varchar(10) primary key,
    -> title varchar(20) not null,
    -> price integer not null);
Query OK, 0 rows affected (0.00 sec)

mysql> desc book;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| isbn  | varchar(10) | NO   | PRI | NULL    |       |
| title | varchar(20) | NO   |     | NULL    |       |
| price | int         | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

### 테이블 수정(칼럼 추가 / 삭제)

`alter` 키워드를 이용한다.

**추가**

alter table 테이블명 add 필드명 타입 [NULL | NOT NULL][DEFAULT ][AUTO_INCREMENT];

**삭제**

alter table 테이블명 drop 필드명;

```bash
mysql> desc book;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| isbn  | varchar(10) | NO   | PRI | NULL    |       |
| title | varchar(20) | NO   |     | NULL    |       |
| price | int         | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql>
mysql> alter table book
    -> add author varchar(20);
Query OK, 0 rows affected (0.00 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc book;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| isbn   | varchar(10) | NO   | PRI | NULL    |       |
| title  | varchar(20) | NO   |     | NULL    |       |
| price  | int         | NO   |     | NULL    |       |
| author | varchar(20) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)
```

```bash
mysql> alter table book
    -> drop price;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc book;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| isbn   | varchar(10) | NO   | PRI | NULL    |       |
| title  | varchar(20) | NO   |     | NULL    |       |
| author | varchar(20) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

### 컬럼 수정

```
alter table 테이블명
    change 필드명 새필드명 타입 [NULL | NOT NULL] [DEFAULT ][AUTO_INCREMENT];
```

```bash
mysql> desc employee2
    -> ;
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| empno    | int          | NO   | PRI | NULL    |       |
| name     | varchar(10)  | YES  |     | NULL    |       |
| job      | varchar(9)   | YES  |     | NULL    |       |
| boss     | int          | YES  |     | NULL    |       |
| hiredate | varchar(12)  | YES  |     | NULL    |       |
| salary   | decimal(7,2) | YES  |     | NULL    |       |
| comm     | decimal(7,2) | YES  |     | NULL    |       |
| deptno   | int          | YES  |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+
8 rows in set (0.00 sec)

mysql> alter table employee2
    -> change deptno dept_no int(11);
Query OK, 0 rows affected, 1 warning (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 1

mysql> desc employee2;
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| empno    | int          | NO   | PRI | NULL    |       |
| name     | varchar(10)  | YES  |     | NULL    |       |
| job      | varchar(9)   | YES  |     | NULL    |       |
| boss     | int          | YES  |     | NULL    |       |
| hiredate | varchar(12)  | YES  |     | NULL    |       |
| salary   | decimal(7,2) | YES  |     | NULL    |       |
| comm     | decimal(7,2) | YES  |     | NULL    |       |
| dept_no  | int          | YES  |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+
8 rows in set (0.01 sec)
```

### 테이블 이름 변경
```
alter table 테이블명 rename 테이블명
```

```bash
mysql> desc employee2;
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| empno    | int          | NO   | PRI | NULL    |       |
| name     | varchar(10)  | YES  |     | NULL    |       |
| job      | varchar(9)   | YES  |     | NULL    |       |
| boss     | int          | YES  |     | NULL    |       |
| hiredate | varchar(12)  | YES  |     | NULL    |       |
| salary   | decimal(7,2) | YES  |     | NULL    |       |
| comm     | decimal(7,2) | YES  |     | NULL    |       |
| dept_no  | int          | YES  |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+
8 rows in set (0.01 sec)

mysql> alter table employee2 rename employee3;
Query OK, 0 rows affected (0.01 sec)

mysql> show tables;
+-----------------------+
| Tables_in_connectdb   |
+-----------------------+
| BONUS                 |
| book                  |
| DEPARTMENT            |
| EMPLOYEE              |
| employee3             |
| PROJECT               |
| PROJECT_PARTICIPATION |
| ROLE                  |
| SALARYGRADE           |
+-----------------------+
9 rows in set (0.00 sec)
```
