## Signup 기능 구현
---
(소스코드는 방침으로 인해 공개하지 않습니다.)

### SignUp 기능 구현
---

많은 애플리케이션에서 활용해 볼 수 있는 회원가입 기능을 구현해본다.

물론 많은 애플리케이션에서 활용하기에는 다소 조금은 복잡한 절차들이지만 **내비게이션 인터페이스** 와 **모달**에 대하여 이해할 수 있다.

또한, 여러 화면에서 공유해야 하는 데이터를 어떻게 관리할 수 있을지 고민해 볼 수 있다.
마지막으로 간단하게나마 디자인 패턴을 실질적으로 구현해 보며 몇몇 디자인 패턴에 대한 이해를 증진시킬 수 있다.


#### 화면 1 - 로그인 화면

- 화면 구성
    - 아이디와 패스워드를 입력하는 필드가 있고, 각각 알맞은 플레이스홀더(placeholder)가 적혀있다.
    - 상단에는 사이트와 관련된 이미지를 보여주며, 그 아래에는 로그인 버튼과 회원가입 버튼이 있다.
- 기능
    - 로그인 버튼을 눌러도 아무 반응이 없으며 회원가입 버튼을 누르면 화면2로 전환한다.

---

우리가 만들어야할 첫번째 하면은 아래와 비슷하다.

![image](https://user-images.githubusercontent.com/33051018/78524973-aa49e200-7810-11ea-83bd-83fedc22d6ff.png)


화면 구성에는 AutoLayout을 적극 이용한다.

`UIImageView` 를 놓고 그 아래에 `Stack View` 를 통해 `Texf Field`를 두개 (ID, PW) 위치시킨다.

이후 `Horizontal View` 놓고 `Sign in` 버튼과 `Sign up` 버튼을 생성한다.

ID와 PW값을 입력받을 TextField 간의 spacing은 적절히 10으로 셋팅하고 사용자에게 해당 필드에 어떠한 값이 입력되어야 한다는 것을 알려주기 위해 `PlaceHolder` 를 적절히 이용한다.

![image](https://user-images.githubusercontent.com/33051018/78525334-c7cb7b80-7811-11ea-98fa-26aa2330f2eb.png)

Image는 본인이 넣고싶은 이미지를 넣는다.

필자는 본인이 좋아하는 캐릭터를 넣었다.

![image](https://user-images.githubusercontent.com/33051018/78525496-47594a80-7812-11ea-9732-9ec1bf07d75c.png)

첫번째 화면 구성은 거의 비슷하게 만들었다.

아이디와 패스워드를 입력하는 필드도 있고, 적절한 `placeholder`도 적용하였다.

상단에도 이미지를 넣어주었으며 그 아래에 로그인 버튼과 회원가입 버튼이 있다.

이후 기능을 적용해야한다.

`Sign In` 버튼 클릭시에는 아무 반응이 없고 `Sign Up` 버튼 클릭시에는 화면 2로 전환한다.

여기서의 화면전환은 정보의 흐름상 모달 뷰 보다는 네비게이션 컨트롤러가 적절하니 네비게이션 컨트롤러를 통해 화면이 이어지도록 구성한다.

---
---

### 화면 2 - 회원가입 화면 (기본정보)

![image](https://user-images.githubusercontent.com/33051018/78525838-3a892680-7813-11ea-91e6-ab75d51d84d1.png)


- 화면구성
    - 상단 오른쪽에는 ID, PW, PW확인 필드가 존재하며 각각 적절한 `placeholder`가 적용된다.
    - 상단 왼쪽에는 이미지뷰가 있고, 그 아래에는 자기소개를 위한 텍스트뷰가 위치한다.
    - 텍스트뷰 하단에는 '취소' 버튼과 '다음' 버튼이 위치한다.

- 기능
    - 상단 왼쪽의 이미지뷰를 탭하면 `UIImagePickerController`를 띄운다.
    - 화면 중간의 텍스트 뷰에는 자기소개를 작성할 수 있다.
    - 하단에 '취소'버튼을 누르면 모든 정보가 지워지고 이전 화면으로 돌아간다.
    - 사용자가 텍스트 필드의 모든 정보를 기입한 상태가 아니라면 하단에 위치하는 '다음' 버튼이 비활성화 되고, 프로필 이미지와 아이디, 자기소개가 모두 채워지고 패스워드가 일치하면 '다음'버튼이 활성화된다.

이제 네비게이션 컨트롤러를 연결해준다.

상단바 [Editor] -> [Embed In] -> Navigation Controller 를 진행한다.

이후 뷰 컨트롤러 인스턴스를 하나 더 만든다.

이후 해당 뷰 컨트롤러를 제어하기 위한 클래스 `SecondViewController.swift` 파일을 만들고 클래스를 할당해준다.

다음, 우리는 `Sign Up` 버튼을 클릭하면 다음 페이지로 이동해야 하니 
`Sign Up` 버튼을 `ctrl` + drag 하여 다음 페이지로 연결한다.

![image](https://user-images.githubusercontent.com/33051018/78526623-8f2da100-7815-11ea-9d5c-0118c04f3e16.png)


![image](https://user-images.githubusercontent.com/33051018/78528861-5e506a80-781b-11ea-9c94-3c34e38bebe0.png)

위 그림과 같이 대략적인 레이아웃을 그려준 이후 각 컴포넌트에 대한 프로퍼티를 설정해준다.

이제 기능구현에 들어간다.

1. 상단 왼쪽에 이미지뷰를 탭하면 `UIImagePickerController` 를 띄운다.

조건에 '탭'하면 컨트롤러를 띄우라고 되어있다.
따라서, `Gesture Recognizer` 를 이용해야 할 것 같다.

`object Library` 에서 `Tap Gesture Recognizer` 를 가져와 `UIImageView` 위에 올려준다.

![image](https://user-images.githubusercontent.com/33051018/78533450-f2263480-7823-11ea-91f0-df1697fe3ae8.png)

(TapGesture 기능 구현하는데 삽질을 너무 많이 했다..)

2. 화면 왼쪽 하단의 '취소' 버튼을 누르면 모든 정보가 지워지고 이전 화면 1로 되돌아간다.

취소 버튼을 가지고 `@IBAction` 메소드를 만든다.

```swift

@IBAction func popToPrev() {
    self.navigationController?.popViewController(animated: true)

}
```
'취소' 버튼을 누르면 현재 네비게이션 뷰를 `pop` 하여 이전 뷰로 되돌아간다.

이떄, 취소를 누르기 전에 작성했던 모든 텍스트필드와 텍스트 뷰의 내용을 지워야하므로 해당 기능도 적용해준다.

컴포넌트 레퍼런스를 위한 `@IBoutlet` 변수를 만든다.

```swift
    @IBOutlet weak var textID: UITextField!
    @IBOutlet weak var textPw: UITextField!
    @IBOutlet weak var textPwCheck: UITextField!
    @IBOutlet weak var textView: UITextView!
```

이를 가져와서 아까 만든 `popToPrev()` 메소드에서 위 변수들의 `text` 프로퍼티를 수정하도록 한다.

다음으로 사용자가 모든 정보를 기입한 상태가 아니라면 화면 오른쪽 하단의 '다음' 버튼이 비활성화 되도록 만든다.

---
---