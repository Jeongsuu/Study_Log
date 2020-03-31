# Swift 기본 문법 2
---

---

### Any, AnyObject, nil

---

- Any : Swift의 모든 타입을 지칭하는 키워드
- AnyObject : 모든 클래스 타입을 지칭하는 프로토콜
- nil : '없음'을 의미하는 키워드

    //MARK: - Any
    var 변수명: 데이터 타입 = 값       // 타입 어노테이션
    
    var someAny: Any = 100
    someAny = "어떤 타입도 수용 가능합니다"
    someAny = 123.12
    
    let someDouble: Double = somemAny // Compile Error
    

Any 타입에 Double 타입 자료를 넣어두었더라도 Any는 Double 타입이 아니기 때문에 할당이 불가능하다.

타입 검사가 매우 강력한 스위프트기 때문에 명시적으로 타입을 변환해 주어야 한다.

    //MARK: - AnyObject
    
    class SomeClass {}
    
    var someAnyObject: AnyObject = SomeClaass()
    
    someAnyObject = 123.12 // 컴파일 에러
    

Any가 스위프트 내 모든 타입을 지칭하는 키워드라면 , AnyObject는 스위프트 내 모든 클래스의 인스턴스를 지칭한다.

 

    //MARK: - nil
    class Someclass {}
    
    var someAny: Any = 100
    var someAnyObject: AnyObject = Someclass()
    
    someAny = nil  // 에러 발생!
    someAnyObject = nil  //에러 발생!

**Any에는 어떠한 데이터 타입이라도 들어올 수 있지만, 값이 없음을 의미하는 nil은 들어올 수 없다.**

**AnyObject**에는 모든 클래스의 인스턴스 값이 들어올 수 있지만, 값이 없음을 의미하는 **nil**은 들어올 수 없다.

### 컬렉션 타입 ( Array, Dictionary, Set)

---

컬렉션 타입은 이름 그대로 여러 변수를 한데 묶어서 표현이 가능한 자료형을 의미한다.

대표적인 예시는 아래와 같다.

- Array : 순서가 있는 리스트 컬렉션
- Dictionary : '키' 와 '값'의 쌍으로 이루어진 컬렉션
- Set : 순서가 없고, 멤버가 중복없이 유일한 컬렉션

    //MARK: - Array
    
    // 빈 int형 배열 생성
    var integers: Array<Int> = Array<Int> ()      // []
    integers.append(1)                            // [1]
    integers.append(100)                          // [1, 100]
    // integers.append(100.1)   ->컴파일 에러, Int 타입 배열에 Double 타입 원소 삽입 시도
    
    integers.contains(100)                        // true
    integers.contains(99)                         // false
    
    integers.remove(at: 0)                        // [100]
    integers.removeLast()                         // []
    integers.removeAll()                          /// []
    
    integers.count()                              // 원소 개수 확인

arr.append()

arr.contains()

arr.remove(at: [])

arr.removeLast() → pop

**Array**

- 원소가 순서(인덱스)를 가지는 리스트 형태의 컬렉션 타입
- 여러가지 리터럴 문법을 활용할 수 있어서 표현 방법이 다양하다.

    // Array<Double> 과 [Double] 은 동일한 표현
    // 빈 Double 배열 생성
    var doubles: Array<Double> = Array<Double> ()
    var doubles: Array<Double> = [Double]()        // 둘이 같은 표현
    
    // 빈 String 배열 생성
    var strings: Array[String] = [String] ()
    
    // 빈 char 배열 생성
    // [] 는 빈 배열
    var characters: [characters] = []
    
    // let을 사용하여 배열 선언시 불변 배열
    let immutableArray = [1, 2, 3]        

### 딕셔너리

---

    //MARK: - Dictionary
    
    // Key가 String 타입이고 Value가 Any 타입인 빈 딕셔너리 생성
    var anyDictionary: Dictionary<String, Any> = [String: Any]()
    
    anyDictionary["somekey"] = "value"
    anyDictionary["anotherkey"] = 100
    
    anyDictionary["somekey"] = "value_Change"
    
    anyDictionary.removeValue(forKey: "anotherKey")
    
    anyDictionary["somekey"] = nil
    

### Set

    //MARK: - Set
    
    // 빈 Int set 생성
    var integerSet: Set<Int> = Set<Int>()
    integerSet.insert(1)
    integerSet.insert(100
    
    integerSet.contains(1)
    
    integerSet.count
    
    let setA: Set<Int> = [1, 2, 3, 4, 5]
    let setB: Set<Int> = [3, 4, 5, 6, 7]
    
    let union: Set<Int> = setA.union(setB)
    
    let intersection: Set<Int> = setA.intersection(setB)
    
    let subtracting: Set<Int> = setA.subtracting(setB)

---

---

### 함수

    import Swift
    
    //MARK: - 함수의 선언
    
    // 함수 기본 형태
    // func 함수명( 매개변수1 이름 : 타입, 매개변수2 이름: 타입, ...) -> 반환타입 {
    //     함수 몸체
    //	   return 반환값
    //	}
    
    func sum(a: Int, b: Int) -> Int {
    	return a + b
    }
    sum(a:3, b:5)
    
    //MARK: 반환값이 없을 경우
    func printMyName(name: String) -> Void {
    	print(name)
    }
    printMyName(name: "Yeojaeng")
    
    func printMyNAme(name: String) {     // void 반환은 생략가능
    	print(name)
    }
    printMyName(name: "Yeojaeng")
    
    
    //MARK: 매개변수가 없는 경우
    func maximumIntegerValue() -> Int {
    	return Int.max
    }
    
    //MARK: 매개변수와 반환값이 없는 경우
    func hello() -> Void { print("Hello") }
    func hello() { print("Hello") }

타 언어에서 사용하는 함수와 같다.

특별한 점이 있다면 void 반환의 경우에는 반환형을 생략할 수 있다.

### 함수 고급

---

1. 매개변수 기본 값
    - 매개변수에 기본적으로 전달될 값을 미리 지정해 둘 수 있다.
    - 기본값을 갖는 매개변수는 매개변수 목록 중 뒤쪽에 위치하는 것이 좋다.

    func 함수명(매개변수1 이름: 타입, 매개변수2 이름: 타입 = 기본값 ...) -> 반환타입 {
    	함수 몸체
    	return 반환값
    }
    
    func greeting(frined: String, me: String = "Yeojaeng") {
    	print("Hello \(friend) i'm \(me)")
    }
    
    greeting(friend: "Hana")
    greeting(friend: "john", me: "eric")

2. 전달인자 레이블

- 함수 호출시 함수 사용자의 입장에서 매개변수의 역할을 좀 더 명확하게 표현하고자 할 때 사용.
- 전달인자 레이블은 변경하여 동일한 이름의 함수를 중복으로 생성이 가능하다.

    func 함수이름 (전달인자 레이블 매개변수1 이름 : 타입, 전달인자 레이블 매개변수2 이름 : 타입 ...) -> 반환 타입 {
    	함수 구현
    	return 반환값
    }
    
    // 함수 내부에서 전달인자를 사용할 때에는 매개변수 이름을 사용한다.
    func greeting(to friend: String, from me: String) {
    	print("Hello\(friend)! I'm\(me)")
    }
    
    greeting(to:"hana", from:"yeojaeng")

3. 가변 매개변수

- 전달받을 인자의 개수를 알기 어려울 때 사용할 수 있다.
- 가변 매개변수는 함수당 하나만 가질 수 있다.

    func 함수명 (매개변수1 이름: 타입, 매개변수2 이름: 타입, ...) -> 반환타입 {
    	함수 몸체
    	return
    }
    
    func sayHelloToFriends(me: String, frineds: String ...) -> String {
    	return "Hello \(friends)! I'm \(me)!"
    }
    
    print(sayHelloToFriends(me: "yeojaeng", friends:"hana", "eric", "wing"))

가변인자에 `...` 로 선언하여 여러개의 인자를 전달할 수 있다.

위에서 설명한 모든 모양은 모두 섞어서 사용이 가능하다.

예시로 함수의 인자로 함수를 받을수 있다.

    func greeting(to friend: String, from me: String) {
    	print("Hello\(friend)! I'm\(me)")
    }
    
    var someFunction: (String, String) -> Void = greeing(to: from:)

### switch

---

    switch 비교값 {
    
    	case 패턴:
    		/* 실행 구문 */
    	default:
    		/* 실행 구문 */
    
    }

    // 범위 연산자 응용 가능
    
    switch someInteger {
    	case 0: 
    		print("zero")
    	case 1..<100:
    		print("1~99")
    	case 100:
    		print("100")
    	case 101...int.max:
    		print("over 100")
    	default:
    		print("unknown")
    }
    
    // 타 언어와 달리 비교값이 정수가 아니여도 가능, 대부분의 기본 자료형 사용 가능
    
    switch "yagom" {
    	case "jake":
    		print("jake")
    	case "mina":
    		print("mina")
    	case "yagom":
    		print("yagom!!")
    	default:
    		print("unknown")
    }

### repeat-while

---

타 언어의 `do~while` 문이다.

    repeat {
    	/*실행 구문*/
    } while 조건
    
    repeat {
    	integers.removeLast()
    } while integers.count > 0

---

---

### 옵셔널

---

Optional : 값이 있을수도, 없을수도...

    let optionalConstant: Int? = nil
    
    let someConstant: Int = nil // nil cannot initialize specified type 'int'

옵셔널은 도대체 왜 필요할까?

---

- nil의 가능성을 문서화 하지 않아도 코드만으로 충분히 표현 가능
    - 문서/주석 작성 시간 절약

- 전달받은 값이 옵셔널이 아니라면 nil 체크 없이 안심하고 사용 가능
    - 효율적인 코딩
    - 예외상황 최소화하는 안전한 코딩

### ? !

---

! → **Implicity Unwrapped Optional → 암시적 추출 옵셔널**

---

    var optionalValue: Int! = 100
    
    switch optionalValue {
    	case .none:
    		print("This optional var is nil")
    	case .some(let value):
    		print("value is \(value)")
    }

? → Optional

    var optionalValue: Int? = 100
    
    switch optionalValue {
    	case .none:
    		print("This optional var is nil")
    	case .some(let value):
    		print("Value is \(value)")
    }

옵셔널 추출 (Optional Unwrapping)

- Optional Binding - 옵셔널 바인딩
- Force Unwrapping - 강제 추출

옵셔널 바인딩 : 옵셔널 값을 꺼내오는 방법 중 하나인데 nil 체크 + 안전한 값 추출

`if - let` 방식을 이용한다.

    func printName(_ name: String) {
    	print(name)
    }
    
    var myName: String! = nil
    
    if let name: String = myName {
    	printName(name)
    } else {
    	print("myName == nil")
    }

if let name: String = myName {

"만일 myName의 값이 있다면 name 상수에 넣어줘!" 이후 if 블럭에서 name 상수 사용

옵셔널 강제추출 ( Force Unwrapping)

    func printName(_ name: String) {
    	print(name)
    }
    
    var myName: String? = "yagom"      // Optional
    print(myName!)          // 옵셔널 강제추출 , 우리가 선언한 값이 값이 있다는것을 확신함!
    
    myName = nil
    print(myName!)          // 강제추출시 값이 없으므로 런타임 에러 발생

### 열거형 (Enum)

---

Swift의 열거형은 타 언어 열거형과 차이가 있다.

- 유사한 종류의 여러 값을 한 곳에 모아서 정의한 것. ( 요일, 계절, 월 등)
- enum 자체가 하나의 데이터 타입, 자료형이다.
- 각 case는 한 줄에 개별로도, 한 줄에 여러개도 정의할 수 있다.

    enum 이름 {
    	case 이름1
    	case 이름2
    	case 이름3, 이름4, 이름5
    	//...
    }
    
    //ex
    enum BoostCamp {
    	case iosCamp
    	case androidCamp
    	case webCamp
    }

### 열거형 사용

- 타입이 명확한 경우, 열거형의 이름을 생략할 수 있다.
- `Switch` 구문에서 사용하면 좋다.

    enum WeekDay {
    	case mon
    	case tue
    	case wed
    	case thu, fri, sat, sun
    }
    
    // 열거형 타입과 케이스 모두를 사용해도 된다.
    var day: Weekday = Weekday.mon
    day = .tue
    
    print(day)   //tue
    
    switch day {
    	case .mon, .tue, .wed, .thu:
    		print("weekDay")
    	case .fri:
    		print("불금")
    	case .sat, .sun:
    		print("주말")
    }

### 클로저

---

1. **클로저**
- 클로저는 실행 가능한 코드 블럭이다.
- 함수와 기능이 매우 유사하지만 이름 정의가 필요없다. 매개변수 전달과 반환 값이 존재한다는 점은 동일하다.
람다식과 유사함!
- 즉, "함수는 이름이 있는 클로저!" 라고 보면 된다.
- 일급 객체로 전달인자, 변수, 상수 등에 저장 및 전달이 가능하다.

**2. 기본 클로저 문법**

- 클로저는 중괄호 "{}" 로 감싸져 있다.
- 괄호를 이용해 파라미터를 정의한다.
- "→" 를 이용해 반환 타입을 명시한다.
- `in` 키워드를 이용해 실행 코드와 분리한다.

    { (매개변수) -> 반환타입 in
    	실행 코드
    }

**3. 클로저 사용**

    //sum 이라는 상수에 클로저 할당 , 일급 객체로 변수, 상수 등에 저장 및 전달 가능!
    
    let sum:(int, int) -> { (a:int, b:int) in
    	return a+b
    
    let sumResult: Int = sum(1,2)
    print(sumResult) // 3

**4. 함수의 전달인자로서의 클로저**

- 클로저는 주로 함수의 전달인자로 많이 사용된다.
- 함수 내부에서 원하는 코드블럭을 실행할 수 있다.

    let add:(int, int) -> Int
    add = { (a:Int, b:Int) in
    	return a+b
    }
    
    let substract: (Int, Int) -> Int
    substract = { (a:Int, b:Int) in
    	return a-b
    }
    
    let divide: (Int, Int) -> Int
    divide = { (a:Int, b:Int) in
    	return a/b
    }
    
    func calculate(a: Int, b: Int, method:(Int, Int) -> Int) -> Int {
    	return method(a, b)
    }
    

### 상속

---

- 상속은 클래스, 프로토콜 등에서 가능하다.
- 열거형, 구조체는 상속이 불가하다.
- 스위프트의 클래스는 단일 상속으로, 다중 상속을 지원하지 않는다.

1. **문법**

    class 이름: 상속받을 클래스 명 {
    	/* 구현 */
    }

**2. 사용**

- final 키워드를 사용하여 재정의(override) 를 방지할 수 있다.
- static 키워드를 사용해 타입 메서드를 만들면 재정의가 불가능하다.
- class 키워드를 사용해 타입 메서드를 만들면 재정의가 가능하다.
- class 앞에 final 을 붙이면 static과 동일한 효과를 지닌다.
- override 키워드를 사용해 부모 클래스의 메서드를 재정의 할 수 있다.

    class Person {
    	var name: String = ""
    	
    	func selfIntroduce() {
    		print("\(name)")
    	}
    
    	//final 키워드를 이용해 재정의 방지
    	final func sayHello() {
    		print("hello")
    	}
    
    	// 타입 메서드
        // 재정의 불가 타입 메서드 - static
        static func typeMethod() {
            print("type method - static")
        }
        
        // 재정의 가능 타입 메서드 - class
        class func classMethod() {
            print("type method - class")
        }
        
        // 재정의 가능한 class 메서드라도 
        // final 키워드를 사용하면 재정의 할 수 없습니다
        // 메서드 앞의 `static`과 `final class`는 똑같은 역할을 합니다
        final class func finalCalssMethod() {
            print("type method - final class")
        }
    }
    
    // Person을 상속받는 Student
    class Student: Person {
        var major: String = ""
        
        override func selfIntroduce() {
            print("저는 \(name)이고, 전공은 \(major)입니다")
        }
        
        override class func classMethod() {
            print("overriden type method - class")
        }
        
        // static을 사용한 타입 메서드는 재정의 할 수 없습니다
    //    override static func typeMethod() {    }
        
        // final 키워드를 사용한 메서드, 프로퍼티는 재정의 할 수 없습니다
    //    override func sayHello() {    }
    //    override class func finalClassMethod() {    }
    }
