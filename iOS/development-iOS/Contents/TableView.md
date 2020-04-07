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

