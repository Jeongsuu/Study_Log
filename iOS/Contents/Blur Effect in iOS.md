# Blur Effect in iOS

<br>

아이폰을 사용하다보면 심심치않게 Blur 효과를 확인하실 수 있습니다.

이번에는 Blur 효과 적용방법에 대해 간단히 알아보도록 하겠습니다.

<br>

## Setting
---

앱의 배경화면으로 이용할 이미지 Asset을 프로젝트에 넣어준 뒤 아래와 같이 기본 셋팅을 진행합니다.

```swift

// 이미지 생성
private let imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.contentmode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
}()


override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imageView)  // 메인 뷰에 이미지 뷰 넣기
    imageView.frame = view.bounds
}
```

Asset으로 저장해놓은 이미지를 가져와서 view의 크기와 동일하게 셋팅합니다.

본격적으로 Blur 효과를 적용하기 위한 기능을 구현해보도록 하겠습니다.

<br>

## UIVisualEffectView & UIBlurEffect
---

![image](https://user-images.githubusercontent.com/33051018/98814026-7438a480-2468-11eb-92b3-ac0f8c765114.png)

Blur 효과를 적용하기 위해 필요한 핵심 클래스는 `UIVisualEffectView` 입니다.

설명에 적혀있듯 시각적 효과를 구현해내기 위해 이용되는 클래스입니다!

시각적 효과를 `View`에 적용하도록 도와주며 기본적으로 `UIBlurEffect` 효과와 `UIVibrancyEffect`를 제공합니다.

이번에는 `UIBlurEffect` 를 사용하여 Blur 효과를 적용해 볼 것이며 Blur의 정도는 `alpha` 프로퍼티를 통해 조정합니다.

`View`에 적용할 수 있는 Blur Effect의 종류도 21개나 됩니다..!

(종류가 궁금한다면 [여기](https://developer.apple.com/documentation/uikit/uiblureffect/style) 를 참고해주세요!)

이번 글에서는 사용자 UI 스타일에 따라 조정되는 `regular` 스타일을 적용해보도록 하겠습니다.

<br>

## Blur Effect & Animation 적용 
---

이제 직접 Blur 효과를 적용해봅니다!

우리는 앞서 `UIBlurEffect` 를 사용하기 위해서는 `UIVisualEffectView` 클래스의 도움이 필요하다는 것을 확인하였습니다.

`UIVisualEffectView`의 인스턴스를 생성시 `UIBlurEffect`를 인자로 전달하여 생성한 뒤, 이를 애니메이션을 통해 효과를 적용시키는 함수를 작성하겠습니다.

```swift
private func makeBlurEffect(targetImage: UIImageView) {
    let blurEffect = UIBlurEffect(style: .regular)                      // regular 타입의 Blur Effect
    let visualEffectView = UIVisualEffectView(effect: blurEffect)       // UIVisualEffectView 객체 생성
    visualEffectView.alpha = 0
    visualEffectView.frame = imageView.bounds
    view.addSubview(visualEffectView)

    // MainThread job
    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
        UIView.animation(withDuration: 1) {
            visualEffectView.alpha = 1
        }
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imageView)
    imageView.frame = view.bounds
    imageBlurEffect(targetView: imageView)
}
```


위와 같이 간단히 `imageBlurEffect(targetView:)` 함수를 정의하였습니다.

해당 함수가 호출된 이후 2초 뒤에 Blur 효과가 적용되는 코드입니다.


![image](https://user-images.githubusercontent.com/33051018/98816912-b237c780-246c-11eb-878b-5777c0fe735b.png)

이랬던 배경화면이 Blur 처리가 적용된 이후에는

![image](https://user-images.githubusercontent.com/33051018/98817128-02168e80-246d-11eb-9fa3-d82f75d1b54b.png)

위와 같이 예상했던대로 Blur가 적용됩니다!

