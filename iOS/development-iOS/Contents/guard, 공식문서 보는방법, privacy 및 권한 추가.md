---

---

### `guard` 의 사용

---

`guard`는 함수와 같은 로직의 시작 부분에 써서 반드시 가져가야할 조건들을 검사하는 기능을 한다.

if문의 조건 검사를 통해서도 완벽히 대체는 가능하다.

그럼에도 `guard` 를 쓰는 이유는 가독성 때문이라고 생각한다.

함수 진입점에 if를 막 나열하는 것 보다 `guard` 로 꼭 필요한 조건들을 걸러내면 로직을 분석하는 사람의 입장에서도 더욱 이해하기 쉬울 것이다.

ex)

int 타입을 쓰긴 했지만 음수값을 받으면 안되는 경우

    func elapsedTime(A:Int, B:Int) throws -> Int {
    	if A < 0 || B < 0 {
    		throws someError
    	}
    	let dt = B - A
    	return dt
    }

위 코드중 조건부분을 `guard`로 대체하면 아래와 같다.

    func elapsedTime(A:Int, B:Int) throws -> Int {
    	guard A >= 0 && B >= 0 else {            //핵심 부분
    			throws someError
    	}
    	let dt = B - A
    	return dt
    }

`guard A >= 0 && B >= 0 else {` 이 부분이 위 코드의 핵심이다.

즉, `guard` 예약어 이후에 나오는 조건이 참일 경우에만 `else` 블럭을 지나치고 이어서 진행한다.

보다 응용한 내용을 살펴보자.

실질적으로 개발에서 응용되는 부분은 `let` 으로 할당한 경우 느낄 수 있다.

    func getLoginUserName() -> String {
    	guard let myInfo = loginMgr.myinfo else {
    		return "X"
    	}
    	
    	return "\(myInfo.userName)님"
    }

guard 문을 쓰면 `let` 으로 받으면서 `nil` 체크를 하는 동시에 그 값을 `guard` 문 이후에도 계속하여 사용이 가능하다.

이번엔 조건문의 중첩에서 얻을 수 있는 `guard` 의 이점을 살펴보자.

옵셔널 바인딩의 경우, → `if let some = some {}` 과 같은 형태로 진행된다.

하지만 실전에서는 `guard let some = some else {}` 가 더욱 많이 사용된다고 한다.

그 이유는 아래 코드를 통해 몸소 느낄수있다.

    if let a = a () {
    	let x = b(a)
    	x.fn()
    	if let u = x.next() {
    		let ux = u.brm()
    		if let uxt = ux.next() {
    				perform(uxt)
    		}
    	}
    }

이를 `guard` 를 이용하면 아래와 같이 작성이 가능하다.

    guard let a = a() else { return }
    let x = b(a)
    x.fn()
    guard let u = x.next() else { return }
    guard let ux = u.brm() else { return }
    
    perform(uxt)

앞서 작성한 코드와 차이점을 살펴본다.

앞서 작성했더너 코드는 `Optional BInding` 을 위해 `if let` 을 사용하는 구조는 계속 중첩되는 코드 블럭으로 실제로 실행되기를 원하는 코드는 겹쳐진 블럭들 사이에 감싸지게 된다.

`guard` 의 경우는 바인딩의 결과 값을 내포된 블럭 영역(scope)가 아닌 현재 영역(scope)에 노출 시킨다는 것이 가장 큰 장점이다.

위의 `guard` 활용 예시 처러머 코드가 마치 순차적인 명령어의 나열처럼 만들어지기 때문에 길이가 긴 함수를 작성할 때 큰 차이점이 발생한다.

---

### Closure ( 재공부 필요 )

---

클로저란 코드의 블록이자, 일급 객체로 완벽한 역할을 수행한다.

일급 객체는 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 잔달할 수 있으며, 함수의 반환 값이 될 수도 있다.

    { (매개 변수) -> 반환 타입 in
    	실행 코드
    }

포맷은 위와 같으며 `in` 키워드는 클로저의 정의부와 실행부를 분리하기 위함이다.

---

### Privacy 추가

---

`Info.plist` 에서 우클릭 `add row` 를 통해 앱 실행시 필요한 권한을 요청한다.

적절치 못하면 앱스토어에 올릴때 반려 사유가 된다.
