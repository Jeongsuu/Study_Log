# How to use Firebase Database in iOS

본 문서에서는 `Firebase` 에서 제공하는 기능 중 하나인 `Database`에 관하여 기재한다.

<br>

## Firebase 실시간 데이터베이스
---

Firebase 실시간 데이터베이스는 클라우드 호스팅 데이터베이스다.

데이터는 `JSON` 형태로 저장되며 연결된 모든 클라이언트에 실시간으로 동기화된다.

<br>

## 앱에 Firebase 실시간 데이터베이스 추가
---
프로젝트 `Podfile`에 아래와 같이 의존성을 추가해준다.

```bash
pod 'Firebase/Database'
```

이후 `podinstall` 을 한 뒤, `.xcwordkspace` 파일을 연다.

<br>

## 실시간 데이터베이스 규칙 구성
---

실시간 디비가 제공하는 규칙 언어로 데이터의 구조, 인덱스 생성 방법, 데이터를 읽고 쓸 수 있는 조건을 정의할 수 있다.

기본적으로 데이터베이스에 대한 읽기 및 쓰기 접근은 인증된 사용자만 데이터를 읽거나 쓸 수 있도록 제한된다.

이 또한, 공개 접근 규칙을 구성하면 별다른 인증 없이 모든 구성원이 사용할 수 있다.

<br>

## Firebase 실시간 데이터베이스 설정
---

실시간 DB를 사용하기 위해서는 `Firebase`를 초기화하고 참조 인스턴스를 생성해야 한다.

1. `AppDelegate`에 `Firebase` 모듈을 `import` 해준다.
2. `application::didFinishLaunchingWithOptions:` 메소드에 `FirebaseApp` 인스턴스를 생성한다.
```swift
// Use Firebase library to configure APIs
FirebaseApp.configure()
```

Firebase 실시간 데이터베이스가 초기화되었으면 다음과 같이 데이터베이스 참조를 정의하고 생성한다.
```swift
var ref: DatabaseReference!
ref = Database.database().reference()
```

`Database.database().reference()` 는 `Firebase`의 데이터베이스에 접근하기 위한 참조 목적의 변수다.

위와 같이 참조 변수를 생성했다면 이제 데이터베이스에 적재할 데이터를 구조화 하여야한다.

<br>

## 데이터베이스 구조화
---

어떠한 데이터베이스든 구조화가 제일 중요하다고 생각한다.

`Firebase`에서는 어떠한 방식으로 데이터를 구조화 하는지 살펴보도록 한다.

앞서 `Firebase`는 `JSON` 형태의 데이터를 사용한다고 배웠다.

`JSON` 형태를 유지하며 데이터베이스를 적절히 구조화하려면 철저한 사전 준비가 필요하며, 가장 중요한 것은 최대한 쉽게 데이터를 저장하고 최대한 쉽게 데이터를 검색하는 방법에 대한 설계다!

<br>

## 데이터를 구조화 하는 방법 : JSON 트리
---

모든 `Firebase` 실시간 데이터베이스의 데이터는 `JSON` 객체로 저장된다.

데이터베이스를 클라우드 호스팅 JSON 트리라고 생각하는 것이 편하다!

`SQL` DB와는 달리 테이블 또는 레코드가 없으며, `JSON` 트리에 추가된 데이터는 연결된 키를 갖는 기존 `JSON` 구조의 노드가 된다.

사용자 ID 또는 의미 있는 이름과 같은 `unique`한 `key`값을 직접 지정할 수도 있고, `childByAutoId` 메서드를 사용하여 자동으로 `key`값을 지정할 수도 있다.

간단한 예시로, 사용자가 기본적인 프로필과 연락처 목록을 저장할 수 있는 채팅 애플리케이션을 만든다고 가정해보자.

사용자 프로필은 일반적으로 `/users/$uid`와 같은 경로에 위치한다.

사용자 `yeojaeng`의 데이터베이스 항목은 아래와 같이 표현된다.

```json
{
    "users": {
        "yeojaeng" : {
            "name" : "Yeo Jungsu",
            "contacts" : { "someone": true },
        },
        "someone" : { ... },
        "someone2" : { ... }
    }
}
```

그렇다, 우리가 자주 봐왔던 형태이다.

데이터의 형태를 파악했으니 이제는 어떠한 방식으로 구조화 하는것이 좋을지 살펴보도록 한다.

<br>

### 데이터베이스 구조 권장사항
---

#### 데이터 중첩 배제

`Firebase` 실시간 데이터베이스는 최대 32 단계의 depth까지 데이터 중첩을 허용한다.

**하지만 데이터베이스의 특정 위치에서 데이터를 가져오면 모든 하위 노드가 함께 검색된다..** 

또한 사용자에게 데이터베이스의 특정 노드에 대한 `RW` 권한을 부여하게 되면 해당 노드에 속한 모든 하위 데이터에 관한 권한 또한 함께 부여된다.

만일 실제 앱을 배포할 목적으로 해당 서비스를 이용한다면 데이터 구조화에 신경을 쓸 필요가 있다.

**따라서 데이터의 구조를 중첩되지 않도록, 깊이가 깊어지지 않도록 최대한 낮은 depth를 유지하며 평면화하는 것이 바람직하다!**

아래 예제는 데이터 중첩을 배제해야 하는 예시이다.

```json
{
    //nested data architecture.
    "chats": {
        "one": {
            "title": "Historycal Tech Poineers",
            "m1": { "sender": "ghopper", "message": "Relay malfunction found. Cause: moth." },
            "m2": { ... },
        }
    },
    "two": { ... }
  }
}
```

위와 같이 설계할 경우, 채팅창의 제목을 나열하려면 모든 멤버와 메세지를 포함한 전체 `chats` 트리를 클라이언트가 가져와야 한다.

```json
{
  // Chats contains only meta info about each conversation
  // stored under the chats's unique ID
  "chats": {
    "one": {
      "title": "Historical Tech Pioneers",
      "lastMessage": "ghopper: Relay malfunction found. Cause: moth.",
      "timestamp": 1459361875666
    },
    "two": { ... },
    "three": { ... }
  },

  // Conversation members are easily accessible
  // and stored by chat conversation ID
  "members": {
    // we'll talk about indices like this below
    "one": {
      "ghopper": true,
      "alovelace": true,
      "eclarke": true
    },
    "two": { ... },
    "three": { ... }
  },

  // Messages are separate from data we may want to iterate quickly
  // but still easily paginated and queried, and organized by chat
  // conversation ID
  "messages": {
    "one": {
      "m1": {
        "name": "eclarke",
        "message": "The relay seems to be malfunctioning.",
        "timestamp": 1459361875337
      },
      "m2": { ... },
      "m3": { ... }
    },
    "two": { ... },
    "three": { ... }
  }
}
```

위와 같은 형태의 경우에는, 데이터를 서로 다른 경로로 분리하여 필요한 데이터에 따라 별도의 호출을 통해 효율적으로 데이터를 가져올 수 있다.

이것이 평면화가 필요한 이유이다!

따라서, 앱에서 저장한 데이터를 어떻게 이용할 것인지를 고려하며 평면화를 진행하는 것이 바람직하다.

<br>

## iOS에서 데이터 저장
---

데이터를 구조화하였다면 이제는 직접 데이터를 저장해보도록 한다.

`Firebase` 실시간 데이터베이스에 데이터를 저장하기 위해 사용하는 메소드는 4가지이다.

- `setValue()` : 정의된 경로 (ex: users/<user-id>/<username>)에 데이터를 쓰거나 대체한다.
- `childByAutoId()` : 데이터 목록에 추가한다, `childByAutoId` 를 호출할 때 마다 `Firebase`에서는 고유한 `key`값을 생성한다.
- `updateChildValues` : 정의된 경로에서의 일부 키를 업데이트한다. 
- `runTransactionBlock` : 동시 업데이트에 의해 손상 위험이 존재하는 복잡한 데이터를 업데이트한다.

<br>

### 참조 위치에서 데이터 쓰기, 업데이트 또는 석제

기본 쓰기 작업의 경우에는 `setValue` 메서드를 사용하여 지정된 위치에 데이터를 저장하고 기존 경로의 모든 데이터를 대체할 수 있다.

- 사용 가능한 자료형은 아래와 같다.
    -   `NSString`
    -   `NSNumber`
    -   `NSDictionary`
    -   `NSArray`

예를 들어, `setValue` 메서드를 이용하여 아래와 같이 사용자를 추가할 수 있다.

```swift
self.ref.child("users").child(user.uid).setValue(["username" : "yeojaeng"])
```

혹은 `setValue`를 사용하여 지정된 위치의 하위 노드값을 업데이트 하는 방법이 있다.

사용자가 프로필을 업데이트 하도록 허용하려면 다음과 같이 사용자 이름을 업데이트 할 수 있다.

```swift
self.ref.child("users/(user.uid)/username").setValue("yeojaeng")
```

### 데이터 추가

여러 사용자가 사용하는 앱에서는 `childByAutoId` 메소드를 사용하여 목록에 데이터를 추가한다.

`childByAutoId` 메소드는 지정된 `Firebase` 참조 위치에 새 하위 항목이 추가될 때 마다 고유한 키 값을 생성한다.

목록의 새 요소마다 이러한 자동 생성 키를 사용하면 여러 클라이언트에서 쓰기 충돌 없이 동시에 같은 위치에 새로운 하위 항목을 추가할 수 있다.

`childByAutoId`가 생성하는 고유 키는 타임 스탬프 값을 기반으로 생성하기 때문에 목록 항목은 시간순으로 자동 정렬된다.

또한, `childByAutoId` 메소드가 반환하는 참조값을 사용하여 새로 만들어낸 키 값을 가져오거나 하위 데이터를 지정하는 것 또한 가능하다.

`childByAutoId` 참조에 대하여 `getKey` 를 호출하면 해당 참조의 키 값이 반환된다.

이러한 자동 생성 키를 사용하여 데이터의 구조를 평면화하는 작업을 단순화 할 수 있다.

<br>

### 특정 필드 업데이트

다른 하위 노드를 덮어쓰지 않고, 특정 하위 노드에 동시에 쓰기 위해서는 `updateChildValues` 메소드를 사용한다.

`updateChildValues`를 호출할 때 키의 경로를 지정하여 하위 노드값들을 업데이트 할 수 있다.

```swift

let key = ref.child("posts").childByautoId().key
let post = ["uid": userID,
            "author" : userName,
            "title" : title,
            "body" : body]

let childUpdates = ["/posts/\(key)" : post,
                    "/user-posts/\(userID)/\(key)" : post]

ref.updateChildValues(childUpdates)

```

위 예제는 `childByAutoId` 메서드를 이용하여 모든 사용자의 게시물을 포함하는 노드에 게시물을 만듦과 동시에 키 값을 가져온다.

이후 해당 키 값을 통해 사용자의 게시물 목록에 두번째 항목을 만들고 이를 여러위치에서 동시에 업데이트 한다.

<br>

### 데이터 삭제
---
데이터를 삭제하는 가장 간단한 방법은 해당 데이터 위치에 대하여 `removeValue()`를 호출하는 것이다.

`setValue()` 또는 `updateChildValues()` 등의 다른 작업에 대한 값으로 `nil`을 지정하여 삭제할 수도 있다.


<br>

### 데이터를 트랜잭션으로 저장
---

예를 들어, 소셜 앱에서 사용자의 포스트에 별표를 주거나 삭제할 수 있게 하고 게시물이 받은 별표 수를 집계하거나 할 때는 여러 사용자가 동시에 접근할 가능성이 존재하기 때문에 이를 트랜잭션으로 저장하여 처리한다.


```swift
ref.runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
  if var post = currentData.value as? [String : AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
    var stars : Dictionary<String, Bool>
    stars = post["stars"] as? [String : Bool] ?? [:]
    var starCount = post["starCount"] as? Int ?? 0
    if let _ = stars[uid] {
      // Unstar the post and remove self from stars
      starCount -= 1
      stars.removeValueForKey(uid)
    } else {
      // Star the post and add self to stars
      starCount += 1
      stars[uid] = true
    }
    post["starCount"] = starCount
    post["stars"] = stars

    // Set value and report transaction success
    currentData.value = post

    return FIRTransactionResult.successWithValue(currentData)
  }
  return FIRTransactionResult.successWithValue(currentData)
}) { (error, committed, snapshot) in
  if let error = error {
    print(error.localizedDescription)
  }
}
```

트랜잭션을 사용하면 여러 사용자가 같은 게시물에 동시에 별표를 주거나 클라이언트 데이터의 동기화가 어긋나도 별표가 잘못 집계되지 않는다.

최초에 FIRMutableData 클래스에 포함되는 값은 해당 경로에 대해 클라이언트에 마지막으로 알려진 값이거나 값이 없는 경우 nil이다.
 
서버는 초기 값과 현재 값을 비교하여 값이 일치하면 트랜잭션을 수락하고, 그렇지 않으면 거부한다. 

트랜잭션이 거부되면 서버에서 현재 값을 클라이언트에 반환하며, 클라이언트는 업데이트된 값으로 트랜잭션을 다시 실행한다. 트랜잭션이 수락되거나 시도가 일정 횟수를 초과할 때까지 이 과정이 반복된다.





<br>

### Reference
---
- [ZidaPapa - Firebase Relatime DB 이용하기 (iOS)](https://medium.com/@zida.papa/firebase-realtime-db-%EC%9D%B4%EC%9A%A9-%ED%95%98%EA%B8%B0-ios-e4eb5f415c53)

- [Firebase.gogole.com](Ohttps://firebase.google.com/docs/database/ios/lists-of-data?hl=ko)
