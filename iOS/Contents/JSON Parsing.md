# JSON Parsing with Codable

<br>

최근 JSON Parsing에 대한 이해가 완벽하지 않다는 것을 깨닫고 이번 기회에 다시 복습하며 정리한 내용을 기록하고자 오랜만에 쓰는 포스트입니다.

## JSON to Codable
---

앱을 구현하다보면 네트워킹 작업이 필수불가결하며 서버에서 가져오는 데이터는 대부분 JSON 포맷을 따릅니다.

따라서, 해당 데이터를 가공하여 우리 iOS 앱에 보여주기 위해서는 Swift를 통해 JSON을 다뤄야합니다.

친절한 Apple은 이를 위해 `Codable` 이라는 프로토콜을 제공하며 이를 통해 더욱 간편하게 JSON을 다룰 수 있도록 합니다.

`Codable` 프로토콜은 `Encodable` & `Decodable` 조합의 typealias입니다.

그러면 이를 이용하여 JSON 파싱을 하는 방법에 대해 살펴보도록 하겠습니다.

아래와 같은 구조체 모델이 있다고 가정해볼께요

```swift
struct Contact: Codable {       // Codable 채택
    var firstName: String
    var lastName: String
    var email: String
    var id: Int
}
```

Contact 라는 구조체 모델은 Codable 프로토콜을 채택한 구현체이며 firstName, lastName, email, id 라는 프로퍼티를 갖습니다.

명심해야 할 것은 프로퍼티의 이름이 key-value 쌍의 JSON 데이터 중 Key값의 이름과 동일시 해주는 것이 좋습니다. (꼭 동일시 해줘야하는 것이 의무는 아니지만 동일할 경우 번거로움을 줄일수 있죠)

우리는 이제 Contact라는 구조체를 이용하여 데이터를 파싱할 준비가 되었습니다.

서버와의 네트워킹을 통해 받아오는 데이터를 임의의 상수 `jsonString` 으로 예시를 살펴보겠습니다.

```swift
let jsonString = """
    {
        "firstName: "Jungsu",
        "lastName: "Yeo",
        "email": "duwjdtn1@gmail.com",
        "id": 101
    }
"""

struct Contact: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var id: Int
}

func parseContact() -> Contact? {
    do {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }
        let contact = try JSONDecoder().decode(Contact.self, from: jsonData)
        return contact
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

let contact = parseContact()
print(contact.firstName)
```

JSON 값을 기반으로 JSONDecoder를 통해 `Contact` 모델의 객체를 만드는 로직의 함수를 구현하였습니다.

이를 통해 parseContact 함수를 호출하면 JSON 값을 디코딩하여 스위프트 객체를 생성합니다.

흐름은 매우 간단합니다만 JSON이 어떻게 오냐에 따라 파싱 작업이 다양하게 응용됩니다.

예를 들어 `firstName` 이라는 프로퍼티를 갖도록 구조체 모델을 설계하였으나 실제 서버에서 받아오는 필드 이름이 `first_name` 인 경우에는 어떨까요?

분명 Codable만으로는 해당 필드를 적절하게 파싱하기는 힘듭니다.

이러한 경우를 대비하여 Apple은 `CodingKeys` 라는 열거형을 제공합니다.

각각의 프로퍼티에 대한 CodingKey들을 설정하여 모델의 프로퍼티명과 서버에서 오는 데이터의 필드 명이 다를 경우에 대한 커버가 가능하죠.

```swift
struct Contact: Codable {
    var firstName: string
    var lastName: String
    var email: String
    var id: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"       // 서버에서 오는 데이터의 필드명이 first_name인 경우를 모델의 firstName으로 매칭시키겠다.
        case lastName
        case email
        case id
    }
}
```

이렇게 CodingKey를 통해 해당 이슈를 간단히 해결할수 있습니다.

<br>

## Handling NULL
---

그렇다면 만일 특정 프로퍼티가 NULL 로 넘어오는 경우는 어떨까요?

앞서 작성했던 코드로 앱을 실행시킨다면 우리 앱은 크래시가 일어납니다.

Swift는 타입에 매우 엄격하며 안전을 매우 중요시하는 언어입니다.

이에 대비하여 `Optional` 타입을 제공하죠.

이를 응용하여 위 문제를 대비할 수 있습니다.

```swift

// JSON without email key
let jsonString = """
    {
        "first_name": "Jungsu",
        "lastName": "Yeo",
        "id": 101
    }
"""

struct Contact: Codable {
    var firstName: String
    var lastName: String
    var email: String?                  // JSON 데이터 중 email 키 값이 있을수도 혹은 없을수도 있으니 옵셔널 타입으로 선언
    var id: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName
        case email
        case id
    }
}
```

위와 같이 Optional 타입을 이용하여 해결하였습니다.

하지만 만일 Optional을 핸들링하고 싶지 않다면 아래와 같이 Decodable 프로토콜을 응용해서도 문제를 풀어낼 수 있습니다.

Decodable을 이용하면 nil value 또는 missing key 이슈를 모두 커버할 수 있죠.

```swift
struct Contact: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var id: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lasstName
        case email
        case id
    }

    // Decodable의 Initializer
    init(from decoder: Decoder) throws {
        // 1 - container 생성
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // 2 - 일반적인 디코딩
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        id = try container.decode(Int.self, forKey: .id)

        // 3 - 조건적 디코딩
        if var emial = try container.decodeIfPresent(String.self, forKey: .email) {
            self.email = email
        } else {
            self.email = "N/A"
        }
    }
}
```

`Decodable` 프로토콜 내에 존재하는 `init` 생성자를 이용하여 안전하게 파싱 작업을 진행하였습니다.

`CodingKeys` 를 기반으로 디코딩을 진행하되 만일 nil 값이 들어올수도 있는 프로퍼티의 경우 `decodeIfPresent` 를 통해 풀어냈습니다.

여태 `init(from decoder:)` 생성자를 자주 사용하지는 않았으나 최근 들어 자주 사용하게 되었으며 이를 사용하며 더욱 JSON을 가공하는데 이해를 높일 수 있었습니다.