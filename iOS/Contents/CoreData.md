# Core Data

<br>

iOS 앱을 개발할 때 내부에 데이터를 저장하여 활용하는 방법 중 오픈 소스를 활용하지 않는 방법은 대표적으로 2가지가 있다.

`UserDefault` 와 `CoreData` 가 존재한다.

하지만 두 기능은 목적이 다르며 쓰임새도 당연히 다르다.

`UserDefault` 는 이름 그대로 사용자의 기본적인 설정값, 상대적으로 가볍고 복잡하지 않은 데이터를 저장하기 위한 기능이고 `CoreData` 는 `UserDefault` 보다는 더 복잡하고 무거운 데이터를 처리하기에 적합하다.

<br>

## OverView
---

코어 데이터를 사용하여 오프라인 사용을 위해 애플리케이션의 영구 데이터를 저장하고 임시 데이터를 캐시한다.

코어 데이터의 Data Model Editor를 통하여 우리는 데이터의 타입과 관게를 지정할 수 있다. 또한 각각의 클래스의 정의도 가능하다.

코어 데이터는 런타임시 아래 특징들에 대하여 객체 인스턴스들을 관리할 수 있다.

### Persistence

코어 데이터는 저장하고자 하는 객체의 세부사항을 추상화하여 DB를 직접 관리하지 않고도 Swift 또는 Objective-C 에서 데이터를 쉽게 저장할 수 있다.

### Undo and Redo of Individual or Batched Changes

코어 데이터의 실행 취소 관리자는 변경 사항을 추적하여 이를 개별적으로 되돌릴 수 있다.

### Background Data Tasks

백그라운드에서 JSON을 파싱하여 객체로 변환하는 것과 같이 UI 차단 데이터 작업을 수행할 수 잇다.

이후 해당 결과를 캐시하거나 저장하여 서버 왕복을 줄일 수 있다.

### View Synchronization

코어 데이터는 테이블 뷰 또는 컬렉션 뷰에 대한 데이터 소스를 제공하여 뷰와 데이터 동기화에 도움이 된다.

### Versioning and Migration

코어 데이터는 앱이 발전함에 따라 모델을 지정하고 사용자 데이터를 마이그레이션하는 메커니즘을 포함하고 있다.


<br>


## Tutorial
---

본 튜토리얼은 [raywenderlich.com](https://www.raywenderlich.com/7569-getting-started-with-core-data-tutorial) 튜토리얼을 기준으로 진행하였다.

### Goal

- Xcode 모델 에디터를 활용한 모델 데이터 사용
- 코어 데이터에 새로운 레코드 더하기
- 코어 데이터로 부터 저장한 레코드 가져오기
- 테이블 뷰를 활용하여 가져온 데이터 보여주기

또한 코어 데이터가 `scene` 뒤에서 어떠한 일을 하는지, 어떻게 동작을 하는지 알아볼 것이다.

<br>

### Getting Started

Xcode를 열어 새로운 프로젝트를 생성한다.

이 때, **Use Core Data** 옵션을 꼭 꼭 체크하자!

![image](https://user-images.githubusercontent.com/33051018/87215786-e5f6c980-c374-11ea-8e10-af09ef985aeb.png)

프로젝트를 생성하면 위와 같은 프로젝트 구조를 확인할 수 있다.

기존에 살펴보지 못햇던 `.xcdatamodeld` 파일도 확인할 수 잇다.

`AppDelegate.swift` 파일로 이동해보자.

```swift
// MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
```

파일 하단에 `NSPersistentContainer` 라는 변수를 확인할 수 있다.

**NSPersistentContainer** 는 코어 데이터에 데이터를 저장하고 이로부터 데이터를 가져오는데 용이하게 해주는 객체들의 집합으로 구성되어 있다.

컨테이너 내부에는 Core Data의 상태를 전체적으로 관리하는 객체가 존재한다.

`Standard Stack`은 대부분의 앱에서 잘 작동하지만 앱과 데이터 요구사항에 따라서 스택을 더욱 효율적으로 사용할 수 있다.

이번에 튜토리얼을 진행하며 만들어 볼 샘플 앱은 매우 간단하다.

테이블 뷰를 통해 `hit list` 라는 우리의 데이터 모델 내 레코드들을 뿌려줄 것이다.

우리는 해당 리스트에 데이터(name)을 추가 또한 해야하고, 결과적으로 코어 데이터를 이용하여 세션 간에 데이터가 저장되도록 할 것이다.

![image](https://user-images.githubusercontent.com/33051018/87215979-299e0300-c376-11ea-9fcc-e01b7b0cf938.png)

`UI` 를 위와 같이 구성한다.

네비게이션 컨트롤러를 사용하고 테이블 뷰를 배치해준다.

```swift
import UIKit

class ViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        
        // register the tableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // touchUpInside add bar button
    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        // Make AlertController instance
        let alert: UIAlertController = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        // Make Save AlertAction
        let saveAction: UIAlertAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            // UIAlertController.textField : The array of text fields displayed by the alert.
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else { return }
            // alert창의 텍스트필드에 입력받은 데이터 추출.
            
            self.names.append(nameToSave)
            self.tableView.reloadData()
        }
        
        // Make Cancel AlertAction
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // UIAlertController.addTextField : alert 창에 텍스트 필드 더하기
        alert.addTextField(configurationHandler: nil)
        
        // alert 창에 액션 더하기
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    //MARK:- DataSource method
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
}


```

예제 코드는 위와 같다.

위 코드는 `Core Data`를 사용하지 않고 ViewController.swift 파일 내에서 배열을 이용해 일시적으로 데이터를 저장하기 때문에 일시적으로 기능은 정상 작동하지만 앱을 꺼버리는 순간 데이터가 날아간다.

즉, `persistence` 한 속성을 갖지 못한다.

이러한 속성을 갖기 위해 우리는 `Core Data` 를 사용해보도록 한다.

`Core Data`는 `persistence`를 제공한다, 즉 데이터를 디바이스 내에 저장하여 앱을 다시 시작하거나 기기를 재부팅하여도 정상적으로 데이터를 이용한 CRUD 작업이 가능하다.

<br>

### Data Modeling

이제 persistence 한 데이터를 사용하기 위해 CoreData를 사용할 것이다.

이를 위해 첫 번째로 할 일은 사용할 모델 객체를 생성하는 것이다

모델링을 하기에 앞서 Core Data에서 사용하는 용어들에 대하여 간단히 살펴보고 진행한다.

- `entity` : 코어 데이터에서 클래스 역할을 한다. 예를 들면 `Employee`, `Person`, `Company` 등이 될 수 있고 이는 관계형 데이터베이스에서 **테이블**의 역할을 한다.

- `attribute` : 특정 entity에서 이용되는 정보를 의미한다. 간단한 예시로 `Employee` entity는 name, position, salary 등 과 같은 속성을 가질 수 있다.

- `relationship` : 여려개의 entity 간의 링크를 의미한다. 코어 데이터 내에서 1:1 관계를 to-one 관계, 1:N 관계를 to-many 관계라고 한다. 예를 들어 `Manager`는 여러 `Employee` entity 들과의 링크를 갖게 되어 `to-many` 관계를 형성할 수 있다. 반면 모든 `Employee` entity는 그의 `manager` entity와 각각 `to-one` 관계를 갖게된다.

`[Filename].xcdatamodeld` 파일을 열고 아래와 같이 모델을 생성해본다.

![image](https://user-images.githubusercontent.com/33051018/87222462-c11f4800-c3ae-11ea-9f85-b714f3ad40ad.png)

`Person` entity는 String 타입의 `name` 이라는 attribute를 갖는다.

<br>

### Saving to Core Data

그냥 String 타입의 이름을 저장하기 보다는 Person 이라는 엔티티를 저장하는 것이 더욱 직관적이다.

따라서, 기존에 선언한 배열 `var name: [String] = []` 문을 아래로 대체한다.

```swift
var people: [NSManagedObject] = []
```

`NSManagedObject` 라는 자료형을 갖는 원소들의 배열로 생성하였다.

`NSManagedObject` 란, Core Data 모델 객체에 필요한 동작을 구현하는 기본 클래스다. 따라서 해당 클래스의 인스턴스는 Core Data 내에 저장된 단일 객체를 의미한다.

이를 통해 이제 단순한 문자열을 저장하는 배열이 아닌 `NSManagedObject`의 인스턴스를 저장하는 배열을 갖게 되었다.

**`NSManagedObject` 는 원하는 것에 맞춰서 다양하게 변할 수 있는 shape-shifter이다.**

데이터 모델 내 어느 엔티티라도 소화할 수 있는 능력을 갖고있다.

이에 맞춰서 DataSource 메소드들을 변경시켜준다.

```swift
// numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
// cellForRowAt
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // person 가져오기
        let person: NSManagedObject = people[indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // person의 name값 뽑아오기
        cell.textLabel?.text = person.value(forKey: "name") as? String
        
        return cell
    }
```

cell 의 textLabel에 값을 넣어주는 부분을 살펴보자.

`cell.textLabel?.text = person.value(forkey: "name") as? String`

`perosn` 객체는 `NSManagedObject` 타입이다. `NSManagedObject` 는 우리가 데이터 모델에서 정의한 `name` 속성을 모른다.

따라서, 해당 프로퍼티에 다이렉트로 접근할 방법이 없다. Core Data가 제공하는 value를 읽어오는 유일한 방법은 `KVC(key-value coding)` 이다. 

person 객체에서 key값이 name인 value를 가져온다. 

`value(forkey:)` 메소드의 반환값은 `Any?` 기 때문에 이를 `String` 으로 다운캐스팅 한 뒤 textLabel에 넣는다.

코어 데이터 내에서 데이터를 가져오는 방법은 알아보았으니 이제 코어 데이터 내에 데이터를 저장하는 방법에 대해 살펴본다.

```swift
func save(name: String) {
        // 0 : appDelegate 참조 획득
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 1 : ManagedObjectContext 생성
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2 : 
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        person.setValue(name, forKey: "name")
        
        // 4
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
```

Core Data로 부터 데이터를 가져오거나 데이터를 저장하기 위해서는 `NSManagedObjectContext` 를 생성해야 한다.

우리는 프로젝트를 생성하기에 앞서 `Use Core Data` 버튼을 체크하였다.

1. 기본 ManagedObjectContext는 AppDelegate 파일 내에 `NSPersistentContainer` 내에 프로퍼티로 정의되어 있다. 이에 접근하기 위해서는 첫 번째로 appDelegate 참조를 획득해야 한다.

2. 새로운 ManagedObjectContext를 생성하고 객체를 삽입해야 한다. 이는 `NSManagedObject.entity(forEntityName:in:)` 이라는 static method를 이용해 진행할 수 있다.

3. KVC를 이용하여 `name` 속성을 지정한다.

4. 변화 내용 commit & 데이터 save

이제 Saving Data 구현은 끝났다.

<br>

### Fetching from Core Data

managed object context 내 persistence 한 데이터를 가져오기 위해서는 아래와 같이 `viewWillAppear` 메소드를 작성한다.

```swift
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        guard let appDelegate:AppDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        // 3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
```

1. 코어 데이터로 어떠한 일을 하던간에, 우리는 **NSManagedObjectContext** 객체가 필요하다. 데이터를 가져오는 것 또한 똑같다. appDelegate 참조를 획득하고 이를 통해 persistentContainer에 접근하여 NSManagedObjectContext 참조를 획득한다.

2. 코어 데이터로부터 데이터를 가져올때는 제네릭 타입을 이용하는 `NSFetchRequest` 를 사용한다. NSManagedObject 타입을 반환받도록 설정.

3. NSManagedObjectContext.fetch() 메소드를 통해서 데이터 가져오기.

<br>

## Summary
---

- **`NSPersistentContainer` 는 코어 데이터에 데이터를 저장하고 이로부터 데이터를 가져오는데 용이하게 해주는 객체들의 집합으로 구성되어 있다.**

- **`register(_:forCellReuseIdentifier:)` : 테이블 뷰에서 사용할 셀 클래스를 등록하는 함수**

- `entity` : 코어 데이터에서 클래스 역할을 한다. 예를 들면 `Employee`, `Person`, `Company` 등이 될 수 있고 이는 관계형 데이터베이스에서 **테이블**의 역할을 한다.

- `attribute` : 특정 entity에서 이용되는 정보를 의미한다. 간단한 예시로 `Employee` entity는 name, position, salary 등 과 같은 속성을 가질 수 있다.

- `relationship` : 여려개의 entity 간의 링크를 의미한다. 코어 데이터 내에서 1:1 관계를 to-one 관계, 1:N 관계를 to-many 관계라고 한다.

- `NSManagedObject` 란, Core Data 모델 객체에 필요한 동작을 구현하는 기본 클래스다. `KVC`를 통해 속성을 읽고 쓸 수 있다.

**`NSManagedObject` 는 원하는 엔티티에 맞춰서 다양하게 변할 수 있는 shape-shifter이다. 데이터 모델 내 어느 엔티티라도 소화할 수 있는 능력을 갖고있다.**

- Core Data가 제공하는 value를 읽어오는 유일한 방법은 `KVC(key-value coding)` 이다. 

- Core Data로 어떠한 일을 하던간에, 이에 접근하기 위해서는 **NSManagedObjectContext** 참조가 필요하다. 이를 위해서는 appDelegate 참조를 획득하고 appDelegate.persistentContainer.viewContext 를 통해 참조를 획득한다.

- `save() , fetch(_:)` 메소드는 에러가 발생할 수 있기 때문에 `do~catch` 블록을 이용한다.

- Core Data는 `on-disk persistence`를 제공한다. 따라서 앱이 죽거나 디바이스가 죽은 이후에도 데이터에 접근이 가능하다. -> `in-memory persistence`와의 차이점

- Xcode는 `Data Model Editor` 기능을 제공한다. 이를 통해 우리는 관리할 `object model`을 생성할 수 있다.

- `Managed Object Model`은 entity, attribute, relationship 으로 구성된다.

- managed object model 이란 `entity` 라고 불리는 모델 객체를 의미한다. NSManagedObjectModel 클래스를 이용하여 entity에 접근한다.

- `NSPersistentStoreCoordinator` 는 실제 데이터베이스를 관리한다.

- `NSManagedObjectContext` 를 통해 엔티티를 생성하고, 수정하고, 가져온다. 코어데이터와의 상호작용을 위해서는 `NSManagedObjectContext` 를 반드시 사용해야 한다.