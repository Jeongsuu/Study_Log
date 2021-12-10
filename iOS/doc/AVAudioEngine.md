# AVAudioEngine

<br>

`AVAudioEngine` 객체는 오디오 노드들의 그래프를 관리하며, 오디오 재생을 제어하고, 실시간 렌더링 제약사항들을 수정할 수 있도록 도와줍니다.

<br>

## Declaration
---

```swift
class AVAudioEngine: NSObject
```

<br>

## Overview
---

오디오 엔진객체는 `AVAudioNode` 인스턴스들의 그룹으로 이 노드들을 체이닝하여 로직을 수행합니다.

![image](https://user-images.githubusercontent.com/33051018/145584487-bb83e7d1-3b5c-45bb-9e0f-e8f76f3b72f5.png)

소스 파일을 playerNode로 부터 받아온 이후 mixerNode를 통해 믹싱을 진행한 이후 결과적으로 OutputNode로 빼냅니다.

물론 약간의 제한은 있으나 실시간 런타임동안 해당 오디오 노드들을 연결하거나 연결을 해제하거나 제거할 수 있습니다.

기본적으로 오디오 엔진은 디바이스에 연결되어 있는 오디오를 실시간으로 렌더링합니다.

<br>

## 오디오 파일 실행을 위한 엔진 생성
---

오디오 파일을 실행하기 위해서는 `AVAudioFile` 객체를 생성해야 합니다.

이후 PlayerNode 객체를 생성하여 이를 엔진 객체의 playerNode 타입에 연결하여 사용합니다.

이후 최종적으로 playerNode를 오디오 엔진의 outputNode 객체에 연결하면 playerNode를 통해 흐르는 오디오 데이터가 outputNode로 전달되어 최종적으로 엔진에 의해 수행됩니다.

아래 예시 코드를 살펴보도록 할게요.

```swift
let audioFile = // AVAudioFile
let audioEnigine = AVAudioEngine()
let playerNode = AVAudioPlayerNode()

// Attach the player node to the audioEngine.
audioEngine.attach(playerNode)

// Connect the player node to the output node.
audioEngine.connect(playerNode, to: audioEngine.outputNode, format: audioFile.processingFormat)
```

이후에는 오디오 파일 재생을 위한 스케줄을 진행합니다. 

콜백을 통해 재생이 완료되는 시점을 핸들링 할 수 있습니다.

```swift
playerNode.scheduleFile(audilFile, at: nil, completionCallbackType: .dataPlayedBack) { _ in 
// Handle any work that's necessary after playback.
}
```

audioFile을 준비하고 playerNode를 생성하여 outputNode로 연결을 완료하였습니다.

이제 엔진을 실행할 준비가 모두 되었으니 엔진을 실행해보겠습니다.

노드를 실행해주기 이전에 엔진을 실행해줍니다.

```swift
do {
    try audioEngine.start()
    playerNode.play()
} catch {
    /* Handle the error. */
}
```

작업이 끝나면 역순으로 노드와 엔진을 순차적으로 해제합니다.

```swift
playerNode.stop()
audioEngine.stop()
```

<br>

## Topcis
---

### Creating an Audio Enigne

- `init()`
    - 실시간 렌더링을 위한 오디오 엔진 객체를 생성합니다.

<br>

### Attaching and Detaching Audio Nodes

- `func attach(AVAudioNode)`
    - 오디오 엔진에 오디오 노드를 연결합니다.
- `func detach(AVAudioNode)`
    - 오디오 엔진에 연결된 오디오 노드를 제거합니다.

- `var attachedNodes: Set<AVAudioNode>`
    - read-only 타입의 오디오 엔진에 연결된 노드들의 집합을 반환합니다.

<br>

### Getting the Input, Output, and Main Mixer Nodes

- `var inputNode: AVAudioInputNode`
    - 오디오 엔진의 인풋 오디오 노드로 싱글톤 객체입니다.
- `var outputNode: AVAudioOutputNode`
    - 오디오 엔진의 아웃풋 오디오 노드로 싱글톤 객체입니다.
- `var mainMixerNode: AVAudioMixerNode`
    - 오디오 엔진의 메인 믹서 노드로 옵셔널 싱글톤 객체입니다.

<br>

### Connecting and DisConnecting Audio Nodes

- `func connect(AVAudioNode, to: AVAudioNode, format: AVAudioFormat?)`
    - 두 노드간의 연결을 진행합니다.
- `func connect(AVAudioNode, to: AVAudioNode, fromBus: AVAudioNodeBus, toBus: AVAudioNodeBus, format: AVAudioFormat?)`
    - 입력과 출력에 대한 버스를 명시하여 두 노드간의 연결을 진행합니다.
- `func disconnectNodeInput(AVAudioInput)`
    - 노드의 입력과 관련된 연결을 모두 제거합니다.
- `func disconnectNodeInput(AVAudioNode, bus: AVAudioNodeBus)`
    - 노드의 특정 버스에 연관된 입력 연결을 제거합니다.
- `func discconnectNodeOutput(AVAudioNode)`
    - 노드의 출력과 관련된 연결을 모두 제거합니다.
- `func disconnectNodeOutput(AVAudioNode, bus: AVAudioNodeBus)`
    - 노드의 특정 버스에 연관된 출력 연결을 제거합니다.

<br>

### Playing Audio

- `func prepare()`
    - 오디오 엔진 시작을 위한 준비를 진행합니다.
- `func start()`
    - 오디오 엔진을 실행합니다.
- `var isRunning: Bool`
    - 오디오 엔진의 현재 실행 여부를 반환합니다.
- `func pause()`
    - 오디오 엔진 실행을 일시정지합니다.
- `func stop()`
    - 오디오 엔진 실행을 중지하고 이전에 준비했던 모든 리소스를 해제합니다.
- `func reset()`    
    - 오디오 엔진 내 연결된 모든 노드들을 리셋합니다.

<br>

### Notifications

- `static let AVAudioEngineConfigurationChange: NSNotification.Name`
    - 오디오 엔진 설정의 변화가 발생할 경우 노티피케이션을 발송합니다.
