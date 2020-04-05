---

---

### 싱글턴 (Singleton)

---

→ iOS 애플리케이션 디자인 패턴 중 하나인 싱글턴 패턴과 싱글턴패턴 사용시 주의해야 할 점에 대하여 살펴본다.

**싱글턴은 '특정 클래스의 인스턴스가 오직 하나임을 보장하는 객체'를 의미한다.**

**싱글턴은 애플리케이션이 요청한 횟수와는 관계없이 이미 생성된 같은 인스턴스를 반환한다.** 

즉, 애플리케이션 내에서 특정 클래스의 인스턴스가 딱 하나만 있기 때문에 다른 인스턴스들이 공유해서 사용할 수 있다.

### Cocoa 프레임워크에서의 싱글턴 디자인 패턴

---

Cocoa 프레임워크에서 싱글턴 디자인 패턴을 활용하는 대표적인 클래스를 알아본다.

싱글턴 인스턴스를 반환하는 팩토리 메소드나 프로퍼티는 일반적으로 `shared` 라는 이름을 사용한다.

- FileManager
    - 애플리케이션 파일 시스템을 관리하는 클래스다.
    - FileManager.default

- URLSession
    - URL 세션을 관리하는 클래스다.
    - URLSession.shared

- NotificationCenter
    - 등록된 알림의 정보를 사용할 수 있게 해주는 클래스이다.
    - Notification.default

- UserDefaults
    - Key - Value 형태로 간단한 데이터를 저장하고 관리할 수 있는 인터페이스를 제공하는 데이터베이스 클래스다.
    - UserDefaults.standard

- UIApplication
    - iOS에서 실행되는 중앙제거 애플리케이션 객체이다.
    - UIApplication.shared

    ### 주의사항

    ---

    싱글턴  디자인 패턴은 애플리케이션 내 특정 클래스의 인스턴스가 하나만 존재하기 때문에 객체가 불필요하게 여러개 만들어질 필요가 없는 경우게 많이 사용한다.

    예를 들면 환경설정, 네트워크 연결처리, 데이터 관리 등등이 있다.

    하지만 멀티 스레드 환경에서 동시에 싱글턴 객체를 참조할 경우 원치 않은 결과를 가져올 수 있으니 어떤 디자인 패턴을 활용하더라도 긍정적인 면과 위험성을 고려하여 활용해야한다.

    싱글턴 : 특정 클래스의 인스턴스가 하나만 존재 -> 불필요한 객체가 여러개 만들어질 필요가 없는 경우 사용된다.

    shortcut

    object Library : Command + Shift + L
    Search : Command + Shift + O

    싱글턴은 특정 클래스의 인스턴스를 하나만 이용하여 여러 화면이나 여러 인스턴스끼리 데이터를 손쉽게 공유할 수 있다.

    ---

    ---

    ### StackView

    ---

    **UIStackView**

    **스택뷰는 여러 뷰들의 수평 또는 수직 방향의 선형적인 레이아웃의 인터페이스를 사용할 수 있도록 해준다.**

    스택뷰와 오토레이아웃 기능을 활용하여 디바이스의 방향과 화면크기에 따라 동적으로 적응할 수 있는 사용자 인터페이스를 만들 수 있다.

    스택뷰의 레이아웃은 스택뷰의 'axis', 'distrubution', 'alignment', 'spacing'과 같은 프로퍼티를 통해 조정한다.

    ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/663930c5-3de5-49e0-bad1-be94150dd0c8/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/663930c5-3de5-49e0-bad1-be94150dd0c8/Untitled.png)

Spacing : 스택 뷰 내의 인터페이스들 간 간격

---

---

### Target-Action 디자인 패턴

**Target-Action 디자인 패턴**

Target-Action 디자인 패턴은 iOS 환경에서 많이 사용하는 디자인 패턴 중 하나다.

**Target-Action 디자인 패턴에서 객체는 이벤트가 발생할 때 다른 객체에 메시지를 보내는 데 필요한 정보를 포함한다.**

액션은 특정 이벤트가 발생했을 때 호출할 메서드를 의미한다. 그리고 타겟은 액션이 호출될 객체를 의미한다.

이벤트 발생 시 전송된 메시지를 액션 메시지라고 하고, 타겟ㅇ느 프레임워크 객체를 포함한 모든 객체가 될 수 있으나, 보통 컨트롤러가 되는 경우가 일반적이다.

직접 타겟이 될 객체에 액션에 해당하는 메서드를 호출하면 될 텐데 굳이 Target 과 Action을 지정하고 이를 디자인 패턴으로 활용하는 이유는 아래와 같다.

만일, 특저어 이벤트가 발생했을때 `abc` 라는 이름의 메서드를 호출해야 하는 상황이라고 해보자.

그런데 이 abc라는 (액션)메서드는 A라는 클래스에도 정의되어 있고, B라는 클래스에도 정의되어 있는 경우가 있다.

**이렇게 같은 메서드가 여러 클래스에 정의되어 있는 경우도 있고, 그런 클래스의 인스턴스가 여러개인 상황도 있다. 이런 여러가지 상황에서 우리가 원하는 객체를 Target으로 지정하면 `abc` 라는 액션을 실행할 객체를 상황에 따라서 선택할 수 있다.**

### Target-Action 디자인 패턴 실습

---

스토리보드에 Object Library에서 datePicker와 dateLabel을 가져와 구성한다.

    //
    //  ViewController.swift
    //  MyDatePicker
    //
    //  Created by Yeojaeng on 2020/04/05.
    //  Copyright © 2020 Yeojaeng. All rights reserved.
    //
    
    import UIKit
    
    class ViewController: UIViewController {
        
        @IBOutlet weak var datePicker: UIDatePicker!
        @IBOutlet weak var dateLabel: UILabel!
        let dateFormatter: DateFormatter = {   // dateFormatter 인스턴스 생성
            let formatter: DateFormatter = DateFormatter()
            
    //       var dateStyle: DateFormatter.Style -> date style of the receiver
            formatter.dateStyle = .medium
    //       var timeStyle: DateFormatter.Style -> time style of the receiver
    //       formatter.timeStyle = DateFormatter.Style.none
            formatter.timeStyle = .short
            
            return formatter
        } ()
        
        
        @IBAction func DidDatePickerValueChanged(_ sender: UIDatePicker) {
            print("DatePicker Value changed")
            
    //      sender는 이 메소드를 호출한 친구 -> 여기서는 UIDatePicker가 되는것
    //      let date: Date = sender.date -> 아래랑 같음
            let date: Date = self.datePicker.date
            let dateString: String = self.dateFormatter.string(from: date)
    
    //      datePicer에서 변경된 값을 아래 레이블에 출력
            self.dateLabel.text = dateString
            
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
        }
    
    
    }

이번 예제 코드를 보기전에 아래 공식 문서를 한번 살펴보면 더욱 좋다.

[DateFormatter] ([https://developer.apple.com/documentation/foundation/dateformatter](https://developer.apple.com/documentation/foundation/dateformatter))

`@IBOutlet` 을 통해 레퍼런스를 위한 컴포넌트를 변수에 등록해준다.

`@IBAction` 을 통해 특정 이벤트에 따른 액션 메소드를 정의해준다.

`Received Action` 속성을 `value chagned`로 감지하여 액션을 제어한다.

DatePicker는 사용자가 선택된 날짜를 바꿀 경우 애플리케이션에 이를 알리기 위해 `Target-Action Design Pattern` 을 이용한다.

DatePicker의 값이 변경될 때 알림을 받기 위해 액션 메서드를 `value changed` 로 설정하고 실행 시점에 DatePicker는 사용자의 날짜 및 시간을 선택하게 되면 설정된 액션 메서드를 호출한다. 

DatePicker를 액션 메서드에 연결하기 위해서는 인터페이스 빌더를 이용하거나 코드를 통해 `addTarget(_:action:for:)` 메소드를 이용한다.

### UIDatePicker & DateFormatter

---

### UIDatePicker

---

DatePicker는 날짜 및 시간을 입력하는 컨트롤러이다. DatePicker를 이용하여 특저어 시저머의 날짜와 시간 또는 시간 간격을 입력할 수 있다.

---

개발시 어떠한 메소드, 어떠한 프로퍼티를 이용해야 할 지 모르겠을때는 공식 문서를 참고한다.

`UIDatePicker` 클래스 공식문서에는 주요 프로퍼티와 주요 메소드에에 대한 상세 설명이 나와있다.

var datePickerMode: UIDatePickerMode →  date picker의 모드를 결정한다.

var date: Date → date picker에 보여지게 될 날짜를 의미한다.

var calender: Calender!: date picker에 사용되는 캘린더

var locale: Locale? → date picker에서 사용하는 로케일

func setDate(Date, animated: Bool) → date picker에 처음 표시할 날짜를 설정한다.

등등등... 아주 친절하게 모두 알려준다.

공식 문서의 중요성을 크게 느끼고 있다.

### DateFormatter

---

**DateFormatter는 날짜와 텍스트 표현 간의 변환을 할 수 있도록 도와준다.**

DateFormatter를 활용해 날짜와 시간을 다양한 방식으로 출력하거나 출력된 날짜 및 시간에 대한 문자열을 읽어올 수 있다.

DateFormatter의 인스턴스는 `Date` 객체의 문자열 표현을 생성하고, 날짜 및 시간의 텍스트 표현을 `Date` 객체로 변환한다.

**사용자 날짜 및 시간 표현**

사용자에게 날짜를 표시할 때 특정 요구사항에 따라 위 에시 코드처럼`date formatter` 의 `dateStyle` 과 `timeStyle` 프로퍼티를 설정한다.

**고정 형식 날짜 표현**

RFC3399등과 같은 고정 형식의 날짜로 사용해야 한다면, `dateFormat` 프로퍼티를 특정 포맷 문자열로 설정한다.

대부분의 고정 형식은 `locale` 프로퍼티를 `POSIX lcale("en_US_POSIX")` 로 설정하고 `timeZone` 프로퍼티를 `UTC`로 설정한다.

**DateFormatter의 주요 프로퍼티 & 메소드**

- func date(from : String) → 주어진 문자열을 Date 객체(날짜와 시간 형태)로 변환하여 반환한다.
- func string(from: Date) → 전달받은 Date 객체를 문자열로 변환하여 반환한다.
- var dateStyle : DateFormatter.Style: DateFormatter의 날짜 형식지정
- var timeStyle: DateFormatter.Style: DateFormatter의 시간 형식지정
-
