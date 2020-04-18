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

[5. 기능 구현](#5.-기능-구현)

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
        self.inputField.resignFirstResponder()
    }
```

위와같이 `tapBackground` 함수 내에 `TextField` 인스턴스의 메서드를  호출해주니 `Tap Gesture Recognizer`가 발생하면 키보드가 사라진다!

<br>
<br>

### 5. 기능 구현
---

임의의 난수를 생성하고 이를 사용자가 예측할 수 있도록 예측값에 따른 `up`, `down` 결과를 표시해주도록 한다.

```swift
//
//  ViewController.swift
//  UpDown
//
//  Created by Yeojaeng on 2020/04/13.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit

// ViewController 클래스의 인스턴스가 스토리보드에 올라가있는 그 View Controller다.

class ViewController: UIViewController {
    
    //MARK:- Properties
    //MARK:- IBOutlets
    
    @IBOutlet weak var resultLabel: UILabel!                        // resultLabel 인스턴스 연결
    @IBOutlet weak var turnCountLabel: UILabel!                     // turnCountLabel 인스턴스 연결
    @IBOutlet weak var inputField: UITextField!                     // inputField 인스턴스 연결
    
    //MARK:- Stored Proeprties
    var randomNumber: UInt32 = 0                                     // 32bit unsigned Int
    var turnCount: Int = 0
    
    //MARK:- Methods

    @IBAction func touchUpSubmitButton(_ sender: UIButton) {                // Submit 버튼 클릭시 실행할 Action 정의
        print("touchUpSubmitButton called")
    
        guard let inputText = self.inputField.text,                    // Optional Binding -> inputFied 공백여부 체크
            inputText.isEmpty == false else {
                print("입력값 없음")
                return
        }
        
        guard let inputNumber: UInt32 = UInt32(inputText) else {        //  Optional Binding -> UInt32 포맷여부 체크
            print("입력값 포맷 잘못 되었음")
            return
        }
        
        turnCount += 1                                                  // submit 버튼 클릭시 turnCount ++
        self.turnCountLabel.text = "\(turnCount)"                       // update tunrCountLabel.text
        
        if inputNumber > randomNumber {                                 // 입력값과 랜덤값의 대소 비교에 따른 출력
            self.resultLabel.text = "DOWN!"
        } else if inputNumber < randomNumber {
            self.resultLabel.text = "UP!"
        } else {
            self.resultLabel.text = "CORRECT!"
        }
    }
    
     
    @IBAction func touchUpResetButton(_ sender: UIButton) {             // Reset 버튼 클릭시 실행할 Action 함수 정의
        print("touchUpResetButton called")
        self.initializeGame()                                           // initializeGame() 함수 호출
    }
    
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {    // TapGesture 인식시 실행할 Action 함수 정의
        print("tapBackground called")
        self.inputField.resignFirstResponder()                          // 키보드 내리기
//      self.view.endEditing(true)
//      self.inputFIeld.endEditing(true)
    }
    
    //MARK:- Custom Methods
    
    func initializeGame() {                                             // initializeGame 함수 정의
        
        self.randomNumber = arc4random() % 25
        //arc4random() : 임의의 Unsinged Int type 반환, 그래서 변수 randomNumber의 타입을 UInt32 선언한것.
        
        self.turnCount = 0
        self.resultLabel.text = "Start!"
        self.turnCountLabel.text = "\(turnCount)"
        self.inputField.text = nil
        
        print("random number: \(self.randomNumber)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializeGame()                                           // initializeGame() 함수 호출
        
    }

}


```


**정리**

- **`@IBAction` 과 `@IBOutlet` 은 모든 iOS 애플리케이션에서 정말 빈번히 사용되니 꼭 익혀두기.**
    - **`@IB` 어노테이션을 통해 선언한 함수명 또는 변수명 변경시에는  `Editor` -> `Refactor` -> `Rename` 기능을 이용하도록 한다. (오류 방지)**

- **공식 개발자 문서를 참고하는 습관 기르기.**

 

