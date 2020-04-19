


#### 구조체와 클래스

**구조체와 클래스란?**

-   구조체와 클래스는 OOP(Object Oriented Programming)를 위한 필수요소로 프로그램의 코드를 추상화하기 위해 사용한다.

-   Swift에서는 다른 프로그래밍 언어와는 달리 구조체와 클래스를 위한 별도 인터페이스와 파일을 만들 필요가 없다.

**구조체와 클래스의 공통점**
-   여러 변수를 담을 수 있는 컨테이너
-   데이터를 용도에 맞게 묶어 표현하고자 할 때 용이
-   __프로퍼티와 메서드를 사용하여 구조화된 데이터와 기능을 가진다.__
-   **하나의 새로운 사용자 정의 데이터 타입을 만들어 주는 것.**
-   확장 사용이 가능하다.
-   프로토콜 사용이 가능하다.
-   `.` 연산자를 통해 하위 프로퍼티에 접근이 가능하다.

**기본 형태**

```swift

struct 구조체 이름 {
    프로퍼티 및 메서드
}

class 클래스 이름 {
    프로퍼티 및 메서드
}

```

**인스턴스 생성 방법**
```swift
let structureInstance = 구조체()
let classInstance = 클래스()
```

**구조체와 클래스의 차이점**
-   **구조체는 값 타입, 클래스는 참조 타입**
-   **구조체는 상속이 불가능하다.**
-   타입캐스팅은 클래스의 인스턴스에만 허용된다. 

참조 타입이란, 값 타입과 달리 복사되는 것이 아닌 **메모리를 참조**한다.

```swift

let referenceExample = ReferenceClass()
referenceExample.number = 27

let result = referenceExample
result.number = 32

print(referenceExample.number)      // 32
```

-   result 상수가 referenceExample **인스턴스를 복사한 것이 아닌 참조한 것!**
-   result는 referenceExample 이 가리키고 있는 메모리 주소를 가리키고 있다.

-   상수로 선언하였어도 값이 바뀌는 이유는 result 자체를 변경하는 것이 아닌 result가 포인팅하고 있는 값을 변경하는 것이기 때문에 가능하다.

**구조체 사용이 유리한 경우**

애플은 다음 조건 중 하나 이상에 해당한다면 구조체를 사용하는 것을 권장한다.

>1. 연관된 간단한 값의 집합을 캡슐화 하는 것만이 목적일 때
>
>2. 캡슐화한 값을 참조하는 것 보다 복사하는 것이 합당할 때
>
>3. 구조체에 저장된 프로퍼티가 값 타임이며, 참조하는 것 보다 복사하는 것이 합당할 때
>
>4. 다른 타입으로부터 상속받거나 자신을 상속할 필요가 없을 때 

#### typealias

`typealias`란, 기존에 선언되어 있는 자료형에 새로운 자료형 별칭을 사용함으로써 코드를 더 읽기 쉽도록, 이해하기 쉽도록 명확하게 만드는 문법이다.

`Swift` 에서는 `typealias`를 크게 3가지 유형으로 나누어 사용한다.

1. 내장 유형 -> String, Int, Float ...etc
2. 사용자 정의 유형 -> class, struct, enum ...etc
3. 복합 유형 -> closure

각각 유형의 예시들을 살펴보도록 한다.

**내장 유형에 대한 예시**

```swift
typealias Name = String
```

간단한 예시로 `String` 타입을 `Name`이라는 별칭으로 사용하겠다는 의미이다.

```swift
let name: Name = "홍길동"

let name: String = "홍길동"
```

위 상수 선언은 두 방법 모두 같은 효과를 지닌다.

결론적으로 모두 `String` 타입이지만 특별한 분류가 필요하거나 구분지어 사용하고 싶을때는 `typealias`를 사용하여 이 변수는 `Name` 이라는 유형의 `String`이다.

라는 방식으로 사용이 가능하다.

**사용자 정의 유형에 대한 예시**

```swift

class Student {

}

typealias Students = [Student]

var student: Students = []
```

학생에 대한 클래스 `Student`를 구현하고 이를 `typealias`를 통해 `Students`라는 `Student` 배열로 선언한다.

이후 `students`라는 변수를 `Students` 타입으로 초기화한다.



**복합적인 유형에 대한 예시**
`Closure`를 입력 매개 변수로 사용하는 함수의 경우, `typealias`를 사용하여 보다 깔끔하게 사용할 수 있다.

```swift

func test(completionHandler: (Void) -> (Void) ) {

}

typealias voidHandler = (Void) -> (void)

func test(completionHandler: voidHandler) {

}
```

test라는 함수에 completionHandler라는 Closure를 사용했을 떄, 
`voidHandler` 라는 `typealias`를 선언한뒤에 위와 같이 매개변수를 voidHandler로 깔끔하게 사용이 가능하다.
