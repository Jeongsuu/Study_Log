# How to use Firebase in iOS

본 문서에서는 `Firebase` 에서 제공하는 실시간 데이터베이스 관련 공식 문서를 살펴보며 이에 대한 사용방법을 기재하도록 한다.

<br>

## How to install and setup on iOS
---

`Firebase` 실시간 데이터베이스는 클라우드 기반 호스팅 DB이다.

데이터는 `JSON` 형태로 저장되며 연결된 모든 클라이언트에 실시간으로 동기화된다.

프로젝트의 `Podfile`에 아래 항목을 추가한다.

`pod 'Firebase/Database'`

pod을 설치한 이후 `.xcwordspace` 파일을 연다.

<br>

## RealTime Database setting
---

`Firebase` 를 사용하기 위해서는 우선 `Firebase`를 초기화 해야 한다.

초기화 방법은 아래와 같다.

1. `AppDelegate` 에 `Firebase` 모듈을 추가한다.

![image](https://user-images.githubusercontent.com/33051018/83332440-2ffc8200-a2d6-11ea-8394-7577bc3f1493.png)

이후 `application:didFinishLaunchingWithOptions:` 메소드에서 `FirebaseApp` 공유 인스턴스를 생성한다.

![image](https://user-images.githubusercontent.com/33051018/83332461-528e9b00-a2d6-11ea-99df-37ba45c704e9.png)

`Firebase` 실시간 데이터베이스가 성공적으로 초기화되었다면 아래와 같은 데이터베이스 참조를 위한 변수를 정의하고 생성한다.

![image](https://user-images.githubusercontent.com/33051018/83332532-a8634300-a2d6-11ea-9d7e-cf02abcf4297.png)



이제 데이터베이스 사용을 위한 준비는 모두 끝났다.

이제 직접 데이터를 저장해보도록 한다.

<br>

## Saving Data in iOS
---

`Firebase` 실시간 데이터베이스에서 데이터를 쓰기 위해 사용되는 메소드는 4가지가 존재한다.

`setValue` : 정의된 경로(ex: users/<user-id>/<username>)에 데이터를 쓰거나 대체한다.

`childByAutoId` : 데이터 목록에 추가한다. `childByAutoId`를 호출할 때 마다 `Firebase`에서 고유 식별자로도 사용할 수 있는 고유키 (ex: user-posts/<user-id>/<unique-post-id>)를 생성한다.

`updateChildValues` : 정의된 경로의 일부 키를 업데이트 한다.

`runTransactionBlock` : 동시 업데이트에 의해 손상될 수 있는 복잡한 데이터를 업데이트 한다.

<br>

~~..이렇게 봐서는 잘 모르겠다, 직접 적용시켜보자.~~

## User Registration
---

현재 진행중인 프로젝트에서는 회원가입을 통해 유저를 관리한다.

현재 프로젝트에 Firebase의 Auth 기능을 적용시켜보도록 한다.


```swift
@objc func nextButtonTapped() {
        print(#function)
        
        // ID & PW 입력값 검증
        guard let id: String = self.idTextField.text, id.isEmpty == false, id.contains("@") else {
            self.showAlert(message: "아이디를 이메일 포맷으로 입력해주세요.\n ex: example@gmail.com")
            return
        }
        
        guard let pw: String = self.pwTextField.text, pw.isEmpty == false, pw.count >= 6 else {
            self.showAlert(message: "비밀번호는 최소 6자 이상을 입력해주세요.")
            return
        }
        
        Auth.auth().createUser(withEmail: id, password: pw) { (dataResult, error) in
            if let e = error {
                print(e.localizedDescription)
                self.showAlert(message: "Error Occured")
            } else {
                let profileVC = ProfileViewController()
                self.navigationController?.pushViewController(profileVC, animated: true)
            }
        }
        
    }
```

위 함수는 로그인 버튼 클릭시 실행되는 함수다.

사용자의 입력값의 포맷이 올바른지 검증한 이후, `Firebase/Auth`의 `createUser()` 메서드를 이용하여 사용자를 서비스에 가입시킬 수 있다.

사용자가 양식을 작성하여 전달하면 입력한 이메일 주소와 비밀번호의 유효성을 검사하여 `createUser()` 메서드에 전달한다.

정말 꿀인건 자체적으로 사용자의 입력값에 대하여 유효값 필터링을 진행한다는 점이다!

핵심은 `createUser()`메서드다.

```swift
Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
  // ...
}
```

`createUser()`는 유저 생성 api이며 이메일과 비밀번호가 필요하다.


![image](https://user-images.githubusercontent.com/33051018/83422069-f2c5fa80-a463-11ea-877f-58dda57fe3f5.png)

해당 함수가 실행되기 이전의 콘솔창이다.

![image](https://user-images.githubusercontent.com/33051018/83422213-2b65d400-a464-11ea-8b5e-afb8eba8a7c9.png)

해당 함수가 실행된 이후의 콘솔창이다.

내가 입력한 ID값으로 데이터가 저장되었음을 알 수 있다.

이제 회원가입에 사용되는 메서드를 확인했다.

<br>

## User Login
---

이제는 회원가입을 진행한 사용자가 회원가입을 진행한 정보를 통해 로그인하는 방법에 대해 살펴보도록 한다.

기존 사용자가 로그인 할 때 필요한 API는 `Auth.auth().signIn()` 메서드이다.

```swift
Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
  guard let strongSelf = self else { return }
  // ...
}
```

`signIn` API는 인증 단계가 끝나지 않으면 에러를 반환한다.

위 코드를 직접 적용 해보도록 한다.

```swift

    @objc func loginButtonTapped() {
        print(#function)
        
        // 입력값 검증
        guard let id: String = self.idTextField.text, id.isEmpty == false, id.contains("@") else {
            self.showAlert(message: "아이디를 이메일 포맷으로 입력해주세요.\n ex: example@gmail.com")
            return
        }
        
        guard let pw: String = self.pwTextField.text, pw.isEmpty == false, pw.count > 6 else {
            self.showAlert(message: "비밀번호는 최소 6자 이상을 입력해주세요.")
            return
        }
        
         Firebase/Auth
        Auth.auth().signIn(withEmail: id, password: pw) { autoResult;, error) in

            if let e = error {
                self.showAlert(message: e.localizedDescription)
                print(e.localizedDescription)

            } else {
                // RootViewController Switching (MainViewController -> tabBarController)
                let tabBar = TabBarController()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = tabBar

            }
        
    }
    
}

```

위 코드를 적용하였다.

에러가 발생할 경우, 에러값을 `alert`으로 띄우고, 그 외의 경우에는 정상적으로 화면을 전환시킨다.

![image](https://user-images.githubusercontent.com/33051018/83423418-e773ce80-a465-11ea-9c50-e23b064469a9.png)


한번 테스트를 진행해봤더니, 정상적으로 로그인이 된다!


**계속하여 작성중**


<br>

### Reference
---
- [Firebase Official API Docs](https://firebase.google.com/docs/reference/swift/firebasecore/api/reference/Classes?authuser=3)

- [tilltue brunch](https://brunch.co.kr/@tilltue/31)
