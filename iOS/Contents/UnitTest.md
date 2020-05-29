# UnitTest

오늘은 익히 들었지만 iOS에서는 한번도 도전해보지 못했던 `UnitTest` 라는 것을 실습해보며 정리해본다.

## UnitTest란?
---

`UnitTest` 직역하면 단위 테스트다.

즉, 컴퓨터 프로그래밍에서 작성된 소스 코드의 모듈 단위를 **의도대로 정확히 작동하는지 검증하는 루틴**을 의미한다.

이를 통해서 핵심 기능인 모델 클래스 및 메소드와 컨트롤러와의 상호작용, UI의 워크 플로우 등을 확인하고

문제가 발생할 경우, 단시간 내에 이를 파악하고 바로 잡을 수 있도록 도와준다.

이상적으로, 각 테스트 케이스는 모두 서로 분리되어야 하며 이를 위하여 가짜 객체 (Mock Object)를 생성하는 것 또한 좋은 방법이다.

**이러한 테스트를 주도적으로 하는 `TDD (Test-Driven-Development)` 방법론을 통해 소스 수정에 대한 부담을 덜고 디버깅 시간을 줄이며 소스코드의 품질을 높일 수 있다.**

<br>

## UnitTest 예시
---

`UnitTest`란 작성한 코드가 의도대로 동작하는지 확인하기 위한 검증 루틴이며, 이를 통해 유지 보수 또는 에러 발생시 적절한 대처 등에 대한 장점을 갖는다는 것을 배웠다.

이제는 직접 예시를 통해 `UnitTest` 를 진행해보도록 한다.

![image](https://user-images.githubusercontent.com/33051018/83260179-49c59880-a1f4-11ea-9c31-b204871aa727.png)

위와 같이 xcode 프로젝트를 생성한다.

프로젝트 명은 무엇으로 하든 당연히 상관이 없다, 하지만 하단에 `Include Unit Tests` 체크박스를 **반드시** 체크하도록 하자!

![image](https://user-images.githubusercontent.com/33051018/83260413-b04ab680-a1f4-11ea-9f81-38cc4a1690b6.png)

그러면 위와 같은 프로젝트 구조를 살펴볼 수 있다.

못보던 프로젝트명 + `Tests` 파일이 생겼다!

해당 파일 내 *.swift 파일을 살펴보도록 한다.

```swift

import XCTest
@testable import Test

class TestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

```

코드 상단부를 살펴보면 `@testable import Test` 를 확인할 수 있다.

이는 테스트 하고자 하는 프로젝트명을 작성해주는 곳으로 xcode가 자동으로 기재해준다.

해당 클래스는 `XCTestCase` 클래스를 상속하고 있다.

![image](https://user-images.githubusercontent.com/33051018/83260756-4848a000-a1f5-11ea-94d7-1ba92afe72d9.png)

`XCTestCase`는 테스트 케이스 ,테스트 메소드 및 성능 테스트를 정의하기 위한 기본 클래스이다.

UnitTests 생성시 기본적으로 작성되어 있는 메소드 중 주요 메소드에 대해 살펴본다.

<br>

### setUpWithError()

![image](https://user-images.githubusercontent.com/33051018/83260990-a1183880-a1f5-11ea-8ada-a59487920706.png)

첫번째로 `setUpWithError()` 메소드다.

> cf) 
> 과거 `setUp` 메소드가 Xcode 11.4 버전부터 `setUpWithError` 메소드로 대체되었다.
> 그러나 setUp, tearDown 메소드가 `deprecated` 된 것은 아니기에 여전히 사용은 가능하다.

해당 메소드는 테스트 케이스 내에서 각각의 테스트 메소드를 호출하기 전에 상태를 재설정하고 에러를 `throw` 할 수 있는 기능을 제공한다.

### tearDownWithError()

![image](https://user-images.githubusercontent.com/33051018/83261499-6793fd00-a1f6-11ea-8ae0-77e95a12c0a1.png)

두번째는 `tearDownWithError()` 메소드다.

해당 메소드는 테스트 케이스의 각 테스트가 끝난 이후 이에 대한 정리와 `throw` 기능을 제공한다.

따라서, `setUpWithError` 는 초기화 코드 , `tearDownWithError`는 해제 코드를 작성하는 것이다.

필자는 본 문서에서는 위 메소드들을 모두 지우고 진행하도록 한다.


이후 프로젝트 파일 내에 테스트를 진행하기 위한 클래스와 메소드들을 정의한다.

```swift
//
//  MathStuff.swift
//  Test
//
//  Created by Yeojaeng on 2020/05/29.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import Foundation

public class MathStuff {
    
    func addNumbers(x: Int, y: Int) -> Int {
        return x+y
    }
    
    func multipleNumbers(x: Int, y: Int) -> Int {
        return x*y
    }
    
    func divideNumbers(x: Int, y: Int) -> Int {
        return x/y
    }
}

```

간단히 두개의 정수를 전달받아 함수에 따라 더하기, 곱하기, 나누기 연산을 지원하는 메소드들을 작성한다.

이후 Test.swift 파일로 이동하여 테스트 코드를 작성한다.

테스트 구현시 우리는 `XCTAssert` 류의 함수들을 이용할 수 있다.

`XCTAssert` 류의 함수들은 내부 파라미터로 넘겨지는 식이 true면 성공하는 함수이다.

- XCTAssertNil()
- XCTAssertNotNil()
- XCTAssertTrue()
- XCTAssertFalse()
- XCTAssertEquals()

등 매우 다양한 함수를 제공한다.


![image](https://user-images.githubusercontent.com/33051018/83262587-387e8b00-a1f8-11ea-83a4-6754891a5598.png)

메소드가 의도대로 동작하면 `Test Successed`를 띄우고, 그 외의 경우는 아래처럼 에러가 발생한다.

![image](https://user-images.githubusercontent.com/33051018/83262745-74195500-a1f8-11ea-82af-467991fed354.png)

위와 같이 프로젝트 파일에서 테스트하고자 하는 함수 등을 `Test.swift` 파일에 작성하고 이를 실행하면 예상 출력값을 통해 정상 작동여부를 확인할 수 있다.

![image](https://user-images.githubusercontent.com/33051018/83263288-50a2da00-a1f9-11ea-9fac-82c46de051e5.png)

<br>

### 결론
---

오늘은 `UnitTest` 기능을 이용해 간단히 테스트를 진행해보았다.

비록 실제 앱을 구성하는 코드를 작성하는 만큼 Test 코드도 작성해야하지만 앞으로는 프로젝트를 진행하거나 앱을 만들때 TDD 방법론을 지향하며 단위 테스트를 작성하는 습관을 들여야겠다.



