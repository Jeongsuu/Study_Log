# Up Down Game
---

<br>
<br>

## README
---

1. 프로젝트명
    - _업-다운 게임_

2. 공부할 내용
    - _IBOutlet_
    - _IBAction_
    - _Gesture Recognizer_

<br>
<br>

## **INDEX**

[1. 인터페이스 구성](#1.-인터페이스-구성)

[2. IBOutlet](#2.-iboutlet)

- [2.1. 클래스, 인스턴스, 객체](#2.1.-클래스,-인스턴스,-객체)

[3. IBAction](#3.-IBAction)

[4. Gesture Recognizer](#4.-Gesture-Recognizer)

---

### 1. 인터페이스 구성

![image](https://user-images.githubusercontent.com/33051018/79130716-680d3b80-7de2-11ea-935e-513232fc28dd.png)

좌측과 우측의 상단에 `Label`을 두개 배치한다.

이후 아래에 `Text Field` 를 배치하고 그 아래에 버튼 두개를 배치한다.

각각의 컴포넌트들 끼리 상관관계를 갖도록 제약을 걸어준다.

이후 뷰 컨트롤러 위에 `Tap Gesture Controller`를 올려준다.

<br>
<br>

### 2. IBOutlet
---

#### 2.1. 클래스, 인스턴스, 객체

**클래스란**
-   객체를 만들어내기 위한 틀
-   연관되어 있는 변수와 메서드의 집합

**객체란**
-   클래스에 선언된 모양 그대로 생성된 실체
-   클래스의 인스턴스 라고도 부른다.
-   객체는 모든 인스턴스를 대표하는 포괄적 의미를 갖는다.

**인스턴스란**
-   소프트웨어로 구현된 구체적 실체
-   즉, 객체를 소프트웨어에 실체화하면 그것을 '인스턴스'라고 부른다.
-   인스턴스는 객체에 포함된다고 볼 수 있다.

객체는 소프트웨어 세계의 <u>구현 대상</u>이며, 이를 구현하기 위한 <u>설계도</u>가 클래스다.

이 설계도에 따라 <u>구현된 실체</u>가 인스턴스다.

---
<br>

인터페이스 빌더에 올려놓은 객체들을 소스코드에서 참조할 수 있도록 편한 방법으로  `@IBOutlet` 연결을 해준다.

**cf) 꿀팁 : 파일을 열 떄, option키를 누르고 파일명을 리턴하면 어시스턴트 에디터에서 해당 파일이 열린다.**

<br>
<br>

### 3. IBAction
---

`submit` 버튼에 `Touch Up Inside` 이벤트 발생시 Action할 함수를 만든다.

```swift
 @IBAction func touchUpSubmitButton(_ sender: UIButton) {
        print("touchUpSubmitButton called")
    }
```

위와 같이 임시로 로그를 찍는 코드를 작성하고 잘 작동하는지 확인한다.

이와 같이 reset 버튼도 `@IBAction` 함수를 만들어 준다.

 ![image](https://user-images.githubusercontent.com/33051018/79134396-9d1c8c80-7de8-11ea-83ed-e7890381711f.png)

<br>
각각의 버튼을 클릭할 때 마다 로그가 정상적으로 출력되는 것을 확인할 수 있다.

<br>
<br>


### 4. Gesture Recognizer
---

뷰 컨트롤러위에 올려놓은 `Tap Gesture Recognizer`를 이용해 Action을 설정한다.

```swift
 @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
    }
```

액션을 발생시킬 객체는 당연히 `UITapGestureRecognizer`이다.

우리는 해당 액션이 발생하면 텍스트 필드 터치시 활성화 되는 키보드를 다시 비활성화 시킬것이다.

이를 위해 [`TextField` 공식 문서](https://developer.apple.com/documentation/uikit/uitextfield)를 살펴보자.


내용을 살펴보다 보면 **Showing and Hiding the Keyboard** 라는 소제목을 확인할 수 있다.

![image](https://user-images.githubusercontent.com/33051018/79139178-cb05cf00-7df0-11ea-9acb-fe99dc935b90.png)

내용을 살펴보자!

사용자가 텍스트 필드를 터치하면 텍스트 필드는 자동으로 `first responder`가 된다고 한다. 이를 통해 시스템은 키보드를 올려준다.

이후, `resignFirstResponse()` 메서드를 통해 키보드를 `dismiss` 할 수 있다고 한다.

우리가 찾던 기능을 수행해 줄 메서드가 이것이다.

```swift
@IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        print("tapBackground called")
        inputField.resignFirstResponder()
    }
```

위와같이 `tapBackground` 함수 내에 `TextField` 인스턴스의 메서드를  호출해주니 `Tap Gesture Recognizer`가 발생하면 키보드가 사라진다!



