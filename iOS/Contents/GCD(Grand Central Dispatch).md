# GCD (Grand Central Dispatch)

<br>

## GCD란?
---

`GCD`는 **멀티 코어 환경에서 최적화된 프로그래밍을 지원하도록 애플이 개발한 기술** 이라고 한다.

일반적으로 우리는 `GCD`를 `Dispatch Queue`라고 부른다.

`Dispatch Queue`에 대하여 살펴보기 이전에 Serial Queue, Concurrent Queue, Sync, Async에 대하여 살펴본다.

<br>

## Serial Queue, Concurrent Queue
---

**큐** 자료구조는 우리가 알고있는 FIFO 형태의 자료구조를 의미한다.

Serial & Concurrent Queue 모두 작동방식은 FIFO를 따른다.

그러면 직렬 큐(Serial Queue)와 동시 큐(Concurrent Queue)는 과연 무엇인지 먼저 살펴보자!

직렬 큐는 **분산처리된 작업을 다른 하나의 스레드에서 처리하는 큐**다. 즉, 스레드에서 이전 작업이 끝나면 다음 작업을 순차적으로 진행한다.

동시 큐는 **분산처리시킨 작업을 다른 여러 개의 스레드에서 처리하는 큐**다. 즉, 병렬 형태로 실행된다.

- Serial Queue : 한번에 한가지 업무만 실행하는 것을 보장한다. 즉 지금 일을 끝내지 않고서는 다른 일을 하지 않는다.
<br>

- Concurrent Queue : 현재 작업중인 일이 끝나지 않더라도 다른 일을 시작할 수 있다. 즉 제일 먼저 시작한 일이 제일 늦게 끝날 수도 있다.


여러 개의 직렬 큐를 만들어 처리한다면 각각의 직렬 큐에는 하나의 스레드에 작업을 할당하지만 해당 큐들은 **Concurrent**하게 작업을 진행한다.


그리고 위 두개의 큐는 동기(sync), 비동기(async) 방식 중 어떻게 실행하느냐에 따라서 아래와 같이 4개의 조합이 나올 수 있다.

- Serial Queue - Sync
- Serial Queue - Async
- Concurrent Queue - Sync
- Concurrent Queue - Async

Sync는 동기를 의미하며 요청에 대한 결과값이 주어질 때 까지, 큐에 작업이 추가된 이후 추가된 작업이 종료될 떄 까지 대기한다.

Async는 비동기를 의미하며 요청에 대한 결과값이 언제 주어지냐는 상관없이 큐에 작업을 추가하기만 할 뿐 작업 완료 여부는 보장하지 않는다.

앞서 설명한 대표적인 Queue 두 개는 `main` 과 `global`로 구분할 수 있다.

<br>

### DispatchQueue.main
- `DispatchQueue.main` 은 시스템 작동시 자동으로 생성되는 **메인 큐** 이다.
- 기본적으로 `Serial Queue`, 직렬 큐로 작동한다.
- UI 변경과 같은 작업을 맡는다.

### DispatchQueue.global
- `DispatchQueue.global` 은 메인 큐와 반대되는 개념으로 백그라운드에서 동작한다.
- 기본적으로 `Concurrent Queue`, 병렬 큐로 작동한다.
- 서버와의 통신같은 경우, 시간이 얼마나 걸릴지 모르므로 백그라운드로 실행하여 후처리를 메인 큐에서 진행하는 경우가 있다.
- `Qos(Quality Of Service)` 값을 활용하여 우선순위를 지정할 수 있다.

**정리**

- Main 큐는 메인 스레드에서 작동하고 Serial Queue 방식이다. 따라서 한 번에 한가지만 실행한다.
- Main 스레드는 UI를 위한 스레드로 사용되기 때문에 되도록 UI 업데이트시에만 사용한다.
- 무거운 작업 혹은 UI 업데이트가 없는 경우, Concurrent Queue인 Global을 사용하면 된다.
- Global queue는 전체 시스템이 공유하는 concurrent Queue다.

<br>

간단한 예시로 직접 살펴보도록 하자!

```swift
import Foundation

DispatchQueue.global().sync { print("num: 1") }
print("num: 2")
DispatchQueue.global().sync { print("num: 3") }
print("num: 4")

/*
num: 1
num: 2
num: 3
num: 4
*/
```

`sync`는 동기이므로 큐에 추가한 작업이 끝날때까지 기다렸다가 다음 코드를 실행하므로 동일한 순서를 보장한다.

<br>

```swift
import Foundation

DispatchQueue.global().async { print("num: 1") }
print("num: 2")
DispatchQueue.global().async { print("num: 3") }
print("num: 4")

/*
num: 1
num: 2
num: 4
num: 3
*/
```

`async`는 비동기이므로 큐에 추가한 작업이 랜덤하게 출력된다.

<br>

### 결론
- UI 업데이트는 메인스레드(DispatchQueue.main)에서, 무거운 작업은 background(DispatchQueue.global)에서

- 순서가 중요치 않은 작업은 `async`를, 순서가 중요한 경우 `sync`를 사용한다.