# Codable
---

**cf)[Codable](https://developer.apple.com/documentation/swift/codable)**
<br> 

### Codable 이란?
---

`Codable: A type that can convert itself into and out of an external representation.`

`Codable` 이라는 `Typealias`는 자신을 변환하거나 외부 표현으로 변환할 수 있는 타입을 의미한다.

여기서 외부표현이란 `JSON`과 같은 타입을 의미한다.

<br> <br>

### 선언 
```swift
typealias Codable = Decodable & Encodable
```
`Codable` 은 위와 같이 이루어져 있다.

즉, Codable은 Decodable 과 Encodable 프로토콜을 준수하는 타입이다.

<br> <br>

### Decodable & Encodable
---

Decodable : 자신을 외부표현(External representation)에서 디코딩 할 수 있는 타입
Encodable : 자신을 외부표현(External representation)에서 인코딩 할 수 있는 타입

여기서 외부타입은 간단히 `JSON` 이라고 생까하자.

### 사용방법
---

`Codable`이 어떻게 이루어진 프로토콜인지 파악했다. 

프로토콜을 사용하기 위해서는 **채택** 을 진행해야 한다는 것을 알고있다.

예제를 통해 사용방법을 알아보도록 하자.

```swift

struct Person {
    var name : String
    var age: Int
}
```

위와 같은 구조체가 있다고 가정했을떄, 위 구조체에 `Codable`을 적용해본다.

```swift

struct Person: Codable {
    var name: String
    var age: Int
}
```

여기서 `: Codable` 을 통해 `Codable`을 채택했다는 의미는 `: Decodable, Encodable` 과 동일하다.

Codable을 채택한 구조체 `Person`는 `A type that can convert itself into and out of an external representation` -> 자신을 변환하거나 외부표현으로 변환할 수 있는 타입이 된다.

이를 이용해 `JSON` 타입으로 변환시켜본다.

```swift
let encoder = JSONEncoder()
```

외부표현(JSON)으로 변환하기 위해서는 해당 표현식의 인코더가 필요하다.

이후, `Encode` 하고싶은 `Person` 타입의 인스턴스를 만들어준다.

```swift
let yeojaeng = Person(name: "Yeojaeng", age: 27)
```

인스턴스를 만들었다면 `Encoding`을 진행한다.

```swift

let jsonData = try? encoder.encode(yeojaeng)
```

아까 만든 `encoder`의 인스턴스 메서드 `encode`를 이용해 인코딩한 결과값을 받아온다.

반환값인 `Data`를 정상적으로 받아오면 이를 바탕으로 `Data`를 변환시켜준다.

```swift

encoder.outputFormatting = .prettyPrinted

if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)   //{"name": "yeojaeng", "age": 27}
}



```

이게 끝!

모든 코드내용을 한번에 살펴보도록 한다.

```swift

struct person: Codable {
    var name: String
    var age: Int
}

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let yeojaeng = Person(name:"Yeojaeng", age:27)
let jsonData = try? encoder.encode(yeojaeng)

if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}
```

> 1. JSONEncoder 선언
>
> 2. JSONEncoder.encode() 메소드를 통해 인스턴스를 Data 타입으로 변환
>
> 3. Data타입을 String타입으로 변환

이렇게 `Codable`을 이용해여 일반 타입의 데이터를 `JSON` 형태의 데이터로 변환할 수 있다.

이어서 인코딩한 결과값을 디코딩하여 원상복구 해보도록 한다.

```swift
let decoder = JSONDecoder()
// JSONDecoder 인스턴스 생성

var data = jsonString.data(using: .utf8)
// JSON -> Data 타입으로 변환

if let data = data, let myPerson = try? decoder.decode(Person.self, from: data) {
    print(myPerson.naem)        // yeoajeng
    print(myPerson.age)         // 27
}

```



