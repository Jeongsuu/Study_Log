## 빈 (Bean)

---

---

### 빈 (Bean)

***빈은 스프링 IoC 컨테이너가 관리하는 객체를 의미한다.***

    @Test
    public void getBean() {
    	
    	OwnerController ownerController = new OwnerController;  //객체 생성
    	
    	OwnerController bean = applicationContext.getBean(OwnerController.class);
    	//객체 생성
    	
    }

첫번째로 객체를 생성하는 부분, 즉 생성자를 통해 생성하는 부분은 빈이 아니다.

그러나 두번쨰로 `applicationContext` 클래스의 `getBean` 을 생성하는것은 빈이 맞다.

스프링에서 얘기하는 빈은 `applicationContext` 가 알고있는 객체, `applicationContext` 가 만들어서 그 안에 담고있는 객체가 빈이다.

오로지 이렇게 생성된 빈들만 의존성 주입이 가능하다.

---

### 빈을 어떻게 등록하지?

- ***Component Scanning***
    - @ComponentScan 이라는 어노테이션이 붙은 부분부터 하위 폴더를 뒤져보며 빈을 등록한다.
    `ComponentScan` 은 어느 지점부터 찾을것인지 알려주는것.
    - 실제 찾게될 어노테이션은 @Bean, @Controller, @Component, @Repository, @Service, @configuration  ...etc
- ***직접 빈으로 등록하는 방법***
    - XML 또는 자바 설정 파일에 등록

    **자바 설정파일을 통해 설정하는 방법**

        // SampleConfig
        
        @Configuration
        public class SampleConfig {
        	
        	@Bean
        	public SampleController sampleController() {
        		return new SampleController();
        	}
        }

    설정 파일을 의미하는 어노테이션 `@Configuration` 이 지정된 클래스에서 `@Bean` 이라는 어노테이션을 통해 생성자에 지정해놓으면 해당 메서드가 리턴하는 객체가 IoC컨테이너 안에 등록이 된다.

    ---

    ### 어떻게 꺼내서 쓰지?

- `ApplicationContext` 를 이용하여 객체를 생성
- `Autowired` 어노테이션을 통해 꺼내오기.

        public OwnerController(OwnerRepository clinicService, VisitRepository visits) {
        		this.owners = clinicService;
        
        -> 
        
        @Autowired
        private OwnerRepository owners;

    직접 `ApplicationContext` 에서 꺼내오는 방법 보다는 Annotation 을 통해 가져오는 경우가 많을 것임.
