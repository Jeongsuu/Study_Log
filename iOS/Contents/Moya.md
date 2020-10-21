# Moya - Networking Library

<br>

이번 시간에는 추상화 네트워킹 라이브러리 `Moya`에 대하여 알아보도록 하겠습니다.

`Moya` 라이브러리는 `urlSession`, `Alamofire`를 한 번 더 감싼 통신 API입니다.

`Moya`를 사용하면 아래와 같이 깔끔한 네트워크 레이어 구성이 가능합니다.

![image](https://user-images.githubusercontent.com/33051018/96685645-5e2f4b00-13b8-11eb-9e4e-ba870d5fe465.png)

`Moya`는 열거형을 이용하여 타입이 안전한 방식으로 네트워크 요청을 캡슐화하여 사용하는 것에 초점이 맞추어져 있습니다.

- Provider : Moya의 MoyaProvider는 모든 네트워크 서비스와 상호작용시 사용할 주요 객체입니다. 이를 초기화 할 때 Moya Target을 가지는 일반적인 객체입니다.

- Target : Moya Target은 일반적으로 전체 API를 의미하며 `TargetType` 프로토콜을 채택하는 것으로 target을 정의합니다.

APIService와 Target Type 정의 예시를 살펴보도록 하겠습니다.

<br>

```swift
// APIServcie가 제공하는 기능 열거
enum APIService {
    case createUser(name: String)
    case readUsers
    case updateUser(id: Int, name: String)
    case deleteUser(id: Int)
}

// TargetType 정의
extension APIService: TargetType {
    
    // endPoint의 baseURL을 반환합니다.
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError()
        }
        return url
    }
    
    // 모든 target(서비스)의 endPoint를 완성하기 위한 path를 반환합니다.
    var path: String {
        switch self {
        case .createUser, .readUsers:
            return "/users"
        case .updateUser(let id, _), .deleteUser(let id):
            return "/users/\(id)"
        }
    }
    
    // 모든 target(서비스)의 case에 따른 HTTP 메소드를 반환합니다.
    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .readUsers:
            return .get
        case .updateUser(_, _):
            return .put
        case .deleteUser(_):
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    // 모든 target(서비스)의 case에 따른 task를 반환합니다.
    var task: Task {
        switch self {
        // param이 필요없는 경우
        case .readUsers, .deleteUser(_):
            return .requestPlain
            
        // param 명시가 필요한 경우
        case .createUser(let name), .updateUser(_, let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
```

<br>

API를 통해 제공할 기능들을 `enum` 형식으로 정의한 이후, 이를 `extension` 합니다.

이 때, `TargetType` 프로토콜을 채택하여 구현하며 TargetType을 통해 기본적인 네트워킹 레이어를 구축합니다.

`TargetType` 준수를 위한 프로퍼티들을 살펴보겠습니다.

- `baseURL` : 모든 target(서비스)의 baseURL을 명시합니다. Moya는 이를 통하여 endpoint 객체를 생성합니다.
- `path` : Moya는 path를 통하여 라우팅을 합니다. endpoint의 subPath를 정의하며 case에 따른 endpoint를 생성합니다.
- `method` : Target(서비스)의 모든 case를 위하여 정확한 HTTP 메소드를 제공해야합니다.  
- `task` : 제일 중요한 프로퍼티입니디. 사용할 모든 endpoint마다 Task 열거형 케이스를 작성해야 하며 기본 요청(plain request), 데이터 요청(data request), 파라미터 요청(parameter request), 업로드 요청(upload request) 등 사용할 수 있는 다양한 task를 제공합니다. 
- `sampleData` : 테스트를 위한 목업 데이터를 제공할 떄 사용합니다. 이번 예제에서는 UnitTest를 진행하지 않으므로 빈 Data 객체를 반환합니다.
- `headers` : 모든 target(서비스)의 endpoint 를 위한 HTTP header를 반환합니다. 이번 예제에서 사용하는 모든 endpoint는 JSON 데이터를 반환하기 때문에  `Content-Type: application/JSON` header를 반환하였습니다.

<br>

위와 같이 TargetType을 구현하면 서비스를 사용할 준비가 끝납니다!

API 서비스를 사용할 ViewController에서 `MoyaProvider`를 생성합니다.

<br>

```swift
let service = MoyaProvider<APIService>()
```

MoyaTarget과 상호작용하는 MoyaProvider를 생성하기 위해 MoyaProvider 인스턴스를 생성합니다.

`MoyaProvider` 는 제네릭 타입으로 정의하며 TargetType을 채택한 자료형을 기입합니다.

이후 request를 요청할때는 `MoyaProvider`를 통해 접근합니다.

API를 통해 데이터를 요청하여 가져오는 소스코드를 작성해보겠습니다.

<br>

```swift
// fetch user data with Moya.
    fileprivate func readUsers() {
        // MoyaProvider를 통해 request를 실행합니다.
        service.request(APIService.readUsers) { [weak self] result in
            guard let self = self else { return }
            
            // 반환되는 result 타입의 결과값에 따라 적절히 데이터를 처리합니다.
            switch result {
            case .success(let response):
                do {
                    let users = try JSONDecoder().decode([User].self, from: response.data)
                    self.users = users
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
```

소스코드가 매우 직관적이며 사용하기 매우 편합니다!

`Alamofire` 혹은 `urlSession` 처럼 request를 요청하며 `completion Handler` 콜백을 통해 response로 넘어온 데이터들을 가공합니다.

본 포스팅에는 `Read` 메소드만 설명되어 있습니다.

전체 소스코드를 보고 싶으신 분은 [여기](https://github.com/yeojaeng/LibraryDemo/tree/master/MoyaDemo/MoyaDemo)를 방문해주세요.

오늘은 이렇게 `Moya` 라이브러리에 대하여 간략하게 살펴보았습니다.

`Moya`는 기존에 사용해왔던 `urlSession` 혹은 `Alamofire`에 비하여 유연하고 안전한 네트워크 레이어를 제공한다는 느낌을 받았습니다.

`enum` 타입을 기반으로 type-safe한 레이어 구성이 가능하며 endPoint에 target 커스터마이징의 자유도도 매우 높다고 느껴집니다.

앞으로 네트워킹 작업이 필요할 경우 자주 사용할 것 같습니다!








<br>


## Reference
---

- [Moya official github](https://github.com/Moya/Moya)