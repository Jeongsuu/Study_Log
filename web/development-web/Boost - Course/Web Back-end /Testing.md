## Test
---

1. 테스트가 필요한 이유에 대해 알아본다.
2. 테스트의 원리에 대해 알아본다.

<br>

### 핵심개념
---
-   테스트
-   장애
-   결함

### 테스트란?
---
1. 테스팅이란?
-   테스팅이란 응용 프로그램 또는 시스템의 동작과 성능, 안정성이 요구하는 수준을 만족하는지 확인하기 위해 결함을 발견하는 과정을 의미한다.
-   전통적 테스팅 개념은 응용 프로그램 또는 시스템이 잘 작동하는지 확인하는 것이다.

프로그램을 개발하기 이전에 요구사항 등을 리뷰하는 것을 정적 테스트<br>
프로그램 개발 이후 실제 실행하면서 테스트하는 것을 동적 테스트라고 한다.
<br>

### 소프트웨어 결함 원인
---

개발자가 잘못 작성한 오류로 인하여 결함이 발생한다.<br>
결함이 있는 소프트웨어는 장애가 발생하여 의도대로 소프트웨어가 동작하지 않거나 소프트웨어가 동작하지 않아야 하는 상황에서 동작하는 문제가 발생할 수 있다.

단, 모든 결함의 원인이 인간이 범하는 오류 때문만은 아니다.


### 테스팅의 일반적 원리

1. 테스팅은 결함이 존재함을 밝히는 행동이다.
-   테스팅은 결함이 존재함을 드러내지만, 결함이 없다는 것을 증명할 수없다.<br>
즉, 프로그램이 완벽하다고 증명할 수 없다.

2. 완벽한 테스팅은 불가능하다.
-   모든 가능성을 테스팅하는 것은 지극히 간단한 소프트웨어를 제외하고는 불가능하다.<br>보통 아래와 같은 이유 때문이다.
    -   한 프로그램 내 내부 조건이 무수히 많음.
    -   입력이 가질 수 있는 모든 값의 경우의 수가 무수히 많음.
    -   GUI 이벤트 발생 순서에 대한 조합도 무수히 많음.

완벽한 테스팅 대신, 리스크 분석과 결정된 우선순위에 따라 테스팅 활동 노력을 집중시켜야 한다. -> `Risk-Based Testing`

3. 테스팅을 개발 초기에 시작한다..
-   테스팅 활동은 소프트웨어 및 시스템 개발 생명주기 중 가능한 초기에 시작되어야 하며, 설정한 테스팅 목표에 집중해야 한다.

---
---


## Junit

테스트에 대하여 알아보았으니 이번엔 java 어플리케이션을 테스트 할 때 자주 사용되는 `Junit`에 대해 알아본다.<br>

### Junit이란?
프로그래밍 언어마다 테스트를 위한 프레임워크가 존재한다.<br>
이러한 도구들을 대체로 `xUnit`이라고 말한다.
자바언어의 경우에는 Junit이라고 한다.<br>

### Junit 사용하기

Junit을 사용하기 위해서는 해당 라이브러리가 `ClassPath`에 존재해야 한다.
Maven 프로젝트를 통해 `pom.xml`에 하기 내용을 추가한다.
```xml
<dependency>
  <groupId>junit</groupId>
  <artifactId>junit</artifactId>
  <version>버전</version>
  <scope>test</scope>
</dependency> 
```
scope가 test인 이유는 해당 라이브러리가 테스트 시에만 사용된다는 의미이다.

![image](https://user-images.githubusercontent.com/33051018/77619031-b74a1400-6f7a-11ea-926f-ceed5b74b983.png)

`src/main/java` 폴더에는 작성해야 할 코드를 기재하고,<br>
`src/test/java` 폴더에는 테스트 코드를 작성한다.

사칙연산을 구하는 `CalculatorService` 클래스를 작성한다.
```java
package kr.or.connect.Testing;

public class CalculatorService {
	
	public int plus(int val1, int val2) {
		return val1 + val2;
	}
	
	public int minus(int val1, int val2) {
		return val1 - val2;
	}
	
	public int multiple(int val1, int val2) {
		return val1 * val2;
	}
	
	public int divide(int val1, int val2) throws ArithmeticException {
		return val1 / val2;
	}
}
```

<br>


**앞서 작성한 CalculatorService 클래스를 테스트하는 CalculatorServiceTest 클래스를 /src/test/java 폴더 아래에 작성한다.**

```java
//CalculatorServiceTest.java
package kr.or.connect.Testing;

import org.junit.Before;
import org.junit.Test;
import org.junit.Assert;

public class CalculatorServiceTest {
	CalculatorService calculatorService;
	
	@Before
	public void init() {
		this.calculatorService = new CalculatorService();
	}
	
	@Test
	public void plus() throws Exception{
		// given
		int val1 = 10;
		int val2 = 5;
		
		// when
		int result = calculatorService.plus(val1, val2);
		
		// then
		Assert.assertEquals(15, result);		//결과값이 15일때만 성공
		
	}
	
	@Test
    public void divide() throws Exception{
        // given
        int val1 = 10;
        int val2 = 5;

        // when
        int result = calculatorService. divide (val1, val2);

        // then
        Assert.assertEquals(2,result); // 결과와 2가 같을 경우에만 성공
    }

    @Test
    public void divideExceptionTest() throws Exception{
        // given
        int val1 = 10;
        int val2 = 0;

        try {
            calculatorService.divide(val1, val2);
        }catch (ArithmeticException ae){
            Assert.assertTrue(true); // 이부분이 실행되었다면 성공
            return; // 메소드를 더이상 실행하지 않는다.
        }
        Assert.assertFail(); // 이부분이 실행되면 무조건 실패다.

    }
	
}
```

그리고 테스트 클래스 선택 이후 `Junit Test` 실행시키면
![image](https://user-images.githubusercontent.com/33051018/77619914-8cf95600-6f7c-11ea-91bb-19f288384f81.png)
`@Test`를 걸어놓은 부분들에 대한 테스팅을 진행한 결과를 알려준다.


![image](https://user-images.githubusercontent.com/33051018/77619808-57546d00-6f7c-11ea-80be-4b24ae761c93.png)

---
---
<br>

## 스프링 테스트 annotation 사용
---

이번엔 스프링 빈 컨테이너가 관리하는 빈 객체를 테스트해본다.

스프링 프레임워크를 사용하기 위해선 설정 파일을 작성해야한다. 이는 xml파일 또는 Java Config로 작성이 가능하다고 하였다.

`Java Config` 파일로 작성해본다.

```java
//ApplicationConfig.java

package org.edwith.webbe.calculatorcli;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages = {"org.edwith.webbe.calculatorcli"})
public class ApplicationConfig {
}


```
위와 같이 `Java Config` 파일로 설정 파일 설정.
클래스 위 `@configuration` 어노테이션이 붙어 있으면 스프링 설정 파일이라는 것을 의미하고
스프링 설정 파일은 스프링 빈 컨테이너인 `ApplicationContext`에서 읽어들인다.

`@ComponentScan`은 특정 패키지 이하에서 컴포넌트를 찾도록 한다.

이제 컴포넌트 대상 파일, 즉 아까 작성헸단 실행할 클래스를 `@Component` 
어노테이션을 통해 스캔 대상으로 지정한다.
**기존 코드**
```java
//CalculatorService.java
package kr.or.connect.Testing;

@Component
public class CalculatorService {
	
	public int plus(int val1, int val2) {
		return val1 + val2;
	}
	
	public int minus(int val1, int val2) {
		return val1 - val2;
	}
	
	public int multiple(int val1, int val2) {
		return val1 * val2;
	}
	
	public int divide(int val1, int val2) throws ArithmeticException {
		return val1 / val2;
	}
}

```

스프링 빈 컨테이너가 관리하다는 것은 개발자가 직접 인스턴스를 생성하지 않는다는 것을 의미한다.<br>스프링 빈 컨테이너가 인스턴스를 직접 생성하여 관리한다는 것을 의미한다.

스프링 빈 컨테이너가 `CalculatorService` 클래스를 찾아 빈으로 등록할 수 있도록 클래스 위에 `@Component` 어노테이션으로 스캔 대상임을 지정해준다.

위와 같이 작성하면, 이제 기존 클래스가 스프링 프레임워크에서 사용될 준비가 끝난것이다.

이제 실행 main 클래스를 작성한다.
```java
package org.edwith.webbe.calculatorcli;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Main {
    public static void main(String[] args){
        // ApplicationConfig.class 설정파일을 읽어들이는 ApplicationContext객체를 생성합니다.
        // 아래 한줄이 실행되면서 컴포넌트 스캔을 하고, 컴포넌트를 찾으면 인스턴스를 생성하여 ApplicationContext가 관리하게 됩니다.
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(ApplicationConfig.class);

        // ApplicationContext가 관리하는 CalculatorService.class타입의 객체를 요청합니다.
        CalculatorService calculatorService = applicationContext.getBean(CalculatorService.class);
        
        // ApplicationContext로 부터 받은 객체를 잉요하여 덧셈을 구합니다.
        System.out.println(calculatorService.plus(10, 50));
    }
}
```
<br>

### 테스트 클래스가 스프링 빈 컨테이너를 사용하도록 수정
---
기존 테스트 클래스는 테스트할 객체를 @Before가 붙은 메소드에서 초기화 하였습니다.

스프링 빈 컨테이너를 사용할 때는 개발자가 직접 인스턴스를 생성하면 안됩니다.

스프링 빈 컨테이너가 빈을 생성하고 관리하도록 하고, 그 빈을 테스트 해야합니다.

이를 위해서 스프링 프레임워크는 몇가지 특별한 기능을 제공합니다. 소스 코드를 아래와 같이 수정하도록 합니다.

```java
package org.edwith.webbe.calculatorcli;


import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ApplicationConfig.class})
public class CalculatorServiceTest {
    @Autowired
    CalculatorService calculatorService;

    @Test
    public void plus() throws Exception{
        // given
        int value1 = 10;
        int value2 = 5;

        // when
        int result = calculatorService.plus(value1, value2);

        // then
        Assert.assertEquals(result, 15); // 결과와 15가 같을 경우에만 성공
    }

    @Test
    public void divide() throws Exception{
        // given
        int value1 = 10;
        int value2 = 5;

        // when
        int result = calculatorService.divide(value1, value2);

        // then
        Assert.assertEquals(result, 2); // 결과와 15가 같을 경우에만 성공
    }

    @Test
    public void divideExceptionTest() throws Exception{
        // given
        int value1 = 10;
        int value2 = 0;

        try {
            calculatorService.divide(value1, value2);
        }catch (ArithmeticException ae){
            Assert.assertTrue(true); // 이부분이 실행되었다면 성공
            return; // 메소드를 더이상 실행하지 않는다.
        }
        
        Assert.assertTrue(false); // 이부분이 실행되면 무조건 실패다.
    }
}
```