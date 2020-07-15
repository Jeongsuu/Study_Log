# UITableView

본 문서에서는 apple 에서 제공하는 `UITableView` 공식 문서에 기재되어 있는 메소드와 프로퍼티에 관하여 정리한다.

<br>

## Topics
---

<br>

### Creating a table View
---
- `init(frame: CGRect, style: UITableView.style)` : 주어진 특정 frame 크기와 style에 맞춰서 테이블뷰를 생성하여 반환한다.

<br>

### Providing the Table's Data and Cells
---

- `var dataSource: UITableViewDataSource?` : 테이블뷰의 데이터 소스 역할을 하는 객체다.

- `var prefetchDataSource: UITableViewDataSource` : 테이블뷰의 prefetch 데이터 소스 역할을 하는 객체, 사용할 셀 데이터의 요구사항에 대한 알람을 수신한다.

- `protocol UITableViewDataSource` : 테이블뷰를 위한 셀을 제공하며 데이터를 관리하기 위한 메소드들을 제공.

<br>

### Recycling TableView Cells
---

- `func register(UINib?, forCellReuseIdentifier: String)` : 지정 식별자 셀을 포함하는 테이블 뷰에 nib 객체를 등록한다.

- `func register(AnyClass?, forCellReuseIdentifier: String)` : 새로운 테이블뷰 셀 클래스를 등록한다.

- `func dequeueReusableCell(withIdentifier: String, for: IndexPath) -> UITableViewCell` : 특정 재사용 식별자에 대응되는 재사용 가능한 셀을 만들어 테이블에 이를 더한다.

- `func dequeueReusableCell(withIdentifier: String) -> UITableViewCell?` : 특정 식별자에 대응되는 재사용 가능한 셀을 반환한다.

<br>

### Recycling Section Headers and Footers
---

- `func register(UINib?, forHeaderFooterViewReuseIdentifier: String)` : 특정 식별자에 해당되는 테이블 뷰의 헤더 혹은 푸터에 nib 객체를 등록한다.

- `func register(AnyClass?, forHeaderFooterViewReuseIdentifier: String)` : 새로운 테이블의 헤더 혹은 푸터 뷰에 사용할 클래스를 등록한다.

- `func dequeueReusableHeaderFooterView(with Identifier: String) -> UITableViewHeaderFooterView?` : 특정 식별자로 찾은 재사용 가능한 헤더 혹은 푸터 뷰를 반환한다.

<br>

### Managing Interactions with the Table
---

- `var delegate: UITableViewDelegate?` : 테이블뷰의 델리게이트 역할을 하는 객체를 반환한다.

- `protocol UITableViewDelegate` : 

셀렉션 관리, 섹션 헤더 혹은 푸터 수정, 셀 삭제 및 재정렬 그리고 테이블뷰에 대한 다른 액션을 위한 메소드를 제공한다.

<br>

### Configure the Table's Appearance
---

- `var style: UITableView.Style` : 테이블뷰의 스타일을 설정하는 변수.

- `enum UITableView.Style` : 테이블 뷰 스타일들의 상수타입 열거형.
    - `case plain` : 일반적인 테이블 뷰
    - `case grouped` : 그룹화된 섹션 테이블 뷰
    - `case insetGrouped` : 그룹화된 섹션이 둥근 모서리로 삽입된 테이블 뷰

- `var tableHeaderView: UIView?` : 테이블 뷰 상단에 디스플레이되는 헤더 뷰

- `var tableFooterView: UIView?` : 테이블 뷰 하단에 디스플레이되는 푸터 뷰

- `var backgroundView: UIView?` : 테이블 뷰의 백그라운드 뷰


<br>

## Reference
---
- [developer.apple.com - UITableView](https://developer.apple.com/documentation/uikit/uitableview)