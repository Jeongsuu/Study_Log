# Clean Architecture + MVVM 예제

<br>

이번에는 저번 시간에 공부했던 [Clean Architecture + MVVM](https://duwjdtn11.tistory.com/658) 을 기반으로 만들어진 프로젝트를 한번 톺아보며 각각의 계층들을 어떻게 풀어냈는지 살펴보도록 할게요.

예제 애플리케이션은 간단한 영화검색 앱이며 영화를 검색하면 해당 단어가 포함되는 영화들을 보여주고, 스크롤시 데이터를 더 불러옵니다.

상세페이지로 이동시에는 영화의 사진, 제목, 설명을 보여주며 검색 기록까지 함께 남겨주는 앱입니다.

이제 프로젝트를 열어보겠습니다.

<br>
<br>

<img width="584" alt="image" src="https://user-images.githubusercontent.com/33051018/167252842-276a796d-4830-4fed-805c-799794f72579.png">

프로젝트 네비게이터를 살펴보니 앞서 공부했던것과 같이 Domain, Presentation, Data Layer에 따라 그룹핑이 되어있습니다.

**Domain 폴더** 내에는 비즈니스 모델 역할을 하는 Entities와 비즈니스 로직을 담당하는 UseCase 그리고 레포지터리 인터페이스들이 존재합니다.

**Presentation 폴더** 내부에는 View와 ViewModel들이 존재합니다.

**Data 폴더** 에는 Domain 계층에서 만들어놓은 레포지터리 인터페이스의 구현체들이 존재하며 Local DB와 Remote 데이터를 가져오기 위한 장치들이 존재합니다.

이제 좀 더 상세히 살펴보도록 할게요!

<br>

## Domain Layer
---

첫 번째로 Domain 계층에 대해 살펴보도록 하겠습니다.

해당 계층 내부에는 Entities, UseCase 등이 존재합니다.

영화검색 앱에서 가장 고차원 수준의 규칙을 가지는 비즈니스 모델은 무엇이 있을까요?

영화검색 앱이니 당연히 영화에 대한 정보를 보여주게 될 것 입니다.

이 앱에서의 Entity는 Movie가 있으며 데이터의 구조는 아래와 같습니다.

```swift
struct Movie: Equatable, Identifiable {
    typealias Identifier = String
    enum Genre {
        case adventure
        case scienceFiction
    }
    let id: Identifier
    let title: String?
    let genre: Genre?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
}

struct MoviesPage: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}
```

평소에서 보던 데이터 모델의 형상과 동일합니다 :D

다음으로는 **시스템의 동작을 사용자의 입장에서 표현한 시나리오**, UseCase 예시를 살펴보도록 할게요.

예시로 `SearchMoviesUseCase` 가 존재하며 이름을 보면 알 수 있듯 영화 검색에 대한 시나리오를 담당하겠네요!

```swift
protocol SearchMoviesUseCase {
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 cached: @escaping (MoviesPage) -> Void,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {

    private let moviesRepository: MoviesRepository
    private let moviesQueriesRepository: MoviesQueriesRepository

    init(moviesRepository: MoviesRepository,
         moviesQueriesRepository: MoviesQueriesRepository) {

        self.moviesRepository = moviesRepository
        self.moviesQueriesRepository = moviesQueriesRepository
    }

    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 cached: @escaping (MoviesPage) -> Void,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {

        return moviesRepository.fetchMoviesList(query: requestValue.query,
                                                page: requestValue.page,
                                                cached: cached,
                                                completion: { result in

            if case .success = result {
                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
        })
    }
}
```

SearchMovieUseCase는 영화를 검색하고 최근 검색어를 저장하는 시나리오를 담당합니다.

Entities는 Use Case에 대하여 알지 못하지만 역은 성립합니다.

따라서 Use Case의 변경이 Entities에 영향을 주어서는 안됩니다.

<br>

## Presentation Layer
---

Presentation 계층에는 View와 ViewModel이 포함됩니다.

ViewModel은 UIKit을 포함하지 않으며 예시로 MovieListViewModel에 대해 살펴볼게요!

```swift
protocol MoviesListViewModelInput {
    func didSearch(query: String)
    func didSelect(at indexPath: IndexPath)
}

protocol MoviesListViewModelOutput {
    var items: Observable<[MoviesListItemViewModel]> { get }
    var error: Observable<String> { get }
}

protocol MoviesListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput { }

struct MoviesListViewModelActions {
    // Note: if you would need to edit movie inside Details screen and update this 
    // MoviesList screen with Updated movie then you would need this closure:
    //  showMovieDetails: (Movie, @escaping (_ updated: Movie) -> Void) -> Void
    let showMovieDetails: (Movie) -> Void
}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    
    private let searchMoviesUseCase: SearchMoviesUseCase
    private let actions: MoviesListViewModelActions?
    
    private var movies: [Movie] = []
    
    // MARK: - OUTPUT
    let items: Observable<[MoviesListItemViewModel]> = Observable([])
    let error: Observable<String> = Observable("")
    
    init(searchMoviesUseCase: SearchMoviesUseCase,
         actions: MoviesListViewModelActions) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }
    
    private func load(movieQuery: MovieQuery) {
        
        searchMoviesUseCase.execute(movieQuery: movieQuery) { result in
            switch result {
            case .success(let moviesPage):
                // Note: We must map here from Domain Entities into Item View Models. Separation of Domain and View
                self.items.value += moviesPage.movies.map(MoviesListItemViewModel.init)
                self.movies += moviesPage.movies
            case .failure:
                self.error.value = NSLocalizedString("Failed loading movies", comment: "")
            }
        }
    }
}

// MARK: - INPUT. View event methods
extension MoviesListViewModel {
    
    func didSearch(query: String) {
        load(movieQuery: MovieQuery(query: query))
    }
    
    func didSelect(at indexPath: IndexPath) {
        actions?.showMovieDetails(movies[indexPath.row])
    }
}

// Note: This item view model is to display data and does not contain any domain model to prevent views accessing it
struct MoviesListItemViewModel: Equatable {
    let title: String
}

extension MoviesListItemViewModel {
    init(movie: Movie) {
        self.title = movie.title ?? ""
    }
}
```

유저의 액션등과 같은 이벤트를 받아들이기 위한 `ViewModelInput` 과 해당 액션들에 대한 결과를 바인딩 해주기 위한 `ViewModelOutput` 을  추상화하고 이를 `ViewModel` 인터페이스가 채택하고 실제 구현체인 `DefaultViewModel`은 해당 인터페이스를 구현하였습니다.

ViewController는 ViewModel을 알고 있기 때문에 ViewController에서 이벤트가 발생하면 ViewModel 내에 함수를 호출하여 필요한 로직을 수행한 뒤 UseCase를 실행하여 결과를 반환받습니다. 

UseCase를 실행하면 필요에 따라 Data Layer에 접근하여 remote 혹은 Local DB로 부터 데이터를 반환하게 됩니다.

이 일련의 절차의 결과값은 ViewModel 내 Output 프로토콜에 명세되어 있던 결과값들에 반영이 되고 이는 ViewController에 바인딩 됩니다.

전반적으로 return type을 사용하지 않고 클로저를 통해 Completion Handler와 같은 방식을 많이 사용하고 있습니다.

정말 코드가 깔끔하고 멋있네요!!

<br>

## Data Layer
---

ViewController로 부터 이벤트가 발생하면 ViewModel의 Input을 호출하고 ViewModel 내부에서 Use Case를 실행하며 또 이 내부에서 필요에 따라 Data Layer에 접근하였습니다.

Data Layer에는 Domain Layer에 존재하는 Repository 인터페이스를 구현한 구현체가 존재합니다.

```swift
final class DefaultMoviesRepository {
    
    private let dataTransferService: DataTransfer
    
    init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMoviesRepository: MoviesRepository {
    
    public func fetchMoviesList(query: MovieQuery, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        
        let endpoint = APIEndpoints.getMovies(with: MoviesRequestDTO(query: query.query,
                                                                     page: page))
        return dataTransferService.request(with: endpoint) { (response: Result<MoviesResponseDTO, Error>) in
            switch response {
            case .success(let moviesResponseDTO):
                completion(.success(moviesResponseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Data Transfer Object (DTO)
// It is used as intermediate object to encode/decode JSON response into domain, inside DataTransferService
struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}

struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [MovieDTO]
}
...
// MARK: - Mappings to Domain
extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: page,
                     totalPages: totalPages,
                     movies: movies.map { $0.toDomain() })
    }
}
```

위 코드를 살펴보면 `DTO` 객체가 사용된것을 살펴볼 수 있습니다.

DTO는 JSON 결과를 Domain으로 매핑하기 위해 존재하는 중간 객체로 Data Transfer Object를 의미합니다.

상황에 따라 CoreData와 같은 프레임워크를 사용한다면 DTO를 NSManagedObject로 변환하여 사용할 수 있습니다.

<br>
<br>

전반적으로 프로토콜과 클로저를 적극 활용하고 있다는 느낌을 받았습니다.

관심사의 분리와 의존성을 분리하기 위해 인터페이스(프로토콜) 선언과 이를 실제 구현하는 레이어가 분리되어 있다는게 특이했고 Coordinator를 통한 화면전환 처리 또한 인상적이었습니다.

저의 경우에는 ViewModel과 Coordinator 객체간 delegate 패턴을 통해 소통하여 로직을 처리하고 있었는데 에제에서는 의존성 주입을 통해 풀어내었습니다.

Coordinator 클래스에서 해당 VC에서 발생 가능한 Actions 객체를 가지고 VC를 생성할때 ViewModel 생성을 위해 이를 주입해줍니다.

그리고 ViewModel에서 로직을 수행하다가 Actions에 정의해놓은 이벤트를 호출하고 이를 Coordinator가 수행합니다.

오늘 살펴본 예제와 같은 코드를 바로 프로젝트 레벨에서 원활하게 풀어내지는 못하겠지만 공부하면서 조금씩이라도 도입해보고 싶은 욕심이 드네요!


<br>

## Reference
---

- [Memdium: iOS-Clean-Architecture-MVVM](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)
- [Github: iOS-Clean-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)

