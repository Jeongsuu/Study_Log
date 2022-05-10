# Swift API Design Guidelines

[Swift.org](https://www.swift.org/documentation/api-design-guidelines/)

# 목차

**1.Fundamentals - 기초**

**2.NAMING - 명명**

- Promote Clear Usage - 사용법을 분명히 하세요
- Strive for Fluent Usage - 편리한 사용성을 위해 노력하세요
- User Terminology Well - 용어를 제대로 사용하세요
1. CONVENTIONS
    - General Conventions - 일반적인 컨벤션
    - Parameters - 파라미터
    - Argument Labels - 인자명
2. Special Instructions

<br>
<br>

## Fundamentals - 기초

---

---
<br>

### **사용하는 쪽 입장에서 명확**하다고 느끼게 하는 것이 가장 중요한 목표입니다.

<br>

<aside>
💡 메소드, 프로퍼티와 같은 요소들은 일반적으로 한번 선언하고 반복적으로 참조 및 호출하게 됩니다. **반복이 거듭되는 요소일수록 더욱 명확하고 간결하게** 사용할 수 있도록 설계해야 합니다.

설계의 평가는 선언부만 보고 평가하는 경우는 거의 없습니다. 항상 UseCase를 바탕으로 평가가 이루어지며 **특정 문맥 속에서 명확해 보이는것이 중요합니다!**

<br>

</aside>

### 명확한 것이 간결한 것보다 중요합니다.

<br>

<aside>
💡 개인의 취향 혹은 더 나아가 사내에 정립된 컨벤션에 따라 다소 차이가 존재.

Swift 코드를 최대한 압축하여 표현할 수 있기는 하지만, **가장 짧은 코드가 가장 좋은 코드는 아닙니다.

코드의 길이를 줄이는 것을 목표로 하기 보다는 명확히 표현하되 간결하게 가져가는 것이 바람직합니다.**

</aside>

<br>

### 문서 주석을 활용하세요.

<br>

<aside>
💡 모든 선언부에 대하여 문서 주석(Documentation Comment)를 작성하세요.

문서를 작성하며 얻은 통찰은 당신의 설계에 큰 영향을 줄 수 있습니다.

</aside>

<aside>
💡 API를 간단하게 설명하는 것이 어렵다면, API를 잘못 설계했을 지도 모릅니다 :D

</aside>

<br>
<br>

# NAMING - 명명


## Promote Clear Usage - 사용법을 분명히 하세요

### 필요한 단어들을 모두 포함해주세요.

---

<br>

코드를 읽는 사람(ex: 클라이언트, 협업자)가 코드를 읽고 모호함을 느끼지 않아야 합니다. 
예를 들어, `collection` 안에서 주어진 `position` 의 `element` 를 제거하는 메소드가 있다고 가정해볼게요.

<br>

**Bad**

```swift
employees.remove(x)     // 제거 대상이 명확하지 않음, x번쨰 요소를 제거하는건가? x라는 요소를 제거하는건가?
```

**Good**

```swift
extension List {
	public mutating func remove(**at postiion:** Index) -> Element
}

employees.remove(at: x)    // x 번째에 위치한 employ를 제거한다.
```

이와 같이 **필요한 단어**는 **모두 포함**하여 모호함을 줄입니다 😀

<br>

### 불필요한 단어를 생략하세요.

---

<br>

네이밍에 들어가는 모든 단어는 **사용되는 시점(at the use site)** 에 핵심적인 정보만을 전달해야 합니다.

**Bad**

```swift
public mutating func removeElement(_ member: Element) -> Element?

allViews.removeElement(cancelButton)
```

위의 예시의 `method signature` 를 보면  `Element` 라는 타입을 기재 했으나 의미있는 정보가 더해지지는 않았습니다.

함수의 이름에서 Element를 제거하겠다는 것과 파라미터의 타입에서도 Element제거하겠다는 것이 중복 표현이 되고 있습니다. → 타입의 정보가 반복되고 있습니다.

이 API는 아래와 같이 디자인하면 더욱 좋습니다!

**Good**

```swift
public mutating func remove(_ member: Element) -> Element?

allViews.remove(cancelButton) // Clearer
```

때로는 모호함을 피하기 위해 타입 정보를 반복하여 네이밍을 해야하는 경우가 있을 수 있습니다.

하지만 일반적으로는 파라미터의 역할로 네이밍을 하는 것이 타입으로 네이밍을 하는 것 보다 좋습니다.

이에 대한 내용은 아래에서 더 자세히 알아볼게요 :D

<br>

<br>

### 타입 대신 역할에 따라 변수(Variables), 파라미터(Parameters), 연관타입(Associated Types) 을 네이밍하세요.

---

**Bad**

```swift
var string = "Hello"              // String 이라는 타입으로 네이밍

protocol ViewController {
	associatedtype ViewType: View   // View의 Type으로 네이밍
}

class ProductionLine {
	func restock(from widgetFactory: WidgetFactory) // WidgetFactory 라는 타입으로 네이밍
}
```

위와 같은 방식으로 타입 이름을 정의하면 명확하게 표현하는 것이 어려워집니다.

대신, 엔티티의 역할을 표현하는 이름을 사용해보세요.

**Good**

```swift
var greeting = "Hello"

protocol ViewController {
	associatedtype ContentView: View
}

class ProductionLine {
	func restock(from supplier: WidgetFactory)
}
```

만일 `associatedtype` 이 해당 `protocol` 제약에 강하게 결합되어 `protocol` 의 이름 자체가 역할(role)을 표현한다면, 충돌을 피하기 위하여 `protocol`이름의 마지막에 `Protocol` 을 붙여줄 수 있습니다.

```swift
protocol Sequence {
	associatedtype Iterator: IteratorProtocol
}

protocol IteratorProtocol { ... }
```

<br>
<br>

### 파라미터의 역할을 명확히 하기 위하여 불충분한 type의 정보를 보충하세요.

---

특히 파라미터 타입이 `NSObject` , `Any`, `AnyObject` 또는 기본 타입(`Int` 또는 `String` 과 같은 타입) 이라면 타입 정보와 사용하는 시점의 **문맥이 의도를 충분히 드러내기 힘들 수 있습니다**.

아래 예시를 살펴보면 정의는 충분히 명확함에도 불구하고, 사용하는 곳에서는 메소드의 의도가 애매합니다.

**Bad**

```swift
func add(_ observer: NSObject, for keyPath: String)

grid.add(self, for: graphics)   // 의도가 명확하지 못험
```

이러한 모호함을 해결하기 위해서는 `type` 자체에 많은 정보를 얻을 수 없는 `parameter` 앞에 역할을 명시(라벨링) 하는 것이 좋습니다.

**Good**

```swift
func addObserver(_ observer: NSObject, forKeyPath path: String)

grid.addObserver(self, forKeyPath: graphics)  // 훨씬 명확함.
```

<br>
<br>

## Strive for Fluent Usage - 유창한(?) 사용성을 위해 노력하세요

여기서 의미하는 “유창한” 은 코드를 읽는데 마치 영어 문장을 읽는듯한 느낌을 의미합니다.

### `method` 와 `function`을 영어 문장 처럼 사용할 수 있도록 하세요.

---

```swift
x.insert(y, position: z)        // 이해는 됩니다, 하지만 물 흐르듯 자연스럽게 읽히는 문장은 아닙니다.
x.insert(y, at: z)              // "x, insert y at z"

x.subViews(color: y)
x.subViews(havingColor: y)      // "x, subviews having color y"

x.nounCapitalize()
x.capitalizeNouns()             // "x, capitalizing nouns"
```

**다만, 첫번째 또는 두번째 argument 이후에 주요 argument가 아닌 경우에는 유창함이 떨어지는 것이 허용됩니다.**

```swift
AudioUnit.instantiate(with: description,
											options: [.inProcess],
											completion: stopProgressBar)
)
```

<br>
<br>


### 부수효과(side-effect)를 기반해서 `function` 과 `method` 네이밍을 하세요.

---

- side-effect가 없는 것은 명사로 읽혀야 함. eg. `x.distance(to: y)`
- side-effect가 있는 것은 동사로 읽혀야 함. eg. `print(x)` , `x.append(y)`
- mutating / nonmutating method의 이름을 일관성 있게 지으세요.
    
    
    | Mutating | NonMutating |
    | --- | --- |
    | x.sort() | z = x.sorted() |
    | x.append() | z = x.appending(y) |


<br>
<br>

### 능력을 설명하는 프로토콜을 able, ible, ing를 사용한 접미사로 네이밍해야 합니다.

- eg: `Equatable`, `hashable`, `ProgressReporting`

<br>
<br>

## Use Terminology Well - 용어를 제대로 사용하세요

---

Term of Art: (Noun) 예술 용어 - 특정 필드나 전문영역에서 정확하고 특별함을 갖는 단어나 구절 == 전문 용어

- **일반적인 단어가 의미를 더 잘 전달한다면 굳이 잘 알려져 있지 않은 용어를 사용하지 마세요.**
    - 우리가 “피부”를 표현하고자 합니다,  `skin` 으로 의도를 드러낼 수 있습니다. 굳이 `epidermis` 와 같은 의학 용어를 사용하지 마세요.
    - **전문 용어는 필수적 대화 수단이지만, 사용하지 않으면 그 뜻이 제대로 전달되지 않는 경우에 사용해야 합니다.**
    
- **전문 용어를 사용한다면 확립된 의미를 사용하세요.**
    - 일반 용어를 사용해서는 정확한 의미 전달이 안되는 경우에만, 전문 용어를 사용하여 정확히 의미를 전달하는 것이 좋습니다.
    
- **약어(abbreviations) 사용을 피하세요.  특히** 정형화 되어 있지 않고 모두에게 익숙치 않은 약어라면 이 약어를 이해하기 위해 다시 풀어서 해석을 해야하는 과정이 필요합니다.
    - 따라서, 약어 또한 전문 용어(아는 사람만 아는 것) 이라고 볼 수 있습니다.
    - 사용된 약어의 의도된 의미는 인터넷 검색을 통해 쉽게 찾아낼 수 있어야 합니다.
    
- **관례를 따르세요.** 기존 문화와 다른 용어를 사용하면서까지 초심자를 배려하지 마세요.
    - 수학같은 특정 프로그래밍 도메인에서, `sin(x)` 와 같이 광범위하게 사용되는 용어는 그대로 사용하는 것이 `verticalPositionOnUnitCircleAtOriginOfEndOfRadiusWithAngle(x)`  같은 네이밍보다 100번 바람직합니다.
    - 이는 약어를 피하는 것이 아니라 **관례를 따르는 것에 더 가중치가 있다는 것에 주목**해야 합니다. 비록 온전한 단어는 `sine` 이지만 “sin(x)” 는 프로그래머들에게는 수십년간, 수학자들에게는 수세기 동안 보편적으로 사용되어 온 관례입니다.
    
<br>
<br>

# CONVENTIONS

---

<br>

**한낱 텍스트에 불과한 코드를 작성하는데 일관성과 규칙이 얼마나 중요할까요?**

**물론 코드 컨벤션은 필요 없을수도 있습니다.**

- 혼자 개발한다. ~~(저는 개인적으로 홀로하는 프로젝트에서도 컨벤션을 유지하는 것을 선호합니다.)~~
- 1년 전에 내가 짠 코드를 보더라도 단번에 파악할 수 있다.
- 내가 아닌 다른 누군가가 쓴 코드를 보더라도 작성자의 설명 혹은 주석 없이 단번에 파악할 수 있다.
- 반대로 “나의 코드는 누가 보더라도 단번에 이해가 가능할 정도로 잘 쓰여진 코드다” 라고 자부하는 사람의 경우.

**그렇다면 컨벤션을 확립하고 이행해 나간다면 어떠한 장점이 있을까요?**

- 코드 구조의 일관성을 유지할 수 있습니다.
- 타 팀원들과 소통 또는 유지보수 시 코드를 이해하는데 있어 많은 시간과 노력에 드는 비용을 줄일 수 있습니다.
- 새로운 인원이 합류하더라도 일관성있는 코드를 보며 더욱 빨리 업무에 익숙해질 수 있습니다.
- 팀원뿐만 아니라 코드를 보는 모든 사람에게 높은 수준의 가독성을 제공합니다.

<br>
<br>

## General Conventions - 일반적인 컨벤션

---

<br>

### 전역 함수 대신 `method` 와 `property` 를 활용하세요.

---

전역 함수는 아래와 같이 특수한 경우를 위해 고안되었습니다.

1. 명확한 `self` 가 없는 경우
    - `min(x, y, z)`
2. function이 generic 으로 제약조건이 걸려있지 않은 경우
    - `print(x)`
3. function 구문이 특정 도메인의 표기법인 경우
    - `sin(x)`

<br>
<br>

### 대소문자 컨벤션을 따르세요.

---

`type` , `protocol` 의 이름은 UpperCamelCase, 나머지는 lowerCamelCase를 따릅니다.

미국 영어에서 보통 **all upper case**로 사용되는 **Acronyms and initialisms**(단어의 첫글자들로 말을 형성하는 것)은 대소문자 컨벤션에 따라 통일성있게 사용되어야 합니다.

```swift
var utf8Bytes: [UTF8.CodeUnit]
var isRepresentableAsASCII = true
var userSMTPServer: SecureSTMTPServer
```

나머지 두문자어는 다른 일반적인 단어들과 동일하게 사용하면 됩니다.

```swift
var radarDetector: RadarScanner
// radar: **ra**dio **d**etection **a**nd **r**anging
var enjoyScubaDiving = true
// scuba: **s**elf-**c**ontained **u**nderwater **b**reathing **a**pparatus = 자급자족 수중 호흡 장치..ㄷㄷ
```

<br>
<br>

### 기본 뜻이 동일하지만 서로 구별되는 도메인에서 동작하는 Method는 base name을 동일하게 사용할 수 있습니다.

---

**Good**

예를 들어, 아래 예시에서 기본적으로 같은 동작을 하기 때문에 같은 이름을 사용하기를 권장합니다.

```swift
extension Shape {
  /// Returns `true` iff `other` is within the area of `self`.
  func contains(_ other: Point) -> Bool { ... }

  /// Returns `true` iff `other` is entirely within the area of `self`.
  func contains(_ other: Shape) -> Bool { ... }

  /// Returns `true` iff `other` is within the area of `self`.
  func contains(_ other: LineSegment) -> Bool { ... }
}

extension Collection where Element : Equatable {
  /// Returns `true` iff `self` contains an element equal to
  /// `sought`.
  func contains(_ sought: Element) -> Bool { ... }
}
```

**Bad**

아래 `index` 메소드는 다른 의미를 갖기 때문에 다르게 네이밍 되어야 합니다.

```swift
extension Database {
  /// Rebuilds the database's search index
  func index() { ... } // 테이블에 대한 동작의 속도를 높여주는 자료 구조

  /// Returns the `n`th row in the given table.
  func index(_ n: Int, inTable: TableID) -> TableRow { ... }
}
```
<br>
<br>

## Parameters - 파라미터

---

<br>

### 주석을 읽기 쉽게 만들어주는 파라미터 이름을 선택하여 라벨링하세요.

---

- 파라미터 이름은 function 이나 method 를 사용하는 곳에서 보이지는 않지만 이를 설명해주는 역할을 갖습니다.
- 문서(주석)을 읽기 편한 파라미터 이름을 사용하세요.

**Bad**

```swift
/// Return an 'Array' containing the elements of 'self'
/// that satisfy 'includeInResult'.
func filter(_ includeInResult: (Element) -> Bool) -> [Generator.Element]

/// Replace the range of elements indicated by 'r' with
/// the contents of 'with'.
mutating func replaceRange(_ r: Range, with: [E])
```

이를 보다 쉽게 읽히도록 파라미터 이름을 변경해볼게요.

**Good**

```swift
/// Return an 'Array' containing the elements of 'self'
/// that satisfy 'predicate'.
func filter(_ predicate: (Element) -> Bool) -> [Generator.Element]

/// Replace the given 'subRange' of elements with 'newElements'.
mutating func replaceRange(_ subRange: Range, with newElements: [E])
```

### 일반적인 사용을 단순화 할 수 있다면, default parameter를 사용하세요.

---

- 일반적으로 사용되는 파라미터가 default로 사용될 수 있습니다.
- 예를 들어 아래의 경우 default parameter를 사용하여 가독성을 높일 수 있습니다.
- default parameter를 제공함으로써 API를 살펴보고 이해하려는 사람들이 신경써야 할 부분을 줄여줄 수 있습니다.

**Bad**

```swift
// Method Family

extension String {
  /// ...description 1...
  public func compare(_ other: String) -> Ordering
  /// ...description 2...
  public func compare(_ other: String, options: CompareOptions) -> Ordering
  /// ...description 3...
  public func compare(_ other: String, options: CompareOptions, range: Range) -> Ordering
  /// ...description 4...
  public func compare(_ other: String, options: CompareOptions, range: Range, locale: Locale) -> Ordering
}
```

**Good**

```swift
extension String {
  /// ...description...
  public func compare(_ other: String, options: CompareOptions = [], range: Range? = nil, locale: Locale? = nil) -> Ordering
}
```

<br>
<br>

## Argument Labels - 인자명

<br>

### 값을 유지하면서 타입을 변환해주는 Initializer라면 첫번째 argument의 label은 생략하세요.

---

```swift
extension String {
	// Convert 'x' into its textual representation in the given radix.
	init(_ x: BigInt, radix: Int = 10)
}

text = "The value is: "
text += String(veryLargeNumber)
text += " and in hexadecimal, it's"
**text += String(veryLargeNumber, radix: 16)**
```

<br>
<br>

### 값의 범위가 좁혀지는 타입 변환의 경우, label을 붙여서 설명하기를 추천합니다.

```swift
extension UInt32 {
	/// Creates an instance having the specified 'value'.
	init(_ value: Int16)

	/// Creates an instance having the lowest 32 bits of 'source'.
	init(truncating source: UInt64)
	
	/// Creates an instance having the nearest representable
	/// approximation of 'valueToApproximate'.
	init(saturating valueToApproximate: UInt64)
}
```

<br>
<br>

### 만일 첫번째 argument가 문법적인 구절을 만든다면 label은 제거하고, 함수 이름에 base name을 추가합니다.

**구절이 정확한 의미를 전달하는 것이 중요합니다**. 다음 예시는 문법적이지만 다소 모호한 표현을 하고 있습니다.

**Bad**

```swift
view.dismiss(false)        // Don't dismiss?, Dismiss a Bool?
words.split(12)            // Split the number 12?
```

**Good**

```swift
view.dismiss(animated: false)
let text = words.split(maxSplits: 12)
let studentsByName = students.sorted(isOrderedBefore: Student.namePrecedes)
```

<br>
<br>

## Special Instructions

### overload set에서의 모호함을 피하기 위해, 제약 없는 다형성에 각별히 주의하세요.

---

**Bad**

```swift
struct Array {
	/// Inserts 'newElement' at 'self.endIndex'.
	public mutating func append(_ newElement: Element)

	/// Inserts the contents of 'newElements', in order, at
	/// 'self.endIndex'.
	public mutating func append(_ **newElements**: S)
		where S.Generator.Element == Element
}
```

위 메소드의 경우 argument type이 뚜렷하게 구분되어 보이지만, `Element` 가 `Any` 인 경우에는 아래와 같은 유형을 가질 수 있습니다.

```swift
var values: [Any] = [1, "a"]
values.append([2 ,3, 4])  // [1, "a", [2, 3, 4]]
```

이러한 모호함을 제거하기 위해, 두번째 overload 메소드 시그니처를 더욱 명시적으로 지정합니다.

**Good**

```swift
struct Array {
	/// Inserts 'newElement' at 'self.endIndex'.
	public mutating func append(_ newElement: Element)

	/// Inserts the contents of 'newElements', in order, at
	/// 'self.endIndex'.
	**public mutating func append(contentsOf newElements: S)**
		where S.Generator.Element == Element
}
```