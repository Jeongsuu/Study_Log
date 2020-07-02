# Realm Tutorial

<br>

본 문서에는 `raywenderlich.com` 의 realm 튜토리얼 문서를 보며 공부한 내용을 기재하였습니다.

<br>

`realm` 이란 모바일 크로스 플랫폼 데이터베이스 솔루션이다. iOS에서 제공하는 Core Data 또는 SQLite에는 의존하지 않는다.

이번 튜토리얼은 iOS에서의 `realm`에 대한 기본적인 특징들에 대해 소개한다.

<br>

## Getting Started
---

국립 공원 서비스 인턴직을 진행한다고 가정해보자. 우리의 업무는 미국에서 가장 큰 국립 공원에서 발견된 동물들의 종을 문서화하는 것이다.

이를 위해서는 발견한 종들에 대한 정리를 해 줄 보조원이 필요하다. 그러나 회사는 예산이 충분치 않기 때문에 우리는 스스로 가상의 보조원을 만들기로 결정했다.

해당 앱의 이름은 `Agents Partner`이다.

<br>

## Concepts and Classes Overview
---

`realm` 이 정확히 어떤 라이브러리인지 보다 잘 이해하기 위해서 아래 개념들과 정보들을 살펴보도록 한다.

- **Realm** : **realm 인스턴스**는 프레임워크의 핵심 개념이다. core data 관리와 같이 데이터베이스에 접근하기 위한 접근 지점이다. `Realm()` 생성자를 통해서 인스턴스를 생성한다.

- **Object** : **Object** 가 우리의 Realm Model이다. 모델을 만드는 것은 데이터베이스에서 스키마를 정의하는 행위이다. 모델을 생성하기 위해서는 `Object`를 서브 클래스로 만들고 유지하고자 하는 속성들을 필드로 정의한다.

- **Relationships** : 참조하고자 하는 객체의 속성을 선언하여 1:N 관계를 만든다. 리스트를 이용해 N:1, N:N 관계를 만들어낼 수 있다.

- **Write Transactions** : 생성, 수정, 삭제와 같이 데이터베이스에서의 어떠한 연산이든, 이 모든 연산들은 realm 인스턴스의 `write(_:)` 메소드를 통해 행해진다. 디스크 I/O 작업이므로 호출 수를 최소로 줄여주는 것이 좋다.

- **Queries** : 데이터베이스로 부터 쿼리를 이용해 객체를 가져온다. 가장 간단한 쿼리는 Realm 인스턴스에서 objects()를 호출하여 찾고자 하는 객체의 클래스를 전달하는 것이다.

- **Results** : **Result**는 객체 쿼리로부터 얻어낸 결과값들을 자동으로 업데이트 해주는 컨테이너이다. Arrays 와 유사한 메소드들을 가지고 있다.

<br>

## Your First Model
---

모델 그룹에 `Specimen.swift` 파일을 열고 아래 내용을 추가하자.

```swift
// Specimen.swift
import Foundation
import RealmSwift

class Specimen: Object {
    @objc dynamic var name = ""
    @objc dynamic var specimenDescription = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var created = Date()
}
```

위 코드를 살펴보자.

Specimen이라는 클래스를 생성할 것인데 해당 클래스의 타입은 Object이다.

![image](https://user-images.githubusercontent.com/33051018/86357436-cb538f00-bca8-11ea-9937-e42b5b0ba5af.png)

정의는 위와 같다. Object는 **realm 모델 객체를 정의하기 위해 사용되는 클래스이다.**

즉 위 코드는 realm 모델을 생성하는데 해당 모델의 이름은 `Specimen` 이며 name, specimenDescription, latitude, longitude, created 라는 속성을 갖는다.

realm 내에서 특정 데이터 타입을 갖는 경우 (ex: String) 반드시 초기값과 함께 생성되어야 한다.

위에서 생성한 realm 모델 `Specimen`은 각각 다른 카테고리로 분류될 것이다.

이번엔 `Category`라는 모델을 생성해보도록 하자.

```swift
//Category.swift
import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
}
```

위와 같이 `Category` 모델을 생성한다.

이를 통해 모델간의 관계를 정의할 수 있다. 각각의 종들은 여러 카테고리로 나뉘어 질 것이며 이를 통해 1:N 관계를 갖게 될 것이다.

그리고 다시 `Specimen.swift` 파일에 아래 속성을 추가한다.

```swift
@objc dynamic var category: Category!
```

**그러면 각각의 Specimen들은 하나의 category 속성을 갖게되지만 category는 여러 Specimen들을 갖게된다.** 

기본적인 model을 모두 설계하였다. 직접 데이터베이스에 데이터를 추가해보도록 하자.

<br>

## Adding Records
---

사용자가 새로운 종을 추가할 떄, 종의 이름과 카테고리를 지정할 수 있다.
`CategoriesTableViewController.swift` 파일을 살펴본다.

위 파일은 카테고리 리스트를 테이블 뷰에 출력하여 사용자에게 한 가지를 선택할 수 있도록 한다.

`Realm`에 데이터를 쓰기 이전에 `RealmSwift` 를 import 하는 것을 잊지 말자.

우리는 현재 테이블 뷰를 몇몇의 기본 카테고리로 채울 것이다.

`Category` 인스턴스는 Results의 인스턴스에 저장할 수 있다.

```swift
let realm = try! Realm()        // 램 객체 생성
lazy var categories: Results<Category> = {
    self.realm.objects(Category.self) } ()
}
```

객체를 가져오기 위해서는 항상 가져오고자 하는 모델을 정의해야 한다.

위 코드를 살펴보면 첫번째로 `Realm` 객체를 생성하고 `realm.objects()` 메소드를 호출하여 `categories`를 생성하였다.

이제 기본으로 제공할 category 들을 생성해보도록 하자.

```swift

private func populateDefaultCategories() {
    if categories.isEmpty {        // categories 가 비어있다면
        try! realm.write() {        // realm에 쓰겠다.
            let defaultCategories = 
            ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ]

            for category in defaultCategories {
                let newCategory = Category()    // 카테고리 인스턴스 생성
                newCategory.name = category     // 새로운 카테고리 인스턴스의 이름을 위에서 적은 기본 카테고리명으로 지정

                realm.add(newCategory) // realm에 객체 더하기.

            }

            // Query
            categories = realm.objects(Category.self)       // 생성한 모든 Category를 가져와서 categories에 저장
        }
}
```

위 코드 로직을 살펴보도록 한다.

Category 객체들의 Result 컨테이너 `categories` 가 비어있다면 트랜잭션을 시작한다.

기본으로 제공할 카테고리를 생성하고 이를 순회하며 새로운 `Category` 객체의 이름으로 지정한다.

이후 해당 객체를 `realm`에 더한다.

이후 query를 날려서 realm DB에 저장된 `Category` 타입 데이터를 모두 불러와 `categories`에 저장한다.

**정리해보면, `realm.write() -> realm.add() -> realm.objects()` 순으로 진행되며 DB에 적재할 데이터를 생성하고, 적재한 뒤, 가져온다.**


이제 테이블 뷰에 데이터를 뿌려주기 위해서 `DataSource` 메소드들을 작성해본다!


```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
```

`cell`을 생성하고 `cateigories` 컨테이너로 부터 현재 인덱스의 카테고리를 가져와 cell.text에 category.name을 기입해준다.

이후 사용자가 선택한 카테고리가 무엇인지 저장할 변수를 생성한다.

```swift
var selectedCategory: Category!
```

이후 `willSelectRowAt` 메소드를 작성한다!

```swift
override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    selectedCategory = categories[indexPath.row]

    return indexPath
}
```

위와 같이 `selectedCategory` 변수를 현재 사용자가 선택한 카테고리 값을 넣어준다.

