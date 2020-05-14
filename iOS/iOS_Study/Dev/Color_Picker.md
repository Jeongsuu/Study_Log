# Color Picker
---

<br>
<br>

## Outline
---

![image](https://user-images.githubusercontent.com/33051018/79637647-28689a00-81bc-11ea-96a5-67b31aabc8e6.png)

1. 프로젝트명
    -   _Color Picker_

2. 공부할 내용
    -   _View - tag_
    -   _UIControlEvents_
    -   _UIStackView_
    -   _Delegation Programming Design Pattern_



# INDEX

[1. 인터페이스 구성](#인터페이스-구성)<br>
[2. IBOutlet & IBAction 연결](#IBOutlet-&-IBAction-연결)<br>
[3. 기능 구현](#기능-구현)
-   [구조체와 클래스](#구조체와-클래스)
-   [typealias](#typealias)<br>

[4. 소스 코드](#소스-코드)<br>

<br>
<br>

### 인터페이스 구성
---

![image](https://user-images.githubusercontent.com/33051018/79637899-82b62a80-81bd-11ea-9d82-e54bd6c4e01e.png)

<br>

![image](https://user-images.githubusercontent.com/33051018/79637904-8c3f9280-81bd-11ea-8dfc-ec31e9bba1e9.png)

인터페이스 구성은 위와 같다.

scene 상단에 `view` 인스턴스를 추가해준뒤

`slider` 4개를 `stack View`로 묶어준다.

-   stackView -> Alignment: Fill , Spacing: 10

-   slider -> tint: red, maximum:255 , value: 255, Tag: 100
-   slider -> tint: green, maximum:255, value: 255, Tag: 101
-   slider -> tint: blue, maximum:255, value: 255, Tag:102
-   slider -> tint: black, maximum:1, value:1, Tag:103

이후 `Picker` 를 배치한다.

<br>
<br>

### IBOutlet & IBAction 연결
---

![image](https://user-images.githubusercontent.com/33051018/79638064-91e9a800-81be-11ea-966b-86e2fa64af1a.png)

위 그림과 같이 연결을 진행한다.

`View`와 `PickerView`를 `@IBOutlet`으로 연결해주고

슬라이더 값 변경에 따른 기능 제어를 위해 `sliderValueChanged` 이벤트로 `@IBAction` 함수를 만들어준다.

이후, `PickerView`의 프로토콜 `dataSource`와 `delegate`를 `ViewController`로 연결해준다.

### 기능 구현
---

기능 구현에 앞서 필요한 내용들을 먼저 공부하고 진행하도록 한다.

#### 구조체와 클래스

**구조체와 클래스란?**

-   구조체와 클래스는 OOP(Object Oriented Programming)를 위한 필수요소로 프로그램의 코드를 추상화하기 위해 사용한다.

-   Swift에서는 다른 프로그래밍 언어와는 달리 구조체와 클래스를 위한 별도 인터페이스와 파일을 만들 필요가 없다.

**구조체와 클래스의 공통점**
-   여러 변수를 담을 수 있는 컨테이너
-   데이터를 용도에 맞게 묶어 표현하고자 할 때 용이
-   __프로퍼티와 메서드를 사용하여 구조화된 데이터와 기능을 가진다.__
-   **하나의 새로운 사용자 정의 데이터 타입을 만들어 주는 것.**
-   확장 사용이 가능하다.
-   프로토콜 사용이 가능하다.
-   `.` 연산자를 통해 하위 프로퍼티에 접근이 가능하다.

**기본 형태**

```swift

struct 구조체 이름 {
    프로퍼티 및 메서드
}

class 클래스 이름 {
    프로퍼티 및 메서드
}

```

**인스턴스 생성 방법**
```swift
let structureInstance = 구조체()
let classInstance = 클래스()
```

**구조체와 클래스의 차이점**
-   **구조체는 값 타입, 클래스는 참조 타입**
-   **구조체는 상속이 불가능하다.**
-   타입캐스팅은 클래스의 인스턴스에만 허용된다. 

참조 타입이란, 값 타입과 달리 복사되는 것이 아닌 **메모리를 참조**한다.

```swift

let referenceExample = ReferenceClass()
referenceExample.number = 27

let result = referenceExample
result.number = 32

print(referenceExample.number)      // 32
```

-   result 상수가 referenceExample **인스턴스를 복사한 것이 아닌 참조한 것!**
-   result는 referenceExample 이 가리키고 있는 메모리 주소를 가리키고 있다.

-   상수로 선언하였어도 값이 바뀌는 이유는 result 자체를 변경하는 것이 아닌 result가 포인팅하고 있는 값을 변경하는 것이기 때문에 가능하다.

**구조체 사용이 유리한 경우**

애플은 다음 조건 중 하나 이상에 해당한다면 구조체를 사용하는 것을 권장한다.

>1. 연관된 간단한 값의 집합을 캡슐화 하는 것만이 목적일 때
>
>2. 캡슐화한 값을 참조하는 것 보다 복사하는 것이 합당할 때
>
>3. 구조체에 저장된 프로퍼티가 값 타임이며, 참조하는 것 보다 복사하는 것이 합당할 때
>
>4. 다른 타입으로부터 상속받거나 자신을 상속할 필요가 없을 때 

#### typealias

`typealias`란, 기존에 선언되어 있는 자료형에 새로운 자료형 별칭을 사용함으로써 코드를 더 읽기 쉽도록, 이해하기 쉽도록 명확하게 만드는 문법이다.

`Swift` 에서는 `typealias`를 크게 3가지 유형으로 나누어 사용한다.

1. 내장 유형 -> String, Int, Float ...etc
2. 사용자 정의 유형 -> class, struct, enum ...etc
3. 복합 유형 -> closure

각각 유형의 예시들을 살펴보도록 한다.

**내장 유형에 대한 예시**

```swift
typealias Name = String
```

간단한 예시로 `String` 타입을 `Name`이라는 별칭으로 사용하겠다는 의미이다.

```swift
let name: Name = "홍길동"

let name: String = "홍길동"
```

위 상수 선언은 두 방법 모두 같은 효과를 지닌다.

결론적으로 모두 `String` 타입이지만 특별한 분류가 필요하거나 구분지어 사용하고 싶을때는 `typealias`를 사용하여 이 변수는 `Name` 이라는 유형의 `String`이다.

라는 방식으로 사용이 가능하다.

**사용자 정의 유형에 대한 예시**

```swift

class Student {

}

typealias Students = [Student]

var student: Students = []
```

학생에 대한 클래스 `Student`를 구현하고 이를 `typealias`를 통해 `Students`라는 `Student` 배열로 선언한다.

이후 `students`라는 변수를 `Students` 타입으로 초기화한다.



**복합적인 유형에 대한 예시**
`Closure`를 입력 매개 변수로 사용하는 함수의 경우, `typealias`를 사용하여 보다 깔끔하게 사용할 수 있다.

```swift

func test(completionHandler: (Void) -> (Void) ) {

}

typealias voidHandler = (Void) -> (void)

func test(completionHandler: voidHandler) {

}
```

test라는 함수에 completionHandler라는 Closure를 사용했을 떄, 
`voidHandler` 라는 `typealias`를 선언한뒤에 위와 같이 매개변수를 voidHandler로 깔끔하게 사용이 가능하다.

<br> <br>

### 소스 코드
---
```swift
//
//  ViewController.swift
//  ColorPicker
//
//  Created by Yeojaeng on 2020/04/22.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Private Types
    
    private struct ColorComponent {                         // ColorComponent 구조체 정의
        
        typealias SliderTag = Int                           // SliderTag 자료형 = Int 자료형
        typealias Component = Int                           // Component 자료형 = Int 자료형
    
    //MARK: define Member property & Method
        
        // static 선언시 객체 생성시 동적으로 메모리에 적재하는게 아니라, 실행과 동시에 메모리에 static 변수 및 함수들을 적재하기 때문에 객체 생성 없이 접근이 가능하다.
        
        static let count: Int = 4                           // static으로 타입 프로퍼티 정의 , 객체 생성 없이 ColorComponent.count로 바로 접근 가능
        
        //rgba , alpha = 투명도를 나타낸다.
        static let red: Int = 0                             // ViewTag = 100
        static let green: Int = 1                           // ViewTag = 101
        static let blue: Int = 2                            // ViewTag = 102
        static let alpha: Int = 3                           // ViewTag = 103
        
        // viewWithTag() 메소드 사용을 위해 tag값을 설정하는 메소드
        // 함수명 (Tag)의 의미가 직관적이지 못해서 ComponentToTag 로 네이밍
//      static func Tag(`for`: Component) -> Int{
        static func ComponentToTag(`for`: Component) -> Int {          // 예약어 for를 매개변수로 사용하기 위해 backtick(`) 으로 감싸준다.
            return `for` + 100                              // tag 함수: 매개변수로 Component(Int) 타입의 자료형 `for`를 받아서 for + 100 값을 반환한다. -> 인스턴스의 tag 프로퍼티에 접근하기 위해 진행하는것이다.
        }
        
        //위와 같은 이유로 함수명 변경      Component -> TagToComponent
        static func TagToComponent(from: SliderTag) -> Component {       // 매개변수로 SliderTag(Int) 타입의 자료형 `from`을 받아서 from - 100값을 Component 자료형으로 반환한다.
            return from - 100                                       // 인자로 받는 SliderTag와 반환하는 Component 모두 Int형 자료형이니 호환 문제 X
        }
        
    }
    
    // 구조체 프로퍼티들을 static으로 타입 프로퍼티로 정의, 객체 생성 없이 ViewTag.sliderRed로 바로 접근 가능
    private struct ViewTag {                                // ViewTag 프로퍼티들만 멤버로 갖는 구조체 정의
        static let sliderRed: Int = 100                     // ViewTag.sliderRed = 100
        static let sliderGreen: Int = 101                   // ViewTag.sliderGreen = 101
        static let sliderBlue: Int = 102                    // ViewTag.slideBlue = 102
        static let sliderAlpha: Int = 103                   // ViewTag.sliderAlpha = 103
    }
    
    //MARK:- Properties
    //MARK: IBoutlets
    
    // 인터페이스 빌더에 추가한 인스턴스와 연결
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK: Privates
    // 접근지정자 private 선언 -> 해당 프로퍼티는 선언된 파일 내에서만 접근 가능 -> 은닉화
    private let rgbStep: Float = 255.0
    private let numberOfRGBStep: Int = 256
    private let numberOfAlphaStep: Int = 11
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {         // sliderValueChange 이벤트가 감지되면 실행할 이벤트
        
        // ViewTag.sliderRed ~ ViewTag.sliderAlpha 까지 순회하며 UISlider.tag 값이 존재하는지 검증
        // 아래 guard문은 잉여코드라고 생각함
        guard (ViewTag.sliderRed...ViewTag.sliderAlpha).contains(sender.tag) else {                 // contains() : 문자열 또는 배열에 인자로 전달받은 값이 존재하는지 확인하는 함수,
            print("Wrong slider Tag")
            return
        }
        
        let component: Int = ColorComponent.TagToComponent(from: sender.tag)
        let row: Int
        
        if component == ColorComponent.alpha {                      // component가 alpha인 경우 -> alpha 슬라이더 값이 변경된 경우
            row = Int(sender.value * 10)                            // row = alphaSlider.value * 10
            
        } else {
            row = Int(sender.value)                                 // 그 외 컴포넌트는 그냥 row = value
        }
        
        self.pickerView.selectRow(row, inComponent: component, animated: false)
        
        self.matchViewColorWithCurrentValue()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // pickerView 값 255로 셋팅
        // 이게 왜 pickerView값을 255로 설정하는지 모르겠음.
        for i in 0..<self.pickerView.numberOfComponents {                                                   // 컴포넌트 순회
            let numberOfRows: Int = self.pickerView.numberOfRows(inComponent: i)                            // 특정 컴포넌트의 행 값 가져오기
            self.pickerView.selectRow(numberOfRows - 1, inComponent: i, animated: false)
        }
        
    }
    
    //MARK: Privates
    // viewWithTag 메소드로 Tag값을 key로 매칭해서 Slider로 초기화
    private func matchViewColorWithCurrentValue() {
        guard let redSlider: UISlider = self.view.viewWithTag(ViewTag.sliderRed) as? UISlider,                      // as? 키워드를 통해 viewWithTag를 UISlider로 조건부 다운 캐스팅
            let greenSlider: UISlider = self.view.viewWithTag(ViewTag.sliderGreen) as? UISlider,
            let blueSlider: UISlider = self.view.viewWithTag(ViewTag.sliderBlue) as? UISlider,
            let alphaSlider: UISlider = self.view.viewWithTag(ViewTag.sliderAlpha) as? UISlider else {
                return
        }
        
        // UIColor의 Red, Green, Blue, Alpha 값은 0과 1사이의 실수 값
        // CGFloat는 32bit에서 float, 64비트에서 double 인 자료형
        let red: CGFloat = CGFloat(redSlider.value / self.rgbStep)
        let green: CGFloat = CGFloat(greenSlider.value / self.rgbStep)
        let blue: CGFloat = CGFloat(blueSlider.value / self.rgbStep)
        let alpha: CGFloat = CGFloat(alphaSlider.value)
        
        // 전달받은 컴포넌트(red, green, blue, alpha)를 통해 color값을 만든다.
        // 모든 인자의 자료형은 CGFlat으로 받기 때문에 위에서 Type Casting을 진행한것임.
        let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        // 위에서 컴포넌트들을 통해 만들어낸 색상을 colorView의 배경값으로 설정한다.
        self.colorView.backgroundColor = color
    }

}



// UIPickerViewDelegate, UIPikerViewDataSource 프로토콜 채택
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 두 프로토콜의 required 메소드 구현
    
    //MARK:- UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ColorComponent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == ColorComponent.alpha {
            return self.numberOfAlphaStep
        } else {
            return self.numberOfRGBStep
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == ColorComponent.alpha {
            return String(format: "%1.1lf", Double(row) * 0.1)
        } else {
            return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        let sliderTag: Int = ColorComponent.ComponentToTag(for: component)
               
        guard let slider: UISlider = self.view.viewWithTag(sliderTag) as? UISlider else {
            return
        }
               
        if component == ColorComponent.alpha {
            slider.setValue(Float(row) / 10.0, animated: false)
        } else {
            slider.setValue(Float(row), animated: false)
        }
        
        self.matchViewColorWithCurrentValue()
        
    }
    
}

