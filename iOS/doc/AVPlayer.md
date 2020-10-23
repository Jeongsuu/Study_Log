# AVPlayer

이번에는 Swift에서 영상 플레이시 주로 사용하는 `AVPlayer`에 대하여 알아보도록 하겠습니다.

<br>

![image](https://user-images.githubusercontent.com/33051018/96978441-5529af80-1559-11eb-97b6-caa89ae73939.png)

`AVPlayer` 는 플레이어의 전송 동작등을 제어하는 인터페이스를 제공하는 객체입니다.

해당 객체는 미디어 데이터 재생의 핵심 클래스로서 재생과 정지, 그리고 특정 시간대로 이동하는 등 재생에 대한 전반적인 제어를 관리합니다.

<br>

## Overview
---

`AVPlayer`는 미디어 재생 등을 조절하는 기능을 제공하는 컨트롤 객체입니다.

`AVPlayer`를 이용하면 마치 QuickTime Player와 같이 파일 기반의 미디어를 원격 혹은 로컬에서 미디어를 실행할 수 있습니다. 뿐만 아니라  `HTTP` 기반의 라이브 스트리밍을 통해 시청각 미디어를 제공할 수 있습니다.

`AVPlayer`는 단일 미디어 데이터만 재생할 수 있지만, `AVFoundation`은 여러 미디어 데이터를 순차적으로 재생하는 `AVQueuePlayer` 클래스를 제공합니다.

<br>

## Topics
---

<br>

### Creating a Player

```swift
// url 기반의 참조를 통해 단일 시청각 미디어를 실행하기 위한 player를 생성합니다.
init(url: URL)

// 특정 플레이어의 항목(미디어)을 재생하기 위한 새로운 플레이어를 생성합니다.
init(playerItem: AVPlayerItem?)
```

<br>

### Managing Playback

```swift

// 현재 항목(미디어)을 재생을 진행합니다.
func play()

// 현재 항목을 잠시 멈춥니다.
func pause()

// 현재 실행중인 항목의 재생속도를 설정합니다.
var rate: Float

// 현재 플레이어의 항목이 끝날때 실행할 액션을 설정하는 변수이며 AVPlayer.ActionItemEnd 타입입니다.
var actionAtItemEnd: AVPlayer.ActionItemEnd

// 플레이어 항목이 끝날떄 실행할 액션을 열거합니다.
enum AVPlayer.ActionAtItemEnd {
    case advance    // 플레이어의 다음 항목이 있을 경우 다음 항목을 진행합니다.
    case pause      // 플레이어의 동작을 멈춥니다.
    case none       // 아무 동작도 진행하지 않습니다.
}

// 현재 플레이어의 항목을 다른 항목으로 대체합니다.
func replaceCurrentItem(with: AVPlayerItem?)

// 비디오 재생이 기기의 슬립 모드를 방지할지 여부를 설정하는 변수입니다.
var preventDisplaySleepDuringVideoPlayback: Bool
```

<br>

### Managing Time

```swift

// 현재 플레이어 항목의 현재 시간을 반환합니다.
func currentTime() -> CMTime

// 현재 플레이어 항목의 시간을 지정 시간으로 설정합니다.
func seek(to: CMTime)

// 현재 플레이어 항목의 시간을 지정 시간으로 변경한 뒤 지정 블록을 실행합니다.
func seek(to: CMTime, completionHandler: (Bool) -> Void)
```

<br>

### Observing Time

```swift

// 재생 중 주어진 블록을 주기적 호출을 요청하면서 변경 시간을 보고합니다.
func addPeriodicTimeObserver(forInterval: CMTime, queue: DispatchQueue?, using: (CMTime) -> Void) -> Any

// 재생 중 지정된 시간을 순회할 때 블록 호출을 요청합니다.
func addBoundaryTimeObserver(forTimes: [NSValue], queue: DispatchQueue?, using: () -> Void) -> Any

// 이전에 저장되어있던 옵저버를 제거합니다.
func removeTimeObserver(Any)
```

<br>

### Synchronizing Playback to an External Source

```swift

// 현재 항목의 재생속도와 시간을 외부 소스와 동기화합니다.
func setRate(Float, time: CMTime, atHostTIme: CMTime)

// 미디어를 가져오는 동안 미디어 파이프라인을 준비합니다.
func preroll(atRate: Float, completionHandler: ((Bool) -> Void)?)
```

### Managing Audio Output

```swift

// 플레이어의 오디오 출력 음소거 여부를 지정합니다.
var isMuted: Bool

// 플레이어의 음량 크기를 조절합니다.
var volume: Float
```

<br>

## Reference
---

- [developer.apple.com - AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer)
