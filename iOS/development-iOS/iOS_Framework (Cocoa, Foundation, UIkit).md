---

---

### iOS 구성요소

---

1. ViewController
    - 화면의 구성요소를 다루는 객체

2. AppDelegate

- 앱의 프로세스 중 일어날 이벤트를 다루는 객체

3. Storyboard

- 앱의 레이아웃 구성화면과 흐름을 총관리

### 코코아 (Cocoa)

---

먼저 코코아는 `NSObject` 를 상속받는 모든 클래스와 모든 객체를 가리킬 때 사용하는 ㄷ나어다.

### 코코아 터치 (Cocoa Touch)

---

코코아 터치 프레임워크란 iOS 개발 한경을 구축하기 위한 최상위 프레임워크다.

즉, 일반적으로 iOS개발을 위해 Swift에서 상속하여 사용하는 UIKit, Foundation을 포함한 대부분의 클래스, 객체들이 모두 코코아 터치 프레임워크에 속한다.

참고로 이름이 비슷한 코코아 프레임워크는 macOS 개발 환경을 위한 프레임워크라고 한다.

그렇기 때문에, 아이폰과 아이패드 등 터치 기반의 iOS 개발 환경에 코코아 터치 프레임워크라는 이름이 붙게된 것 같다.

### UIKit

---

UI(User Interface) 라는 이름에서 알 수 있듯이, UIKit 프레임워크는 사용자의 인터페이스를 관리하고, 이벤트를 처리하는게 주요 목적인 프레임워크다.

iOS 이전의 macOS에서는 비슷한 개념으로 Application Kit 줄여서, AppKit 이라는 프레임워크를 사용했었지만, iOS로 넘어오면서 비슷한 개념을 가진 UIKit 으로 대체되었다.

UIKit에서 주로 처리하는 사용자 이벤트로는 제스처 처리, 애니메이션, 그림 그리기, 이미지 처리, 텍스처 처리 등이 있다.

또한 테이블 뷰, 슬라이더, 버튼, 텍스트 필드, 경고창 등 애플리케이션의 화면을 구성하는 요소도 포함한다.

그렇기 때문에, 자주 사용하는 `UIViewController`, `UIView` , `UIAlertController` 등 앞에 `UI`가 붙는 클래스들을 사용하려면 반드시 `UIKit` 을 상속해야 한다.

그냥 화면을 구성하기 위해 필수적으로 상속해야 하는 프레임워크라고 봐도 무방하다.

### Foundation

---

프로그램의 뿌리를 담당하는 프레임워크다. 가장 기본적인 원시 데이터 타입 (String, Int, Double)부터가 Foundation에 포함되어 있기 때문에, 프레임워크를 상속하지 않으면 아무것도 할 수 없다고 봐도 무방하다.

`Foundation` 내에 포함된 클래스들은 앞에 `NS`가 붙으며 주로 사용하는 기능은 아래와 같다.

`Number, Data, String`: 원시 데이터 타입 사용

`Collection`: Array, Dictionary, Set 등과 같은 컬렉션 타입 사용

`Date and Time`: 날짜와 시간을 계산하거나 비교하는 작업

`Unit and Measurement`: 물리적 차원을 숫자로 표현 및 관련 단위 간 변환 기능

`Data Formatting`: 숫자, 날짜, 측정값 등을 문자열로 변환 또는 반대 작업

`Filter and Sorting`: 컬렉션의 요소를 검사하거나 정렬하는 작업

### 애플리케이션 지원

`Resources`: 애플리케이션의 에셋과 번들 데이터에 접근 지원

`Notification`: 정보를 퍼뜨리거나 받아들이기는 기능 지원

`App Extension`: 확장 애플리케이션과의 상호작용 지원

`Error and Exceptions`: API와의 상호작용에서 발생할 수 있는 문제 상황에 대처할 수 있는 기능 지원

### 파일 및 데이터 관리

`File System`: 파일 또는 폴더를 생성하고 읽고 쓰는 기능 관리

`Archives and Serialization`: 속성 목록, JSON, 바이너리 파일들을 객체로 변환 또는 반대 작업 관리`iCloud`: 사용자의 iCloud 계정을 이용해 데이터를 동기화하는 작업 관리

### 네트워킹

`URL Loading System`: 표준 인터넷 프로토콜을 통해 URL과 상호작용하고 서버와 통신하는 작업

`Bonjour`: 로컬 네트워크를 위한 작업
