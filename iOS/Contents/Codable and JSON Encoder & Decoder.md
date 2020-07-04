# Codable 그리고 JSON Encoder & Decoder

<br>

## Codable
---

```swift
typealias Codable = Decodable & Encodable
```

인코딩 : 정보의 형태 또는 형식을 다른 형태, 형식으로 변환하는 처리 방식

디코딩 : 인코딩의 반대 작업


`Codable`은 스위프트의 인스턴스를 다른 데이터 형태로 변환하고 그 반대의 역할을 수행하는 방법을 제공해준다.

스위프트의 인스턴스를 다른 데이터 형태로 변환하는 것을 `Encodable` 프로토콜에 표현하였고, 그 반대로 다른 데이터 형태를 스위프트 인스턴스로 변환하는 것을 `Decodable`로 표현하였다.

### Example

Coordinate 타입과 Landmark 타입의 인스턴스를 다른 데이터 형식으로 변환(인코딩)하고 싶은 경우, `Codable` 프로토콜을 준수하도록 하면 된다.

`Codable` 타입의 프로퍼티는 모두 `Codable` 프로토콜을 준수하는 타입이어ㅑ 한다.

```swift

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
    
}

struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var vantagePoints: [Coordinate]
    var metadata: [String: String]
    var website: URL?
}
```

위 코드에 존재하는 두 개의 구조체 모두 `Codable` 프로토콜을 채택하고 있다.

이를 통해 해당 구조체의 인스턴스를 다른 데이터 타입 (ex: JSON)으로 변환하는 인코딩 작업 또는 타 테이터 타입을 위 구조체 인스턴스로 변환하는 디코딩 작업을 진행할 수 있다.

<br>

## CodingKey

개발을 진행하다보면 `JSON` 형태의 데이터를 자주 다루게 되며 이를 상호 변환하고자 할 때는 기본적으로 인코딩/디코딩 할 **JSON 타입(key:value)의 키와 애플리케이션의 사용자정의 프로퍼티가 일치해야 한다.**

만일 `JSON`의 키 이름을 구조체 프로퍼티의 이름과 다르게 표현하려면 `CodingKey`를 이용해야 한다.

### Example

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: int
    var location: Coordinate
    var vantagePoints: [Coordinate]

    enum CodingKeys: String, CodingKey {
        case name = "title"  // Codable property = JSON Key
        case foundingYear = "founding_date" // Codable property = JSON Key

        // JSON 타입의 키와 구조체의 프로퍼티 이름이 동일하다면 값을 할당하지 않아도 무방하다.
        case location
        case vantagePoints
    }
}
```

위와 같이 `CodingKeys` 열거형을 작성한다.

프로퍼티의 열거형 케이스의 값으로 매칭할 JSON의 키 값을 작성하면 된다.

즉 실제 JSON 데이터의 키 값이 `title`인데 이를 Landmark.name에 매칭하고 싶은 경우에는 `case name = "title"` 과 같이 작성한다.

<br>

## JSONEncoder / JSONDecoder

`Codable` 프로토콜을 채택해 작성한 모델을 `JSONEncoder, JSONDecoder`를 이용해 JSON 형식으로 인코딩 및 디코딩 할 수 있다.

즉, JSONEncoder 및 JSONDecoder를 활용하여 스위프트 타입의 인스턴스를 JSON 데이터로 인코딩, JSON 데이터에서 스위프트 타입의 인스턴스로 디코딩할 수 있습니다.

`Codable` 프로토콜을 준수하는 GroceryProduct 구조체의 인스턴스를 JSON 데이터로 인코딩 하는 방법이다.
```swift

struct GroceryProduct: Codable {
    var name: String
    var points: int
    var description: String?
}

let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear.")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
    let data = try encoder.encode(pear)
    print(string(data: data, encoding: .utf8)!)
} catch {
    print(error)
}

/*
 {
   "name" : "Pear",
   "points" : 250,
   "description" : "A ripe pear."
 }
*/
```

JSON 데이터를 `Codable` 프로토콜을 준수하는 GroceryProduct 구조체의 인스턴스로 디코딩 하는 방법이다.

```swift
struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let json = """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

do {
	let product = try decoder.decode(GroceryProduct.self, from: json)
	print(product.name)
} catch {
	print(error)
}

// "Durian"
```
