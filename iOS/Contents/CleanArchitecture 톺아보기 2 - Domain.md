# CleanArchitecture 톺아보기 2 - Domain.md

<br>

저번 포스팅에 이어서 이번에는 `Domain` 계층에 대해 톺아보도록 하겠습니다!

<br>

Domain 계층에는 앱에서 사용되는 주요 데이터 모델인 Entity, 서비스 동작 시나리오 UseCase, 데이터에 관련 로직을 위한 기능들을 추상화 한 Repository Interface가 존재합니다.

하나씩 살펴보도록 할게요!

<br>

## Entity
---

Entity는 비즈니스 모델을 의미합니다.

해당 예제(영화 검색 서비스) 에서는 영화가 주요 Entity 입니다.

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

`Movie` 라는 구조체가 존재하며 서비스를 위해 필요한 프로퍼티들을 가지고 있습니다.

또 페이징 처리에 대한 편의를 위해 `MoviesPage` 라는 구조체를 별도로 정의하였네요!

이제 UseCase와 Repository 등에서 Entity가 어떻게 사용되는지 살펴볼게요.

<br>

## Repository Interface
---

서비스를 위해서는 로컬 DataBase를 통해 데이터에 접근하거나 외부 서버에서 제공하는 API를 통해 데이터에 접근합니다.

Repository는 단어의 의미 그대로 저장소를 의미하며 앱에서의 위 기능들을 담당하며 Interface는 해당 기능들을 추상화합니다.

```swift
protocol MoviesRepository {
    @discardableResult
    func fetchMoviesList(query: MovieQuery, page: Int,
                         cached: @escaping (MoviesPage) -> Void,
                         completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
```

`MoviesRepository` 라는 인터페이스에서는 인자로 query와 page를 받고 completion 핸들러를 통해 Result<MoviesPage, Error> 타입을 반환합니다.

이를 호출하는(UseCase) 쪽에서 핸들러를 통해 Result를 제어하게 됩니다.

```swift
protocol MoviesQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[MovieQuery], Error>) -> Void)
    func saveRecentQuery(query: MovieQuery, completion: @escaping (Result<MovieQuery, Error>) -> Void)
}
```

`MoviesQueryRepository` 인터페이스에서는 최근 쿼리 내역을 fetch, save하는 기능을 추상화 하였습니다.

이 또한 마찬가지로 completion을 통해 Result 타입을 반환합니다.

```swift
protocol PosterImagesRepository {
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
```

`PosterImagesRepository` 인터페이스에서는 포스터 이미지를 fetch해오는 기능을 추상화 하였습니다.

image의 위치, 너비등과 같이 필요한 정보를 인자로 전달받고 completion으로 Result 타입을 반환합니다.

Repository Interface에서는 실제 Repository에서 구현해야 할 기능들을 간략히 추상화만 해놓았기 떄문에 쉽게 이해할 수 있습니다!

이렇게 추상화 된 Repository Interface들은 `Data` 계층에서 구현하게 됩니다.

<br>

## UseCase
---

다음으로 UseCase에 대하여 살펴보도록 하겠습니다.

```swift
// 무비 검색 시나리오에 대한 명세
protocol SearchMoviesUseCase {
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 cached: @escaping (MoviesPage) -> Void,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

// 시나리오 프로토콜을 채택한 구현체
final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {

  // 데이터 레이어의 레포지터리 구현체가 아닌 도메인 레이어의 인터페이스를 갖는다.
    private let moviesRepository: MoviesRepository
    private let moviesQueriesRepository: MoviesQueriesRepository

  // 인스턴스 생성시에는 인터페이스를 구현한 구현체를 함께 주입받는다.
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

struct SearchMoviesUseCaseRequestValue {
    let query: MovieQuery
    let page: Int
}
```

각 기능에 따른 UseCase도 protocol로 추상화하고 `Default` 라는 prefix를 붙여 구현체를 만들었습니다.

구현체의 생성자 부분을 살펴보면 `moviesRepository` 와 `moviesQueriesRepository`를 전달 받습니다.

UseCase 시나리오를 정상적으로 수행하기 위해서 데이터 접근이 필요하며 해당 데이터에 접근하는 Repository들을 전달 받는 형태입니다.

실제 `SearchMoviesUseCase`의 로직이 수행되는 `execute` 메소드 내부를 살펴보면 repository로 부터 result를 전달받고 결과를 completion으로 전달합니다. 

즉 일반적으로 유저로부터 이벤트가 들어오면 ViewController -> ViewModel -> UseCase -> Repository -> Entity 방향으로 request가 들어오고 그 역방향으로 response가 전달되며 마지막에 User에게 보여지게 됩니다.

앱이 제공하는 서비스가 검색뿐이다 보니 Domain 계층에서 생각보다는 많은 내용을 볼 수 없었지만 간결하여 더욱 이해하기 쉬웠던 것 같습니다!

이상으로 Domain 계층에 대한 톺아보기를 마치고 다음에는 Data 계층 톺아보기로 돌아오도록 하겠습니다 :D 