# Snapkit

이번 프로젝트에서 `SnapKit` 을 사용하게 되어 이를 직접 사용하기 이전에 `SnapKit` 이 무엇인지 먼저 공부하며 본 문서를 작성한다.

<br>

## SnapKit이란?
![image](https://user-images.githubusercontent.com/33051018/81568777-34b9ce80-93d9-11ea-944d-2e8e583c9f62.png)

cf) [SnapKit Official Repository](https://github.com/SnapKit/SnapKit)
---

`iOS` 앱을 개발할 때에는 다양한 해상도를 유연하게 지원하기 위하여 `Auto Layout`이라는 기능을 제공한다.

<br>

#### `Auto Layout`이란?
`AutoLayout` 이란, 기존의 `Frame-Based Layout` 과는 달리 `View`와 `View`사이의 관계를 이용하여 해당 객체의 위치와 크기를 자동으로 결정하는 `Layout System`이다.


`SnapKit`이란 `iOS`와 `OS X`의 `Auto Layout` 기능을 코드로 손쉽게 적용하도록 도와주는 기능을 제공하는 라이브러리이다.

즉, 가독성을 잃지 않으면서 최소한의 코드만으로 자동 레이아웃을 코드에 작성하는 것 을 단순화한 레이아웃 라이브러리이다.

<br>

## SnapKit 사용법
---

외부 라이브러리를 프로젝트에서 사용하기 위해서는 `CocoaPods`와 같은 `dependency manager`를 이용한다.

본 문서에서는 설치방법은 다루지 않는다.

간단한 예제로 `SnapKit`에서 제공하는 예시를 진행해보도록 한다.

코드는 아래와 같다.

```swift
import UIKit
import SnapKit

class ViewController: UIViewController {

    var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(box) {
            box.backgroundColor = .green
            box.snp.makeConstrints { (make ) in
                make.width.height.eqaulTo(100)
                make.center.equalTo(self.view)
            }
        }
    }
}
```

위 코드를 보면 알 수 있듯, 코드가 매우 직관적이다.

`box` 라는 UIView 객체를 만들고 이를 `view`의 `SubView`로 더한다.

이후 `box` 뷰에 대한 UI를 설정한다.

배경색은 초록색으로 설정한 뒤, 제약을 추가한다.

`make.width.height.equalTo(100)` : 박스의 너비와 높이는 100으로 설정한다.
`make.center.equalTo(self.view)` : 박스의 중앙은 현재 뷰의 중앙으로 설정한다.

코드를 실행해보도록 한다.

![image](https://user-images.githubusercontent.com/33051018/81570508-a6931780-93db-11ea-91d4-84a5eca3389a.png)

대략 예상했던 것과 동일하게 나왔다.


