# Alamofire

`Alamofire`를 사용해보면서 공부한 내용을 정리한다.



`Alamofire`는 `Swift`에서 `HTTP` 통신을 하기 위해 이용되는 대표적인 오픈소스 라이브러리다.

`Alamofire`가 제공하는 간략한 기능 소개는 아래와 같다.

-   Request & Response 의 체이닝 함수 제공
-   URL / JSON 형태의 파라미터 인코딩
-   File / Data / Stream / MultipartFormData 등 업로드 기능
-   HTTP Response의 Validation

### Request
---

- `Request`란, 이름 그대로 요청을 보내기 위해 사용하는 함수이다.

`Alamofire.request`에는 다양한 인자가 존재한다.

**기본 사용법**
> `Alamofire.request("URL")`

<br>

**HTTP Methods - `method`**

`Alamofire`에는 `HTTPMethod` 라는 열거형이 정의되어 있다.

```swift
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
```

<br>

대표적인 method는 `REST API` 에서 이용되는 get, post, put, delete를 인자로 전달할 수 있으며 사용은 아래와 같이 한다.

<br>

```swift
AF.request("https://google.com/get")
AF.request("https://google.com/post", method: .post)
AF.request("https://google.com/put", method: .put)
AF.request("https://google.com/delete", method: .delete)
```

`get` 메소드가 `default` 기 때문에 `get` 메소드 사용시에는 따로 `method` 인자를 전달하지 않는다.

<br>

### Parameter Encoding - `parameters, encoding`

- Alamofire는 URL, JSON, PropertyList 3가지 매개 변수 인코디 유형을 지원한다.
- `ParameterEncoding` protocol을 준수하는 범위 내에서 custom이 가능하다.
    - **JSONEncoding**
    
    - `JSONEncoding`은 `parameters` 객체를 JSON 타입으로 인코딩 하는 것.

    ```swift
    let param = [
        "name" : "YeoJungsu",
        "age" : 27
    ]

    Alamofire.request("https://google.com/post", method: .post, parameters: param, encoding: JSONEncoding.default)

    // HTTP Body : {"name" : "YeoJungsu", "age" : 27}
    ```

<br>

### Response Handling

`Alamofire.request` 를 통해 입맛에 맞게 요청값을 `Handling` 이 가능하다.

아래는 간단한 `response Handling` 예시이다.

```swift
AF.request("https://google.com/get").responseJSON {
    response in 
    print("Request: \(String(describing: response.request))")   // Original request
    print("Response: \(String(describing: response.response))")  // url response
    print("Result: \(response.result)") // response serialization
}
```
request에 대한 response를 처리하기 위해 closure 타입으로 콜백이 지정된다.

response에 정의된 closure 안에서 수신된 응답에 대한 처리를 진행하며 해당 방식은 비동기로 처리된다.

<br>

### Response Validation

기본적으로 Alamofire는 response 내용과는 상관없이 정상처리된 request는 `.success`로 처리된다.

**Manual Validation**
```swift
Alamofire.request("https://google.com/get")
    .validate(statusCode: 200..<300)
    .validate(contentType: ["application/json"])
    .responseData { response in
        switch response.result {
            case .success:
                print("Success")
            case .failure(let e):
                print(e)
        }
    }

```

**Automatic Validation**
```swift
Alamofire.request("https://google.com/get").validate().responseData { response in
    switch response.result {
        case .success:
            print("success")
        case .failure(let e):
            print(e)
    }
}
```

`validate()`는 자동적으로 정상 status code 범위와, request의 헤더와 일치하는 Content-Type에 대해 유효성을 검증한다.

<br>

## Example
---

<br>

## Alamofire
---

`Alamofire`는 `Swift`에서 `HTTP` 통신을 하기 위해 이용되는 대표적인 오폰소스 라이브러리다.

`Alamofire`가 제공하는 간략한 기능 소개는 아래와 같다.

- Request & Response 의 체이닝 함수 제공
- URL / JSON 형태의 파라미터 인코딩
- File / Data / Stream / MultipartFormData 등 업로드 기능
- HTTP Response의 Validation

<br>

일단은 간단하게 Alamofire를 통해 받아온 서버의 response 값을 뿌려주기 위한 기본 셋팅을 진행한다.

<br>

### Basic Setting
---

<br>

```swift
class ViewController: UIViewController {
    
    //MARK:- Property
    let urlString = "https://api.androidhive.info/contacts/"
    let tableView = UITableView()
    var dataSource: [Contact] = []
    //MARK:- Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
```

superView와 동일한 사이즈를 갖는 tableView를 생성하고 커스텀셀을 등록해준다.

`Alamofire`를 이용해 request를 요청할 URL은 변수로 생성해준다.

해당 URL은 연락처 데이터를 JSON 형태로 반환해주는 URL이며 우리는 이번 예제에서 해당 URL로 요청을 보낼 것이다.

데이터는 아래와 같은 타입으로 전달받는다.

![image](https://user-images.githubusercontent.com/33051018/93872134-ab14f880-fd0a-11ea-86d9-b6870fbd39c5.png)


<br>

### Custom Cell
---

위 JSON 데이터에서 우리는 `name`, `email`, `gender` 데이터를 가져와서 TableView에 뿌려줄 것이다.

해당 데이터를 뿌려줄 CustomCell을 작성한다.

```swift
import UIKit

import SnapKit

class CustomCell: UITableViewCell {
    static let identifier: String = "cellIdentifier"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(emailLabel)
        self.contentView.addSubview(genderLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        genderLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(nameLabel.snp.top)
            make.bottom.equalTo(nameLabel.snp.bottom)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.top.equalTo(nameLabel.snp.top).offset(30)
            make.bottom.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
}
```

CustomCell을 만들었으면 이를 TableView에서 사용할 수 있도록 해당 TableView에 등록해줘야 한다.

```swift
private func registerCell() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
}
```

위와 같이 `register()` 함수를 이용하여 이 셀 타입을 사용할 것임을 TableView에게 알려준다!

이제 UI 준비는 끝났다!

<br>

### Codable (Swift Object <-> JSON)
---

자 이제는 JSON 데이터를 가져와서 이를 기반으로 Swift 객체를 만들어야 한다.

과거에는 (물론 지금도 많이 사용) `SwiftyJSON` 이라는 라이브러리를 이용해 JSON 파싱을 했다. 필자도 추후 한번 다뤄볼 생각이다!

이번에는 Swift 자체에서 제공하는 `Codable` 을 이용하여 JSON 데이터를 Decode 해보도록 한다.

(만일, `Codable` 프로토콜 사용법 혹은 이해가 부족하다면 [Codable](https://duwjdtn11.tistory.com/562) 를 한번 읽고오자!)

이번 예제에서는 name, email, gender 정보만을 이용할 것이다.

따라서, JSON 데이터로부터 해당 내용들을 가져와 Swift 객체로 만들기 위한 구조체를 아래와 같이 생성한다.

```swift
struct APIResponse: Codable {
    let contacts: [Contact]
}

struct Contact: Codable {
    let name: String
    let email: String
    let gender: String
}
```

이후 디코딩 한 스위프트 객체를 저장하기 위한 `[Contact]` 타입의 변수를 ViewController에 하나 생성한다.

```swift
let dataSource: [Contact] = []
```

<br>

### HTTP request & JSON Decoding
---

드디어 사전준비를 모두 마쳤다.

이제 `Alamofire` 를 이용하여 해당 서버에 데이터를 요청해본다.

```swift
private func fetchData() {
        // HTTP Request
        AF.request(urlString).responseJSON { (response) in
            switch response.result {
                // 성공
            case .success(let res):
                do {
                    // 반환값을 Data 타입으로 변환
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    // Data를 [Contact] 타입으로 디코딩
                    let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                    // dataSource에 변환한 값을 대입
                    self.dataSource = json.contacts
                    // 메인 큐를 이용하여 tableView 리로딩
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
                // 실패
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
```

데이터를 요청하고 받아온 JSON 값을 기반으로 decoding 하는 메소드다. 흐름은 아래와 같다.

1. AF.reqeust 를 이용하여 Request 송신
2. response 값을 `JSONSerialization.data()`를 이용해 Data 타입으로 변환
3. jsonData 값을 `JSONDecoder().decode()` 를 이용해 `[Contact]` 타입으로 디코딩
4. 메인 큐를 이용하여 테이블 뷰 리로딩

해당 함수를 `viewDidLoad()` 에서 호출해주도록 하고 실행해본다!


![image](https://user-images.githubusercontent.com/33051018/93874130-dd742500-fd0d-11ea-9068-858070f4eacb.png)

정상적으로 데이터가 TableView에 보여지는 것을 확인할 수 있다!

<br>

전체 코드는 [Alamofire Demo](https://github.com/yeojaeng/LibraryDemo/tree/master/AlamofireDemo) 에서 확인할 수 있다.

간단하게 `Alamofire` 란 무엇인지, 어떤 기능을 제공하며 이를 사용하기 위해서는 어떻게 해야하는지 알아보았다.

요즘 앱에서 네트워킹 기능이 없는 앱은 거의 없으니 꼭꼭 익혀두고 더욱 편하게 네트워킹을 하자!