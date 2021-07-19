# TabBarController With Coordinator-Pattern

<br>

**(본 내용은 공부 목적으로 작성되었습니다. 잘못되거나 틀린 내용이 있다면 댓글 남겨주시면 감사하겠습니다.)**

안녕하세요! 이전 시간에 간단한 예제와 함께 살펴봤던 Coordinator에 이어 이번에도 Coordinator에 대해 알아보도록 하겠습니다.

(이전 게시글을 안보신 분이 계시다면 [Coordiantor 패턴](https://duwjdtn11.tistory.com/644)을 한 번 참고해주세요 :) )

바로 본론으로 들어가도록 하겠습니다.

이전 시간에는 NavigationController만을 사용하여 간단히 화면을 전환하는 예제를 통해 Coordinator(이하 코디네이터) 패턴에 대해 알아보았는데요,

오늘은 UITabBarController와 UINavigationController 모두를 사용해보며 예제를 진행해보도록 하겠습니다.

<br>
<br>

## Coordinator 초기 작업
---

첫 번째로, 모든 코디네이터들이 채택하여 준수하게 될 프로토콜을 작성해보도록 할께요

코디네이터들은 부모-자식 코디네이터간의 참조를 유지하기 위해 `childCoordinator`를 가지게 될 것이며 코디네이터를 통해 화면 전환 로직을 수행할 `start()` 라는 메소드를 가지게 됩니다.

```swift
protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }

    func start()
}
```

코디네이터 객체들이 가져야 할 상태와 행위를 프로퍼티와 메소드를 통해 정의하였습니다.

<br>
<br>

## Coordinator 와 ViewController 생성
---

<br>

첫 번째로, 탭 바 내에 포함될 ViewController의 Coordinator를 만들어보도록 할께요!

```swift
class FirstViewCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController

    init() {
        eslf.navigationController = .init()
    }

    func start() {
        // Do Something
    }

    // FirstViewController 객체를 생성하여 반환하는 메소드
    func startPush() -> UINavigationController {
        let firstViewController = FirstViewController()
        firstViewController.delegate = self
        firstViewController.view.backgroundColor = .white
        navigationController.setViewController([firstViewController], animated: false)

        return navigationController
    }
}
```

이와 같이 본인이 담당하는 ViewController 객체를 생성하여 반환하는 `startPush` 라는 메소드를 갖는 코디네이터를 3개 만들었습니다.(FirstViewCoordinator, SecondViewCoordinator, ThirdViewCoordinator)

이 중 FirstViewController는 `UINavigationController` 를 반환하여 depth를 가질수 있도록 하였습니다.

<br>
<br>

## AppCoordinator 생성 및 연결
---

<br>

이제는 앱 내 전반의 코디네이터를 관리할 메인 코디네이터를 작성해보도록 하겠습니다! (많이 검색을 해봤으나 대체로 MainCoordinator || AppCoordinator 라는 네이밍을 따르는것 같아서 저도 AppCoordinator 라는 네이밍을 따르도록 하겠습니다.)

앱이 런칭되고 나면 우리는 `AppCoordinator` 를 통해 앱의 진입 화면을 띄워야합니다. 이를 위해 필요한 로직을 정리해보도록 할께요!

- SceneDelegate에서 `AppCoordinator` 객체를 생성하여 start() 메소드를 호출합니다 -> 화면 트랜지션
- 따라서 `AppCoordinator`는 `UIWindow` 클래스의 객체를 생성자의 파라미터로 받도록 합니다.
- 첫 화면에 진입시 우리는 TabBar 기반의 메인 뷰를 보여주기 위해 `UITabBarController`를 생성하고 이를 `window` 객체의 `rootViewController`로 지정합니다.


이를 염두하고 작성해보도록 하겠습니다.

```swift
class AppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    let window: UIWindow?

    init(_ window: UIWindow?) {
        // UIWindow 객체를 생성자의 파라미터로 전달 받습니다.
        self.window = window
        window?.makeKeyAndVisible()
    }

    func start {
        // TabBar를 구성하고 이를 window의 rootView로 지정합니다.
        let tabBarController = TabBarController()
        self.window?.rootViewController = tabBarController
    }

    // 데모용 탭바를 생성하여 반환하는 메소드
    func setTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let firstItem = UITabBarItem(title: "First", image: nil, tag: 0)
        let secondItem = UITabBarItem(title: "Second", image: nil, tag: 1)
        let thirdItem = UITabBarItem(title: "Third", image: nil, tag: 2)

        let firstViewCoordinator = FirstViewCoordinator()
        firstViewCoordinator.parentCoordinator = self
        childCoordinator.append(firstViewCoordinator)
        let firstViewController = firstViewCoordinator.startPush()
        firstViewController.tabBarItem = firstItem

        let secondViewCoordinator = SecondViewCoordinator()
        secondViewCoordinator.parentCoordinator = self
        childCoordinator.append(secondViewCoordinator)
        let secondViewController = secondViewCoordinator.startPush()
        secondViewController.coordinator = self
        secondViewController.tabBarItem = secondItem

        let thirdViewCoordinator = ThirdCoordinator()
        thirdViewCoordinator.parentCoordinator = self
        childCoordinator.append(thirdViewCoordinator)
        let thirdViewController = thirdViewCoordinator.startPush()
        thirdViewController.tabBarItem = thirdItem

        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]

        return tabBarController
    }
}
```

간단한 예시이므로 ViewModel를 별도로 구성하지는 않았습니다.

`setTabBarController` 메소드 내부를 살펴보면, 각각의 VC를 직접 생성하지 않고 해당 VC 담당 Coordinator 객체를 생성하고 이를 기반으로 VC를 반환받아 초기화합니다.

물론 Coordinator 객체를 생성할때 부모-자식 코디네이터 간의 참조도 유지할수 있도록 해줍니다.

진입시 보여줄 화면이 준비되었으니 이를 `SceneDelegate` 의 `willConnectTo` 메소드에서 연결해주도록 할께요.

```swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.appCoordinator = AppCoordinator(window)    // AppCoordinator 생성자의 인자로 window 객체를 전달합니다.

        appCoordinator?.start()              // AppCoordinator의 statt 메소드를 호출하여 진입 화면을 보여줍니다.
    }
}
```

자 이제 실행해보도록 하겠습니다.

<img width="400" alt="image" src="https://user-images.githubusercontent.com/33051018/126193009-3a6524e3-86eb-463e-a87c-74d94b193724.png">

작성한대로 3개의 탭 바를 갖는 뷰가 보여지고 FirstVC는 네비게이션 바를 가지고 있는것을 확인할 수 있습니다.

탭 바 아이템 간 화면 전환도 정상적으로 작동합니다.

마지막으로 FirstVC에서 `Push FourthVC` 라는 버튼을 터치하면 현재 NavigationController에 `Fourth VC` 객체를 push 할 수 있도록 해볼께요!

<br>
<br>

## 탭 바 내 네비게이션
---

<br>

이를 위해서 첫 번 째로 버튼의 이벤트를 연결해주도록 할텐데, 화면 전환은 Cooridnator가 할 수 있도록 델리게이트 패턴을 이용하여 진행하도록 하겠습니다.

```swift
protocol FirstViewDelegate: AnyObject { // 델리게이트 프로토콜 정의
    func pushFourthVC()
}

class FirstViewController: UIViewController {
    weak var coordinator: Coordinator?
    private weak var titleLabel: UILabel!
    private weak var button: UIButton!

    weak var delegate: FirstViewDelegate?       // 델리게이트 객체

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        let titleLabel = UILabel()
        titleLabel.text = "First VC"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        view.addSubview(titleLabel)
        self.titleLabel = titleLabel

        let button = UIButton()
        button.setTitle("Push FourthVC", for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(pushFourthVC), for: .touchUpInside)
        view.addSubview(button)
        self.button = button

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    // 버튼에 터치이벤트가 발생하면 delegate를 객체를 통해 함수를 호출합니다.
    @objc func pushFourthVC() {
        delegate?.pushFourthVC()
    }
}
```

위와 같이 FirstViewController 작업을 완료하였습니다.

화면 전환의 시작점이 될 곳에서 delegate 객체를 가지고 이를 기반으로 함수를 호출합니다.

화면 전환의 출발지는 `FirstViewController` 이고 목적지는 `FourthViewController` 입니다.

따라서, 화면 전환 로직 수행은 출발지 담당 코디네이터 `FirstViewCoordinator`에서 진행해주도록 합니다.

```swift
class FirstViewCoordinator: Coordinator, FirstViewModelDelegate {   // 프로토콜을 채택합니다.
    
    // 위와 동일

    // 델리게이트 메소드를 정의합니다.
    func pushFourthVC() {
        // 목적지 VC 담당 코디네이터 객체를 생성후 start() 메소드를 호출하도록 합니다.
        let fourthViewCoordinaor = FourthViewCoordinator(navigationController: navigationController)
        fourthViewCoordinator.parentCoordiantor = self
        childCoordinator.append(fourthViewCoordinator)

        fourthViewCoordinator.start()
    }
}
```

위와 같이 작성한 뒤 빌드하여 버튼을 터치하면 아래와 같이 의도한대로 `FourthVC` 가 push 되는것을 볼 수 있습니다!

<img width="400" alt="image" src="https://user-images.githubusercontent.com/33051018/126195057-d4d473e5-29a3-42e7-b6ea-6d42f4e508d5.png">


<br>

오늘은 이렇게 간단한 코디네이터 패턴을 접목한 TabBarController에서의 네비게이션에 대해 살펴보았습니다!

공부중인 내용이다보니 잘못된 내용이 있을수도 있습니다. 그렇다면 꼭 댓글로 해당 내용 남겨주시면 감사하겠습니다 :)