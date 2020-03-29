## 5. Inversion of Control

[예제로 배우는 스프링 입문 5. Inversion of Control](https://www.youtube.com/watch?v=NZ_lPFvu9oU&list=PLfI752FpVCS8_5t29DWnsrL9NudvKDAKY&index=5)

---

---

### Inversion of Control

- 일반적인 (의존성에 대한) 제어권 : '내가 사용할 의존성은 내가 만든다"

    class OwnerController{
    	private OwnerRepository repository = new OwnerRepository();
    }

일반적인 경우는 위와 같다.

자기가 사용할 의존성을 직접 자기가 생성자를 통해 만들어서 생성한다.

여기서 자기란 'OwnerController' 다. 

그런데 얘가 직접 관리하는게 아니라 아래처럼 하는게 `IOC`

    class OwnerController {
    	private OwnerRepository repo;
    
    	public OnwerController(OwnerRepository repo) {
    		this.repo = repo;
    	}
    }
    
    class OwnerControllerTst {
    	@Test
    	public void create() {
    			OwnerRepository repo = new OwnerRepository();
    			OwnerController controller = new OwnerController(repo);
    	}
    }

위 예시는 `OwnerController` 가 `OwnerRepository` 를 사용을 하지만 직접 생성하지는 않는다.

누군가가 `OwnerController` 코드 밖에서 만들어서 제공한다. 

이러한 의존성을 만드는 일은 더이상 `OwnerController`가 하는일이 아니다.

이 의존성을 관리해주는 것은 누군가 밖에서 해주므로 제어권이 역전되었다 라고 표현한다.

실제 예제 프로젝트 코드를 살펴보자.

    // OwnerController.java
    
    public OwnerController(OwnerRepository clinicService) {
    		this.owners = clinicService;
    	}

 `OwnerController`의 인스턴스를 만들기 위해서는 `OwnerRepository`가 필요하다.

즉, `OwnerRepository` 없이는 `OwnerController` 를 만들수 없다.

그러면 이 `Dependency` , 의존성인 OwnerRepository는 누가 넣어주냐?

스프링에 있는 IOC 컨테이너가 만들어준다. → 스프링이 관리하는 객체 : `Bean`

어떻게 알고 넣어주냐? → 특정 생성자 또는 특정 **어노테이션을 보고 주입해준다.**
