# Searchable TableView

<br>


```swift

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    var data = [String]()
    var filteredData = [String]()
    var filetered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.delegate = self
        table.dataSource = self
        
        field.delegate = self
        
        // brind the data into tableView
        setupData()
    }
    
    
    private func setupData() {
        data.append("Apple")
        data.append("MacOS")
        data.append("IphoneOS")
        data.append("IpadOS")
        data.append("Macbook Pro")
        data.append("Ipad Pro")
        data.append("Macbook Air")
        data.append("Iphone")
        data.append("Airpod")
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString replaceString: String) -> Bool {
        
        if let text = textField.text {
            filterText(text+replaceString)
        }
        
        return true
    }
    
    func filterText(_ query: String) {
        // 중복 제거를 위해 클리어
        filteredData.removeAll()
        
        for string in data {
            if string.lowercased().starts(with: query.lowercased()) {
                filteredData.append(string)
            }
        }
        
        table.reloadData()
        filetered = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
            return filteredData.count
        }
        
        return filetered ? 0 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if !filteredData.isEmpty {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

```