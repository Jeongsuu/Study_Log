# 면접 내용 정리

<br>

## **UI 업데이트를 반드시 mainQueue 에서 진행해야 하는 이유**
---

`Cocoa Touch` 앱에서 `UIApplication의 인스턴스` 가 메인 스레드에서 작동하기 때문이다.

`UIApplication` 은 앱을 시작할 때 인스턴스화 되는 앱의 첫번째 부분이다.

앱의 main event loop는 touch, gesture 등의 모든 UI event를 수신한다.

**즉, `UI` 와 관련된 모든 event가 main thread에 attach 하기 때문에, 반드시 main에서 해야하는 것이다.**


<br>

## **스토리보드 vs 코드 기반 UI의 차이**
---

애플은 스토리보드 사용을 권장한다. 아마 미래에는 스토리보드 기반의 UI작성이 표준이 될 것으로 예상된다.

그러나 스토리보드를 사용하여 UI 작업을 진행하는 것은 몇몇 단점이 존재한다.

각각의 방법에 대하여 장점을 살펴보자!

### Storyboard

**1. Ease of use**

대부분 처음 iOS 개발을 배울 때에는 스토리보드 기반으로 배우게 된다. 이 방법이 코드 기반 UI 작업에 비해 간단하고 배우기도 쉽다.

새로운 뷰 컨트롤러, 버튼, 레이블, 텍스트 필드, 세그 등이 필요하다면 클릭 몇 번으로 구현이 가능하기 때문이다.

만일 동일한 작업을 코드 기반으로 진행하게 되면 작업 시간이 더 오래 걸리고 복잡해진다.

아래 간단한 예시를 통해 코드 기반 UI 제약사항 작업을 살펴보자.

```swift

// 뷰 인스턴스 생성
let sampleView: UIView = UIView()

// 현재 뷰에 인스턴스 뷰 더하기
view.addSubview(sampleView)

// 자동 레이아웃 제약 조건 변환 기능 비활성화
sampleView.translateAutoresizingMaskIntoConstraints = false

// 레이아웃 앵커 프레임 활성화
sampleView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true

sampleView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true

sampleView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true

sampleView.heightAnchor.constraintEqualToAnchor(view.heightAnchor).active = true

```

위 코드는 `view` 인스턴스를 생성하고 간단히 제약만 설정하는 코드다.

정말 간단한 `view` 하나 생성하는데 위와 같이 상대적으로 많은 코드를 적어내야 한다.

만일 여기에 버튼, 레이블, 텍스트 필드 ...등을 더한다면 코드는 ....

위에서 가장 중요한 코드는 `translatesAutoresizingMaskIntoConstraints` 부분과 `.active = true` 부분이다.

위 코드를 작성하지 않으면 실제 뷰에서 우리가 생성한 뷰를 볼 수 없다.

**2. Visual**

스토리보드의 주요 장점 중 하나는 시각적으로 즉각 살펴볼 수 있다는 점이다.

단순 클릭 몇번만으로 모든 버튼, 레이블, 텍스트 필드 등의 객체들이 어디에 어떻게 배치될 지 즉각적으로 살펴볼 수 있기 때문에 전체 뷰를 상대적 간단하게 작성할 수 있다.

추가로 제약조건 또한 매우 시각적으로 잘 보여진다, 

<br>

### Programmatic

**1. Control**

모든 UI를 코드 기반으로 작성하게 되면 모든 UI 요소들에 대한 제어감각이 생긴다.

스토리보드를 통해 할 수 있는 작업 모두를 코드 기반으로도 작성할 수 있다.

**2. Reusability**

위에서 언급했던 것과 같이 코드 기반으로 UI를 작성하다 보면 상대적으로 어려운 프로세스를 거치게 된다.

그러나 작성한 코드를 프로젝트 전반에 걸쳐 재사용할 수 있다.

만일, 프로젝트 중간 뷰 내에 레이블을 생성하고 싶다면 대부분의 코드들을 그냥 기존 코드에서 copy & paste하면 된다.

혹은 이전에 진행했던 프로젝트에서 사용했던 뷰와 정확히 동일한 뷰 레이아웃이 필요하다면 그냥 가져와서 쓰면 된다.

**3. Clutter and Navigation**

스토리보드를 사용한 UI 작업시의 혼란(?)스러움을 방지할 수 있다.

복잡한 스토리보드 내에서 간단한 레이블 위치 조정을 진행하려고 하다보면 레이블과 전혀 관련없는 다른 요소가 클릭되기도 하고 골치가 아파진다..

이를 해결하기 위해서 Zoom In 하여 작업을 진행하는 방법도 있지만 그닥 실용적인 해결방안은 아니다.

**4. Merge Conflict**

대부분의 code-based UI 작업을 진행하는 iOS 개발자들은 이 장점을 중요시 한다.

혼자 진행하는 프로젝트가 아닌 여러 개발자와 함께 하는 프로젝트인 경우 스토리보드를 선호하는 개발자도 있고 코드 기반 개발을 선호하는 개발자도 있다. 

이러한 경우, Github에서 merge 작업을 진행할 때 conflict 가 종종 발생한다.

스토리보드 merge 충돌은 단순한 코드가 아니라 UI를 렌더링 하는 코드가 있기 대문에 절대 간단한 작업이 아니다..

또한, 스토리보드 기반의 UI작업은 필요하지 않은 뷰 컨트롤러가 자동적으로 생성되기 때문에 메모리 낭비 현상도 발생한다.

이러한 낭비 현상은 프로젝트 빌드의 속도만 봐도 간접적으로나마 체험해 볼 수 있다.

<br>

## GCD - Dispatch Queue
---

Queue는 모든 개발자가 알고있는 선입선출 형태의 자료구조이다.

이러한 Queue에는 크게 두 가지 종류 `Serial, Concurrent` 큐가 존재한다.

**Serial** 은 단어의 뜻에서 알 수 있듯, 직렬 방식으로 하나의 작업이 들어오면 해당 작업을 끝낸 이후에 타 작업을 진행하는 방식이다.

**Concurrent** 는 한번에 하나의 작업만 하는 것이 아니라, 동시에 여러 작업을 처리한다.

하지만, Concurrent Queue 또한 Queue 이기 때문에 먼저 들어온 작업이 먼저 서비스를 받는다.

이 서비스를 동시 다발적으로 진행하는 것 뿐이다.

이러한 특징들이 DispatchQueue에 적용되어 Serial DispatchQueue 와 Concurrent DispatchQueue로 나뉘어진다.

Serial DispatchQueue는 먼저 들어간 task가 끝난 이후에 뒤에 있는 task를 진행하는 방식으로 작업이 진행되고, Concurrent DispatchQueue는 먼저 들어간 task의 완료 여부와는 상관없이 여러개의 task를 동시에 진행한다.

이러한 DispatchQueue가 Cocoa Application 에서는 `main`과 `global` 로 나뉘어진다.

### DispatchQueue.main

**DispatchQueue.main** 는 앱 내 main thread에서 task를 실행하는 serial Queue이다.

보통 DispatchQueue.main 에서는 UI 와 관련된 task 작업이 진행된다. 

### DispatchQueue.global

**DispatchQueue.global** 는 Concurrent Queue로써 동시에 하나 이상의 task를 실행하지만 Queue이기 때문에 큐에 추가된 순서대로 작업을 실행한다.

두 가지 큐는 아래와 같이 생성한다.

![image](https://user-images.githubusercontent.com/33051018/86525944-932a9700-bec8-11ea-9ff9-b3aef3041fd3.png)

여러 개의 파라미터를 전달받아 생성한다. 각각의 파라미터에 대하여 간단하게 설명하고 지나간다.

- label : 옵션 파라미터로 유니크한 identifier를 갖는 큐를 생성하고자 할 때 지정해준다.

- qos : Quality Of Service의 약자로 실행할 task들의 우선순위에 따른 스케쥴링을 위한 파라미터이다.<br> `enum` 형태로 제공되며 아래와 같은 case가 있다. QoS 를 적절히 지정해주면 앱의 에너지 효율이 좋아진다!
![image](https://user-images.githubusercontent.com/33051018/86525969-eef52000-bec8-11ea-8517-81b8c596ce26.png)

- attributes : 큐와 관련된 속성을 지정한다. concurrent 큐를 생성하고 싶다면 .concurrent 값을 전달해줘야한다.

간단히 serialQueue 와 ConcurrentQueue를 생성해보도록 한다.


```swift

let serialQueue = DispathcQueue(label: "yeojaeng")

let concurrentQueue = DispatchQueue(label: "yeojaeng", attributes: .concurrent)
```

작업을 병렬적으로 처리하는 동시성 큐를 생성하기 위해서는 `attributes` 파라미터에 `.concurrent` 값을 전달해줘야 한다.

이렇게 DispatchQueue 는 Concurrent 성격을 갖는 global 큐와 Serial 성격을 갖는 main 큐가 존재한다는 것을 알았다.

위 Queue들은 `sync` 와 `async` 함수를 갖는다. 함수명에서 알 수 있듯 sync는 동기로 처리할 것을 의미하고 async는 비동기로 처리할 것을 의미한다.

일단은 **sync** 부터 살펴보도록 한다.


### global.sync
```swift

import Foundation

DispatchQueue.global().sync {
    
    for i in 1...5 {
        print(i)
    }
}

for i in 10...15 {
    print(i)
}

/*
1
2
3
4
5
10
11
12
13
14
15
*/
```

globalQueue를 생성하여 sync 방식으로 1~5를 출력한다.

이후 10~15를 출력한다.

sync 방식을 채택하였기 때문에 모든 큐 내의 작업이 끝난 이후 아래 코드를 작업하게 될 것이다.

결과는 예상한 바와 동일하다.

### serial.async

```swift
import Foundation

let myQueue = DispatchQueue(label: "yeojaeng")

myQueue.async {
    for i in 1...5 {
        print(i)
    }
}

myQueue.async {
    for i in 10...15 {
        print(i)
    }
}

for i in 20...25 {
    print(i)
}

/*
1
2
3
4
5
20
21
22
23
10
24
11
12
25
13
14
15
*/
```

`async` 방식으로 작업을 처리했기 때문에 결과는 매번 달라진다.

하지만 결과값을 자세히 살펴보면 알 수 있듯, `serial` 의 특성을 확인할 수 있다.

두 개의 큐 중 하나의 큐가 작업을 진행하면 해당 작업이 끝날때 까지는 큐 내에 다른 작업을 진행하지 않는다.

맨 마지막에 위치하는 for loop은 Queue 내에 들어있지 않기 때문에 언제 실행될 지 모른다!


### global.async

```swift
import Foundation

DispatchQueue.global().async {
    for i in 1...5 {
        print(i)
    }
}

DispatchQueue.global().async {
    for i in 10...15 {
        print(i)
    }
}

for i in 20...25 {
    print(i)
}

/*
20
1
10
21
2
11
22
3
4
5
12
23
13
14
15
24
25
*/
```


위 코드의 결과값을 예상하여 맞췄다면 당신은 컴퓨터 그자체다.

두 개의 global 큐를 생성하였고 `async`하게 작업을 처리하도록 하였다.

이후 for loop을 통해 정수를 출력하도록 하였다.

**비동기** 방식으로 작업을 진행하기 때문에 매번 결과값이 달라진다.

왜냐하면 `async` 방식은 큐 내에 task 완료 여부에 상관없이 다음 코드를 실행하기 때문이다.



## Summary
---

- UI 관련 이벤트를 `mainQueue`에서 작업해야 하는 이유는 UI와 관련된 모든 이벤트가 main thread에 attach하기 때문이다.

- 스토리보드 기반, 코드 기반의 UI 작업 방법은 각각 장점이 있다. 협업시 스토리보드 기반 작업 파일 포맷 형식이
XML이므로 가독성이 떨어져 Merge Conflict처리의 어려움을 유발한다.

- 앱의 규모가 크지 않은 개인 프로젝트 혹은 복잡하지 않아 빠르게 만들 수 있는 앱의 경우, 흐름을 한 눈에 살펴보고 싶은 경우에는 적절히 스토리보드를 활용하는 것도 좋은 방법이다.

- Queue는 크게 Serial 큐와 Concurrent큐로 나뉜다.

- Cocoa 앱 내에서는 이를 DispatchQueue.main(), DispatchQueue.global(attributes: .concurrent)로 구분한다.

- 각각의 큐는 sync, async 에 따라 작업을 처리할 수 있다.


<br>

## Reference
---

- [Storyboard vs Programmatically in Swift](https://medium.com/@chan.henryk/storyboard-vs-programmatically-in-swift-9a65ff6aaeae)

- [DispatchQueue](https://developer.apple.com/documentation/dispatch/dispatchqueue)

- [DispatchQueue Initializer](https://developer.apple.com/documentation/dispatch/dispatchqueue)

- [DispatchQoS.QoSClass](https://developer.apple.com/documentation/dispatch/dispatchqos/qosclass)
