# Enumerations

열거형은 서로 연관있는 값들을 그룹지어 정의할 수 있도록 해줍니다.

이를 통해 우리의 코드 내에서 Type-Safe 한 방법으로 해당 값들을 사용할 수 있도록 해줍니다.

Swift의 Enum은 String, Character 등 다양한 값들을 넣을수 있도록 더욱 유연한 기능을 제공합니다.

<br>

## Enumeration Syntax
---

열거형은 `enum` 키워드를 통해 정의합니다.

```swift
enum SomeEnumeration {
    // enumration definition goes here
}
```

이번엔 동서남북 방향에 대한 열거형은 정의해보겠습니다.

```swift
enum CompassPoint {
    case east
    case west
    case south
    case north
}
```

열거형 내 정의된 값(east, west, south, north)들은 열거형의 각각의 case에 대응됩니다.

여러 케이스들을 콤마 구분자를 이용하여 한 라인에 정의하는것 또한 가능합니다.

```swift
enum Planet {
    case earth, mercury, venus, mars, jupiter, saturn, uranus, neptun
}
```

각각의 열거형들은 새로운 타입을 정의합니다. 

이번엔 Enumerations을 Switch과 응용하는 사례에 대해 알아보겠습니다.

<br>


## Matching Enumeration Values with a Switch Statement
---

```swift
enum CompassPoint {
    case east
    case west
    case south
    case north
}

var directionToHead = CompassPoint.south

switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
}
```

Enum과 Switch문을 같이 사용하게되면 Enum에 정의된 각각의 case들에 따라 switching이 가능해집니다.

로직에 대한 분기 경우의 수가 다양한 경우 흐름을 제어하기 용이합니다.

이러한 흐름을 제어하기 위한 enum을 사용할 경우 enum 내 선언된 모든 case를 명확히 제어해주는것이 좋습니다.

만일 그렇지 못한 상황이라면 `default` 케이스를 통해 명시하여 제어중인 case를 제외한 모든 case를 제어할수 있습니다.

```swift
enum Planet {
    case earth, mercury, venus, mars, jupiter, saturn, uranus, neptun
}

let somePlanet = Planet.earth

switch somePlanet {
    case .earth:
        print("Planet.earth case")
    default:
        print("other cases")
}
```

<br>

## Iteracting over Enumeration Cases
---

enum은 정의된 모든 case들을 순회할 수 있도록 하는 기능 또한 제공합니다.

모든 case를 순회하기 위해서는 `CaseIterable` 프로토콜을 채택합니다.

```swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
```

위 예시에서 Beverage라는 열거형은 `CaseIterable` 프로토콜을 채택하였으며 이를 통해 열거형 타입의 프로퍼티 `allCases`에 접근할수 있께 되었습니다.

`allCases` 해당 열거형의 모든 케이스를 의미합니다.

따라서 이를 통해 모든 케이스를 순차적으로 접근할수 있습니다.

```swift
for beverage in Beverage.allCases {
    print(beverage)
}
```

<br>

## Associated Values
---

이전에는 enum 내 각각의 case들을 정의하고 이를 어떻게 사용하는지 살펴봤다면 이번에는 이를 더욱 유연하게 사용할 수 있는 방법에 대해 살펴보겠습니다.

enum을 이용하여 상품에 대한 바코드의 번호와 QRCode값을 정의해보겠습니다.

```swift
enum Barcode {
    case upcNumber(Int, Int, Int, Int)
    case qrCode(String)
}
```

위 코드는 아래와 같이 해석할수 있습니다.

`BarCode` 라는 열거형을 정의하는데 이는 Int형 값 4개 타입 연관값을 갖는 `upcNumber` 와 String형 타입 연관값을 갖는 `qrCode` 라는 case가 될 수 있습니다.

위 정의 자체만으로는 어떠한 Int 또는 String 값을 제공하지는 않습니다.

이는 단지 연관값들에 대한 `type`을 정의한 것이며 이는 매번 정의할때 마다 새로운 값을 갖게됩니다.

위에서 정의한 각각의 타입들을 직접 초기화해서 객체를 만들어 보겠습니다.

```swift
var productBarcode = Barcode.upcNumber(8, 85909, 51226, 3)
```

`productBarcode` 라는 변수를 새로 생성하였으며 이는 upcNumber 케이스에 해당되며 `upcNumber` 라는 연관값 `(Int, Int, Int, Int)`를 초기화하였습니다.

같은 방법으로 다른 타입의 바코드로 다시 정의할수 있습니다.

```swift
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
```

이번에는 이를 switch문과 함께 사용해보겠습니다.

```swift
switch productBarcode {
    case .upcNumber(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR Code: \(productCode).")
}
```

각각의 케이스들에 대해 연관된 데이터를 저장하기 위한 타입을 정의하는데 이를 associated values 라고 부릅니다. 

<br>

## Raw Values

위에서 살펴본 Associated Values는 각각의 case들에 대해 연관된 값들을 정의하고 사용하기 위한 기능이었다면 이번에 살펴볼 기능은 case 자체에 값을 정의하는 기능입니다.

case 자체에 값을 부여할때는 원시값(Raw Value) 이라는 형태로 실제값을 부여하게 됩니다.

```swift
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

위에서 정의한 열거형 `ASCIIControlCharacter`는 Character 타입으로 정의되었으며 일반적으로 사용되는 ASCII 캐릭터들을 Raw Value로 같습니다.

Raw Value는 string, character, integer, float 등 어떠한 타입도 사용이 가능하며 각각의 Raw Value들은 열거형 내 중복이 불가합니다.

<br>

## Reference
---

- [docs.swift.org - Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)