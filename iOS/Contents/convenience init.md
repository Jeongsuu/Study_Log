# convenience init

<br>

`Swift`에서 이용되는 init은 다른 언어에서의 init과 같이 동일하게 **생성자** 역할을 하며 `designated init` 과 `convenience init`으로 나뉘어진다.

우리가 일반적으로 쓰는 `init()` 이 `designated init`이다.

`designated init`은 반드시 1개는 있어야 하고, `convenience init`은 말 그대로 보다 유연하고 간편하게 쓰려고 만드는 생성자다.

```swift
class Person {
    var name: String
    var age: Int
    var height: Int
    var weight: Int
    
    init(name: String, age: Int, height: Int, weight: Int) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
    }
}
```

위 예시가 우리가 일반적으로 사용하던 `designated init`이다.

이 init은 클래스 내 모든 프로퍼티를 의무적으로 초기화 시켜줘야 한다.

만일, 프로퍼티 중 단 한가지라도 초기화시켜주지 않으면 에러를 뿜는다..

![image](https://user-images.githubusercontent.com/33051018/95325197-cd4a7100-08db-11eb-9f2c-31a1d5bdb539.png)
(요로코롬..)

그렇다면 `convenience init`은 어떤 기능을 제공하는지 살펴보자!

`convenience init`은 `designated init`을 보조하는 보조 생성자 역할을 한다.

`designated init`의 파라미터 중 일부를 기본값으로 가지도록 하여 `convenience init` 내부에서 `designated init`을 호출하도록 한다.

즉, `convenience init`을 사용하기 위해서는 반드시 `designated init` 이 선언되어 있어야한다.

```swift
class Person {
    var name: String
    var age: Int
    var height: Int
    var weight: Int
    
    init(name: String, age: Int, height: Int, weight: Int) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
    }
    
    convenience init(age: Int, height: Int, weight: Int) {
        self.init(name: "기본값", age: age, height: height, weight: weight)
    }
}
```

이와 같이 기존의 `designated init`에서 `name` 프로퍼티를 기본값으로 갖도록 하는 `convenience init`을 만들어서 사용할 수 있다.

![image](https://user-images.githubusercontent.com/33051018/95325909-c96b1e80-08dc-11eb-9baf-5eefd01fafb9.png)


이와 같이 사용하면 당연히 파라미터로 넘겨주지 않은 데이터는 기본값을 갖는 인스턴스로 생성된다.

![image](https://user-images.githubusercontent.com/33051018/95326118-0c2cf680-08dd-11eb-9d1c-c088339a9706.png)

```swift
// 아무개
// 기본값
```

결과적으로 `convenience init`을 사용하면 `designated innit`을 보조하는 역할로서 이를 기반으로 하여 재사용성에 이점을 가져갈 수 있다.