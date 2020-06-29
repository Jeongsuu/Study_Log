# Searchable TableView

<br>

이번에는 지난 시간에 진행했던 테이블 뷰에서 한 가지 개념을 응용해보고자 한다.

검색창을 추가하여 검색 쿼리에 따라 적절한 데이터를 출력해주는 테이블 뷰를 만들어보자.

예제 코드는 아래와 같다.

```swift

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    // 기존 데이터
    var data = [String]()
    
    // 쿼리 결과에 따른 데이터
    var filteredData = [String]()
    
    // Filter 진행 여부 플래그
    var filetered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // delegate & dataSource 선언
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        
        // 데이터 가져오기
        setupData()
    }
    
    // 더미 데이터 생성
    private func setupData() {
        data.append("Apple")
        data.append("MacOS")
        data.append("IphoneOS")
        data.append("IpadOS")
        data.append("Macbook Pro")
        data.append("Ipad Pro")
        data.append("Macbook Air")
        data.append("Iphone")
        data.append("Airpod")
        
    }
    
    // textfield delegate 메소드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            filterText(text+string)
        }
        
        return true
    }
    
    // 쿼리에 따른 필터링 진행 함수
    func filterText(_ query: String) {
        // 중복 제거를 위해 클리어
        filteredData.removeAll()
        
        // data 배열 내 원소 순회
        for string in data {
            if string.lowercased().starts(with: query.lowercased()) {
                // 쿼리와 원소 비교 및 데이터 추가
                filteredData.append(string)
            }
        }
        
        table.reloadData()
        filetered = true
        
    }
    
    // 섹션 내 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 필터링 된 데이터가 존재할 경우
        if !filteredData.isEmpty {
            return filteredData.count
        }
        
        // 그 외 필터가 진행된 경우에는 0, 아닌 경우에는 data 배열 길이 반환
        return filetered ? 0 : data.count
    }
    
    // 셀 디자인
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if !filteredData.isEmpty {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    
}



```

<br>

위 코드에서의 핵심은 textField의 delegate 메소드인 `shouldChangeCharactersIn` 메소드이다.

<br>

```swift
// textfield delegate 메소드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            filterText(text+string)
        }
        
        return true
    }
```

위 메소드의 정의는 " 지정된 text를 변경해야 하는 경우, 델리게이트에게 요청한다. " 이다.

즉, 사용자의 액션에 의해 text가 변경될 때 마다 해당 메소드를 호출하게 된다.

매개변수를 하나하나 살펴보도록 하자.

- textField : text를 가지고 있는 textField다.

- range : 대체할 문자의 범위를 의미한다.

- string : 지정된 범위 내에서 대체할 문자열이다. 

위 함수를 통해 쿼리를 전달하는 역할의 함수를 호출한다.

```swift
// 쿼리에 따른 필터링 진행 함수
    func filterText(_ query: String) {
        
        // 중복 제거를 위해 클리어
        filteredData.removeAll()
        
        for string in data {
            if string.lowercased().starts(with: query.lowercased()) {
                filteredData.append(string)
            }
        }
        
        table.reloadData()
        filetered = true
        
    }
```

`data` 배열을 순회하면서 소문자로 변화시킨 `string`의 접두사와 `query`의 접두사를 비교하여 동일한 경우의 데이터를 `filteredData` 배열에 추가한다.

이후, 테이블 뷰 데이터를 reload 하고 플래그를 변화시킨다.

결과를 간단히 살펴보도록 하자.

**Before**

![image](https://user-images.githubusercontent.com/33051018/86022403-475d9500-ba65-11ea-89e9-5428fc118c94.png)


**After**

![image](https://user-images.githubusercontent.com/33051018/86022448-5f351900-ba65-11ea-9489-a94eb380c09c.png)


생각했던대로 정상작동한다!

그 외의 코드는 이전에도 많이 다뤄왔던 tableView 내용이기 떄문에 따로 설명하지는 않는다.



