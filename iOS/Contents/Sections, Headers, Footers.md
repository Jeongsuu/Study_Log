# Secitons, Headers, Footers in tableView

<br>

이번에는 tableView 내에 존재하는 Sectioons, Headers, Footers에 대해 알아본다.

<br>

`tableView` 구현을 위해 `UITableViewDelegate, UITableViewDataSource` 프로토콜을 채택한다.

예시 코드는 아래와 같이 작성하였다.

```swift

import UIKit

class ViewController: UIViewController {
    
    // Connect UITableView
    @IBOutlet var tableView: UITableView!
    
    let data = [
        ["Apple", "MacOS", "iOS", "IpadOS"],
        ["one", "two", "three", "four"]
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Assign Delegate & DataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        
        header.backgroundColor = .systemOrange
        footer.backgroundColor = .systemTeal
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "This is tableView Header"
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        
        let footerLabel = UILabel(frame: footer.bounds)
        footerLabel.text = "This is tableView Footer"
        headerLabel.textAlignment = .center
        footer.addSubview(footerLabel)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    // row when selected : 셀 터치시 회색 표시 없애기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "This is Section Header"
    }
    
    // Footer Height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    // Footer Title
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "This is Section Footer"
    }
    
    
    // Number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    // cell Design
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.backgroundColor = .systemBlue
        
        return cell
    }
}

```

위 코드를 실행하면 아래와 같은 레이아웃을 확인할 수 있다.

![image](https://user-images.githubusercontent.com/33051018/85924519-d2a42280-b8cd-11ea-8d6c-4cbfc387431f.png)

`tableView` 는 여러개의 섹션으로 이루어질 수 있으며, 섹션은 여러개의 행으로 이루어지며 행에는 `cell`이 들어간다.

즉, `cell` 을 보여주는 `row`가 모여서 `section`이 되고 `section`이 모여서 `tableView`가 된다.

또한, 각각의 `section`은 `Header` 와 `Footer`를 가질 수 있다.

물론 단 하나의 `section` 또는 `row` 를 갖는 `tableView` 도 생성할 수 있다.

<br>

### tableView Header
---

`tableView Header` 란, 이름을 보면 알 수 있듯 `tableView`가 시작하는 지점에 위치한다.

레이아웃의 최상단을 보면 "This is tableView Header" 라는 레이블을 확인할 수 있다.

해당 레이아웃을 그리는 코드는 아래 부분이다.

```swift

let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))

header.backgroundColor = .systemOrange

let headerLabel = UILabel(frame: header.bounds)
headerLabel.text = "This is tableView Header"
headerLabel.textAlignment = .center
header.addSubview(headerLabel)

tableView.tableHeaderView = header
```
`header` 라는 `UIView`를 생성하고 프로퍼티를 설정한 이후, 맨 마지막 줄에서 `tableView.tableHeaderView = header` 를 통해 해당 tableView의 header를 설정해준다.

`section`이 `header` 와 `footer`를 가지는 것 처럼 `tableView` 또한 `header` 와 `footer`를 가질 수 있다.


<br>

### section Header
---

`section Header` 는 섹션이 시작하는 지점에 위치한다.

`tableView Header` 아래에는 `section Header`가 자리잡고 있다.

`section`의 `header`는 `UITableViewDataSource` 프로토콜의 옵션 메소드를 통해 구현한다.

```swift

extension ViewController: UITableViewDataSource {

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    // Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "This is Section Header"
    }
}
```

메소드의 이름을 보면 바로 알 수 있듯 `heightForHeaderInSection` 메소드를 통해 섹션 헤더의 높이를 지정할 수 있고, `titleForHeaderInSection` 메소드를 통해 섹션 헤더의 title을 지정할 수 있다.  (네이밍의 중요성을 다시 한번 느낀다..)

<br>

### section rows
---

`section Header` 아래에서 부터는 해당 섹션을 구성하는 `Rows`가 보인다.

이를 구현하는 코드는 아래와 같다.

```swift
// Number of Rows
func tableView(_ tableView: UItableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
}

// Cell Design
func tableView(_ tableView: UItableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = data[indexPath.section][indexPath.row]
    cell.backgroundColor = .systemBlue

    return cell
}
```

`numberOfRowsInSection` 메소드를 통해 섹션을 구성하는 행의 개수를 지정하고 행에서 보여줄 `cell`을 `cellForRowAt` 메소드를 통해 생성한다.

<br>

### Section Footer
---

다음으로는 `Section Footer` 다.

이름 그대로 `Section` 이 끝나는 지점에 위치한다.

`Section Footer` 는 아래와 같이 구현한다.

```swift

extension tableViewController: UITableViewDataSource {

    //Footer Height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    // Footer Title
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "This is Section Footer"
}

```

`UITableViewDelegate` 내 메소드 중, `heightForFooterInSection` 메소드를 통해 Footer의 높이를 지정할 수 있고 `titleForRowinSection` 메소드를 통해 Footer의 타이틀을 지정할 수 있다.

<br>

### tableView Footer
---

`tableView Footer`는 테이블 뷰가 끝나는 지점에 위치한다.

구현은 아래와 같이 한다.

```swift

// View 생성
let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))

// view Background 지정
footer.backgroundColor = .systemTeal


// footer 내부에 Label 넣기
let footerLabel = UILabel(frame: footer.bounds)
footerLabel.text = "This is tableView Footer"
headerLabel.textAlignment = .center
footer.addSubview(footerLabel)

// footer View 지정
tableView.tableFooterView = footer

```

앞서 `tableView Header` 와 동일하다.

이를 `tableHeaderView`에 지정하느냐, `tableFooterView`에 지정하느냐의 차이다.

<br>

각각의 `Header` 와 `Footer`를 잘 이용하면 더욱 편리하게 멋있는 앱을 만들 수 있다!

오늘은 이렇게 평소에 매우 자주쓰는 `tableView` 의 구성에 대하여 알아보았다.

끝!

