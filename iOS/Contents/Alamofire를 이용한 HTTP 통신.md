# HTTP 통신 예제

`iOS` 앱을 개발하다보면 네트워크를 통해 데이터에 접근해야 하는 경우가 발생한다.

이러한 경우를 위해 애플은 `URLSession` 이라는 파운데이션을 제공한다. -> 이 또한 매우 좋음..!

그러나 `URLSession` 을 사용하다보면 종종 쓰기 난해하고 복잡하다는 것을 느낄 수 있다.

이러한 경우 `Alamofire`는 우리에게 사용의 용이성을 제공한다.

`Alamofire`란 스위프트 기반의 `HTTP` 네트워킹 라이브러리다. 애플의 파운데이션 기반으로 네트워킹을 쉽게 할 수 있도록 만들어진 라이브러리이며 `request`, `response`에 대한 체이닝 메소드, `JSON`, `Codable` 디코딩 기능을 제공한다.

이번 예제를 통해 해볼 것은 아래와 같다.

- 서드파티 RESTful API에 데이터 요청.
- `request` 파라미터 전달.
- `response`를 `JSON` 형태로 컨버팅.
- `Codable` 프로토콜을 이용해 스위프트 데이터 모델로 컨버팅

<br>

## Understanding HTTP, REST and JSON
---

### HTTP

`HTTP`란, 서버와 클라이언트간 통신을 위해 이용되는 프로토콜이다.

클라이언트가 원하는 행위에 따라 request 메소드를 통해 서버에 데이터를 요청한다.

대표적인 메소드는 아래와 같다.

- GET : 데이터를 가져온다, 가령 예를 들면 웹 페이지 컨텐츠를 가져오는 것이다. 서버 내에서 변경되는 데이터는 없다.
- HEAD : GET과 유사하다. 그러나 실제 데이터가 아닌 헤더만 수신한다.
- POST : 서버에 데이터를 송신한다. 예를 들면 전송 버튼 클릭시 폼을 데이터를 받아와 해당 데이터를 폼에 출력시켜주는데 이용된다.
- PUT : 특정 위치로 데이터를 송신한다, 사용자의 프로필을 업데이트 하거나 하는 등에 사용된다.
- DELETE : 특정 위치의 데이터를 삭제한다.


### JSON

`JSON`은 JavaScript Object Notation의 약자로서, 사람이 읽기 편하고 시스템 간 데이터 전송을 용이하게 해주는 데이터 형태이다.

Swift4 초창기에는 `JSONSerialization` 클래스를 이용하여 데이터를 JSON 형태로, JSON을 데이터 형태로 컨버팅 하는데 사용했다.

물론 지금도 사용이 가능하며 많이들 사용하고 있다, 그러나 현재는 우리의 데이터 모델로 쉽게 컨버팅 해주기 위한 프로토콜 `Codable` 이라는 새로운 개념이 생겨났으며 제일 많이 사용하는 것으로 알고있다.

### REST

`REST`란, 일관된 web API를 구성하기 위한 일련의 규칙이다. 이를 통해 개발자는 request에서 데이터 상태를 추적하지 않고 API를 쉽게 사용할 수 있다.

`HTTP, JSON, REST` 는 웹 서비스에서 큰 파이를 갖는다. 그렇기에 우리는 더욱이 이를 사용할 줄 알아야한다!

<br>

## Why use Alamofire?
---

애플이 `URLSession` 또는 다양한 HTTP 통신을 위한 클래스를 제공함에도 불구하고 왜 Alamofire를 이용하는지 궁금한 사람들이 있을것이다.

간단히 말하면, `Alamofire` 또한 `URLSession`에 기반을 두고 있다. `URLSession`을 사용하다보면 많은 어려움? 또는 난해함을 느끼게되고 우리는 더욱 간편한 것을 찾으려고 노력하다보니 `Alamofire`가 탄생하게 되었고 많이들 사용하게 되었다.

이를 사용하면 얼마 안되는 코드로 인터넷 상 데이터에 접근이 가능하고 코드 또한 깔끔해지며 가독성을 얻을 수 있다.

`Alamofire` 의 주요 함수들에 대해 살펴보자.

- AF.upload : 이름을 보면 알 수 있듯이 스트림, 파일 또는 데이터 방식으로 파일을 업로드 할 수 있다.
- AF.download : 파일을 다운로드 하는 기능을 제공한다.
- AF.request : 파일 전송과 관련이 없는 데이터를 HTTP 프로토콜을 통해 요청한다.

위 메소드들은 인스턴스 메소드가 아니기 때문에 `Alamofire` 인스턴스화 할 필요가 없다.

<br>

## Requesting Data
---

자 이제 이론은 끝났다, 직접 데이터를 전송해보도록 하자!

`Alamofire`를 사용하고자 하는 위치에서 이를 `import` 해준다.

![image](https://user-images.githubusercontent.com/33051018/86225014-9cfc8380-bbc4-11ea-88b2-e331284c2409.png)

```swift
extension MainTableViewController {

    let targetURL = "https://swapi.dev/api/films"

    func fetchFilms() {
    
    let request = AF.request(targetURL)
    
    request.responseJSON { (data) in
      print(data)
    }
  }
}
```

위와 같이 코드를 작성하고 이를 살펴본다.

HTTP 요청을 보낼 URL을 지정하고 , `AF.request()` 메소드를 이용해 request를 요청한다.

이후, 체이닝하여 `responseJSON` 으로 데이터를 핸들링한다.

해당 함수를 `viewDidLoad()` 에서 호출하여 받아온 데이터를 간단히 Print 해보자.

```JSON
success({
    count = 6;
    next = "<null>";
    previous = "<null>";
    results =     (
                {
            characters =             (
                "http://swapi.dev/api/people/1/",
                "http://swapi.dev/api/people/2/",
```

(response 값이 너무 필어서 잘랐다..)

데이터가 정상적으로 받아와지는 것을 확인했다.

이렇게 몇 줄 안되는 코드를 이용해 서버로부터 JSON 데이터를 받아왔다! 

<br>

## Using a Codable Data Model
---

이제는 전달받은 JSON 데이터를 활용해 볼 것이다.

JSON 데이터는 보면 알 수 있듯이 중첩 구조를 갖고 있기 때문에 raw data를 직접 가공하는 것을 어려울 수 있으므로 해당 데이터를 저장할 데이터 모델을 정의한다.

```swift
// Film.swift
import Foundation

struct Film: Decodable {
  
  let id: Int
  let title: String
  let openingCrawl: String
  let director: String
  let producer: String
  let releaseDate: String
  let starships: [String]
  
  enum CodingKeys: String, CodingKey {
    case id = "episode_id"
    case title
    case openingCrawl = "opening_crawl"
    case director
    case producer
    case releaseDate = "release_date"
    case starships
  }
}
```

```swift
//Films.swift
import Foundation

struct Films: Decodable {
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}

API의 엔드포인트에서 데이터를 가져오는데 필요한 데이터 프로퍼티 및 코딩 키를 작성했다.

CodingKey 프로토콜은 인코딩 및 디코딩을 위한 키로 사용할 수 있도록 도와주는 프로토콜이다.

위 코드의 예시중 `case releaseDate = "release_date"` 가 의미하는 바는 `release_date`는 `releaseDate` 로 넣어준다는 의미이다!

여기서 주목할 점은 구조체가 채택하고 있는 프로토콜 `Decodable`이다. 이를 통해 JSON 데이터를 데이터 모델로 컨버팅한다.

```swift

request.responseDecodable(of: Films.self) { (response) in
    guard let films = response.value else { return }
    print(films.all[0].title)
}
```

위 코드는 요청에 대한 응답값 JSON 형태의 데이터를 핸들링하여 `Films` 형태로 디코딩하며 해당 데이터의 title 값을 출력한다.

<br>

## Method Chaining
---

`Alamofire` 는 메소드 체이닝 기법을 이용한다. 이는 응답값을 다른 메소드의 입력으로 연결해주는 기능을 한다.

이를 통해 코드를 더욱 간결하게 작성할 수 있다.

위에서 작성한 fetchFilms 함수를 아래와 같이 수정해본다.

```swift
func fetchFilms() {
    
    AF.request(targetURL)
      .validate()   // 응답상태 검증
      .responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else { return }
        print(films.all[0].title)
    }
    
  }
```

`alamofire`를 이용하여 특정 URL에 데이터를 요청하고 이에 대한 응답값의 유효성도 검증하고 해당 값을 Films 형태로 디코딩하여 `respone.value` 값을 films에 넣는다.

위 코드에서 print문을 제거하고 아래 코드를 추가한다.

```swift

self.items = films.all
self.tableview.reloadData()
```

이후 해당 값을 간단히 테이블 뷰를 통해 출력해주면

![image](https://user-images.githubusercontent.com/33051018/86243459-65500480-bbe1-11ea-8be9-7981f70f9138.png)

이와 같이 정상적으로 데이터가 출력된다!



<br>

