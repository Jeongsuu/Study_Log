# Swift 기본 문법

---

---

## ***변수와 상수***

---

> 변수는 값을 수정할 수 있고, 상수는 그렇지 않다. `Swfit` 에서는 언제 어디서 값이 어떻게 바뀔지 모르는 변수보다는 상수 사용을 권장한다. → 그래야 안전하거든요
변수는 `var` 로 선언하고, 상수는 `let` 으로 선언한다.

    var name = "Jungsu YEO"
    let birthyear = 1994

만일 변수의 경우에는, 나중에 일므을 바꾸고 싶다면 바꿀 수 있다.

    name = "여정수"

그러나,  상수를 변경하려하면 컴파일 에러가 발생한다.

`Swift` 는 정적 타이핑 언어이다. 말이 어려운데 이는 변수나 상수를 정의할 때 그 자료형(타입)이 어떤 것인지 명시해줘야 하는 언어를 의미한다. 예를 들면 이런 것들이다.

    var name: String = "Jungsu YEO"
    let birthyear: Int = 1995
    var height: Float = 174.6

위와 같이 변수 또는 상수 이름 뒤에 콜론( : )을 붙이고 자료형을 써주면 된다. 이 떄 사용하는 `: String` 과 ` Int` 등을 가지고 `Type Annotation` 이라고 한다.

`Swfit` 는 타입을 굉장히 엄격하게 다루기 때문에, 다른 자료형끼리는 애초에 기본적 연산조차 되지 않는다. → Int + Float 도 불가능하다!

위를 예시로 한다면 아래와 같이 진행해야한다.

    Float(birthyear) + height 

이번엔 문자열과 변수를 합하여 출력하는 것을 알아보자.

    String(birthyear) + "년에 태어난' + name + "아 안녕!"

이렇게 쓰면 가독성도 좋지 않다... `Swift` 에서는 아래와 같이 작성할 수도 있다!

    "\(birthyear)년에 태어난 \(name)아 안녕!"

어떠한 로직에 `string`을 이용하고자 할때는 `\()` 를 사용한다!

### ***타입 추론 (Type Inference)***

---

그런데 우리가 맨 처음에 사용한 에제에서는 자료형을 명시하지 않았다.

    var name = "Jungsu YEO"
    let birthyear = 1994

위 처럼 말이다.

그런데도 우리는 `name` 이 문자열이라는 것을 알았고, `birthyear` 가 정수형이라는 것을 알았다.

`swfit`  컴파일러도 마찬가지로 , 큰 따옴표 (")로 감싸진 텍스트는 `String` 이라는 것을 알고, 숫자는 `Int` 타입인 것을 인식할 수 있다.

이렇게 자료형을 직접 명시하지 않고도 값을 가지고 정적 타이핑을 할 수 있게 해주는 것을 ***타입 추론 (Type Inference)*** 라고 한다.

### *배열(Array) 와 딕셔너리(Dictionary)*

---

`Swift` 에서 배열과 딕셔너리는 모두 대괄호 ( [] )를 이용해서 정의한다. 아래처럼

    var languages = ["Swift", "Objective-C", "Java"]
    var capitals = [
    	"Korea" : "Seoul",
    	"Japan" : "Tokyo",
    	"China" : "Beiging"
    ]

배열과 딕셔너리에 접근하거나 값을 변경할때도 대괄호를 이용한다! 매우 쉽군!

    languages[0] // Swift
    languages[1] = "Ruby"
    
    capitals["Korea"] // Seoul
    capitlas["France"] = "Paris"

참고로, 다른 상수와 마찬가지로 배열과 딕셔너리를 `let` 으로 정의하면 값을 수정할 수 없다...(아주 빡쎈친구)

물론 값을 추가하거나 빼는 것도 당연히 불가능하다!

위에서 정의해본 `languages` 와 `capitals` 의 타입은 어떻게 쓸 수 있을까? 이번에도 대괄호를 쓴다! 대신, 대괄호 안에 어떤 타입을 받을지 명시한다!

    var languages: [String] : ["Swift", "Objective-c", "Java"]
    var capitals: [String: String] : [
    	"한국" : "서울",
    	"일본" : "도쿄",
    	"중국" : "베이징"
    ]
    

만일 빈 배열이나 빈 딕셔너리를 정의하고 싶다면? 이번에도 대괄호를 이용한다

배열과 딕셔너리는 대괄호로 시작해서 대괄호로 끝나는 친구들이다!

    var languages: [String] : []
    var capitals: [String: String] = [:]

빈 배열로 선언하는 것을 조금 더 간결하게 하고 싶다면, 이렇게 할 수 있다!

    var languages = [String] ()
    var capitals = [String: String] ()

타입 뒤에 괄호 () 를 쓰는 것은 생성자`Initializer` 를 호출하는 것이다!

---

## *조건문과 반복문*

---

조건을 검사할 때에는 `if, switch` 를 사용한다. 아래 코드는 `if` 를 사용한 예시이다.

    var age = 10
    var student = ""
    
    if age >= 8 && age < 14 {
    	student = "초딩"
    } else if age < 17 {
    	student = "중딩"
    } else if age < 20 {
    	student = "고딩"
    } else {
    	student = "기타"
    }
    
    student // 고딩

`if`문의 조건절에는 값이 명확하게 **참 또는 거짓**으로 나오는 `Bool` 타입을 사용해야 한다. 위에서 언급한 것 처럼 `Swift` 에서는 타입 검사를 굉장히 엄격하게 하기 때문에, 다른 언어에서 사용이 가능한 아래와 같은 코드는 사용ㅇ이 불가능하다..

    var number = 0
    if !number {   // Compile Error!!
    	...
    }

대신 이렇게 써야한다.

    if number == 0 {
    	//...
    }

빈 문자열 또는 배열 등을 검사할 때에도 명확하게 길이가 0인지 검사해야 한다.

    if name.isEmpty {...}
    if languages.isEmpty {...}

`switch` 는 단순히 값이 같은지를 검사하는 것으로 알고는데 `Swift` 에서의 `switch` 는 조금 차이가 있다!

**패턴 매칭이 가능하기 때문이다! 아래 코드는 위에서 작성한 `if` 문을 `switch` 문으로 옮겨본 것이다.**

    switch age {
    	case 8..<14:
    		student = "초딩"
    	case 14..<17:
    		student = "중딩"
    	case 17..<20:
    		student = "고딩"
    	default:
    		student = "기타"
    }

`8..<14` 와 같이 범위 `Range` 안에 `age`가 포함되었는지 여부를 검사할 수 있다.

반복되는 연산을 할 때는 `for, while` 문을 이용한다. `for` 문을 이용하여 배열과 딕셔너리를 차례대로 순환해보자.

    for languege in languages {
    	print("저는 \(language) 언어를 다룰 수 있습니다.")
    }
    
    for (country, capital) in capitals: {
    	print("\(country)의 수도는 \(capital) 입니다.")
    }

매우 쉽지? 단순한 반복문을 만들고 싶다면 아까 이용했던 `range` 를 응용해서 아래처럼 반복할 수 있어! 

    for i in 0..<100 {
    	i
    }

매우 깔끔하고 간결하지? 파이썬처럼 `i`를 이용하지 않으면 `for _ in 0..<100` 이렇게도 작성할 수 있지!

---

## 옵셔널 (Optional)

---

`Swift` 가 가지고 있는 가장 큰 특징 중 하나가 바로 옵셔널(`Optional`) 이지! 

직역하면 '선택적인' 이라는 의미인데, **이름 그대로 값이 있을수도 있고 없을수도 있는 것을 의미해!**

예를 들어, 문자열의 값이 있으면 "가나다"가 될꺼야 만일 값이 없다면 "" 일까? ㄴㄴㄴㄴ 틀렸음. ""도 엄연히 값이 있는 문자열이야! 엄밀히 말하면 값이 없는것이 아니라 '빈 값'을 갖는거지.

**값이 없는 문자열은 바로 nil 이다!**

또 다른 예시를 들어보자! 정수형의 값이 있으면 123과 같은 값이 들어있을꺼야, 근데 만일 값이 없다면? 0일까? ㄴㄴㄴ 이또한 마찬가지로 0은 0이라는 숫자 '값'이야, 이 경우에도 값이 없는 정수는 `nil` 이 되는거지!

**마찬가지로 빈 배열이나 빈 딕셔너리라고 해서 값이 없는게 아니야! 다만 비어있을 뿐이지!**

배열과 딕셔너리도 '없는 값'은 `nil` 이야

이렇게, 값이 없는 경우를 나타낼 때에는 `nil` 을 사용해! , 그렇다고 해서 모든 변수에 `nil` 을 넣을수 있는건 아니야.... 

간단한 예시로 우리가 위에서 정의한 `name` 이라는 변수에 `nil` 을 넣으려고 하면 에러가 발생하지

    var name: String = "여정수"
    name = nil    // 컴파일 에러

값이 있을수도 있고 없을수도 있는 변수를 정의할 때에는 `Type Annotation` 에 `?` 를 붙여야 한다리.

이렇게 정의한 변수를 바로 옵셔널(Optional) 이라고 하고 옵셔널에 초깃값을 지정하지 않으면 `nil` 이야!

    var email: String?
    print(email)   // nil
    
    email = "duwjdtn1@gmail.com"
    print(email)   // Optional(duwjdtn1@gmail.com"

옵셔널로 정의한 변수는 옵셔널이 아닌 변수랑은 완전히 달라, 아래 예시를 보자

    let optionalEmail : String? = "duwjdtn1@gmail.com"
    let requiredEmail : String = optionalEmail   // 컴파일 에러!

`requiredEmail` 변수는 옵셔널이 아닌 `String` 타입 이기 때문에 항상 값을 가지고 있어야 하지!

반면에, `optionalEmail` 은 옵셔널로 선언된 변수기 때문에 실제 코드가 실행되기 전까지는 값이 있는지 없는지 알 수 없어.

따라서 `Swift` 컴파일러는 안전한 실행을 위해서 `requiredEmail` 에는 옵셔널로 선언된 변수를 대입할 수 없게 해놨어 → 명시적으로 값이 있어야 하는곳에 값이 없어도 되는 걸 넣으려고 하니 불안전하지!

옵셔널은 개념적으로 아래처럼 표현할 수 있어, 어떤 값 또는 `nil` 을 가지고 있는 녀석이지.

Optional 

1. 어떤 값 (ex: String, Int, ...etc)
2. `nil`

## 옵셔널 바인딩(Optional Binding)

---

그런 옵셔널의 값을 가지고오고 싶을때는 어떻게 해야 할까? 이 때 사용하는 것이 `Optional Binding` 이야!

옵셔널 바인딩은 옵셔널 변수의 값이 존재하는지를 검사한 뒤, 만일 존재하면 그 값을 다른 변수에 대입시켜줘!

**옵셔널 바인딩은 대체로 `if let` 또는 `if var` 와 같이 사용되는데, 옵셔널의 값이 존재한다면 이 값을 벗겨서 `if` 문 내부 로직을 수행하게 되고, 값이 `nil` 이라면 그냥 통과하도록 되어있지.**

예를 들어, 아래 코드에서 `optionalEmail` 에 값이 존재한다면 `email` 이라는 변수 안에 실제 값이 저장될거고, `if` 문 내에서 이것을 사용할 수 있지!

근데 만약 `optionalEmail`이 값이 없는 상태인 `nil` 이라면 `if` 문이 실행되지 않고 그냥 넘어갈꺼야!

    if let email = optionalEmail {
    	
    	print(email)  //optionalEmail에 값이 존재한다면 해당 값이 출력된다.
    }
    	// optionalEmail 내 값이 존재하지 않는다면 그냥 if 문을 지나친다.

하나의 `if`문 에서 콤마 ( , )로 구분하여 여러 옵셔널을 바인딩 할 수 있어! 이곳에 사용된 모든 옵셔널의 값이 존재해야 `if` 문 내부로 들어가지!

    var optionalName: String? = "여정수"
    var optionalEmail: String? = "duwjdtn1@gmail.com"
    
    if let name = optionalName, email = optionalEmail {
        // name 과 email 값이 존재할 경우
    }

옵셔널을 바인딩 할 때 `,` 를 사용해서 조건도 함께 지정할 수 있어! `,` 이후의 조건절은 옵셔널 바인딩이 일어난 이후에 실행되게 되지.

즉, 옵셔널이 버서겨진 값을 가지고 조건을 검사하게 돼!

    var optionalAge: Int? = 27
    
    if let age = optionalAge, age >= 20 {
    	// age 값이 존재하고 , age가 20이상인경우
    }

위 코드는 아래 코드랑 동일한 코드야

    if let age = optionalage {
    	if age >= 20 {
    		// age 값이 존재하고, 그 값이 20보다 큰 경우
    	}
    }

## 옵셔널 체이닝 (Optional Chaining)

---

`Swift` 코드를 간결하게 만들어주는 많은 요소들이 있는데, 그 중 하나가 옵셔널 체이닝이야!

옵셔널로 선언된 배열이 있다고 가정해보자, 이 배열이 '빈 배열' 인지 검사하려면 어떻게 해야할까? `nil` 이 아니면서 빈 배열인지 확인해보면 되겠지? 마치 아래처럼

    let array: [String]? = []     //옵셔널 빈 배열 선언
    var isEmptyArr = false
    
    if let array = array, array.isEmpty {
    	isEmptyArray = true
    } else {
    	isEmptyArray = false
    }

옵셔널 체이닝을 이용하면 더 간결하게 이를 사용할 수 있어!

`let isEmptyArray = array?.isEmpty == true`

## 옵셔널 언랩 (Optional Unwrapping)

---

옵셔널을 사용할 때 마다 옵셔널 바인딩을 하는것이 바람직해! 

근데 개발을 하다보면 값이 있는것이 확실함에도 불구하고 옵셔널로 사용해야 하는 경우가 종종 있는데, 이럴 떄에는 옵셔널에 값이 있다고 가정하고 값에 바로 접근할 수 있도록 도와주는 키워드인 `!` 를 붙여서 사용하면 된다.

    print(optionalEmail) // Optional("duwjdtn1@gmail.com")
    print(optionalEmail!) // duwjdtn1@gmail.com

`!` 키워드는 매우 조심해서 사용해야돼, 옵셔널의 값이 `nil` 인 경우에는 런타임 에러가 발생해! `java` 의 `NullPointerException` 이랑 비슷한 개념이지!

    var optionalName: String?
    print(optionalName!)   // 런타일 에러!

런타임 에러가 발생하면 iOS 앱은 강제로 종료되니 조심해야돼!

## 암묵적 옵셔널 언랩 ( Implicitily Unwrapped Optional )

---

만일, 옵셔널을 정의할 때 `?` 대신 `!` 를 붙이면 `ImplicitlyUnwrappedOptional` 이라는 옵셔널로 정의된다.

이 름이 굉장히 길지... 

    var email: String! = "duwjdtn1@gmail.com"
    print(email)   // duwjtn1@gmail.com

이렇게 정의된 옵셔널은 `nil`을 포함할 수 있는 옵셔널이긴 한데, 접근할 때 옵셔널 바인딩이나 언랩 과정을 거치지 않고도 바로 값에 접근이 가능하다는 점에서 일반적인 옵셔널과는 조금 차이가 있어

---

## 함수와 클로저 (Func & Closure)

---

**함수는 `func` 키워드를 사용해서 정의하고 `->` 를 사용해서 반환 타입을 지정한다!**

    func hello(name: String, time: Int) -> String {
    	var string = ""
    	for _ in 0..<time {
    		string += "\(name)님 안녕하세요!\n"
    	}
    
    	return string
    }

`Swift` 에서는 함수를 호출할 때 독특하게 파라미터 이름을 함께 써줘야 한다.

`hello(name: "여정수", time: 3)`

만일, 함수를 호출할 때 사용하는 파라미터 이름과 함수 내부에서 사용하는 파라미터 이름을 달리 사용하고 싶으면 이렇게 할 수 있다.

    func hello(to name: String, numberOfItems time: Int) {
    	for _ in 0..<time {
    		print(name)
    	}
    }

`hello(to: "여정수", numberOfItems: 3)`  함수를 호출할때는 `to` 와 `numberOfItems` 를 사용한다.

혹은 아래와 같이 파라미터 이름을 `-` 로 지정하면 함수를 호출할 때 파라미터 명을 생략할 수 있다.

    func hello(_ name: String, _ time: Int) {
    	for _ in 0..<time {
    		print(name)
    	}
    }

`hello("여정수", 3)` 

## 클로저 (Closure)

---

클로저를 사용하면 위에서 작성한 코드를 조금 더 간결하게 만들 수 있다.

**클로저는 ( {} ) 중괄호로 감싸진 '실행 가능한 코드 블럭' 이다!**

**기존 함수**

    func helloGenerator(message: String) -> (String, String) -> String {
    
    	func hello(firstName: String, lastName: String) -> String {
    		return lastName + firstName + message
    	}
    
    	return hello
    }

**클로저 { } 이용**

    func helloGenerator(message: String) -> (String: String) -> String {
    		return { (firstName: String, lastnName: String) -> String in   //Closure
    			return lastName + firstName + message
    	}
    }

함수와는 다르게 함수 이름 정의가 따로 존재하지 않는다.

하지만 파라미터를 받을 수 있고, 반환 값이 존재한다는 점은 함수와 동일하다.

위 함수에서 클로저를 반환하는 코드를 좀 더 자세히 살펴보자. 클로저는 { }  중괄호로 감싸져있다.

그리고 파라미터를 괄호로 감싸고 있다. 함수와 마찬가지로 `->` 를 사용해서 반환 타입을 명시한다.

조금 다른점은 `in` 키워드를 사용해서 파라미터, 반환 타입 영역과 실제 클로저 코드를 분리하고 있다.

    { (firstName: String, lastName: String) -> String in
    		return lastName + firstName + message
    }

얼핏 봐서는 간결하다는 느낌이 없지..?? 사실 클로저의 장점은 간결함과 유연함에 있다.

바로 위에서 작성한 코드는 이해를 돕기 위해 생략 가능한 것들을 하나도 생략하지 않고 모두 기재헀기 때문에 조금 복잡해 보일수도 있다.

이제 하나씩 생략해볼까?

`Swift` 는 앞서 배웠던 `Type Inference` 타입 추론 ( 스트링을 스트링으로 알아차리고 인트를 인트로 알아차리는 기능) 덕분에 ,

`helloGenerato()` 함수에서 반환하는 타입을 클로저에서 어떤 파라미터를 받고 어떤 타입을 반환하는지 알 수 있어!

따라서 과감하게 생략해버리자.

    func helloGenerator(message: String) -> (String, String) -> String {
    	return { firstName, lastName in             // 타입 추론, 알아서 이름이 문자열이라는 것을 알아차림
    		return lastName + firstName + message
    	}
    }

훨씬 깔끔해졌지? 근데 여기서 더 생략이 가능해

타입 추론 덕분에 첫번째 파라미터가 문자열이고, 두번째 파라미터도 문자열이라는 것을 알 수 있어.

근데 이걸 첫번째 파라미터는 `$0` , 두번째 파라미터는 `$1` 로 바꿔서 쓸 수도 있어. 아래처럼

    func helloGenerator(message: String) -> (String, String) -> String {
    	return { 
    		return $1 + $0 + message
    	}
    }

이러한 클로저 기능은 변수처럼 정의도 가능해

    let hello: (String, String) -> String = { $1 + $0 + "님 안녕하세요!" }
    hello("정수", "여")

물론 옵셔널로도 정의할 수 있지, 옵셔널 체이닝도 가능하고

    let hello: ((String, String) -> String)?
    hello?("정수", "여")

클로저를 변수로 정의하고 함수에서 반환도 가능한 것 처럼, 파라미터로도 받을 수 있어!

    func manipulate(number: Int, using block: Int -> Int) -> Int {
    	return block(number)
    }
    
    manipulate(number: 10, using: { (number: Int) -> Int in
    	return number * 2
    }

## 클래스와 구조체

---

클래스는 `class` 로 정의하고, 구조체는 `struct` 로 정의한다.

    class Dog {
    	var name: String?
    	var age: Int?
    
    	func simpleDescription() -> String {
    		
    		if let name = self.name {
    			return "\(name)"              // 만일 name에 값이 있다면 이름을 반환한다.
    		} else {
    			return "No name"
    		}
    	}
    }
    
    struct Coffee {
    	var name: String?
    	var size: String?
    
    	func simpleDescription() -> String {
    		if let name = self.name {
    			return "\(name)"
    		} else {
    			return "No name"
    		}
    	}
    }
    
    
    var myDog = Dog()
    myDog.name = "꾸찌"
    myDog.age = 3
    print(myDog.simpleDescription())
    
    var myCoffee = Coffee()
    myCoffee.name = "아메리카노"
    myCoffee.size = "Venti"
    print(myCoffee.simpleDescription())
    

궁극적으로 기능만 살펴보면 클래스와 구조체의 기능은 같다!

가장 큰 차이점은 클래스는 상속이 가능하고 구조체는 불가능하다는 것이다.

    class Animal{
    	let legs = 4
    }
    
    class Dog: Animal {         //Animal 클래스를 상속받은 Dog 클래스
    	var Name: String?
    	var age: Int?
    }
    
    var myDog = Dog()
    print(myDog.legs)   // 4 -> Animal 클래스로부터 상속받은 상수값이 존재하기 때문에 출력된다.

클래스는 참조(Reference) 하고, 구조체는 복사(Copy) 한다.

    var dog1 = Dog()           // dog1은 새로 만들어진 Dog() 를 참조한다.
    var dog2 = dog1            // dog2는 dog1이 참조하는 Dog() 를 똑같이 참조한다.
    dog1.name = "꾸찌"          // dog1의 이름이 바뀌면 Dog()의 이름도 바뀌기 때문에,
    print(dog2.name)           // dog2의 이름을 가져와도 "꾸찌"로 출력된다.
    
    var coffee1 = Coffee()     // coffee1은 새로 만들어진 Coffee() 그 자체다.
    var coffee2 = coffee1      // coffee2는 cofee1을 복사한 값 자체이다.
    coffee1.name = "아메리카노"   // coffee1의 이름을 바꾸어도
    coffee2.name               // coffee2와는 별개이기 때문에 이름이 바뀌지 않는다. 

## 생성자 (Initializer)

---

클래스와 구조체 모두 생성자를 가지고 있다. 생성자에서는 객체의 초기값을 지정하여 생성이 가능하다.

    class Dog {
    	var name: String?
    	var age: Int?
    
    	init() {
    		self.age = 0
    	}
    }
    
    struct Coffee {
    	var name: String?
    	var size: String?
    
    	init() {
    		self.size = "Tall"
    	}
    }

만일 속성이 옵셔널이 아닐 경우, 항상 초깃값을 가져야 한다.

만약 옵셔널이 아닌 속성이 초깃값을 가지고 있지 않을 경우에는 컴파일 에러가 발생한다.

속성을 정의할 때 초깃값을 지정해주는 방법과,

    class Dog {
    	var name: String?
    	var age: Int = 0           // 속성 정의시 초깃값 설정
    }

생성자에서 초깃값을 지정해주는 방법이 있다.

    class Dog {
    	var name: String?
    	var age: Int
    
    	init() {
    		self.age = 0          // 생성자에서 초깃값 설정
    	}
    }

생성자도 함수와 마찬가지로 파라미터를 전달받을 수 있다.

    class Dog {
    	var name: String?
    	var age: Int
    
    	init(name: String, age: Int) {
    		self.name = name
    		self.age = age
    	}
    }
    
    var myDog = Dog(name: "꾸찌", age:3)

만일 상속받은 클래스라면 생성자에서 상위 클래스의 생성자를 호출해줘야 한다.

만일 생성자의 파라미터가 상위 클래스의 파라미터와 같다면 `override` 키워드를 붙여줘야 한다.

`super.init()` 은 클래스 속성들의 초깃값이 모두 설정된 후에 해야 한다. 이후에 자기 자신에 대한 `self` 키워드를 사용할 수 있다.

    class Dog: Animal {
    	var name: String?
    	var age: Int
    
    	override init() {
    		self.age = 0    // 초기값 설정
    		super.init()    // 상위 클래스 생성자 호출
    		print(self.simpleDescription()) 
    	}
    }

---

## 튜플 (Tuple)

튜플은 어떠한 값들의 묶음이다. 배열과 비슷하지만 길이가 고정되어 있다. 즉 원소를 추가하거나 삭제가 불가능하다.

값에 접근할 때에도 `[]` 대신 `.` 을 이용한다.

    var coffeeInfo = ("아메리카노", 5100)
    coffeeInfo.0 //아메리카노
    coffeeInfo.1 //5100
    

이 튜플의 파라미터에 이름을 붙일 수도 있다.

    var namedCoffeeInfo = (coffee: "아메리카노", price: 5100)
    namedCoffeeInfo.coffee // 아메리카노
    namedCoffeeInfo.price // 5100

튜플의 타입 어노테이션을 이렇게 생겼다.

    var coffeeInfo: (String, Int)
    var namedCoffeeInfo: (coffee, String, price: Int)

튜플을 조금 응용하면, 아래와 같이 상수 값도 지정할 수 있지.

    let (coffee, price) = ("아메리카노", 5100)

## 프로토콜 (Protocol)

---

`Swift` 에서의 프로토콜은 , 타 언어에서의 인터페이스다.

최소한으로 가져야 할 속성 또는 메소드를 정의한다.

구현은 하지 않고 진짜 정의만 한다.

    // 전송 가능한 인터페이스를 정의한다.
    
    protocol Sendable {
    	var from: String? { get }
    	var to: String? { get }
    	
    	func send()
    }
    

클래스와 구조체에 프로토콜을 적용시킬 수 있다.

프로토콜을 적용하면, 프로토콜에서 정의한 속성과 메서드를 모두 구현해야 한다! → 일반적 인터페이스와 동일

    struct Mail: Sendable {           // 프로토콜 적용
    	var from: String?
    	var to: String
    
    	func send() {
    		print("Send a mail from \(self.from) to \(self.to)")
    	}
    }
    
    struct Feedback: Sendable {         // 프로토콜 적용
    	var from: String? {
    		return nil         // 피드백은 무조건 익명으로 보낸다.
    	}
    	var to: String
    	
    	func send() {
    		print("Send a feedback to \(self.to)")
    	}
    
    }

프로토콜은 마치 추상 클래스 처럼 사용될 수 있다.

    func sendAnything(_ sendable: Sendable) {
    	sendable.send()
    }
    
    let mail = Mail(from: "duwjdtn1@gmail.com", to: "jeon@stylesha.re")
    sendAnything(mail)
    
    let feedback = Feedback(from: "duwjdtn1@gmail.com")
    sendAnything(feedback)

`sendAnything` 함수는 `Sendable` 타입의 인자를 파라미터로 받는다. 

`Mail` 과 `Feedback` 은 엄연히 다른 타입이지만, 모두 `Sendable` 을 따르고 있으므로 `sendAnything()` 함수에 전달될 수 있다.

## Any 와 AnyObject

---

`Any`는 모든 타입에 대응한다. `AnyObject` 는 모든 객체에 대응한다.

    let anyNumber: Any = 10
    let anyString: Any = "Hi"
    
    let anyInstance: AnyObject = Dog()

`Any` 와 `AnyObject` 는 프로토콜이다. `Swift` 에서 사용 가능한 모든 타입은 `Any`를 따르도록 설계되었고, 모든 클래스들에는 `AnyObject` 프로토콜이 적용되었다.

## 타입 캐스팅 (Type Casting)

---

`anyNumber` 에 10을 넣었다고 해서 `anyNumber` 가 `Int` 가 되는것은 아니다. `Any` 프로토콜을 따르는 어떠한 값이기 때문이다.

    anyNumber + 1          // 컴파일 에러!

이럴 때에는 `as` 를 이용해서 다운 캐스팅 을 해야 한다. `Any` 는 `Int` 보다 더 큰 범위이기 때문에, 작은 범위로 줄인다고 하여 다운 캐스팅이다.

`Any` 는 `Int` 뿐만 아니라 `String` 과 같은 전혀 엉뚱한 타입도 포함되어 있기 때문에 무조건 `Int` 로 변환되지는 않는다.

따라서, `as?` 키워드를 이용해서 옵셔널을 취해야 한다.

    let number: Int? = anyNumber as? Int

옵셔널이기 때문에, 옵셔널 바인딩 문법도 사용할 수 있다.

실제로 이렇게 이용하는 경우가 굉장히 많다.

    if let number = anyNumber as? Int {
    	print(number + 1)
    }

## 타입 검사

---

타입 캐스팅 까지는 필요 없고, 만일 어떤 값이 특정한 타입인지 검사할 때는 `is` 를 사용한다.

    print(anyNumber is Int) // true
    print(anyNumber is Any) // true
    print(anyNumber is String) // false
    print(anyString is String) // true 

## 익스텐션 ( Extension )

---

`Swift` 에서는 이미 정의된 타입에 새로운 속성이나 메서드를 추가할 수 있다.

익스텐션이라는 기능인데 `extension` 키워드를 사용해서 정의할 수 있다.

    extension String {
    	var length: Int {
    		return self.characters.count
    	}
    
    	func reversed() -> String {
    		return self.characters.reversed().map { Strings($0) }.joined(separator: "")
    	}
    }
    
    let str="안녕하세요"
    str.length // 5
    str.reversed() //요세하녕안
