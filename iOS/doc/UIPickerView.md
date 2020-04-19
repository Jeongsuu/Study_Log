# UIPickerView
---

**cf) [UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview)**

# INDEX

[1. Declaration](#Declaration)<br>
[2. Overview](#Overview)<br>
[3. Topics](#Topics)<br>
[4. UIPickerDataSource](#UIPickerViewDataSource)<br>
[5. UIPickerViewDelegate](#UIPickerViewDelegate)
-   [Declaration](#UIPickerViewDelegate-Declaration)
-   [UIPickerViewDelegate Overview](#UIPickerViewDelegate-Overview)
-   [UIPickerViewDelegate Topics](#UIPickerViewDelegate-Topics)

<br><br>

`UIPickerView` 클래스는 하나 이상의 값을 세트로 표시하기 위한 슬롯 뷰를 제공한다.

### Declaration
---

```swift
class UIPickerView: UIView
```

<br><br>

### Overview
---
`picker view`는 사용자가 아이템을 선택하기 위해 선택 가능한 항목을 나타내는 일련의 행의 모임이다.

각각의 행은 사용자가 해당 행에서 항목을 식별할 수 있도록 문자열 또는 뷰를 제공한다.

사용자는 휠을 이용해 해당 값으로 휠을 회전시켜 picker view 내에서 해당 항목을 선택한다.

`picker data source`를 이용하여 `picker view`에 표시할 데이터를 제공한다.

이는 `UIPickerViewDataSource` 프로토콜을 채택하여 기능을 구현한다.

또한 `UIPickerViewDelegate` 프로토콜을 채택하여 데이터를 보여주고 사용자와 `picker view` 사이의 상호작용 기능을 제공한다.

<br><br>

### Topics
---

#### Providing the Picker Data

```swift
var dataSource: UIPickerViewDataSource?
```

picker view의 데이터소스이다.

<br>

#### Customizing the Picker Behavior

```swift
var delegate: UIPickerViewDelegate?
```

picker view의 델리게이트다.

<br>

#### Getting the Dimensions of the View Picker

```swift
var numberOfComponents: Int
// picker view 에서 사용된 컴포넌트의 개수를 가져온다.

func numberOfRows(inComponent: Int) -> Int
// 컴포넌트의 행의 개수를 반환한다.

func rowSize(forComponent: Int) -> CGSize
// 컴포넌트의 행의 크기를 반환한다.
```
<br>

#### Reloading the View Picker

```swift
func reloadAllComponents()
// picker view 내 모든 컴포넌트들을 다시 불러온다. -> update 기능

func reloadComponent(Int)
// picker view 내 특정 컴포넌트를 다시 불러온다. -> 특정 컴포넌트 update 기능
```

#### Selecting Rows in the View Picker

```swift
func selectRow(Int, inComponent: Int, animated: Bool)
// picker view 내 특정 컴포넌트의 행을 선택한다.

func selectedRow(inComponent: Int) -> Int 
// 선택된 컴포넌트의 행 인덱스 값을 반환한다.
```

#### Returning the View for a Row and Component

```swift
func view(forRow: Int, forComponent: Int) -> UIView?
// 인자로 전달받은 행과 컴포넌트가 picker view 내에서 사용된 뷰를 반환한다.
```

<br> <br>

### UIPickerViewDataSource
---

`UIPickerViewDataSource`는 프로토콜이다.

`UIPickerViewDataSource` 프로토콜은 pickerView 객체와 애플리케이션의 데이터 모델 사이를 중개하는 객체에 의해 채택되어야 한다.

data source 는 picker view에 컴포넌트 개수를 제공하며, 각각의 컴포넌트들의 행의 숫자를 제공한다. 이는 picker view 에 데이터를 표시하기 위해 사용되며 이 프로토콜은 아래 두가지 메소드를 반드시`(@Required)` 구현해야 한다.

#### Providing Counts for the Picker View
```swift
func numberOfComponents(in: UIPickerView) -> Int
// picker view를 이루는 컴포넌트의 개수를 알고싶을때 picker view에 의해 호출된다.

func pickerView(UIPickerView, numberOfRowsInComponent: Int) -> Int
// 특정 컴포넌트의 행 숫자를 알고싶을때 picker view에 의해 호출된다.
```

<br> 

### UIPickerViewDelegate
---

`UIPickerViewDelegate` 또한 프로토콜이다.

`UIPickerView`의 객체가 해당 프로토콜을 채택하고 프로토콜 내 약속된 메소드를 구현하여 picker view 구성에 필요한 데이터를 제공한다.


#### UIPickerViewDelegate Declaration

```swift
protocol UIPickerViewDelegate
```

선언은 위와 같이 한다.
<br>

#### UIPickerViewDelegate Overview

델리게이트는 이 프로토콜에 약속된 필수 메소드들을 구현하여 컴포넌트의 높이, 너비, 행 제목 등등에 대한 뷰 컨텐츠를 리턴한다.

각 컴포넌트는 행의 컨텐츠를 문자열 또는 뷰로 제공한다.
<br>

#### UIPickerViewDelegate Topics

**Setting the Dimension of the Picker View**

```swift
func pickerView(UIPickerView, rowHeightForComponent: Int) -> CGFloat
// 행의 내용을 제공하기 위해 행의 높이가 필요할때 picker view에 의해 호출된다.

func pickerView(UIPickerView, widthForComponent: Int) -> CGFloat
// 행의 내용을 제공하기 위해 행의 너비가 필요할때 picker view에 의해 호출된다.
```

**Setting the Content of Component Rows**

아래 메소드들은 `@required` 가 아닌 `@optional` 메소드다.

```swift
func pickerView(UIPickerView, titleForRow: Int, forComponent: Int) -> String?

// 특정 컴포넌트의 특정 행의 제목의 지정이 필요할 떄 picker view에 의해 호출된다.

func pickerView(UIPickerView, attributedTitleForRow: Int, forComponent: Int) -> NSAttributedString?
// 특정 컴포넌트의 특정 행에 스타일이 지정된 제목이 필요할 때 picker view에 의해 호출된다.

func pickerView(UIPickerView, viewForRow: Int, forComponent: Int, reusing: UIView?) -> UIView
// 특정 컴포넌트의 특정 행에서 뷰를 사용해야 할 때 picker view에 의해 호출된다.
```

#### Responding to Row Selection
```swift
func pickerView(UIPickerView, didSelectRow: Int, inComponent: Int) 
// 사용자가 컴포넌트 내 특정 행을 선택했을 떄 picker view에 의해 호출된다.
```