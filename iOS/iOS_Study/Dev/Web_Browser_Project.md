## iOS 프로그래밍

---

<br>

## README

1. 프로젝트명
    - _Web Browser Project_

2. 기능
    - _웹 뷰를 이용해 웹 페이지 보여주기_
    - _뒤로가기, 앞으로 가기, 새로고침 기능_
    - _마지막 페이지 저장_
    - _재실행시 로드_

#### **INDEX**

1. [UI 구성](#1.UI_구성)
2. [기능 구현](#2.기능_구현)
    - [UserDefaults](#1.UserDefaults)
    - [WKWebView](#2.WKWebView)


<br> 

---
---

### 1.UI 구성
---

이번 프로젝트가 제공하는 기능은 웹 뷰와 이에 관한 부가적 기능이다.

따라서, 인터페이스에는 `View Controller`에 웹 뷰를 얹고 각각의 부가적 기능들을 실행할 수 있는 버튼들을 구성하도록 한다.

<br>


프로젝트 생성 후 프로젝트 네비게이션 영역에서 `Storyboard` 로 이동한다.

생성되어 있는 뷰 컨트롤러의 인스턴스를 클릭하여 `상단바 -> Editor -> Embed In -> Navigation Controller` 를 눌러 아래와 같이네비게이션 컨트롤러를 만들어준다.

![image](https://user-images.githubusercontent.com/33051018/79063806-e385c480-7cde-11ea-88f0-8dfb9df88e08.png)


이후 네비게이션 컨트롤러 인스턴스를 클릭하여 `Attribute Inspector` 에서 `Shows Toolbar` 를 활성화한다.

![image](https://user-images.githubusercontent.com/33051018/79063907-b38af100-7cdf-11ea-9592-fdb4381d9c0e.png)

`Toolbar` 를 활성화하면 우리가 사용하는 앱에서 볼 수 있었던 바가 하단에 생긴다!

이제 이 화면에 `WebView`를 얹어줄 것이다.

`Object Library`에서 `WebView`를 가져와서 `View Controller`에 얹어준다.

이후 `Auto Layout` 기능을 활용해 `Scene` 전체를 웹 뷰로 보기 위해 아래와 같이 제약조건을 걸어준다.

![image](https://user-images.githubusercontent.com/33051018/79063881-76266380-7cdf-11ea-9f33-1967bc613959.png)


이후 화면 하단에 `Bar Button Item`을 총 3개 추가하고 `Flexible Space`를 적절히 사용해 공간을 확보한다.

![image](https://user-images.githubusercontent.com/33051018/79063975-17151e80-7ce0-11ea-8a45-dc75d605fdec.png)

이후 각각의 `Bar Button`에 `Attribute Inspector` 내 `System item` 을 변경하여 아이콘 모양을 변경해준다.

다음으로 `Activity Indicator View` 를 뷰 컨트롤러 위에 얹어준다.

![image](https://user-images.githubusercontent.com/33051018/79064059-8be85880-7ce0-11ea-97c6-3bce7b19b202.png)

이제 인터페이스 구성이 끝났다.

<br>
<br>

### 2.기능 구현
---

기능을 구현하기에 앞서 필요한 내용들을 먼저 살펴보고 이해하도록 한다.

#### 1.UserDefaults

공식 문서([UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)) 를 살펴보자.

`UserDefaults` 클래스는 앱 실행시 사용자의 기본 DB와의 인터페이스를 의미한다.

선언은 아래와 같이 한다.

```swift
class UserDefaults : NSObject
```

`UserDefaults` 클래스는 기본 시스템과 상호교류를 위한 프로그래밍적인 인터페이스를 제공한다.

이러한 기본 시스템을 통해 앱은 상용자의 환경 설정에 맞게 동작 정의가 가능하다.

런타임시에 `UserDefaults` 객체를 사용하여 앱이 사용자의 기본 DB에서 사용하는 기본값들을 읽어온다고 한다.

그렇다면 `UserDefaults`가 제공하는 주요 프로퍼티와 메서드들에 대해 살펴보자.

```swift
class var standard: UerDefaults
```

사용자의 기본값을 갖는 객체를 얻어오는 방법이다.

공유 기본값을 갖는 객체를 반환받는다.

이후 기본값들을 가져오기 위한 메서드들을 살펴본다.

우리는 이번 프로젝트의 기능에서 사용자가 사용하던 `URL`을 가져와야 하므로 관련 메서드를 살펴보도록 한다.

```swift

// Getting Default Values
func url(forKey: String) -> URL?
```
`Key` 값을 인자로 받는 `url` 메서드는 특정 키 값과 연관된 URL을 반환한다.

```swift

// Setting Default Values
func set(URL?, forKey: String)
```
`Key` 값을 인자로 받는 `set` 메서드는 특정 키 값을 지정 URL로 설정한다.

<br>

**2.WKWebView**

공식 문서 ([WKWebView](https://developer.apple.com/documentation/webkit/wkwebview)) 를 참고해보자.

![image](https://user-images.githubusercontent.com/33051018/79067539-03c37c80-7cfb-11ea-8d06-009175dae96c.png)

`WKWebView` 클래스는 앱 내 브라우저와 같은 웹 관련 컨텐츠와의 상호작용을 위한 객체를 제공한다.

사용방식은 매우 간단하다.

1. URL 지정 ( `URL(String:)` )
2. URL 요청 ( `URLRequest(url: )` )
3. 결과값 출력 ( `WKWebView.load( )` )

또한 `Navigating` 기능을 지원하여 `goBack(), goForward(), reload()` 등과 같은 메서드를 지원한다.

<br>

**3.UIApplication**

공식 문서 ([UIApplication](https://developer.apple.com/documentation/uikit/uiapplication))를 살펴본다.

![image](https://user-images.githubusercontent.com/33051018/79067735-8f89d880-7cfc-11ea-8645-207c72ce14e9.png)

iOS 내에서 실행되는 앱을 제어하기 위한 클래스다.

아직 정확히 뭔지는 모르겠지만 뭔가 매우 중요한 클래스같은 느낌이 든다..

모든 iOS앱은 하나의 `UIApplication` 인스턴스를 갖는다.

앱이 실행되면, 시스템은 `UIApplicationMain(_:_:_:_:)` 함수를 호출한다. 
그 이후, `shared` 클래스 메서드를 호출하여 객체에 접근한다.

즉, 앱이 시작되면 `UIApplicationMain` 함수가 `shared app instance`를 생성한다.




---
---


<br><br><br>

> 코드작성 / @IBOutlet @IBAction 연결

```swift
//
//  AppDelegate.swift
//  MyWebBrowser
//
//  Created by Yeojaeng on 2020/04/12.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit

/// 웹 뷰 마지막 페이지 주소를 UserDefaults 에서 관리하기 위한 키 값
let lastPageURLDefaultKey: String = "lastURL"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    var window: UIWindow?
    var lastPageURL: URL?
    
    
    //MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.lastPageURL = UserDefaults.standard.url(forKey: lastPageURLDefaultKey)         // 앱이 끝날때 URL 가져와서 저장하기.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let userDefaults: UserDefaults
        userDefaults = UserDefaults.standard
        
        userDefaults.set(self.lastPageURL, forKey: lastPageURLDefaultKey)                   // 앱이 종료될 떄 저장해놨던 lastPageURL을 userDefaults에 셋팅
        userDefaults.synchronize()
        // 비동기 업데이트를 통해 
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

```





```swift
//
//  ViewController.swift
//  MyWebBrowser
//
//  Created by Yeojaeng on 2020/04/12.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    // MARK: - Properties
    // MARK: IBOutlets
    
    @IBOutlet var webView: WKWebView!                           // 인터페이스 빌더에서 올려줬던 인터페이스들을 연결해준다.
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.webView.navigationDelegate = self              // webView의 딜리게이트를 ViewController로 지정
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstPageURL: URL?
        
        if let lastURL: URL = UserDefaults.standard.url(forKey: lastPageURLDefaultKey) {
            firstPageURL = lastURL
        } else {
            firstPageURL = URL(string: "https://www.google.com")
        }
        
        guard let pageURL: URL = firstPageURL else {
            return
        }
        
        let urlRequset: URLRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequset)
    }
    
    //MARK: IBActions
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    //MARK: Custom MEthods
    func showNetworkingIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideNetworkingIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension ViewController: WKNavigationDelegate {
    
    //MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish navigation")
        
        if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.lastPageURL = webView.url
        }
        
        webView.evaluateJavaScript("document.title") { (value: Any?, error:Error?) in
            if let error: Error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let title: String = value as? String else {
                return
            }
            
            self.navigationItem.title = title
    }
        self.hideNetworkingIndicator()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("did fail  navigation")
        print("\(error.localizedDescription)")
        
        self.hideNetworkingIndicator()
        let message: String = "오류발생\n" + error.localizedDescription
        
        let alert: UIAlertController
        alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("did start navigaion")
        self.showNetworkingIndicator()
    }
}


```
