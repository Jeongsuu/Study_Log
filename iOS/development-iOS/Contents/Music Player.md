## Music Player
---

이번 문서에서는 부스트코스에서 진행한 1차 강의 '음원 재생기 애플리케이션'을 총 복습하며 내용을 정리한다.

**핵심 키워드**
- `Interface Builder`
- `UIButton`
- `UISlider`
- `UILabel`
- `UIKit`

---

### Interface Builder

인터페이스 빌더는 이름 그대로 사용자와 어플리케이션이 접촉하는 인터페이스를 구성하기 위해 도와주는 도구를 의미한다.

인터페이스 빌더의 `Object Library` 에는 아이폰 또는 애플 앱에서 자주 살펴볼 수 있었던 컴포넌트들이 아래와 같이 존재한다.

 ![image](https://user-images.githubusercontent.com/33051018/78882697-661a4400-7a93-11ea-9790-01114888e22a.png)

위 컴포넌트들을 이용해 `scene` 을 구성할 수 있으며 각각의 객체들에 접근 또한 가능하며 기능도 정의할 수 있다.

이를 위해서는 `IBOutlet` 과 `IBAction`에 대하여 알아야한다.
두 단어의 앞에는 `IB` 라는 단어가 공통적으로 붙는다.

눈치가 빠른분들은 바로 알아차렸겠지만 `IB`는 `Interface Builder`를 의미한다.

앞에 붙는 `@`는 컴파일러에게 어떠한 속성을 가지고 있다는 전달하는 역할을 하는 예약어이다.

이 둘의 공통된 핵심 역할은 `Storyboard`와의 연결고리 기능을 한다.

- `IBOutlet` : 인터페이스 빌더의 인스턴스 값에 접근하기 위한 변수
- `IBAction` : 이벤트가 일어날 경우 호출되는 Action을 정의
<br>
---
<br>

### UIKit
---

`UIKit`은 이름 그대로 `UI` 구성을 위한 도구들의 모음집이다.

**cf) [UIKit](https://developer.apple.com/documentation/uikit)**


`UIKit` 은 일종의 프레임워크로서 iOS 앱들을 위한 그래픽 기반의 이벤트 중심 인터페이스를 구성하고 관리하도록 돕는다.

공식문서의 요약내요을 살펴보자.

`UIkit` 프레임워크는 iOS 앱에 필요한 인프라를 제공한다. 이는 인터페이스를 구현하기 위한 뷰 구조 또는 창 등을 제공한다.

`UIKit`에는 `UIButton`, `UISwitch`, `UIStepper` 등 `UIControl`을 상속받은 다양한 클래스가 존재한다.

이러한 컨트롤 객체에 발생한 다양한 이벤트 종류를 특정 액션 메서드에 연결할 수 있다.

이를 통해 컨트롤 객체에서 특정 이벤트가 발생하면, 미리 지정해 둔 타겟의 액션을 호출할 수 있다. 

**cf) [Target-Action](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Target-Action/Target-Action.html)**

이번 강의에서는 `UIButton` 과 `UISlider`, 그리고 `UILabel` 클래스가 사용되었다. 

하나하나 차례대로 상세히 알아보도록 하자.

첫번째로 `UIButton`이다.

**cf) [UIButton](https://developer.apple.com/documentation/uikit/uibutton)**

`UIButton` 클래스는 유저와의 상호작용을 할 때 개발자가 작성한 코드를 실행할 수 있도록 제어하는 역할을 제공한다.

선언은 아래와 같이 하며 사용방법에 대하여 살펴본다.


`class UIButton : UIControl`

1. 버튼의 타입을 지정한다.
2. 타이틀을 지정하고 컨텐츠에 적절하게 크기등을 조절한다.
3. 하나 또는 그 이상의 액션 메서드를 버튼에 연결한다.

버튼은 사용자가 버튼을 탭했을때 나의 앱에게 이를 알려주기 위해 `Target - Action` 디자인 패턴을 이용한다.

터치 이벤트를 직접 처리하기 보단 버튼에 액션 메서드를 할당하고 메서드 호출을 트리거하는 이벤트를 지정하여 사용한다.

버튼을 액션 메서드에 연결하기 위해서는 `addTarget(_:action:for:)` 메서드를 이용하거나 인터페이스 빌더에서 연결한다.

`Button` 클래스는 안쓰이는 앱을 찾기 힘들정도로 매우 많이 쓰이니 꼭 꼭 공식문서를 살펴보며 공부를 하는것이 좋은것 같다.


두번째로 `UISlider` 에 대하여 알아본다.

**cf) [UISlider](https://developer.apple.com/documentation/uikit/uislider)**

`UISlider` 클래스는 볼륨 바 , 또는 progress 바 등과 같이 연속적인 값 범위 내에서 단일 값을 선택하는데 이용되는 컨트롤러다.

선언은 아래와 같이 한다.

`class UISlider: UIControl`


![image](https://user-images.githubusercontent.com/33051018/78885223-2fdec380-7a97-11ea-9926-ca681159264b.png)

예를들어 슬라이더의 `Thumb`를 움직이면 업데이트된 값을 연결한 `Action`에 전달한다.

사용법은 아래와 같다.

1. `slider`에서 제공할 값의 범위를 지정한다.
2. 하나 또는 그 이상의 액션 메서드를 슬라이더에 연결한다.

`UISlider` 또한 `UIButton` 과 같이 `Target-Action` 패턴을 이용하여 슬라이더 내 값이 변경되었을때 앱에게 이를 알린다.

슬라이더의 값이 변경되었음을 앱에 알리기 위해선 액션 메서드에 `valueChanged` 프로퍼티를 이용해야한다.

**cf) [valueChanged](https://developer.apple.com/documentation/uikit/uicontrol/event/1618238-valuechanged)**

액션 메서드에 이를 연결할때는 `Target - Action` 패턴에 따라 `addTarget()` 메서드를 이용하거나 인터페이스 빌더(@IBAction)를 이용한다.

세번째로 `UILabel`에 대해 살펴본다.

**cf) [UILabel](https://developer.apple.com/documentation/uikit/uilabel)**

`UILabel`은 정보를 하나 이상의 행을 통해 표시하도록 하는 클래스다.

원형은 아래와 같다!

```swift
class UILabel : UIview
```

우리는 레이블 내 `text` 값을 수정하거나 특성을 수정해 커스텀이 가능하다.

인터페이스 내에서 `label` 을 사용하는 방법은 아래와 같다.

자 이제 프로젝트에서 사용된 인터페이스 빌더의 인스턴스들에 대해서는 모두 설명하였다.

이제 코드를 살펴보도록 한다.

![image](https://user-images.githubusercontent.com/33051018/78886833-ce6c2400-7a99-11ea-924a-a36e0099274b.png)

참고로 필자가 구성한 인터페이스 빌더는 위 그림과 같다.

`initial view`를 살펴보면 `UIButton`을 화면 중앙에 배치하고 버튼 클릭시 다음화면으로 넘어가도록 구성하였다.

```swift
//
//  MusicPlayer
//

import UIKit
import AVFoundation                                                     // for AVAudioPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate {         // AVAudioPlayerDelegate 프로토콜 채택
    
    // MARK:- Properties
    var player: AVAudioPlayer!                                          // AVAudioPlayer 인스턴스 생성
    var timer: Timer!                                                   // Timer 인스턴스 생성
    
    // MARK: IBOutlets
    @IBOutlet var playPauseButton: UIButton!                            // reference를 위한 IBOutelt 변수 선언
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    
    // MARK: - Methods
    // MARK: Custom Method
    func initializePlayer() {                                           // 플레이어 초기화 메서드
            
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "Jasmine")    // guard문의 조건이 참일 경우 pass
            else {
                print("음원 파일 에셋을 가져올 수 없습니다.")
                return
        }
        
        do {                                                                // 예외사항 처리를 위해 do~catch & try 문 이용
            try self.player = AVAudioPlayer(data: soundAsset.data)          // AVAudioPlayer 인스턴스 생성
            self.player.delegate = self                                     // AVAUdioPlayer의 델리게이트 는 ViewController
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지: \(error.localizedDescription)")
        }
        
        self.progressSlider.minimumValue = 0                                // UISlider 최소값 초기화
        self.progressSlider.maximumValue = Float(self.player.duration)      // UISlider 최대값을 player의 프로퍼티 duration으로 초기화
        self.progressSlider.value = Float(self.player.currentTime)          // UISlider의 값을 player의 프로퍼티 currentTime으로 초기화
        
    }
    
    func updateTimeLabelText(time: TimeInterval) {                          //레이블 업데이트 메서드
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld : %02ld : %02ld ", minute, second, milisecond)     // 지정 포맷에 따라 시간 출력
        
        self.timeLabel.text = timeText
    }
    
    //타이머를 만들고 수행할 메서드
    func makeAndFireTimer() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer:Timer) in
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        
        self.timer.fire()
    }
    
    
    func invalidateTimer() {        // 타이머를 해제해 줄 메서드
        self.timer.invalidate()     // 타이머 기능 정지
        self.timer = nil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializePlayer()             // 플레이어 초기화 메서드 실행
    }
//                                            어떤 인스턴스가 이 메서드를 호출했는지
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        // 누르면 재생 시작
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player?.play()
        } else {
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.makeAndFireTimer()
        }
        
        print("button tapped")
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
        print("slider value changed")
    }
    
    // MARK: AVAudioPlayerDelegate
    // Responding to an Audio Decoding Error
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error: Error = error else {                                   // guard 조건이 참이면 그냥 치나가고, 틀리면 else문 진행
            print("오디오 플레이어 디코드 에러 발생")
            return
        }
        // let error:Error = error 일 경우 진행
        let message: String = "오디오 플레이어 에러 발생 \(error.localizedDescription)"
        
        // Creating an Alert Controller
        // alert을 발생시키기 위해 UIAlertController 클래스의 인스턴스를 alert 이라는 이름으로 생성한다.
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // An Action that can be taken when the user taps a button in an alert.
        // 유저가 띄워진 경고창에서 버튼을 클릭했을때의 액션을 위함
        // Creating an Alert Action
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in                   //closure 사용
            
            // UIViewController.dismiss(animated: Bool, completion: ( () -> Void)?)
            // Dismisses the view controller that was presented modally by the view controller.
            self.dismiss(animated: true, completion: nil)       // oK버튼 클릭시 경고창 내리기.
        }
        
        // UIAlertController.addAction(UIAlertAction)
        // Attaches an action objejct to the alert or action sheet.
        
        alert.addAction(okAction)                               // Action 더하기
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // Responding to Sound Playback Completion
    // func audioPlayDidFinishPlaying(AVAudioPlayer, successfully: Bool)
    // Called when a sound has finished playing. -> 노래가 끝나면 호출되는 함수.
    
    //MARK:- audioPlayerDidFinishisPlaying
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }
    
}

```

