# OOP 그리고 POP
---

이번 문서에서는 OOP와 POP에서의 Swift 사용 방법에 대해 살펴봅니다.

객체지향 프로그래밍 개념에 대한 이해도가 높으면 프로토콜지향 프로그래밍을 이해하는데 큰 도움이 된다고 생각하며, 프로토콜지향 프로그래밍으로 해결하고자 했던 문제에 대해서 통찰력을 얻을 수 있을 것 입니다.

<br>

## 객체지향 프로그래밍이란
---

객체지향 프로그래밍에서는 이름 그대로 **객체**가 핵심입니다. 

**객체**는 프로퍼티로 불리는 속성 정보와 메소드로 불리는 객체가 수행하는 행위의 정보를 가진 자료구조입니다.

이러한 객체를 지향하는 프로그래밍을 구현하기 위해서는 객체의 프로퍼티와 메소드를 정의하는 것도 좋지만, **객체 간에 상호작용이 어떻게 이뤄지는지에 대해 더욱 깊은 이해가 필요합니다.**

객체 간 상호작용에 대한 이해도가 높으면 더욱 올바른 객체를 설계할 수 있기 때문입니다.

대부분의 객체지향 프로그래밍 언어에서는 청사진을 클래스의 형태로 나타냅니다.

클래스는 일종의 구성체로, 프로퍼티와 메소드를 코드에서 나타내고자 하는 개체를 모델링하는 단일 타입의 캡슐화입니다.

해당 클래스의 인스턴스를 생성하기 위해서 우리는 주로 클래스의 생성자(Initializer)를 사용하며 이를 통해 객체가 갖게되는 프로퍼티의 초깃값을 설정하거나 클래스에서 필요로하는 다른 초기화 작업을 수행하게 됩니다.

OOP에서는 이러한 클래스들을 기반으로 설계를 진행하게 됩니다.

<br>

## 프로토콜지향 프로그래밍
---

기존에 객체지향 설계 방식에서는 슈퍼클래스를 설계로 시작하였으나 프로토콜지향 설계 방식은 프로토콜로 설계를 시작합니다.

이러한 프로토콜지향 설계 방식에서는 3가지 기술이 주로 사용됩니다.

- 프로토콜 상속
- 프로토콜 컴포지션
- 프로토콜 확장

상속이란 어떠한 프로토콜이 다른 프로토콜로부터 요구사항을 상속받는 것을 의미하며 이는 객체지향 프로그래밍에 있는 클래스 상속과 유사합니다.

그러나 슈퍼클래스의 기능들을 상속하는 대신 여기서는 프로토콜로부터 요구 사항들을 상속받습니다.

또한, 프로토콜 상속은 클래스 상속과는 달리 다중 상속이 가능하다는 장점이 있습니다.

프로토콜 컴포지션은 하나 이상의 프로토콜을 따를 수 있도록 해줍니다.

단일 프로토콜을 따르는 타입도 있는 반면, 프로토콜 컴포지션을 사용해 다중 프로토콜을 따르는 타입을 만드는 것 또한 가능합니다.

이 두가지(프로토콜 상속, 프로토콜 컴포지션) 개념을 적절히 활용하면 더 작으면서도 구체적인 프로토콜을 만들 수 있는데 용이하기 때문에 프로토콜지향 설계 방식에서 매우 중요한 개념입니다.

OOP에서 슈퍼 클래스가 비대해지는 불상사를 POP에서 상속과 컴포지션을 이용하여 해결할 수 있씁니다.

프로토콜 확장은 프로토콜의 초기 구현시 주로 이용되며 해당 프로토콜을 따르는 타입에 메소드와 프로퍼티 구현체를 제공하게 프로토콜을 확장할 수 있는 기능을 제공합니다.

아래에 `Vehicle` 이라는 프로토콜을 생성하며 직접 살펴보도록 하겠습니다.

```swift
protocol Vehicle {
    var hitPoints: Int { get set }      // 변수
}
```

`vehicle` 프로토콜에 이동수단의 남은 체력 정보를 저장할 `hitPoints` 라는 프로퍼티를 하나 정의합니다.

그리고 해당 프로토콜에 확장 개념을 더하여 기능을 제공해보겠습니다.

```swift
extension Vehicle {
    mutating func takeHit(amount: Int) {
        hitPoints -= amount
    }

    func hitPointsRemaining() -> Int {
        return hitPoints
    }

    func isAlive() -> Bool {
        return hitPoints > 0 ? true : false
    }
}
```

위와 같이 `Vehicle` 프로토콜을 확장하여 3가지 메소드를 정의합니다.

그러면 앞으로 `Vehicle` 프로토콜을 따르는 모든 타입 혹은 `Vehicle` 프로토콜을 상속한 프로토콜을 따르는 모든 타입은 자동으로 위 메소드들을 받게 될 것 입니다.

위에서 정의한 `Vehicle` 프로토콜을 상속하는 프로토콜들을 정의해보도록 합니다.

```swift
protocol LandVehicle: Vehicle {
    var landAttack: Bool { get }        // 상수
    var landMovement: Bool { get }      // 상수
    var landAttackRange: Int { get }    // 상수
    
    func doLandAttack()
    func doLandMovement()
}

protocol SeaVehicle: Vehicle {
    var seaAttack: Bool { get }
    var seaMovement: Bool { get }
    var seaAttackArrange: Int { get }

    func doSeaAttack()
    func doSeaMovement()
}

protocol AirVehicle: Vehicle {
    var airAttack: Bool { get }
    var airMovement: Bool { get }
    var airAttackRange: Int { get }

    func doAirAttack()
    func doAirMovement()
}
```

위 프로토콜에 대해서 살펴보겠습니다.

위에서 정의한 3가지 프로토콜은 모두 `Vehicle` 프로토콜을 상속하였기에 요구사항을 상속받았기에 `Vehicle` 프로토콜 확장으로부터 기능을 상속 받습니다.

또한 모든 프로퍼티를 `get` 속성으로만 정의했는데, 이는 이들 프로토콜을 따르는 타입에서 해당 프로퍼티를 상수로 정의하겠다는 것을 의미합니다. `get set` 속성으로 정의한다면 변수로 정의한다는 의미가 되겠죠?

이번엔 위에서 정의한 프로토콜 중 하나를 채택하는 타입을 만들어보겠습니다.

```swift
struct Tank: LandVehicle {
    var hitPoints = 68      // Vehicle 프로토콜의 요구사항
    let landAttack = true   // LandVehicle 프로토콜의 요구사항
    let landMovement = true
    let landMovementArrange = 5

    func doLandAttack() {
        print("Tank Attack")
    }

    func doLandMovement() {
        print("Tank Move")
    }
}
```

OOP가 아닌 POP 에서는 참조 타입 대신 값 타입을 활용하여 더욱 안정성을 높일 수 있습니다.

값 타입 사용을 통해 멀티스레드 환경에서 Thread-safe 한 개발이 가능합니다.

이번에는 프로토콜 컴포지션을 활용하여 다른 타입을 만들어보도록 하겠습니다.

```swift
struct Ampibious: LandVehicle, SeaVehicle {
    var hitPoints = 25
    let landAttackRagne = 1
    let seaAttackRange = 1

    let landAttack = true
    let landMovement = true

    let seaAttack = true
    let seaMovement = true

    func doLandAttack() {
        print("Amphibious Land Attack")
    }

    func doLandMovement() {
        print("Amphibious Land Move")
    }

    func doSeaAttack() {
        print("Amphibious Sea Attack")
    }

    func doSeaMovement() {
        print("Amphibious Sea Move")
    }
}
```

Amphibious 라는 타입을 생성하였습니다.

해당 구조체는 여러 이동수단 타입을 따르기 위해 프로토콜 컴포지션 개념을 사용하였습니다.

프로토콜 컴포지션을 이용해 `LandVehicle` 프로토콜과 `SeaVehicle` 프로토콜을 동시에 채택하여 두 프로토콜 내에 정의된 모든 기능을 가질 수 있게 되었습니다.


























