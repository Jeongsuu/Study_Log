# RxDataSources

<br>

본 문서에는 `RxDataSources` 라이브러리를 공부하며 정리한 내용을 기록합니다.

<br>

## Table and Collection View data sources
---

기존에 `TableView` 와 `CollectionView` 를 이용할 때 해당 UIKit을 위한 `DataSource` 내에 정의된 메소드들을 사용하며 테이블 뷰와 콜렉션 뷰 내에 데이터를 관리하고 보여줬습니다.

하지만 `RxSwift`를 사용하며 마치 아래와 같이 위 프로토콜 없이도 간단한 기능들을 더욱 Reactive하게 처리하게 되었습니다. 

```swift
// [String] 타입의 옵저버블 생성
let data = Observable<[String]>.just(["first element", "second element", "third element"])

// tableView.items에 데이터 바인딩
data.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { idx, model, cell in
    cell.textLabel?.text = model
}
.disposed(by: disposeBag)
```

간단한 데이터를 다루기에는 전혀 지장이 없으나 만일 많은 **섹션**을 이용한다거나, 복잡한 데이터셋을 바인딩해야 한다거나, 아이템을 추가 및 삭제 할 때 애니메이션을 수행해야 하는 경우에는 해당 기능을 제공하는 Sugar API가 존재하지 않기에 직접 기능을 구현해야 했습니다.

**이것이 바로 RxDataSources 가 필요한 이유입니다.**

`RxDataSources`를 이용하면 더욱 수월하게 기능들을 구현할 수 있습니다.

```swift
let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: configureCell)

// just Operator를 이용하여 Observable을 생성합니다. 이 때, SectionModel 타입의 자료형을 전달합니다.
Observable.just([SectionModel(model: "title", items: [1, 2, 3])])
    .bind(to: tableView.rx.items(dataSource: dataSource))
    .disposed(by: disposeBag)

```

<br>

## Summary
---

- `Reactive` 한 TableView, CollectionView의 DataSource 메소드 기능들을 를 구현하기 위해서 `RxDataSources`를 제공한다.

<br>

## Reference
---

- [github - RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources)