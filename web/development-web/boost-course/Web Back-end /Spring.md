# Spring Framework
---

이번에는 `Spring Framework`가 무엇인지, 그리고 `Spring Framework`를 구성하는 모듈에는 어떠한 것이 있는지 알아본다.

<br>

### `Spring Framework`란
---

`Framework`란?
> 완전한 제품이 아닌 반제품.

> 반제품을 이용해서 내가 원하는 제품을 만들어낸다.

-   엔터프라이즈 급 어플리케이션을 구축할 수 있는 가벼운 솔루션이자, `원-스탑-숍(One-Stop-Shop)`이다. 모든 과정을 한꺼번에 해결하는 상점을 의미한다.
-   원하는 부분만 가져다 사용할 수 있도록 모듈화가 잘 되어있다.
-   IoC 컨테이너다.
-   선언적으로 트랜잭션을 관리할 수 있다.
-   완전한 기능을 갖춘 `MVC Framework`를 제공한다.

![image](https://user-images.githubusercontent.com/33051018/77528212-e4da8300-6ed0-11ea-8623-bb7e407f0e2d.png)


-   스프링 프레임워크는 약 20개의 모듈로 구성되어 있다.
-   필요한 모듈만 가져다 사용할 수 있다.

이어서 스프링 프레임워크의 핵심 개념 중 하나인 `IoC`와 `DI`에 관하여 알아본다.

### 컨테이너란?
-   컨테이너는 인스턴스의 생명주기를 관리한다.
-   생성된 인스턴스들에게 추가적 기능을 제공한다.


### `IoC`란?
-   Inversion of Control의 약어.
-   제어의 역전을 의미한다. 
-   일반적으로 개발자는 프로그램의 흐름을 제어하는 코드를 작성한다.
이 흐름의 제어를 개발자가 하는것이 아니라 다른 프로그램이 제어하는 것을 IoC라고 한다.

### `DI`란?
-   DI는 `Dependency Injection`의 약자로, 의존성 주입을 의미한다.
-   DI는 클래스 사이의 의존 관계를 빈 설정 정보를 바탕으로 컨테이너가 자동으로 연결해주는 것을 말한다.

#### `DI`가 적용 안 된 예시
개발자가 직접 인스턴스를 생성한다.

```java
class Engine {

}

class Car {
    Engine V5 = new Engine();
}
```
![image](https://user-images.githubusercontent.com/33051018/77530885-56b4cb80-6ed5-11ea-8360-2f6b32aa3599.png)

<br>


#### `DI`가 적용된 예시
엔진 `type`의 `v5`변수에 인스턴스가 할당되지 않았다.
컨테이너가 `v5`변수에 인스턴스를 할당해준다.
```java
@Component
class Engine {

}

@Component
class Car {
    @Autowired
    Engine v5;
}
```

![image](https://user-images.githubusercontent.com/33051018/77530915-659b7e00-6ed5-11ea-93cb-920d3384938b.png)
<br>

Bean은 일반적인 클래스르 의미한다.

**Bean의 특징**
 1) 기본 생성자를 가져야 있다.
 2) 필드는 private하게 선언한다.
 3) getter, setter메소드를 가져야한다. getName(), setName() 메소드를 name 프로퍼티(Property)라고 한다 (용어 중요!)

#### 용어
-   프로퍼티 : getter, setter 메소드
-   빈 : 일반적인 클래스

 ```java
//UserBean.java

package kr.or.connect.diexam01;

public class UserBean {
/*
 * Bean의 특징 
 * 1) 기본 생성자를 가지고 있어야다.
 * 2) 필드는 private하게 선언한다.
 * getter, setter메소드를 가진다. getName(), setName() 메소드를 name 프로퍼티(Property)라고 한다 (용어 중요!)
 */
	
	private String name;					// name 필드 , 이의 getter, setter 메서드는 getName(), setName() -> Name의 프로퍼
	private int age;
	private boolean male;
	
	
	/*
	public UserBean(String name, int age, boolean male) {
		this.name = name;
		this.age = age;
		this.male = male;
	}
	
	
	 * 위 처럼 UserBean 이라는 객체를 편하게 생성하고 싶기 때문에 생성자를 만들고 싶으나, 그냥 기본 생성자만 갖도록한다.
	 */

	public UserBean()	{}				// 기본 생성자


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public boolean isMale() {
		return male;
	}


	public void setMale(boolean male) {
		this.male = male;
	}
	
	// 위에가 private 필드 별 getter, setter 메소드 
}

```

<br>
<br>

---
---
---


DI : 내가 원하는 객체를 내가 생성하는게 아니라 현재 우리는 스프링을 사용하니 `Spring`에서 제공하는 공장이 만들어서 나에게 주입시켜준다.

## `Bean` 특징
-	기본적인 생성자를 갖는다.

`public userBean() {}`
-	필드는 모두 private으로 선언한다.

`private String name; private int age; private boolean male;`
-	getter, setter 메소드를 가진다 -> 프로퍼티

`상단바 source -> generate Getter/Setter`

## Spring Bean Factory 이용하기

**pom.xml 설정**

```xml
 <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <spring.version> 4.3.14.RELEASE</spring.version>
  </properties>
```

property는 상수처럼 사용할 수 있는것을 선언한다.

spring version을 선언해놓으면 여러곳에서 참조할 떄 4.3.14.RELEASE를 쓰거나 spring.version을 쓰면 된다.

버전 변경이 필요하다면 참조하는 모든 위치의 값을 바꿀 필요 없이 위 `value`값만 바꿔주면 된다.

```xml
  <dependencies>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>${spring.version}</version>
    </dependency>
```
스프링 라이브러리를 사용하기 위해 dependency로 의존성 주입.

![image](https://user-images.githubusercontent.com/33051018/77599673-ce700e00-6f48-11ea-954f-a41d879181e9.png)

성공하면 프로젝트 익스플로러에 `Maven Dependencies` 에 라이브러리들이 추가된 것을 확인할 수 있다.

여기까지 한 일은 "나 스프링공장 쓸꺼야~" -> 스프링 공장에 해당하는 라이브러리만 추가한 것.

```java
package kr.or.connect.diexam01;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ApplicationContextExam01 {

	public static void main(String[] args) {
		// ClassPathXmlApplicationContext 생성자를 이용해 ApplicationContext객체를 만든다, 아까 bean 정보를 xml에 기입하였으니 해당 정보를 저기서 찾아줘 하고 classpath를 기입한다.
		ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		System.out.println("초기화 완료!");
		
		// 공장을 세웠으니 정보를 얻어온다.
		// 공장한테 getBean 이라는 메소드를 통해 해당 빈은 얻어온다.
		UserBean userBean = (UserBean)ac.getBean("userBean");
		// xml파일에 기재한 내용을 바탕으로 공장 ac를 세웠다.
		// 거기서 getBean으로 빈을 생성하면 이 xml파일 을 뒤져서 id가 userBean이랑 일치하는 애를 찾는다.
		// xml에서 찾으면 userBean이랑 같이 등록되어있는 class 이름을 알아내서 클래스를 생성해준다.

		userBean.setName("yeo");
		
		System.out.println(userBean.getName());
		
		UserBean userBean2 = (UserBean)ac.getBean("userBean");
		
		if(userBean == userBean2)
			System.out.println("Same Object");
		
		// userBean 과 userBean2는 같은 인스턴스다.
		// 싱글턴 패턴을 이용하기 때문에 사용자가 계속 getBean으로 요청해도 그 객체를 계속 만드는게 아니라 하나 만든 bean을 이용하는것.

	}

}
```

#### 정리

> ApplicationContext라는 인터페이스가 있다.<br>
> 이 인터페이스를 구현하는 다양한 컨테이너가 존재한다.<br>
> 그 중 xml파일을 classpath에서 읽어들여서 사용하는 객체가 ClassPathXmlApplicationContext다. -> 기억하기.<br>
> resources 폴더는 src/main에 들어있다. 이건 소스폴더임. 그래서 리소스 폴더에서 생성한 xml은 자동으로 classpath로 지정이된다.<br>
> 이 ClassPathXmlApplicationContext가 생성될 떄, 생성자 파라미터로 지정된 설정 파일을 읽어들인 후에 그 안에 선언된 bean들을 모두 메모리에 올려준다.<br>
> applicationContext.xml에 넣어놓은 빈들이 여러개 있다면 이 객체들을 전부 생성해서 올려놓은다.
> 이후 ApplicationContext 클래스가 가지고 있는 getBean이라는 메소드로 객체를 얻어온다.

<br>

## DI 동작 확인
---

```java
//Engine.java

package kr.or.connect.diexam01;

public class Engine {
	
	public Engine() {
		System.out.println("Engine 생성자");
	}
	
	public void exec() {
		System.out.println("Engine 동작 ");
	}
}



//car.java
package kr.or.connect.diexam01;

public class Car {						// Car Class
	private Engine v8;					// Car Field
	
	public Car() {						// Car constructor
		System.out.println("Car 생성");
	}
	
	public void setEngine(Engine e) {	// Car method
		this.v8 = e;
	}
	
	public void run() {					// Car method
		System.out.println("엔진을 이용해 달리기.");
		v8.exec();
	}
	
	public static void main(String[] args) {	
		
		//자동차는 엔진이 필요하니 엔진과 자동 생성
		Engine e = new Engine();		//엔진 객체 생성 
		Car c = new Car();				//차 객체 생성 
		
		c.setEngine(e);		// Car 객체의 Engine 필드값 초기화 -> 엔진 설정 
		c.run();			//달리기 
		
	}
}

```

원래는 main 함수 내 순서대로 진행되는것이 일반적이다.

지금 메인 메서드에서 객체를 생성하고 있는데 이 부분 자체를 제어의 역전으로 넘긴다.

이것을 Spring IoC 컨테이너가 만들어 줄 것이다.

이를 위해선 설정파일에다가 해당 Bean들을 등록한다.

```xml
<!-- applicationcontext.xml -->

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="userBean" class="kr.or.connect.diexam01.UserBean"></bean>
	<bean id="c" class="kr.or.connect.diexam01.Car" />
	<bean id="e" class="kr.or.connect.diexam01.Engine" />

</beans>

```

bean id를 메인 메서드에서 생성한 객체명 처럼 Car c, Engine e로 지정하여 등록하였다.

그러나 이렇게 작성하면 Car에다가 Engine을 Set해라 이런 의미는 없다.

Car 인스턴스에 엔진을 Set 하려면 아래와 같이 수정해야한다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="userBean" class="kr.or.connect.diexam01.UserBean"></bean>
	<bean id="c" class="kr.or.connect.diexam01.Car" />
	<bean id="e" class="kr.or.connect.diexam01.Engine" > 
		<property name="engine" ref="e" </property>
		
	</bean>
	

</beans>

```

```xml
<bean id="e" class="kr.or.connect.diexam01.Engine" >
<bean id="c" class="kr.or.connect.diexam01.Car" />
	<property name="engine" ref="e" </property>
 
```

위 부분만 보자.
bean 등록시 `property`라는 엘리먼트를 사용할 수 있다.
property는 getter, setter 메소드!

`property name ="engine" ref ="e"`

ref -> 참고해라<br>name이 Engine인 property는 `SetEngine()` 혹은 `GetEngine()` 이라는 메소드를 의미한다. <br>
그런데 ,`<bean>` 태그 내부는 모두 값을 설정하는 부분이기 때문에 `setEngine()` 메소드의 의미를 갖는다.<br>
`SetEngine()` 메소드는 파라미터로 `Engine` 타입을 받는다.<br>

`setEngine(Engine e)` -> 파라미터로 Engine 타입을 받는것 확인.

이를 `ref="e"` 를 통해 `<bean id>` 가 `e`로 선언된 인스턴스를 참고해라.<br>라는 의미로 전달해주는 것.

따라서 위 내용이 실행한 부분은 실제 메인 메소드에서 
```java
Engine e = new Engine();		//엔진 객체 생성 
		Car c = new Car();				//차 객체 생성 
		
		c.setEngine(e);		// Car 객체의 Engine 필드값 초기화 -> 엔진 설정 
```

여기까지 실행한 것과 같음.

이제는 위에서 등록한 xml 파일들의 설정들을 읽어들여서 실행하는 `ApplicationContextExam02`를 만들어본다.

```java
///ApplicationContextExam02.java

public class ApplicationContextExam02 {

		public static void main(String[] args) {
			
			// 일단은 스프링 컨테이너가 필요하다.
			ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
			// applicationContext.xml정보를 기반으로 컨테이너를 생성한다.
			
			// 자동차 객체 생성
			Car car = (Car)ac.getBean("c");
			// 자동차 객체 생성 주체가 이제는 내가 아닌 스프링 컨테이너(ApplicationContext)!
			car.run();
		
			
		}
}

```
**output**
Engine 생성자<br>
Car 생성자<br>
엔진을 이용하여 달립니다.<br>
엔진이 동작합니다.<br>

---

이렇게 어떠한 객체에게 객체를 주입하는 것을 DI 라고 한다.


<br>

Spring 컨테이너가 관리하는 객체를 Bean이라고 한다.
(우리가 직접 new  연산자로 생성해서 사용하는 객체는 Bean이라고 하지 않는다.)

Spring은 빈을 생성할 떄 기본적으로 싱글톤 객체로 생성한다.
<br>싱글톤 : 메모리에 하나만 생성한다.<br>
메모리에 객체가 하나만 생성될 경우, 해당 객체를 동시에 이용하는 것을 막기 위해 scope를 주어 해결할 수 있다.

