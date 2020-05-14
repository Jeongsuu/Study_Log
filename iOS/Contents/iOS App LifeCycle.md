# iOS 앱 생명주기

<br>

### App Life Cycle
---
![image](https://user-images.githubusercontent.com/33051018/81951811-95971000-9640-11ea-8520-ebf41a283665.png)


`App`의 생명주기란, `App`을 터치하여 실행시킨 뒤 이것이 완전히 종료되기 까지 크게 3단꼐, 세밀하게 10단계로 진행이 된다.

- UIApplication 객체 생성
- AppDelegate 객체 생성
- Event Loop 을 실행하며 유저의 이벤트 확인

1. App Touch
2. main() 안에서 `UIApplicationMain()` 호출, `UIApplication` 객체 생성
3. `UIApplication` 객체는 `info.plist` 파일으로부터 앱에 필요한 데이터와 객체들을 로드
4. 커스텀 코드를 처리하기 위한 `AppDelegate`를 생성하고 이를 `UIApplication` 객체와 연결
5. 실행을 준비하고 `application(_:willFinishLaunchingWithOptions:)` 호출
6. 준비가 끝나고 앱 실행 직전에 `application(_:didFinishLaunchingWithOptions:)` 호출
7. `Main run loop` 실행, 이벤트 큐를 이용해 이벤트 순차 처리, 
8. 앱을 더이상 사용하지 않으면 `iOS System`에 `terminate` 메시지 전달
`applicationWillTerminate(_:)` 호출
9. App종료


`Swift`는 C 계열의 언어가 아니기 때문에 `main()`과 같은 시작점을 갖지 않는다.

따라서, `@UIApplicationMain` 이라는 어노테이션을 통해 `UIApplication` 객체 생성 과정을 대신한다.

모든 iOS 앱들은 `UIApplication` 함수를 실행한다.

이 떄 생성되는 것 중 하나가 `UIApplication` 객체이며 이는 `Singleton` 형태로 생성되어, `UIApplication.shared` 형태로 앱 전역에서 사용이 가능하다.

<br>

### 앱의 상태 변화
---

앱의 상태라는 것은, 여러가지 의미를 내포하지만 애플에서는 앱의 상태를 크게 5가지로 구분한다.

![image](https://user-images.githubusercontent.com/33051018/81952267-3e456f80-9641-11ea-9dca-d47371e03bdd.png)

- Not Running: 아무것도 실행하지 않은 상태.
- InActive: 앱이 Foreground 상태로 돌아가지만, 이벤트는 받지 않는 상태.
- Active : 일반적으로 앱이 돌아가는 상태.
- Background : 앱이 Suspended 상태로 진입하기 전에 거치는 상태. 실행되는 코드는 있는 상태.
- Suspended : 앱이 Background 상태에 있으나, 아무 코드도 실행하지 않는 상태.

Background 상태에서 앱을 실행하면 `InActive` 상태를 거치지 않고 앱이 실행된다.

홈버튼을 두번 클릭하여 앱을 전활할 때, 앱이 재시작되지 않고 바로 실행된다면 해당 앱은 Background 상태에 있었던 것이다.

**iOS 앱에는 다양한 상태가 있지만, 주요 작업들은 Active, Background 상태에서 이루어진다.**

<br>

### AppDelegate
---

앞서 설명한 상태들에 접근하기 위해서 사용되는 파일이 `AppDelegate.swift` 파일이다.

`iOS` 프로젝트를 생성하면 `AppDelegate.swift` 파일은 자동적으로 생성된다.

**`AppDelegate`는 이름 그대로 앱과 시스템을 연결하기 위해 필요한 `Delegate` 메소드들을 담고 있다.**

![image](https://user-images.githubusercontent.com/33051018/81953009-1f93a880-9642-11ea-847a-60304b2e8701.png)

위 그림과 같이 `AppDelegate` 클래스에는 `@UIApplication` 이라는 어노테이션이 기재되어있다.

이를 통해 앱은 이를 시스템과 연결하기 위한 파일로 인식한다.

해당 파일 내 다양한 델리게이트 메서드들을 통해 앱의 생명주기 단계들에 접근이 가능하다.
