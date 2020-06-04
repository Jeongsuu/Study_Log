# How to use Firebase Auth in iOS

본 문서에서는 `Firebase` 에서 제공하는 기능 중 하나인 `Auth`에 관하여 기재한다.

<br>

## How to install and setup on iOS
---


프로젝트의 `Podfile`에 아래 항목을 추가한다.

`pod 'Firebase'`

pod을 설치한 이후 `.xcwordspace` 파일을 연다.

<br>

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
    
}ㅠ

```

위 코드를 적용하였다.

에러가 발생할 경우, 에러값을 `alert`으로 띄우고, 그 외의 경우에는 정상적으로 화면을 전환시킨다.

![image](https://user-images.githubusercontent.com/33051018/83423418-e773ce80-a465-11ea-9c50-e23b064469a9.png)


한번 테스트를 진행해봤더니, 정상적으로 로그인이 된다!




<br>

### Reference
---
- [Firebase Official API Docs](https://firebase.google.com/docs/reference/swift/firebasecore/api/reference/Classes?authuser=3)

- [tilltue brunch](https://brunch.co.kr/@tilltue/31)
