# URLSession & URLSessionDataTask

<br>

## URLSession
---

`URLSession` 은 HTTP/HTTPS 프로토콜을 통해 데이터를 주고받는 API를 제공하는 클래스이다.

이 API는 인증 지원을 위한 다양한 `delegate` 메서드를 제공하며, 애플리케이션이 실행중이지 않거나 일시 중단된 상태 동안 백그라운드 작업을 통하여 컨텐츠를 다운로드 진행을 하기도 한다.

`URLSession` API를 사용하기 위해 애플리케이션은 **세션**을 생성한다.

이렇게 생성된 세션을 통해 관련 데이터 전송작업 그룹을 조절한다.

### Request

- 서버로 요청을 보낼 때 어떤 (HTTP)메서드를 사용할 것인지 등을 설정한다.

### Response
- URL 요청에 대한 응답을 나타내는 객체이다.

### 세션의 유형
- `URLSession` API는 세가지 유형의 세션을 제공한다. 해당 타입은 `URLSession` 객체가 소유한 `configuration` 프로퍼티 객체에 의해 결정된다.
  - 기본 세션 : URL 다운로드를 위한 다른 파운데이션 메서드와 유사하게 동작한다.
  - 임시 세션 : 기본 세션과 유사하지만, 디스크를 사용하지 않고 메모리에 올려 세션과 연결한다.
  - 백그라운드 세션 : 백그라운드 세션은 별도의 프로세스가 모든 데이터 전송을 처리한다는 점을 제외하고는 기본 세션과 유사하다.

<br>

### 세션 만들기

```swift
init(configuration: URLSessionConfiguration)
// 지정된 세션 구성으로 세션을 생성한다.

class var shared: URLSession { get }
// 싱글턴 세션 객체를 반환한다.
```

### 세션 구성

```swift
@NSCopying var configuration: URLSessionConfiguration { get }
// 세션에 대한 구성 객체이다.

var delegate: URLSessionDelegate? { get }
// 세션의 델리게이트다.
```

<br>

## URLSessionTask
---

`URLSessionTask` 는 세션 작업 하나를 나타내는 추상 클래스다.

하나의 세션 내에서 `URLSession` 클래스는 세 가지 작업의 유형을 지원한다.

- `URLSessionDataTask`
  - HTTP의 각종 메서드들을 이용하여 서버로부터 응답 데이터를 받아와서 `Data` 객체를 가져오는 작업을 수행한다.

- `URLSessionUploadTask`
  - 애플리케이션에서 웹 서버로 `Data` 객체 또는 파일 데이터를 업로드하는 작업을 수행한다. 주로 HTTP의 POST 혹은 PUT 메서드를 이용한다.

- `URLSessionDownloadTask`
  - 서버로부터 데이터를 다운로드 받아서 파일의 형태로 데이터를 저장하는 작업을 수행한다. 백그라운드 상태에서도 작업이 가능하다.

데이터 작업은 서버로부터 어떠한 응답이라도 `Data` 객체의 형태로 전달받을 때 사용하며, 업로드 작업 혹은 다운로드 작업은 단순한 바이너리 파일 전달에 목적을 두고있다.

`JSON, XML, HTML` 데이터 등 단순 데이터의 전송에는 주로 데이터 작업을 사용하며, 용량이 큰 파일의 경우에는 백그라운드 상태에서도 전달할 수 있도록 업로드(다운로드) 작업을 주로 사용한다.

<br>

### 세션에 Data Task 추가하기

```swift
func dataTask(with url:URL) -> URLSessionDataTask
// URL에 데이터를 요청하는 데이터 작업 객체 생성.

func dataTask((with request: URLRequest) -> URLSessionDataTask)
// URLRequest 객체를 기반으로 URL에 데이터를 요청하는 데이터 작업 객체 생성.

func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
// URL에 데이터를 요청하고 요청에 대한 결과 응답을 처리할 completion Handler를 갖는 데이터 작업 객체 생성.
```

<br>

### 세션에 Download Task 추가하기

```swift
func downloadTask(with url: URL) -> URLSessionDownloadTask
// URL에 요청한 데이터를 다운로드하여 파일에 저장하는 다운로드 작업 객체 생성.

func downloadTask(with url: URL, completionHandler: @escaping(URL?, URLResponse?, Error?) -> Void)
// URL에 요청한 데이터를 다운로드 받아서 파일에 저장 후 completion Handler를 호출하는 다운로드 작업 객체 생성.

func downloadTask(with request: URLRequest) -> URLSessionDownloadTask
// URLRequest 객체 기반 URL에 요청한 데이터를 다운로드하여 파일로 저장하는 다운로드 작업 객체 생성.
```

### 세션에 Upload Task 추가하기
```swift
func uploadTask(with request: URLRequest, from bodyData: Data) -> URLSessionUploadTask
// URLRequest 기반으로 URL에 데이터를 업로드 하는 작업 생성.

func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
// URLRequest 객체 기반으로 URL에 데이터를 업로드 한 이후 completion Handler를 호출하는 작업을 만든다.

func uploadTask(with request: URLRequest, fromFile fileURL: URL) -> URLSessionUploadTask
// URLRequest 객체 기반으로 URL에 파일을 업로드하는 업로드 작업을 만든다.
```

<br>

### 작업(Task) 상태 제어
```swift
func cancel()
// 작업을 취소한다.

func resume()
// 일시중단된 작업을 재개한다.

func suspend()
// 작업을 일시중단한다.

var state: URLSessionTask.State { get }
// 작업의 상태 값을 갖는 프로퍼티

var priority: Float { get set }
// 작업처리 우선순위 프로퍼티이며 0.0 ~ 1.0 사이 값을 갖는다.


