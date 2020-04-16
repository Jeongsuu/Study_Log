# UITableView
---

**cf)[UITableView](#https://developer.apple.com/documentation/uikit/uitableview)**

# INDEX
[1. Declaration](#Declaration)

[2. Overview](#Overview)

[3. 인터페이스에 테이블 뷰 추가하기](#인터페이스에-테이블-뷰-추가하기)

[4. 테이블 뷰 데이터 추가하기](#테이블-뷰-데이터-추가하기)

[5. 행의 모양 정의하기](#행의-모양-정의하기)

[6. 각각의 행에 셀 생성 및 수정](#각각의-행에-셀-생성-및-수정)

[6. 테이블 현재 상태 저장 및 복원](#테이블-현재-상태-저장-및-복원)

<br>
<br>

`UITableView` 클래스는 단일 열에 여러개의 행을 사용하여 데이터를 표시하기 위해 사용한다.


### Declaration
---

```swift
class UITableview: UIScrollView
```

<br>
<br>

### Overview
---

`iOS` 디스플레이의 테이블뷰는 세로로 스크롤되는 컨텐츠를 화면을 행으로 나누어 보여준다.

테이블 내 각각의 행에는 앱의 컨텐츠들을 포함한다.

대표적인 예시로 연락처 앱은 각각의 연락처를 분리된 행에 따라 보여준다.

![image](https://user-images.githubusercontent.com/33051018/79439970-6cb73700-8010-11ea-96c0-8d70ddc3d638.png)

설정 앱은 그룹 테이블을 이용해 컨텐츠를 보여준다. 

![image](https://user-images.githubusercontent.com/33051018/79440054-85275180-8010-11ea-9ee5-5e9f62943c75.png)

단일 행 목록을 표시하도록 테이블을 구성할수도 있고 사용자 경험에 맞추어 컨텐츠를 보다 쉽게 보여줄 수 있도록 관련 행을 섹션으로 그룹화 할 수도 있다.

테이블은 주로 구조화 되어있거나 체계적으로 구성되어있는 데이터를 갖는 앱에서 사용된다.

체계화된 데이터를 갖는 앱은 종종 테이블 내 네비게이션 뷰 컨트롤러를 사용하여 깊이에 따른 정보를 출력하도록 해준다.

대표적인 예시로 셋팅 -> 디스플레이 설정 -> 해상도 조절 등과 같은 느낌이다.


`UITableView`는 테이블의 기본적 외형을 관리한다.

그러나 실제 데이터는 `cell(UITableViewCell)` 객체가 제공한다.

표준 셀은 텍스트나 이미지의 간단한 조합을 제공한다. 만일 커스텀 셀을 이용하면 우리가 원하는 어떠한 컨텐츠라도 셀에 담을수 있다.

또한, `header` 와 `footer`를 이용해 셀 그룹에 대한 추가적인 정보를 제공할 수 있다.

<br>
<br>

### 인터페이스에 테이블 뷰 추가하기

인터페이스 내에 테이블 뷰를 추가하기 위해서는 `Table View Controller` 객체를 스토리보드에 추가 해야한다.

![image](https://user-images.githubusercontent.com/33051018/79457378-1b687100-802b-11ea-9a4e-af28f9bd6501.png)

테이블 뷰는 데이터를 중심으로 생성되며 일반적으로 제공하는 데이터는 데이터 소스 (`DataSource`) 객체로부터 데이터를 가져온다.

데이터 소스 객체는 앱의 데이터와를 관리하고 테이블 셀을 생성하고 수정하는 역할을 한다.

<br>
<br>

### 테이블 뷰 데이터 추가하기
**cf) [Filling a Table with Data](#https://developer.apple.com/documentation/uikit/views_and_controls/table_views/filling_a_table_with_data)**

`data source` 객체를 이용해 테이블의 셀들을 동적으로 생성하고 수정하거나 스토리보드에 정적으로 제공하기 위한 내용을 기재한다.

**Data Source** 객체는 셀 별 데이터의 각 부불을 화면에 렌더링 하는데 필요한 뷰와 함께 앱의 데이터를 제공한다.

`Data Source` 는 `UITableViewDataSource` 프로토콜을 채택한다.

테이블 뷰는 화면에 뷰를 배열하고 해당 데이터를 최신 상태로유지하기 위해서 데이터 소스 객체와 함께 작동한다.

테이블 뷰가 스크린에 보여지기 이전에, 테이블 뷰는 총합 `row` 와 `section`의 개수를 `data source` 객체로부터 알아온다.

```swift
func numberOfSections(in tableView: UItableView) -> Int //optional

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

위 메소드들은 테이블뷰를 구성하는 행의 개수와 섹션의 개수를 리턴한다.


### 행의 모양 정의하기

스토리보드 내의 셀 모양은 개발자가 직접 제어한다. ( Custom cell )

이 셀은 `UITableViewCell` 클래스의 객체이며 테이블 내 행의 **템플릿** 처럼 이용된다.

셀은 **뷰** 이며 display 하고자하는 어떠한 컨텐츠도 모두 보여줄 수 있다.

레이블을 더하거나 이미지 뷰를 더하는 등 모든것이 가능하다.

앱 내 인터페이스에 테이블 뷰를 추가하면 이를 구성하는 프로토타입 셀이 하나 자동 포함된다.

만일 더 많은 프로토타입 셀을 이용하고 싶으면 `Prototype Cell` 특성을 통해 추가가 가능하다.

각각의 셀들은 외형을 정의하는 스타일을 가지고 있으며 `UIKit` 에서 제공하는 표준 스타일 중 하나를 선택하거나 사용자가 직접 커스텀해서 사용하는 custom cell을 사용하여 디자인 할 수 있다.

<br>
<br>

### 각각의 행에 셀 생성 및 수정
테이블 뷰가 스크린에 나타나기 이전에, 테이블 뷰는 `data source` 객체에게 셀을 제공해달라고 요청한다.

`data source` 객체의 `tableView(_:cellForRowAt: )` 메소드가 이에 대한 내용을 반환하며 아래 패턴을 따라서 해당 메소드를 구현한다.

1. 셀을 검색하기 위해 테이블 뷰의 `dequeueReusableCell(withIdentifier:for:)` 메소드를 호출한다.

2. 사용자가 정의한 데이터를 사용하여 셀의 뷰를 구성한다.

3. 테이블 뷰에게 셀을 반환한다.

아래 예시 코드를 통해 이해를 돕는다.
```swift

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //ask for a cell of the appropriate type.

    let cell = tableView.dequeueResuableCell(withIdentifier: "basicStyleCell", for:indexPath)

    cell.textLabel!.text = "Row \(indexPath.row)"

    return cell
}
```

<br>
<br>

### 테이블 현재 상태 저장 및 복원

테이블의 데이터를 저장하고 복원하기 위해서는 테이블뷰의 프로퍼티 중 `restorationIdentifier` 프로퍼티를 할당해야 한다.

해당 뷰의 부모 뷰 컨트롤러가 저장된 경우, 테이블 뷰는 현재 선택된 행과 보이는 행의 인덱스 경로를 자동을 저장한다.

<br>
<br>

### 메소드 및 프로퍼티
---

```swift

var dataSource: UITableViewDataSource?
// 테이블 뷰의 데이터 소스 역할을 하는 객체

func dequeueReusableCell(withIdentifier: String, for: IndexPath) -> UITableViewCell
// 특정 cell Identifier에 대해 재사용 가능한 테이블뷰 셀 객체를 반환하고 이를 테이블에 추가한다.

```

