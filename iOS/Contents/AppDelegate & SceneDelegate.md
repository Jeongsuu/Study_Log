# AppDelegate & SceneDelegate

오늘은 `iOS13` 버전 이후 프로젝트 생성시 자동으로 생성되는 `AppDelegate.swift` 와 `SceneDelegate.swift` 파일에 대해 알아보고자 한다.

![image](https://user-images.githubusercontent.com/33051018/82457301-34fc4d00-9af0-11ea-9722-fd91b74c02c4.png)

iOS 12 까지는 하나의 앱에 하나의 `window` 구성이였으나 iOS 13 이후부터는 window의 개념이 `scene` 으로 대체되고 하나의 앱에서 여러개의 `scene`을 가질 수 있게 되었다.

그러면 여기서 말하는 `Scene`이 대체 무엇인지 먼저 알아보도록 하자!

### Scene이란
`scene`은 앱의 사용자 인터페이스 및 컨텐츠의 배경으로 사용된다.

`Scene`에는 UI의 하나의 인스턴스를 나타내는 `windows`와 `ViewController`가 들어있다.

`Scene`들은 같은 메모리와 앱 프로세스 공간을 공유 하며 서로 동시에 실행된다.

결과적으로 하나의 앱은 여러개의 `scene`과 `SceneDelegate` 객체를 동시에 활성화 할 수 있다.

이를 통해 iOS 및 iPadOS에서는 `Split View`를 제공하여 다중 창 앱을 빌드할 수 있다.


![image](https://user-images.githubusercontent.com/33051018/82457380-4e04fe00-9af0-11ea-85c1-4a3badf57aec.png)

기존의 `AppDelegate`의 역할인 `UILifeCycle`에 대한 부분을 `SceneDelegate`가 대체하게 되었다.

또한, `AppDelegate` 는 `Session LifeCycle` 역할을 하게 되었기에 `Scene session`에 관련된 `application(_:configurationForConnecting:options:)` 와 `application(_:didDiscardSceneSessions:)` 함수가 추가되었다.
`SceneDelegate` 클래스에 존재하는 메소드들을 살펴보도록 하자.

#### `scene(_ :willConnectTo : options :)` 
- 가장 중요한 기능을 제공한다, iOS 12의 `application(_ : didFinishLaunchingWithOptions :)` 함수와 유사한 기능을하며 `scene` 이 앱에 추가될 때 호출된다.

#### `sceneDidDisconnect(_:)`
- 메소드명 그대로 `scene`의 연결이 해제될 때 호출된다.

#### `sceneDidBecomeActive(_ :)`
- `App Switcher`에서 선택되는 등 `scene`과의 상호작용이 시작될 때 호출된다.

#### `sceneWillResignActive(_ :)`
- 사용자가 `scene`과의 상호작용을 중지할 때 호출된다. 

#### `sceneWillEnterForeground(_ :)`
- `scene`이 foreground로 진입할 때 호출된다.

#### `sceneDidEnterBackground(_ :)`
- `scene`이 백그라운드에 진입한 직후에 호출된다.

<br>

### AppDelegate의 역할

이전에는 앱이 `foreground`에 들어가거나 `background`로 이동할 때 앱의 상태를 업데이트하는 등 앱의 생명주기 이벤트를 더이상 `AppDelegate` 클래스가 관리하지 않는다.

이제 `AppDelegate`는 아래와 같은 일을 한다.

- 앱의 주요 데이터 구조를 초기화한다.
- 앱의 scene을 설정한다.
- 앱 밖에서 발생한 알림에 대응한다.

`AppDelegate`에 새로 추가된 메소드들을 살펴보자!

#### `application(_ : configurationForConnecting : options :)`
- `scene`을 만들때 구성 객체를 반환한다.

#### `application(_ : didDiscardSceneSessions :)`
- 사용자가 `App Switcher`를 통해 `scene`을 닫을때 호출된다.


<br>

### 요약
---

- `iOS 13` 이상에서는 유저가 앱 UI의 여러 인스턴스를 동시에 만들고 관리할 수 있으며, `App Switcher`를 통해 전환 또한 가능하다.

- `iOS 13` 이상에서는 `AppDelegate`는 `Process LifeCycle`과 `Session LifeCycle`을 관리하며 `SceneDelegate`는 `UI LifeCycle`을 관리한다.

