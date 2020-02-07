## SQLI (SQL injection) 

---

>- What is SQLI?
>- describe some common examples
>- Explain how to find & exploit various kinda SQL Injection
>- summarize how to prevent SQL Injection



### What is SQL Injection?

---

`SQL Injection`이란 웹 어플리케이션 보안 취약점을 의미한다.

이는, 공격자가 변조된 쿼리를 통해 타겟의 `DataBase`에 접근하여 데이터를 삽입/ 삭제/ 변조가 가능하도록 하는 취약점이다.

실제 공격들의 대부분의 경우, 공격자들은 데이터를 변조하거나 삭제한다. 

몇몇 경우의 경우, 공격자들은 `SQL Injection` 공격을 통해 점차적으로 확대시켜 WAS 또는 다른 백엔드 인프라등을 공격한다거나 `DOS` 공격을 감행한다.



### What is the impact of a successful SQL injection Attack?

---

성공적인 `SQL Injection`은 패스워드, 신용카드 정보, 개인정보 등과 같은 민감한 정보에 인가되지 않은 접근이 가능하다.

`high-profile` 정보일수록 그 피해는 더욱 커진다.

몇몇 경우에는 공격자가 내부 시스템에 접근할 수 있는 백도어를 얻는 경우도 있다. 



### SQL injection examples

---

`SQL Injection`은 매우 다양하고 광범위한 분야를 아우르는 취약점 겸 공격 겸 기술이다.

또한 이는 매번 다른 상황을 야기하며 아래에는 대표적인 `SQL injection`이다.

>- Retrieving hidden data  : SQL 쿼리를 조작하여 숨겨진 데이터들을 획득할 수 있다.
>- `Subverting application logic` : 앱 내에 중요한 역할을 하는 쿼리를 조작할 수 있다.
>- `UNION Attacks` : 서로 다른 디비 테이블로 부터 데이터를 획득할 수 있다.
>- `Examining the DB` : DB의 구조 또는 버전과 같은 정보를 추출해 낼 수 있다.
>- `Blind SQL Injection` : 쿼리 결과에 따른 서버의 반응을 토대로 공격하여 정보를 알아낸다.



#### Retrieving hidden data

---

서로 다른 카테고리에서 다양한 제품을 파는 쇼핑몰을 상상해본다.

사용자가 `Gifts` 카테고리를 클릭하면 브라우저는 서버에게 아래와 같은 URL을 요청한다.

`https://insecure-website.com/products?category=Gifts`

**위 요청은 아래와 같이 어플리케이션이 DB로부터 관련 정보를 획득해 내기 위한 SQL 쿼리를 요청시킨다.**

```SQL
SELECT * FROM products WHERE category = 'Gifts' AND released = 1
```

위 쿼리는 디비로부터 아래와 같은 결과를 반환받기를 요구하는 것이다.

- all details (*)
- from the products table
- where the catogory is Gifts
- and released is 1

`released = 1`는 출시되지 않은 제품을 숨기기 위해 사용되고 있다, 미공개 제품의 경우 출시된 것으로 추정한다.

해당 어플리케이션은 `SQL injection`에 대한 어떠한 방어선도 구축하지 않았다고 가정하면 공격자는 아래와 같은 `SQL Injection`벡터를 시도할 수 있다.

```sql
SELECT * FROM products WHERE category = 'Gifts'--' AND released = 1
```

위 벡터 중 중요한 내용은 더블 대시 `--`이다.

이는 주석을 의미하며 이를 기준으로 뒤쪽은 모두 주석처리를 진행하겠다는 의미이다.

따라서, `AND released = 1`쿼리는 무효화되는 것이다.

더 나아가 공격자는 DB에는 존재하나 클라이언트 측에서는 확인이 불가능한 숨김처리 되어있는 카테고리들도 아래 쿼리문을 통해 확인이 가능하다.

```sql
SELECT * FROM products WHERE category = 'Gifts' or 1=1--'
```

변조된 위 쿼리 부분 `category = 'Gifts' or 1=1--'` 부분은 항상 참을 반환하게 되어 존재하는 모든 카테고리를 SELECT 하게된다.

이를 통해 `Hidden data`를 찾아내고 확인할 수 있다.





