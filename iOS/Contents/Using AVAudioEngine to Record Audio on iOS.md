# Using AVAudioEngine to Record Audio on iOS

<br>

`AVAudioEngine` 은 2014년부터 제공된 클래스입니다.

이를 통해 오디오 데이터 처리(프로세싱)에 대한 파이프라인을 구성할수 있게 되었으며 이번 문서에서는 `AVAudioEngine` 을 이용하여 어떻게 오디오를 녹음하고 압축하고 스트리밍하는지 알아보도록 하겠습니다.

<br>

## AVAudioEngine Basics
---

오디오 파이프라인은 `AVAudioEngine` 클래스를 사용하여 빌드하며 `AVAudioNode`를 엔진에 연결하는 방식으로 구성합니다.

오디오 데이터는 "노드 -> 노드" 방향으로 흐르며 각 노드들에서 담당하는 로직을 수행하며 파이프라인이 진행됩니다.

모든 프로세싱이 끝난 오디오 데이터는 최종적으로 `outputNode` 에 도착하게 되며 이를 통해 스피커로 출력시킬수 있습니다.

가장 중요한 사실은 이 모든것을 실시간으로 처리할 수 있다는 점 입니다.

위 내용을 보니 오디오 데이터를 실질적으로 처리하는 역할을 `AVAudioNode` 가 담당한다는 것을 알 수 있습니다.

다양한 프로세싱을 위해 애플은 여러가지의 Node를 제공하며 이에 대해 간단히 살펴보도록 하겠습니다.


### A variety of types of nodes

- `AVAudioInputNode`: InputNode는 이름 그대로 오디오의 인력(ex: 기기의 마이크)을 담당하며 캡쳐한 오디오 데이터를 다른 노드로 전달하는 역할입니다.

- `AVAudioUnit`:  AudioUnit은 입력 오디오를 처리하고 속도, 피치, 반향 등 다양한 효과를 실시간으로 적용하는 데 사용됩니다. 해당 클래스를 서브클래싱 하는 다양한 클래스가 존재하며 각각의 클래스가 각각의 효과를 담당하게 됩니다.

- `AVAudioMixerNode`: MixerNode는 이름 그대로 믹싱을 진행합니다. 따라서 입력을 여러 노드로부터 받을 수 있으며 이들을 믹싱한 이후 단일 출력으로 전달합니다. 예를 들어 AVAudioUnit을 통해 여러 효과가 적용된 여러 입력 노드들을 MixerNode를 통해 믹싱하여 다음 파이프라인으로 전달할 수 있습니다.

- `AVAudioOutputNode`: OuputNode는 이름 그대로 오디오의 출력을 담당합니다. (ex: 기기의 스피커)


![image](https://user-images.githubusercontent.com/33051018/145673928-7b7e16ed-092e-481f-8606-82ed21f6164d.png)

**기본적으로 `AVAudioEngine` 인스턴스는 각각 하나의 inputNode, mixerNode(aka mainMixerNode)와 outputNode를 가집니다.**

기본적으로는 위와 같이 구성되며 필요에 따라 추가할 수 있습니다.

<br>

## Using AVAudioEngine for recording
---

AVAudioEngine을 통해 녹음을 어떻게 하는지 알아보기 위해 해당 기능들을 캡슐화한 Recorder 클래스를 만들어볼게요.

```swift
import Foundation
import AVFoundation

class Recorder {

    enum RecordingState {
        case recording
        case paused
        case stopped
    }

    private var engine: AVAudioEngine!
    private var mixerNode: AVAudioMixerNode!
    private var state: RecordingState = .stopped

    init() {
        setupSession()
        setupEngine()
    }
}
```

`Recorder` 클래스는 `AVAudioEngine` 인스턴스에 대한 레퍼런스를 가집니다. (init 중에 해당 인스턴스가 생성될 거에요!)

또한 `mixerNode` 에 대한 레퍼러스를 가지고 현재 Recorder 의 상태를 정의하기 위한 Enum 또한 하나 만들어줍니다.

Recorder 클래스를 생성할때 `setupSesison` 과 `setupEngine` 을 호출하게 됩니다.

각각의 함수들의 역할에 대해 알아보도록 할게요.

```swift
    /// 오디오세션을 셋업합니다.
    fileprivate func setupSession() {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.record)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("[ERROR] \(#function) - \(error.localizedDescription)")
        }
    }
```

`setupSession` 메소드는 이름 그대로 오디오 세션을 설정합니다.

(엔진의 실행을 위해서는 세션 활성화가 전제조건 입니다.)

`AVAudioSession` 싱글톤 인스턴스를 참조하여 `category = .record` 로 설정하여 애플리케이션이 오디오 녹음을 가능토록 설정해줍니다. 만일 오디오 재생도 함께 필요하다면 `cateogry = .playAndRecord` 로 설정합니다.

이후 session을 활성화 합니다.

```swift
    /// 오디오엔진을 셋업합니다.
    fileprivate func setupEngine() {
        // 오디오 엔진과 커스텀 Mixer Node를 생성합니다.
        engine = AVAudioEngine()
        mixerNode = AVAudioMixerNode()

        // 레코딩 준비를 위하여 볼륨을 0으로 변경합니다.
        mixerNode.volume = 0

        // MixerNode를 engine에 연결합니다.
        engine.attach(mixerNode)

        makeConnection()

        engine.prepare()
    }

    /// 노드를 엔진에 연결합니다.
    fileprivate func makeConnection() {
        let inputNode = engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        engine.connect(inputNode, to: mixerNode, format: inputFormat)

        let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatInt32, sampleRate: inputFormat.sampleRate,
                                        channels: 1, interleaved: false)
        engine.connect(mixerNode, to: engine.mainMixerNode, format: mixerFormat)
    }
```

AudioSession을 준비했으니 AudioEngine을 준비합니다.

앞서 얘기하였듯 AudioEngine은 해당 클래스의 인스턴스와 노드들을 기반으로 구성합니다.

위 코드는 아래와 같은 동작을 합니다.

- `setupEngine` 메소드 내부에서 오디오 엔진과 커스텀 MixerNode를 생성합니다.
- 생성한 커스텀 MixerNode를 engine에 연결합니다.
- 이후 `makeConnection` 메소드 내부에서 엔진의 inputNode를 우리의 커스텀 MixerNode로, 커스텀 MixerNode를 엔진의 mainMixerNode로 파이프라인을 구성합니다.

위 코드로 생성한 파이프라인을 그림으로 표현해보면 아래와 같습니다.

![image](https://user-images.githubusercontent.com/33051018/145674531-57528855-a713-4770-8ad5-e7d850d17df3.png)

- 최종적으로 엔진 prepare를 실행하여 시스템이 필요한 리소스를 할당할 수 있도록 합니다.

노드를 연결할때 오디오의 포맷을 명시해주는것을 확인할 수 있는데요, PCM 오디오 포맷을 준수해야 합니다.(그 이유는 추후에 알아보도록 할게요)

AudioNode의 포맷은 소스 노드의 출력 오디오 포맷을 의미합니다.

만일 입력 포맷이 `nil` 인 경우, 소스 노드의 출력 포맷과 동일하게 설정됩니다.

<br>

## Capturing Audio
---

오디오 세션과 오디오 엔진의 준비가 완료되었다면 이제는 녹음을 할 준비가 모두 완료된 것 입니다.

이제 녹음 기능을 제공하는 메소드를 작성해볼게요.

```swift
    /// 녹음을 실행합니다.
    fileprivate func startRecording() throws {
        let tapNode: AVAudioNode = mixerNode
        let format = tapNode.outputFormat(forBus: 0)

        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let file = try AVAudioFile(forWriting: documentURL.appendingPathComponent("recording.caf"), settings: format.settings)

        tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: { (buffer, time) in
            try? file.write(from: buffer)
        })

        // 엔진을 실행합니다.
        try engine.start()

        state = .recording
    }
```

오디오 엔진의 핵심 특징은 오디오 데이터를 실시간으로 탭하여 캡쳐할 수 있다는 의미입니다.

**오디오 데이터는 그래프를 관통하며 흐를것이며 우리는 위 `installTap` 을 통해 해당 스트림에 접근할 수 있습니다.**

위에 작성한 `startRecording` 메소드가 실행되면 어떠한 일이 일어나는지 살펴볼게요.

- 커스텀으로 생성한 MixerNode를 탭하여 얻어낸 `block` 클로저 내부에서 오디오 버퍼에 대한 접근을 얻어냅니다.
- MixerNode를 지나는 buffer를 캡처하여 이를 file에 write합니다.
- 엔진을 실행하여 리소스를 할당하고 input/output 노드들을 오디오 입출력에 연결합니다.

<br>

## Pausing/Resuming Audio
---

오디오 일시정지와 재생은 매우 간단합니다.

제공하는 API가 매우 직관적이기 떄문에 별도 설명이 필요 없을것입니다.

```swift
    fileprivate func resumeRecording() throws {
        try engine.start()
        state = .recording
    }

    fileprivate func pauseRecording() {
        engine.pause()
        state = .paused
    }

    fileprivate func stopRecording() {
        // 기존에 탭했던 노드를 제거합니다.
        mixerNode.removeTap(onBus: 0)

        engine.stop()
        state = .stopped
    }
```

<br>

## Interruptions
---

앱을 통한 녹음이 항상 보장되지는 않습니다. 즉 마이크에 대한 접근이 항상 보장되지는 않는다는 의미이며

마이크에 대한 접근 우선순위가 높은 작업(ex: 전화)이 들어온다면 마이크의 제어권을 뺏길수 있습니다.

이러한 인터럽션이 발생하고 끝났을때 기존 녹음을 원활하게 작업하기 위해 적절한 예외 처리가 필요합니다.

이는 AVAudioSession.Notification으로 전달되며 아래와 같이 코드를 작성하여 처리할 수 있습니다.

```swift
fileprivate func registerForNotification() {
        NotificationCenter.default.addObserver(forName: AVAudioSession.interruptionNotification,
                                               object: nil,
                                               queue: nil, using: { [weak self] notification in
            guard let self = self else {
                return
            }

            // 어떠한 종류의 인터렵션이 발생했는지 확인합니다.
            let userInfo = notification.userInfo
            let interruptionTypeValue = userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt ?? 0
            let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeValue)!

            switch interruptionType {
            case .began:
                // 인터럽션이 감지된 경우
                self.isInterrupted = true

                if self.state == .recording {
                    // 녹음을 중지합니다.
                    self.pauseRecording()
                }
            case .ended:
                // 인터럽션이 끝난 경우
                self.isInterrupted = false

                try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

                self.handleConfigurationChange()

                if self.state == .paused {
                    // 녹음을 재개합니다.
                    try? self.resumeRecording()
                }
            @unknown default:
                break
            }
        })
    }
```

해당 메소드는 Notification을 observing 할 수 있도록 합니다.

notification이 들어오면 userInfo를 기반으로 어떠한 인터럽션이 발생했는지 확인한 이후 해당 인터럽션의 케이스에 대한 분기를 진행합니다.

인터럽션이 발생한 경우라면 녹음을 중지하고 인터럽션이 끝난 경우라면 녹음을 재개합니다.

인터럽션이 끝난 경우에는 오디오 세션을 다시 활성화 한 이후에 녹음을 재개해야 합니다.

<br>

## Configuration Changes
---

하드웨어 설정에 대한 변경이 발생하면(ex: 외부 마이크가 연결되거나 해제되거나) `AVAudioEngineConfigurationChange` Notification이 전달됩니다.

우리는 해당 Notification을 관찰하고 있다가 이에 대해서도 적절한 처리를 진행해줘야 합니다.

```swift
NotificationCenter.default.addObserver(forName: Notification.Name.AVAudioEngineConfigurationChange,
                                               object: nil,
                                               queue: nil, using: { [weak self] notification in
            guard let self = self else {
                return
            }

            // 설정 변경이 대기중임을 의미합니다.
            self.confingChangePending = true

            if !self.isInterrupted {
                self.handleConfigurationChange()
            } else {
                print("defering changes")
            }
        })
    }

    fileprivate func handleConfigurationChange() {
        if confingChangePending {
            // 연결을 재시도합니다.
            makeConnection()
        }

        confingChangePending = false
    }
```

하드웨어 설정이 변경되었다면 인터럽션 여부를 확인한 이후에 설정 변경을 적용해줍니다.