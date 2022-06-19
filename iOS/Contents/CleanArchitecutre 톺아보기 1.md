# CleanARchitecture 톺아보기 1

<br>

해당 게시글에서는 [CleanArchitecture](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM) 예제를 톺아보며 학습한 내용을 기록합니다.

<br>

## AppDIContainer
---

```swift
final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                          queryParameters: ["api_key": appConfiguration.apiKey,
                                                            "language": NSLocale.preferredLanguages.first ?? "en"])
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.imagesBaseURL)!)
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        // MovieScene에서는 API 서비스와 Image 처리 서비스가 필요하여 두가지 서비스를 주입하여 반환합니다.
        let dependencies = MoviesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService,
                                                               imageDataTransferService: imageDataTransferService)
        return MoviesSceneDIContainer(dependencies: dependencies)
    }
}
```

`AppDIContainer` 입니다.

앱을 관통하는 서비스들과 이를 구성하기 위한 설정 정보들을 가지는 AppConfigraution 객체 그리고 각 Scene을 구성하기 위해 필요한 Container 빌더 메소드가 존재합니다.


<br>
<br>

## AppDelegate
---

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppAppearance.setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
    
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStorage.shared.saveContext()
    }
}
```

`didFinishLaunchingWithOptions` 메소드입니다.

외부로부터 의존성 주입을 위해 별도의 `Container`를 구성하였으며 `Coordinator` 를 접목하여 화면 전환 책임을 분리하였습니다.

해당 메소드 내부에서의 핵심 로직은 앱의 흐름을 제어하는 `AppFlowCoordinator` 객체를 생성하여 내부에 구현되어 있는 `start` 를 통해 영화 검색 페이지를 띄우는 내용입니다.

이를 위해서 객체 생성시 `AppDIContainer` 객체를 전달받고 있는것으로 보아 코디네이터 내부 로직에서 해당 컨테이너에서 필요한 의존성들을 꺼내와 주입해주는 형태가 예상됩니다.

그러면 AppFlowCoordinator 내부에서 어떤 일이 일어나는지 살펴보죠!

```swift
final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
            // 생성자 의존성 주입
            self.navigationController = navigationController
            self.appDIContainer = appDIContainer
         }

    func start() {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
```

생성자에서 DIContainer를 주입받고 해당 컨테이너로부터 필요한 의존성을 꺼냅니다.

moviesSceneDIContainer를 반환받고 이를 통해 코디네이터(MovieSearchFlowCoordinator)를 반환 받아 `start`를 호출합니다.

```swift
// MovieSearchFlowCoordinator

final class MovieSearchFlowCoordinator {
    ...

    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails,
                                                 showMovieQueriesSuggestions: showMovieQueriesSuggestions,
                                                 closeMovieQueriesSuggestions: closeMovieQueriesSuggestions)
        let vc = dependencies.makeMoviesListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        moviesListVC = vc
    }
}
```

실질적으로 첫 화면을 띄우는 코드입니다.

화면에서 발생가능한 화면 전환 이벤트를 ViewModel 내에 `MoviesListViewModelActions` 라는 구조체로 정의해놓고 이를 코디네이터에서 생성 및 주입하여 관리합니다.

이를 주입받은 ViewModel에서는 해당 이벤트 시점에 주입받은 Actions 객체를 참조하여 메소드를 호출하고 코디네이터가 이를 수신하여 적절한 액션을 취하는 형태입니다.

<br>

오늘은 앱의 실행부터 첫 화면을 띄우기까지의 흐름을 살펴보았습니다.

간단히 하나의 화면을 띄우는데 까지 꽤나 많은 함수 호출과 분기등이 요구되었습니다.

확실하게 관심사가 분리되어 각각의 모듈 및 클래스가 담당하는 역할의 경계가 명확해졌다는 느낌은 받았으나 아직 비즈니스 로직쪽을 살펴보지 않아 해당 패턴의 장점이 느껴지지는 않습니다.

다음에는 Domain Layer 톺아보기로 돌아올게요 :D