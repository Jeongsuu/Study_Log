# CleanArchitecture 톺아보기 3 - Data

<br>

안녕하세요! ian 입니다.

이번에는 저번 포스팅에 이어 `Data` 계층에 대하여 톺아보도록 하겠습니다.

예제는 기존 [예제](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)를 그대로 살펴보도록 할게요!

<br>

## Data 계층
---

Data 계층에는 이전에 살펴봤던 Domain 계층에 존재하던 레포지터리 인터페이스를 구현한 레포지터리 구현체가 존재하며 실제 앱에서의 서비스를 처리하기 위해 필요한 데이터를 가져오는 데이터소스를 담당합니다.

여기서 말하는 데이터소스란 리모트 혹은 로컬(ex: Persistent DB) 등을 의미하며 Data 계층 또한 Domain 계층에 대한 의존성을 갖습니다.

자 그러면 레포지터리 구현체부터 톺아보도록 해요:D

<br>

## Repository
---

이전 포스팅에서 Repository 인터페이스들을 살펴봤으며 대표적으로 검색 쿼리에 따른 영화 정보를 가져오는 함수 `fetchMoviesList(query:,page:,cached:,completion:)` 가 존재하던 `MoviesRespotiry` 가 있었습니다.

해당 인터페이스를 구현한 구현체 `DefaultMoviesRepository` 는 아래와 같이 구현되어 있습니다.

```swift
final class DefaultMoviesRepository {

    private let dataTransferService: DataTransferService
    private let cache: MoviesResponseStorage

    init(dataTransferService: DataTransferService, cache: MoviesResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultMoviesRepository: MoviesRepository {

    public func fetchMoviesList(query: MovieQuery, page: Int,
                                cached: @escaping (MoviesPage) -> Void,
                                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {

        let requestDTO = MoviesRequestDTO(query: query.query, page: page)
        let task = RepositoryTask()

        cache.getResponse(for: requestDTO) { result in

            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getMovies(with: requestDTO)
            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
                switch result {
                case .success(let responseDTO):
                    self.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}
```

상속을 하지 않을 클래스이며 정적 디스패치를 위해 `final` 키워드를 적용하여 클래스를 정의하였습니다.

프로퍼티로 해당 레포지터리에서 데이터를 끌어오기 위해 필요한 네트워킹 서비스 `DataTransferService` 와 검색 결과값을 저장하는 Storage를 의존성으로 가지고 있으며 레포지터리 객체를 생성하는 시점에 생성자를 통해 주입합니다.

각각의 객체들이 담당하는 역할과 책임이 확실히 분리되어 있으니 레포지터리가 가지는 역할을 수행하기 위해 딱 필요한 책임을 가지는 객체들만 주입을 받습니다.

실제 인터페이스에 대한 구현은 `extension`으로 빼서 구현되어 있는데요! 개인적으로 선호하는 프로토콜 채택 형태이며 Swift Prograaming Language 자료에서도 볼 수 있었던 내용의 형태입니다.

인터페이스에 기재되어 있던 함수 `fetchMoviesList` 를 구현한 부분을 살펴보면 `cache` 라는 `MovieResponseStorage` 객체를 통해 `getResponse` 메소드를 호출하고 completion을 통해 result 값을 반환받아 각각의 케이스에 따라 로직을 처리합니다.

APIEndpoints 얻어와서 Networking 기능을 랩핑하고 있는 `DataTransferService` 를 통해 response를 받아옵니다.

response가 정상적인 경우에는 Storage에 save 이후 completion으로 DTO를 엔티티로 변환하여 전달하고 response에 에러가 존재하는 경우 에러를 전달합니다.

이전 포스팅에서 살펴봤듯 UseCase가 이를 호출하여 completion을 처리하였습니다.

<br>

<br>

## PersistentStorage
---

다음으로는 로컬 DB를 담당하는 Persistent Storage입니다.

이 또한 인터페이스를 별도로 두고 해당 인터페이스를 구현하는 구현체가 존재하는 패턴으로 작업이 되어 있습니다!

Storage가 해야 할 일을 인터페이스에 명시해놓고 추후에 DB가 변경될 경우 해당 인터페이스만 채택하여 DB만 갈아끼우면 유지보수에 유연하게 대처가 가능할 것 같네요:D 

```swift
protocol MoviesResponseStorage {
    func getResponse(for request: MoviesRequestDTO, completion: @escaping (Result<MoviesResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: MoviesResponseDTO, for requestDto: MoviesRequestDTO)
}
```

인터페이스만 보니 MovieResponseStorage가 어떠한 일을 해야할 지 알 수 있습니다.

```swift
final class CoreDataMoviesResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: MoviesRequestDTO) -> NSFetchRequest<MoviesRequestEntity> {
        let request: NSFetchRequest = MoviesRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(MoviesRequestEntity.query), requestDto.query,
                                        #keyPath(MoviesRequestEntity.page), requestDto.page)
        return request
    }

    private func deleteResponse(for requestDto: MoviesRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataMoviesResponseStorage: MoviesResponseStorage {

    func getResponse(for requestDto: MoviesRequestDTO, completion: @escaping (Result<MoviesResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first

                completion(.success(requestEntity?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response responseDto: MoviesResponseDTO, for requestDto: MoviesRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
```

MoviesResponseStorage는 DB 용도로 CoreData를 사용하고 있네요!

생성자를 통해 싱글톤 CoreDataStorage 객체를 주입받고 `NSFetchRequest`를 생성하여 반환하는 메소드와 delete를 하는 메소드를 구현하고 앞서 살펴봤던 인터페이스를 Extension으로 뺀 이후 채택하였습니다.

해당 기능들을 생성자를 통해 주입받았던 CoreDataStorage(DB)를 통해  `getResponse` 와 `save` 를 구현하였습니다.

이상으로 간략하게 `Data` 계층에 대하여 알아보았습니다.

CleanArchitecture를 톺아보며 느끼는건 각 계층 그리고 그 계층 내 존재하는 클래스들의 책임과 역할이 명확히 분리되어 있다는것 입니다.

이를 통해 객체들간의 협력 관계가 질서있게 설계된 의존성 규칙에 따라 명확히 동작하며 인터페이스 기반의 설계 덕택에 객체가 엄격하며 유연한 책임을 가지며 역할을 할 수 있는것 같아요 :D