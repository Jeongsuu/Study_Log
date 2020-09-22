# KingFisher

<br>

## KingFisher 소개
---

<br>

`KingFisher` 는 iOS에서 이미지를 간편하게 관리할 수 있도록 기능을 제공하는 오픈소스 라이브러리다.

물론 `Alamofire` 혹은 `URLSession` 등을 이용해 네트워킹을 통하여 이미지를 다운로드한 뒤 이를 다룰 수 있다.

하지만, 많은 양의 이미지 데이터가 필요한 경우 혹은 큰 용량의 이미지들을 다뤄야 하는 경우에는 앱 성능에 심각한 영향을 줄 수 있으므로 이러한 상황에 보다 효율적으로 대처하기 위해 여러가지 추가 작업이 필요하고 네트워킹 작업이 필요한 부분은 비동기 처리를 진행해줘야 한다.

이러한 번거로운(?) 작업들을 위해 `KingFisher`는 아래 기능들을 제공한다.

1. 비동기 이미지 다운로드 및 캐싱
2. URLSession 기반 네트워킹
3. 메모리와 디스크를 위한 다중 계층 캐시 제공
4. GIF 형식의 이미지 지원
5. 유용한 이미지 프로세서 & 필터 기능을 제공한다.
6. UIImageView, UIButton (NS 포함)에 대한 Extension 형식으로 기능을 제공한다.
7. SwiftUI도 제공한다.

`KingFisher` 의 가장 큰 장점은 이미지를 캐싱하여 재접근시 캐시의 장정믈 이용해 이미지 로딩 시간을 크게 줄여준다는 것 같다.

<br>

### KingFisher 이미지 로드 방법
---

<br>

```swift
guard let url = URL(string: imageURL) else { return }
imageView.kf.setImage(with: url)
```

제일 간단한 use-case 이다.

이미지를 설정할 `imageView`에 메소드체이닝으로 `KingFisher`를 호출하여 `setImage()` 메소드를 이용한다.

**위와 같이 코드를 작성하면 `KingFisher`가 url로 부터 이미지를 다운받고 이를 메모리와 디스크 캐시에 저장한다. 그 이후에 `imageView`에 디스플레이 된다.**

**첫 다운로드때 이를 캐시에 저장해놓기 때문에 추후 같은 URL에 대한 이미지 요청시 캐시로부터 데이터를 바로 가져오기 때문에 매우 빠른 속도로 처리가 가능하다.**

```swift
guard let url = URL(string: imageURL) else { return }
let processor = DownsamplingImageProcessor(size: imageView.bounds.size) >> RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.indicatorType = .activity
imageView.kf.setImage(
    with: url,
    placeholder: UIImage(named: "placeholderImage"),
    options: [
        .processor(processor),
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage
    ])
{
    result in
    switch result {
        case .success(let value):
            print("Task done")
        case .failure(let err):
            print(err.localizedDescription)
    }
}
```

이미지를 다운로드 받는 동안 `indicator`를 보여주도록 `.indicatorType` 을 통해 설정 또한 가능하며 해당 작업에 다양한 옵션을 제공할 수 있다.

<br>

### Processor
---

`ImageProcessor` 는 `KingFisher`를 좀 더 유연하게 만드는 기능이다.

이는 이미지 혹은 데이터를 다른 이미지로 변환하도록 도와준다.

`options` 파라미터를 사용하지 않으면 default processor로 전달된다.

```swift
// Without Anything
imageView.kf.setImage(with: url)

// It equals to
imageView.kf.setimage(with: url, options: [.processor(DefaultImageProcessor.default)])
```

`KingFisher` 가 제공하는 내장 프로세서들은 아래와 같다.
```swift
// 둥근 모서리 효과 프로세서
let processor = RoundCornerImageProcessor(cornerRadius: 20)

// 이미지 사이즈 재설정 프로세서
let processor = ResizingImageProcessor(targetSize: CGSize(width: 100, height: 100))

// 블러 처리 프로세서
let processor = BlurImageProcessor(blurRadius: 5.0)

// 틴트 컬러 설정 프로세서
let processor = TintImageProcessor(tint: .black)

// 샘플이미지 다운로드 프로세서
let processor = DownSamplingImageProcessor(size: CGSize(width: 100, height: 100))
```

위와 같이 다양한 프로세서를 제공하며 이외에도 몇개 더 제공한다.

특히, 고해상도 이미지를 다운로드 받는 경우 `DownSamplingImageProcessor`를 이용하여 메모리에 로딩하기 이전에  특정 사이즈의 샘플 썸네일 이미지를 다운로드 받아 제공할 수 있다!

다양한 프로세서를 제공하는 만큼 해당 프로세서를 여러개 묶어서 동시에 사용 또한 가능하다.

```swift
let processor = BlurImageProcessor(blurRadius: 4) >> RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.setImage(with: url, options: [.processor(processor)])
```

위 예제는 다운로드 받은 이미지를 Blur 처리한 이후, 해당 이미지의 모서리를 둥글게 만든뒤 셋팅하는 코드다.

<br>

### 퍼포먼스 팁
---

<br>

**불필요한 다운로드 작업 취소**
```swift
imageView.kf.setImage(with: url) { result in
    // result 가 .failure인 경우
}

imageView.kf.cancelDownloadTask()
imageView.kf.setImage(with: url2) { result in
    // result 가 .success인 경우
}
```

이러한 기술은 테이블 뷰 & 콜레견 뷰에서 유용히 사용된다.

사용자가 리스트를 빠르게 스크롤하면 이미지 다운로드 작업이 다량 생겨날 수 있다.

따라서, `didEndDisplaying` 델리게이트 메소드에서 불필요한 작업들은 취소시켜 퍼포먼스를 향상시킬 수 있다.

```swift
func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    cell.imageView.kf.cancelDownTask()
}
```

<br>

### URL 내 한국어가 포함될 경우 대응
---

```swift
let url = URL(string: urlString?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed))
```

이와 같이 `addingPercentEncoding()` 을 이용하여 대처할 수 있다.

<br>

## Summary
---

- `KingFisher`는 iOS 에서 이미지를 간단하게 처리할 수 있도록 기능을 제공하는 오픈소스 라이브러리다.
- KingFisher를 이용하여 이미지 다운로드시, 첫 시도에 이미지를 다운로드 한 이후 캐시에 저장을 해놓기 때문에 같은 URL에 대한 이미지 요청시 캐시로부터 바로 가져와서 매우 빠른 속도로 처리가 가능하다.
- 다양한 내장 프로세서와 캐시 옵션을 제공하며 사용법도 매우 간편하다.
- `cancelDownTask()` 메소드를 이용하여 불필요한 작업을 줄이고 퍼포먼스를 올릴 수 있다.

