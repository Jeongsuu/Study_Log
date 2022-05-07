# Clean Architecture

<br>

사이드 프로젝트에서 MVVM에 더불어 Clean Architecture를 함께 사용하게 되었습니다.

이번 기회에 간략하게만 알고있던 Clean Architecture를 실제 프로젝트 레벨에 사용해보기 앞서 간략하게 공부한 내용을 정리해보겠습니다.

<br>

## Clean Architecture
---

먼저 Clean Achitecture란 무엇인지 알아보도록 할게요.

<br>

<img width="542" alt="image" src="https://user-images.githubusercontent.com/33051018/167250812-f2b1cc2d-bd6f-4cd8-afaa-7309fdff657a.png">

위 사진과 같이 앱의 아키텍처를 구성한 것을 Clean Architecture라고 합니다.

우리는 여태 시스템 아키텍처에 대한 다양한 다이어그램을 봐왔습니다. 대부분의 아키텍처들의 경우 세세한 부분은 모두 다르지만 기본적으로 공통된 성질을 가지고 있습니다.

**그것은 바로 관심사의 분리(SoC, Separation of Concenrs) 입니다.**

소프트웨어의 구조를 계층화하여 나눔으로써 관심사를 분리합니다.

이 아키텍처가 가능하게 하는 중요한 것 중 하나는 바로 의존 규칙입니다. 이 규칙에 의해서 아키텍처의 게층화가 가능해지며 각 계층별 책임이 분리됩니다.

<br>

### 의존 규칙
---

- 바깥쪽 원은 메커니즘이고 안쪽의 원은 정책입니다.
- 가장 바깥쪽 원은 저수준의 구체저인 정보를 담습니다. 원의 내부로 이동해 나아가면서 소프트웨어는 추상화되고 고수준의 정책들을 캡슐화합니다.
- 소스 코드들은 안쪽을 향해서는 의존할 수 있습니다.
- 안쪽의 원은 바깥쪽 원에 대하여 전혀 알지 못합니다. 특히 바깥쪽의 원에서 선언된 어떠한 이름도 안쪽 원에서 참조해서는 안됩니다.
- 바깥쪽 원의 어떠한 것도 안쪽의 원에 영향을 주어서는 안됩니다.


<br>



### 계층 설명
---

<img width="542" alt="image" src="https://user-images.githubusercontent.com/33051018/167251480-74e08984-1749-4858-b9c7-bc3260755f44.png">

<br>

**1. 엔티티(Entities) = 비즈니스 모델 계층**

엔티티는 프로젝트 레벨의 비즈니스 규칙들을 캡슐화합니다.

비즈니스 모델로서 메서드를 갖는 객체일수도 있고 데이터 구조와 함수의 집합일수도 있습니다.

<br>

**2. 유스케이스(Use Cases) = 비즈니스 로직 실행 계층**

유스케이스는 비즈니스 규칙을 포함하며 시스테믜 모든 유스케이스를 캡슐화하고 구현합니다.

유스케이스는 비즈니스 모델(비즈니스 규칙) 엔티티로부 부터의 혹은 엔티티에서의 데이터 흐름을 조합합니다.

그리고 엔티티를 사용하여 유스케이스의 목적을 달성하도록 합니다.

여기서 중요한것은 UseCase 계층의 변경이 절대 엔티티 계층에 영향을 주지 않습니다.
(안쪽의 원은 바깥쪽의 원에 대하여 전혀 알지 못하며 바깥쪽 원은 안쪽 원에 영향을 주어서는 안됩니다.)

<br>

**3. 인터페이스 어댑터 = Presentation 계층**

이 계층은 유스케이스와 엔티티에 있어 용이한 형식으로 부터 DB 혹은 웹 등 외부의 기능에 용이한 형식으로 데이터를 변환합니다.

Controller, Gateway, Presenter 등이 해당 계층에 포함됩니다.

<br>

**4. 프레임워크와 드라이버 = 프레임워크 혹은 도구들 모음 계층**

DB나 웹 프레임워크 등 일반적으로 프레임워크나 도구로 구성이 됩니다.

대부분 이 계층에서는 안쪽의 원과 통신할 연결 코드를 제외하고 별다른 코드는 작성하지 않습니다.

<br>
<br>

## MVVM + CleanArchitecture
---

CleanArchitecture 를 MVVM과 함께 사용하여 계층화를 그룹핑하면 어떻게 표현할 수 있을까요?

<img width="542" alt="image" src="https://user-images.githubusercontent.com/33051018/167251579-67bb8fba-6a2a-40c2-aef0-b8aea63b85f9.png">

3개의 계층으로 계층화가 가능하며 제일 내부에는 Domain Layer(비즈니스 로직)가 자리합니다.


<br>

### Domain Layer

Domain Layer는 완전히 독립되며 다른 계층에게 의존성을 갖지 않습니다.

**이 Domain Layer 내부에는 엔티티(비즈니스 모델), 유즈케이스(비즈니스 로직), 레포지터리 인터페이스(구현체 X)가 포함됩니다.**

이 계층은 타 프로젝트에서도 재사용이 가능할 정도로 완전히 독립되어 있어야 합니다.

Domain Layer에서는 Presentation Layer에서 사용되는 UIKit, SwiftUI 혹은 Data Layer에서 사용되는 Codable과 같은 것들을 포함해서는 안됩니다.

<br>

### Presentation Layer

Presentation Layer에서는 UI(UIViewControllers || SwiftUI Views) 를 포함합니다.

**View는 ViewModel에 의해 코디네이팅 되며 ViewModel을 통해 하나 혹은 여러개의 유즈케이스를 실행합니다.**

Presentation Layer는 오직 Domain Layer에 대한 의존성을 갖습니다.

<br>

### Data Layer

**Data Layer에는 아까 Domain Layer에 존재하던 레포지터리 인터페이스를 구현한 레포지터리 구현체가 존재하며 하나 혹은 그 이상의 데이터소스가 존재합니다.**

데이터소스란 리모트 혹은 로컬(ex: Persitent DB) 등이 되며 Data Layer 또한 Domain Layer에 대한 의존성을 갖습니다.

<br>
<br>

## 데이터 흐름 및 의존성
---

<img width="584" alt="image" src="https://user-images.githubusercontent.com/33051018/167252050-80000583-0dc5-4bba-a95a-3d44895eded9.png">

### 데이터 흐름

1. 뷰(UI)에서 뷰모델(Presenter)의 메소드를 호출합니다.

2. 뷰모델(Presenter)에서 유즈케이스(Domain)을 실행합니다.

3. 유즈케이스는 각각의 레포지터리에게 데이터를 요청합니다.

4. 각각의 레포지터리(Network, Persitent DB)는 데이터를 반환합니다.
5. 이를 UI에 보여줍니다.


### 의존성 방향

Presentation Layer -> Domain Layer <- Data Layer

Presentation Layer(MVVM) = ViewModels + Views(Presentation)

Domain Layer = Entities + Use Cases + Repositories Interfaces

Data Layer = Repositories Implements + API(Network) + Persistent DB

<br>
<br>

## Reference
---

- [Uncle Bob's Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

- [iOS-Clea-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)