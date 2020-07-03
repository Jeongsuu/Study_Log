## 테이블 뷰 구현 이론
---

iOS에서 가장 많이 사용하는 패턴 중 하나가 `delegate` 패턴이다.

이를 이해하기 위해 큰 도움이 된다!

테이블 뷰 구현은 보통 5단계로 구분된다.

1. 테이블 뷰 배치
2. 프로토타입 셀 디자인 & Cell Identifier 지정
3. 데이터 소스, 델리게이트 연결
4. 데이터 소스 구현
5. 델리게이트 구현

데이터소스는 `UITableViewDataSource` 프로토콜을 채택한다.

이는 테이블 뷰의 데이터를 표시하기 위한 다양한 메서드가 선언되어있다.

테이블 뷰는 어떤 데이터를 어떠한 디자인으로 어떻게 표현해줄지 모른다.

이를 위해 `UITableViewDataSource` 프로토콜에 선언해놓았다.

```swift
 // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Memo.dummyMemoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let target = Memo.dummyMemoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = target.insertDate.description
        
        return cell
    }
```

프로토콜에 선언된 메서드들을 `override` 하여 직접 구현한다.

첫번째 함수를 살펴본다.
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInsSection section: Int) -> Int {
    // return the number of rows.
    return Memo.dummyList.count
}
```

인자값을 보면 , tableView와 numberOfRowsInSection이 들어간다.
반환값은 `Int` 자료형으로 지정되어있으며 주석으로 행의 개수를 리턴하라고 표기되어있다.

테이블 뷰는 처음에 몇개의 셀을 출력해야 할 지 모른다.
그래서 해당 내용을 우리에게 물어본다.

즉, 우리가 만들어 낼 테이블뷰에 몇개의 행을 만들지 지정하는 함수이다.
여기서는 간단하게 만들어놓은 `Memo` 클래스의 프로퍼티를 전달하였다.

이후에는 테이블 뷰는 어떠한 디자인으로 어떤 데이터를 표시해야 하는지 다시 물어본다.

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let target = Memo.dummyMemoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = target.insertDate.description
        
        return cell
    }
```

위 내용이 그에 대한 답변이다.

인자값으로 `cellForRowAt indexPath` 를 받는다.

이름만 봐도 대충 유추가 가능하다, 어떠한 행을 지정할지에 대한 `index` 값을 의미한다.

이후 `cell` 이란 상수에 `tableView.dequeueResuableCell()` 메서드를 사용할 셀 디자인을 가져온다.

![image](https://user-images.githubusercontent.com/33051018/78633468-b0a59000-78dc-11ea-8948-0b242fdffa5c.png)

위 메서드는 매우 중요한 메서드니 상세히 살펴보도록 한다.

`Instance Method` 이며 재사용이 가능한 테이블 뷰의 셀을 지정된 `reuse identifier` 를 통해 만들어 반환하는 함수라고 한다.

즉, 셀을 만드는 기능을 하는것 같다.

```swift
func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
```

메서드의 원형은 위와 같다.

메서드의 인자값으로 resueable 한 `cell identifier` 과 `Indexpath`를 받는다.

파라미터 값 정의를 살펴본다.
#### Parameters
**identifier**
A string identifying the cell object to be reused. This parameter must not be nil.

-> 재사용될 셀 객체를 확인하기 위한 스트링 값이며 해당 파라미터는 반드시 `nil`이면 안된다고 되어있다. ( 대충 느낌 오는군..! )

즉, 셀의 디자인을 결정하는 파라미터다.

**indexPath**
The index path specifying the location of the cell. Always specify the index path provided to you by your data source object. This method uses the index path to perform additional configuration based on the cell’s position in the table view.
-> `index Path`는 셀의 위치를 결정하는 파라미터다.

#### Return Value
`A UITableViewCell object with the associated reuse identifier. This method always returns a valid cell.`

해당 메서드는 항상 유효한 셀을 반환하며 이는 `reuse identifier`와 연관된 `UITableViewCell` 객체이다.

셀을 만들고 반환하면 이는 그냥 빈 셀이다.

따라서, 여기에 내용을 채워줘야한다.

```swift
let target = Memo.dummyMemoList[indexPath.row]
        cell.textLabel?.text = target.content   // 주내용
        cell.detailTextLabel?.text = target.insertDate.description      // 부내용
        
        return cell
```

target은 채울 내용을 의미하고 `cell`의 프로퍼티에 순차적으로 접근하여 `target`의 프로퍼티값으로 초기화를 진행한 뒤, `cell`을 반환한다.

그러면 테이블 뷰가 이셀을 받아서 화면에 표시해준다.

지금까지 설명한 두개의 메서드는 필수 메서드다!

여기까지가 기본적인 `Data Source` 이고, 이후에 `delegate`다.

보통 셀을 터치하면 다른화면으로 이동하는 방식이다.

테이블 뷰는 아무것도 몰라서 이를 터치했을때 어떻게 동작해야할지도 모른다.

이것도 우리가 직접 하나하나 알려줘야한다.

만약 이러한 이벤트를 처리하고 싶다면 `delegate`를 연결하고 필요한 메서드를 구현해야 한다.

<br>

<br>

### 테이블뷰 셀의 기본 기능

- `UITableViewCell` 클래스를 상속받는 기본 테이블뷰 셀은 세 가지 프로퍼티가 정의되어 있다.
    - textLabel: UILabel = 주 제목 레이블
    - detailTextLabel: UILabel = 부 제목 레이블
    - imageView: UIImageView = 이미지 표시를 위한 이미지 뷰

<br>

### 커스텀 테이블뷰 셀

- `UITableViewCell` 클래스에서 제공하는 기본 형태를 벗어나 다양한 애플리케이션의 요구를 충족시키기 위해 셀을 커스텀 할 수 있다.
- 커스텀 셀을 만드는 방법은 크게 두가지이다.
    - 셀의 콘텐츠뷰에 서브뷰 추가
    - `UITableViewCell`의 커스텀 서브클래스 만들기

<br>

## DataSource 와 Delegate
---

`UITableView` 객체는 데이터 소스와 델리게이트가 필연적으로 필요하다.

MVC 프로그래밍 디자인 패턴에 따라 데이터 소스는 애플리케이션의 데이터 모델 M과 관련되어 있으며, 델리게이트는 테이블뷰의 모양과 동작을 관리하기에 컨트롤러 C의 역할에 가깝다.

그리고 마지막 테이블뷰가 뷰 V를 담당한다. 

<br>

**DataSource**

- 테이블뷰 데이터 소스 객체는 `UITableViewDataSource` 프로토콜을 채택한다.
- 데이터 소스는 테이블 뷰를 생성하고 수정하는데 필요한 정보를 테이블뷰 객체에 제공한다.
- `UITableView` 객체의 섹션의 수, 행의 수를 알려주어 행의 삽입, 삭제 및 재정렬하는 기능을 선택적으로 구현할 수 있다.
- `UITableViewDataSource` 프로토콜의 주요 메서드는 아래와 같다.

```swift
@required
func tableView(UITableView, cellForRowAt: IndexPath)        // 특정 위치에 표시할 셀을 요청하는 메서드

@required
func tableView(UITableView, numberOfRowsInSection: Int)     // 각 섹션에 표시할 행의 개수를 지정하는 메서드

@optional
func numberOfSections(in: UITableView)                      // 테이블뷰 내 섹션을 몇개로 지정할 것인지 묻는 메서드

```

<br>

**Delegate**

- 테이블뷰 델리게이트 객체는 `UITableViewDelegate` 프로토콜을 채택한다.
- 델리게이트는 테이블뷰의 시각적인 부분 수정, 행의 관리, 액세서리뷰 지원, 개별 행 편집등을 돕는다.
- `UITableViewDelegate` 프로토콜의 주요 메서드는 아래와 같으며 필수로 구현해야 하는 메서드는 없다.

```swift
func tableView(UITableView, didSelectRowAt: IndexPath)      // 특정 행이 선택되었음을 알리는 메서드

func tableView(UITableView, didDeselectRowAt: IndexPath)    // 특정 행의 선택이 해제되었음을 알리는 메서드

func tableView(UITableView, willBeginEditingRowAt: IndexPath)       // 테이블뷰가 편집모드로 들어갔음을 알리는 메서드

func tableView(UITableView, didEndEditingRowAt: IndexPath?)         // 테이블뷰가 편집모드에서 빠져나왔음을 알리는 메서드
```

