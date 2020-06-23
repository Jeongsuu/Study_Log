# Alamofire 

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

### Request

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
Alamofire.request("https://google.com/get")
Alamofire.request("https://google.com/post", method: .post)
Alamofire.request("https://google.com/put", method: .put)
Alamofire.request("https://google.com/delete", method: .delete)
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
Alamofire.request("https://google.com/get").responseJSON {
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

