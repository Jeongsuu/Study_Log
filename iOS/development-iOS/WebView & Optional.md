---

---

[(6) swift 강좌 : xcode11을 통한 swiftUI, 샘플프로젝트 리뷰 - [센치한개발자]](https://www.youtube.com/watch?v=0WkoGUL8JBQ&list=PLva6rQOdsvQWlAzZJYhx1a0Y5Stu88cZK&index=6)

[Apple Developer Documentation](https://developer.apple.com/tutorials/swiftui)

**IOS App Develope Official Doc**

기존에 `xml`을 이용해 UI를 그리거나 하던 방식

swift도 UI를 편하게 만들라고 `SwiftUI` 가 따로 나왔음. (기존 : UIKit)

`SwiftUI`는 소스가 매우 직관적이라 UI와 일대일 매칭되는 것이 장점임.

Vstack : Vertical Stack → 세로로 쌓겠다.

Hstack : Horizontal Stack → 가로로 쌓겠다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8b02152f-f2a5-4688-9465-7518c2b81d28/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8b02152f-f2a5-4688-9465-7518c2b81d28/Untitled.png)

---

---

### 웹뷰(WKWebView), 옵셔널 바인딩(Optional Binding)

[(7) swift 강좌 : 웹뷰(WKWebView), 옵셔널 바인딩(optional binding) - [센치한개발자]](https://www.youtube.com/watch?v=euCHaq49a-Y)

본 실습은 프로젝트 생성시 `User Interface` 를 `SwiftUI` 가 아닌 `Stroyboard` 방식으로 진행함.

`Main.storyboard`  를 열고 `ViewController`에 매칭된 클래스를 확인한다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2ef6e563-1276-404c-a59b-295fc5acf204/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2ef6e563-1276-404c-a59b-295fc5acf204/Untitled.png)

즉, 뷰 컨트롤러 씬과 클래스 연결을 확인한다.

컴포넌트를 추가할수 있는 라이브러리를 클릭하여 `WebKit View`를 드래그 앤 드랍.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9fc888b1-4bcd-4caf-a929-9937f5de78f0/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9fc888b1-4bcd-4caf-a929-9937f5de78f0/Untitled.png)

웹뷰를 화면에 배치 → 제약조건(Constraints) 설정 하단바에서 위 그림 중 두번째클릭 해서 제약조건을 상하좌우 다 걸어준다.

**이후 코딩의 편의를 위해 `Assistant` 기능 활성화**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fd3dedc8-1bc7-4f90-a3fb-398a833c05fc/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fd3dedc8-1bc7-4f90-a3fb-398a833c05fc/Untitled.png)

이후 웹뷰를 클릭하여 활성화 해놓고 클래스랑 매칭 → 컨트롤 누르고 드래그

웹 뷰를 컨트롤러에 출력해주는 방법은 매우 간단한다.

 1. 불러오고자 할 url을 string-type 으로 저장한다.
2. 해당 string값을 `URL` 메서드를 통해 url-type 으로 변환한다.
3. `urlRequest` 메서드를 통해 요청 값을 만든다.
4. `WebViewmain` 라이브러리의 메소드 `load` 를 이용해서 해당 url을 요청한다.

    //  ViewController.swift
    //  SampleWebView
    //
    //  Created by Yeojaeng on 2020/03/26.
    //  Copyright © 2020 Yeojaeng. All rights reserved.
    //
    
    import UIKit
    import WebKit
    
    class ViewController: UIViewController {
        @IBOutlet weak var WebViewMain: WKWebView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            //1. 불러오고자 할 url string 을 찾는다.
            //2. url 주소를 URLrequest로 만든다.
            //3. Request를 웹 뷰에 뿌려준다.
            
            let urlString = "https://www.google.com"        // 띄울 url을 string type 으로 가져오기
            if let url = URL(string: urlString)  {          // string Type의 urlString을 URL type으로 변환
    						// URL Type으로 변환 중 에러발생 ->  if { } 를 통해서 unwrap 진행. -> Optional Binding
                let urlReq = URLRequest(url: url)
                WebViewMain.load(urlReq)
            }
            
    				// NullPointerException 을 방지하기 위한것이 unwrap -> NULL값에 안전함
            
            
        }
    
    
    }

`unwrap`

변수 종류가 

var abc = "1" → 얘는 값이 변할수 있음

var abc1 :String? = nil     → 자바에서 NULL값, `?` 에 의미는 값이 비어있을수 있다는 의미.
abc1! 방식으로 치면 그냥 안에 값이 무조건 들어있으니까 그냥 믿고 unwrap 해줘! 라는 의미.

→ let aaa = abc1!

let abc2 = "1"

---

`let VS var`

let 은 상수이며 var는 변수이다.

let 으로 지정한 값은 불변 , var로 정의한 값은 변경이 가능하다.

let 을 많이 사용하고 var를 줄이는 것이 좋은 코딩방법

- let : 선언시 처음 입력된 데이터만 저장하게 된다.
- var : 선언시 처음 입력된 데이터 이후 추가로 입력이 가능하며 마지막에 입력된 데이터를 저장한다.

---

### *Optional 기본 개념*

[Swift Optional (1)](https://medium.com/@codenamehong/swift-optional-1-54ae4d37ee09)

Swift는 안전한 코딩을 할 수 있게 해주는 언어라고 알려져 있다.

이 안정성의 기본 바탕에 있는 중요한 요소 중 하나는 `Optional` 이라는 개념이다.

`Optional` 은 `Type Casting` 이나 `nil value` 체크 등에 있어서 중요한 역할을 한다.

`Optional`  은 '?' 을 통해 표현되는데, 그 의미는 아래와 같다.

> ***이 변수에는 값이 들어갈 수도 있고, 아닐 수도 있어 (nil == null)***

즉, `nil` 을  표현하기 위한 수단으로 "?" 를 사용한다는 것이다. 이것이 어떻게 적용되는지 알아보자.

    let myFirstOptionalVar: Int?

위처럼 변수와 타입 뒤에 `?` 를 붙여주면 해당 변수는 `Optional` 이 된다.

`Swift` 에서는 기본적으로 변수 선언시 nil 값이 들어가는 것을 허용하지 않는다.

그러므로 아래 첫번째 줄 코드는 에러이고, 두번째 줄 코드는 Optional type(String ?)으로 선언 했으므로 에러가 아니다.

    var optionalString: String = nil
    var optionalString: String? = nil

### ***nil***

`Swift` 에서 `nil`은 `optional` 변수 이외에 사용이 불가하다.

그러나 iOS 개발을 할 경우에는 상당히 많은 부분에서 `nil` 을 사용하게 된다.

그러므로 `optional` 에 대하여 잘 알아두어야 한다. 

**또한 nil 값은 따로 초기화를 진행하지 않아도 기본으로 설정된다.**

    var optionalString: String?
    var optionalString2: String? = nil

위 두 변수 모두 `nil` 값을 갖는다.

### *Wrapping*

---

`Optional` 에 대하여 보다보면, 많은 곳에서 `Wrapping` 이라는 개념이 나온다.

`Optional` 타입은 기본적으로 `wrap` 이 되어있는 상태다.

**즉, `Optional`로 선언된 변수들은 값이 있는 것인지, `nil` 인 것인지 `wrap` 되어 있어서 모르는 상태다.**

그렇기 때문에 컴파일러 입장에서는 변수가 `nil` 일 수도 있기 때문에 `wrap` 된 상태에서는 설렁 변수에 값이 들어가 있다 하더라도 바로 값을 출력하지 않는다.

아래 예제를 통해 이해를 돕자.

    var optionalString: String? = "Hello"
    print(optionalString)
    // output : Optional("Hello")

이 경우, `optionalString` 이 `nil` 일 수도 있기 때문에, 결과값 `Hello` 가 출력되지 않고 `Optional("Hello")`가 출력된다.

### *Forced Unwrapping*

---

앞선 예제처럼 출력 결과가 `Optional("Hello")` 처럼 나오는 것은 우리가 원하는 결과값이 아니다.

이 떄, 올바른 출력을 위해서 사용하는것이 "**!**" 즉 느낌표다.

`optional` 로 선언했으나, 무조건 변수가 있는 상황으로 보장되는 경우 "**!**" 를 쓰면 우리가 원하는 변수 내 값을 출력할 수 있다.

    var optionalString: String? = "Hello"
    print(optionalString!)
    // output : Hello

변수명 뒤에 느낌표는 `Optional`을 `unwrap` 한다.

`Optional` 은 `unwrap` 된 상태에서만 값을 제대로 출력할 수 있다.

만일 값이 있는지 보장이 안되는 상태에서 해당 변수를 이용하고 싶을때는 `if` 문을 통해 값이 `nil` 인 경우를 검증하고 이용한다.

    let value: String! = nil
    if value != nil {
    	print(value)
    }