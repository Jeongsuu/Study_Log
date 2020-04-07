## Target-Action Pattern
---

`Target-Action` 패턴은 `iOS` 환경에서 `delegate` 패턴만큼이나 자주 사용하는 패턴 중 하나다.

`Target-Action` 패턴에서 `Target`은 `Action`이 호출될 객체를 의미한다.

`Action`은 특정 이벤트가 발생했을 때 호출할 메서드를 의미한다.

즉, 한 객체를 `Target`에 연결해두고, 지정 `Event` 가 발생하면 타겟이 특정한 액션을 취한다.

지정 객체에서 어떤 `EVENT`가 발생했을 때, 누가 무엇을 수행할지 ( 무엇을 타겟으로 하며 어떠한 액션을 취할지 )
를 미리 등록해두면 해당 `Event`가 발생할 때 마다 타겟에게 메시지를 전달해서 액션을 취하게 하는 방법이다.

간단한 예시를 살펴보자.
```swift
self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
```

`addTarget` 메서드의 파라미터를 살펴보자.

self : 액션이 호출될 객체 ( 주로 컨트롤러 )

action : 수행할 행동

for : 이 이벤트가 발생하면


![image](https://user-images.githubusercontent.com/33051018/78669356-19a9f980-7917-11ea-9884-f976ae845d8b.png)

위 그림처럼 씬에 `DatePicker` 하나와 `Label`을 하나 배치한다.

이후, `DatePicker`에서 값이 변경될 때 마다 `Label` 을 관리하는 `ViewController`에게 메시지를 보내 `Label`을 업데이트 하도록 메시지를 보내는 코드를 작성해본다.

```swift
class NewViewController: UIViewController {

    // IB Reference variable initialize
    @IBOutlet weak var datePicker: UIDatePicker!        // self.datePicker
    @IBOutlet weak var dateLabel: UILabel!              // self.dateLabel

    // dateFormatter 인스턴스 생성
    let dateFormatter: DateFormatter = {                // self.dateFormatter
        let f: DateFormatter = DateFormatter()          // 인스턴스 생성
        f.dateStyle = .medium                           // 인스턴스 프로퍼티 초기화
        return f                                        // 인스턴스 반환
    }()

    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = self.datePicker.date           // 레퍼런스 변수 datePicker의 프로퍼티 date값을 가져온다.
        let dateString: String = self.dateFormatter.string(from: date)
        dateLabel.text = dateString
    }


    // 뷰가 출력된 이후 한번 호출되는 메서드
    // 주로 초기화 내용을 이 부분에 기재한다.
    override func viewDidLoad() {
        super.viewDidLoad()

        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)

        // datePicker 인스턴스에 타겟을 더한다.
        // UIControl.Event.valueChagned 가 발생하면 didDatePickerValueChanged 메서드를 ViewController에 실행시킨다.

    }

}
```

![image](https://user-images.githubusercontent.com/33051018/78673068-91c6ee00-791c-11ea-98e5-21fb680f6aed.png)

액션이 실행될 객체(Target)를 `Target`으로 지정하면 액션(Action) 메서드를 실행할 객체를 상황에 따라 직접 지정할 수 있다.
