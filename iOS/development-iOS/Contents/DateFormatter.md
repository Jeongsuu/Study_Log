## DateFormatter
---
---

이번에는 `DateFormatter`에 대해 공부하며 이를 활용하여 원하는 포맷으로 날짜를 출력해본다.

![image](https://user-images.githubusercontent.com/33051018/78635634-a4700180-78e1-11ea-92e5-71b6431a0c5e.png)

현재 날짜는 위와같이 출력되고 있다.

개발자의 입장에서는 어느정도 친숙한 포맷이지만, 일반 사용자 입장에서는 그닥 친화적인 디자인은 아니다.

따라서, UX를 고려한 포맷으로 변경해보자.

날짜를 원하는 포맷으로 출력할때는 `DateFormatter` 를 사용한다.

공식 문서를 참고해보도록 한다.

공식 문서 내용은 아래 링크를 클릭하면 살펴볼 수 있다.

[DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)


![image](https://user-images.githubusercontent.com/33051018/78635972-4ee82480-78e2-11ea-810e-4284a15e61a3.png)


`DateFormatter` 클래스에 대해 간략하게 살펴보자.

`DateFormatter`는 날짜와 텍스트값 표현간 변화를 도와주는 포매터라고 한다.

원형은 아래와 같다.

`class DateFormatter : Formatter`

내용을 살펴보면 `User-Visible` 한 날짜와 시간의 포맷을 변경할 수 있다고 한다.

`date` 를 `string` 으로, `string` 을 `date` 포맷으로도 상호변경이 가능하다고 한다.

타 내용은 각자 살펴보도록 하고 지금 우리에게 필요한 것은 날짜와 시간에 대한 이쁜 포맷이다.

`DateFormatter` 공식문서에서 `Topic` 을 기준으로 살펴보다 보면
![image](https://user-images.githubusercontent.com/33051018/78636321-1432bc00-78e3-11ea-8a96-c3ed46e3e36f.png)

위와 같이 `Managing Formats and Styles` 라는 `Topic` 을 살펴볼 수 있다.

주제명이 뭔가 우리가 원하는 딱 그것을 의미하는것 같다..!!

내용을 상세히 살펴본다.

```swift

var dateStyle: DateFormatter.Style

// The date style of the receiver.

var timeStyle: DateFormatter.Style

// The time style of the receiver.
```

우리는 위 두개만 있으면 된다.

메모 내용에서 포맷을 바꾸기 위한 TableViewController 를 작성한다.

```swift
class MemoListTableViewController: UITableViewController {

    // 클로저를 활용하여 DateFormatter 인스턴스를 초기화한다.
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        
        return f

    }
}()
```

formatter 인스턴스를 만들고 하나하나 초기화하는것 보다 생성과 동시에 여러개의 프로퍼티를 초기화 할 때 클로저를 이용하면 매우 편리하다!

위 내용은, `formatter` 라는 인스턴스를 만드는데 클로저 내부에서 `f`라는 객체를 생성하고 해당 객체의 인스턴스들을 초기화 한 뒤 이를 반환하여 `formatter`값으로 초기화한다는 의미이다.

간단한 예시로 `tableView`에서 이를 확인해보도록 한다.

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let target = Memo.dummyMemoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)
//        cell.detailTextLabel?.text = target.insertDate.description
        
        return cell
    }
```

주석 부분이 기존코드이며 그 위 부분이 `formatter`를 이용해 `string` 메서드로 날짜값을 변환한 뒤 해당 값을 스트링으로 받아오도록 했다.

![image](https://user-images.githubusercontent.com/33051018/78636938-53154180-78e4-11ea-86ca-0b597f762655.png)

훨씬 친숙한 디자인으로 변경되었다!

DateFormatter 인스턴스 생성자를 수정하면 한글로도 출력이 가능하다!
```swift
class MemoListTableViewController: UITableViewController {

    // 클로저를 활용하여 DateFormatter 인스턴스를 초기화한다.
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifer: "Ko_KR"))
        return f

    }
}()

```

![image](https://user-images.githubusercontent.com/33051018/78637009-79d37800-78e4-11ea-8389-fb7959f22f74.png)

