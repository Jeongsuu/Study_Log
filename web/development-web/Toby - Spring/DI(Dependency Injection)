## DI (Dependecy Injection)

---

---

**필요한 의존성을 어떻게 받아올 것인가.**

`Autowired` / `Inject` annotation을 어디에 붙일까?

- 생성자
- 필드
- Setter

---

`AutoWired` 라는 annotation이 있다.

생성자 대신에 이 anootation을 사용하면 의존성을 주입할 수 있다.

`OwnerController` 생성자를 살펴본다.

    public OwnerController(OwnerRepository clinicService, VisitRepository visits) {
    		this.owners = clinicService;
    		this.visits = visits;
    	}

기존 코드는 생성자를 통해서 객체를 생성한다.

이를 annotation을 이용해 필드로 바로 의존성을 주입하는 방법은 아래와 같다.

    @Autowired
    private ownerRepository owners;
    
    @autowired
    private VisitRepository visits;

혹은 `Setter()` 를 이용한 방법도 있다.

    @Autowired
    public void setOwners(OwnerRepository owners) {
    	this.owners = owners;
    }

그러면 스프링 IoC 컨테이너가 OwnerController 클래스의 인스턴스를 만들고 setter를 통해서 IoC컨테이너에 들어있는 빈 중에 OwnerRepository 타입을 찾아서 여기에 넣어준다.

**여기서 스프링 프레임워크 레퍼런스에서 권장하는 방법은 생성자를 이용한 방법이다.**

 

    @Controller
    class OwnerController {
    
    	private static final String VIEWS_OWNER_CREATE_OR_UPDATE_FORM = "owners/createOrUpdateOwnerForm";
    
    	private final OwnerRepository owners;
    	private final VisitRepository visits;
    
    	public OwnerController(OwnerRepository clinicService, VisitRepository visits) {
    		this.owners = clinicService;
    		this.visits = visits;
    	}

OwnerController의 인스턴스를 만들기 위해서는 OwnerRepository 객체와 VisitRepository 객체가 필수적으로 있어야한다. → 객체 생성을 강제화한다 → 코드를 안전하게 돌리기 위해 생성자 방법을 권고한다.
