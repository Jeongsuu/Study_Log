---

---

### 내비게이션 인터페이스란?

---

iOS에서 내비게이션 인터페이스는 주로 계층적 구조의 화면전환을 위해 사용되는 드릴 다운 인터페이스를 의미한다.

드릴 다운 인터페이스란 아래 그림과 같이 각 선택할 수 있는 항목에 대한 세부항목이 존재하는 인터페이스다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f298f865-e728-4bb1-acb5-7d51a8ea055b/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f298f865-e728-4bb1-acb5-7d51a8ea055b/Untitled.png)

**내비게이션 인터페이스는 내비게이션 컨트롤러를 통해 구현한다.**

### 내비게이션 컨트롤러

---

내비게이션 컨트롤러는 컨테이너 뷰 컨트롤러로써 내비게이션 스택을 사용하여 다른 뷰 컨트롤러를 고나리한다.

여기서 내비게이션 스택에 담겨 콘텐츠를 보여주게 되는 뷰 컨트롤러들을 컨텐트 뷰 컨트롤러 라고 한다.

내비게이션 컨트롤러는 두개의 뷰를 화면에 표시한다. 하나는 내비게이션 스택뷰에 포함된 최상위 컨텐트 뷰 컨트롤러의 콘텐츠를 나타내는 뷰와 내비게이션 컨트롤러가 직접 관리하는 뷰 (내비게이션바 또는 툴바)가 있다.

추가로 내비게이션 인터페이스 변화에 따른 특정 액션을 동작하도록 하기 위해 내비게이션 델리게이트 객체를 사용할 수 있다.

### 내비게이션 스택이란?

---

내비게이션 컨트롤러에 의해 관리되는 내비게이션 스택은 뷰 컨트롤러를 담을 수 있는 배열이다.

내비게이션 스택 : 뷰 컨트롤러를 담을 수 있는 배열
내비게이션 스택은 내비게이션 컨트롤러에 의해 관리된다.

내비게이션 스택에 가장 하위에 있는 (가장 먼저 스택에 추가된) 뷰 컨트롤러는 내비게이션 루트 뷰 컨트롤러다.

내비게이션 스택 내 뷰 중 최하위 컨트롤러는 루트 뷰 컨트롤러다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b45735b7-2fba-46d9-9f18-2e3c8dfbf304/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b45735b7-2fba-46d9-9f18-2e3c8dfbf304/Untitled.png)

이름에서도 알 수 있듯 내비게이션 스택은 푸시, 팝 을 통해 아이템( 뷰 컨트롤러  )를 관리한다.

새로운 뷰 컨트롤러를 내비게이션 스택에 푸시하거나 기존 뷰 컨트롤러를 삭제하기 위해 팝을 사용한다.

내비게이션 스택에 푸시된 각 뷰 컨트롤러들은 애플리케이션에 자신이 가지고 있는 뷰 게층 구조를 통해 컨텐츠를 표시하게 된다.

### 내비게이션 스택에서의 화면이동

---

`UINavigationController` 클래스의 메서드 또는 `세그(segue)` 를 사용하여 내비게이션 스택의 뷰 컨트롤러를 추가 또는 삭제할 수 있다.

segue : 스토리보드에서 한 화면에서 다른 화면으로의 전환

세그도 내부적으로는 `UINavigationController` 클래스의 메서드를 사용한다.

### 내비게이션 스택의 푸시 (push)

---

내비게이션 스택에 새로운 뷰 컨트롤러가 푸시 될 때 `UIViewController` 인스턴스가 생성되고 내비게이션 스택에 추가된다.

1. 가장 먼저 내비게이션 스택에 루트 뷰 컨트롤러만 들어가 있는 초기상태다.
( 내비게이션 컨트롤러를 생성할 때 반드시 루트 뷰 컨트롤러가 설정되어 있어야 한다. )

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7434b65c-fe9e-4ea1-a1a0-514c8a52df33/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7434b65c-fe9e-4ea1-a1a0-514c8a52df33/Untitled.png)

2. '뷰 컨트롤러1로 이동' 이라는 버튼을 통해서 내비게이션 스택에 뷰 컨트롤러1을 푸시한다.

뷰 컨트롤러1의 인스턴스가 생성되고 내비게이션 스택에 추가된다. 

뷰 컨트롤러1이 최상위 뷰 컨트롤러로써 화면에 보이게된다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fea407ca-561f-438f-8bc7-57f3c7f999b3/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fea407ca-561f-438f-8bc7-57f3c7f999b3/Untitled.png)

3. '뷰 컨트롤러2로 이동' 버튼을 통해 내비게이션 스택에 뷰 컨트롤러2도 푸시한다.

뷰 컨트롤러2의 인스턴스가 생성되고 내비게이션 스택에 추가된다.

뷰 컨트롤러2가 최상위 뷰 컨트롤러로써 화면에 보이게 된다. 

여기서 주목할 점은 새로운 뷰 컨트롤러가 추가될 때에도 아래에 있는 뷰 컨트롤러들이(인스턴스) 삭제되지 않고 유지된다.

### 내비게이션 스택의 팝 (pop)

---

내비게이션 스택에 존재하는 뷰 컨트롤러가 팝 될 때 생성되었던 `UIViewController` 의 인스턴스는 다른 곳에서 참조되고 있지 않다면 메모리에서 해제되고, 내비게이션 스택에서 삭제된다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2b856268-c6d9-4da0-9986-c44c7c095192/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2b856268-c6d9-4da0-9986-c44c7c095192/Untitled.png)

1. 푸시 예제의 마지막 상태에서 상단 내비게이션바에 있는 뷰 컨트롤러1을 (back button) 눌러서 뷰 컨트롤러2를 팝 한다. 뷰 컨트롤러2가 내비게이션 스택에서 삭제된다.

    따라서, 그 아래에 있던 뷰 컨트롤러1이 다시 최상위 뷰 컨트롤러로써 화면에 보여지게 된다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/af446859-e8cd-43f6-b2cb-8915ec72cd22/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/af446859-e8cd-43f6-b2cb-8915ec72cd22/Untitled.png)

2. 내비게이션바에서 루트 뷰 컨트롤러를(back button) 눌러서 뷰 컨트롤러1을 팝한다. 뷰 컨트롤러1이 메모리에서 해제되고 내비게이션 스택에서 삭제된다.

루트 뷰 컨트롤러가 최상위 뷰 컨트롤러가 되고 화면에 보여지게 된다. 루트 뷰 컨트롤러는 내비게이션 스택에서 팝되지 않는다.

상단에 내비게이션바를 통해서도 루트 뷰 컨트롤러를 팝 하는 버튼이 따로 생성되지 않는다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f9242c57-cf33-4c4d-afca-f1f849ef941f/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f9242c57-cf33-4c4d-afca-f1f849ef941f/Untitled.png)

### UINavigation Controller 클래스

---

위에서 설명한 내비게이션 컨트롤러와 내비게이션 스택의 동작들이  UINavigationController 클래스에서 어떻게 구현되어 있는지 살펴본다.

- 내비게이션 컨트롤러의 생성

    // 내비게이션 컨트롤러 인스턴스 생성 메서드
    // 매개변수로 네비게이션 스택의 최하위에 있는 루트 뷰 컨트롤러가 될 뷰 컨트롤러를 넘겨준다.
    
    init(rootViewController: UIViewController)

- 내비게이션 스택의 뷰 컨트롤러에 대한 접근

    // 내비게이션 스택에 있는 최상위 뷰 컨트롤러에 접근하기 위한 프로퍼티
    var topViewController: UIViewController?
    
    // 현재 내비게이션 인터페이스에서 보이는 뷰의 컨트롤러에 접근하기 위한 프로퍼티
    var visibleViewController: UIViewController?
    
    // 내비게이션 스택에 특정 뷰 컨트롤러에 접근하기 위한 프로퍼티 ( 루트 뷰 컨트롤러 인덱스 = 0 )
    var viewController:[UIViewController]

- 내비게이션 스택의 푸시와 팝에 관한 메서드

    // 내비게이션 스택에 뷰 컨트롤러를 푸시한다.
    // 푸시 된 뷰 컨트롤러는 최상위 뷰 컨트롤러로 화면에 표시된다.
    func pushViewController(UIViewCOntroller, animated:Bool)
    
    // 내비게이션 스택에 있는 최상위 뷰 컨트롤러를 팝한다.
    // 최상위 뷰 컨트롤러 아래에 있던 뷰 컨트롤러의 컨텐츠가 화면에 표시된다.
    func popViewController(animated: Bool) -> UIViewController?
    
    // 내비게이션 스택에서 루트 뷰 컨트롤러를 제외한 모든 뷰 컨트롤러를 POP
    func popToRootViewController(animated: Bool) -> [UIViewController]?
    
    // 특정 뷰 컨트롤러가 내비게이션 스택에 최상위 뷰 컨트롤러가 되기 전 까지 상위에 있는 뷰 컨트롤러들을 팝한다.
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
