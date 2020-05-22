//
//  ViewController.swift
//  DISCTest
//
//  Created by Yeojaeng on 2020/05/21.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    //MARK:- Methods
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nameField.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchUpStartButton(_ sender: UIButton) {
        
        guard let name: String = self.nameField.text,               // Optional Binding
            name.isEmpty == false else {                            // 이름이 입력되지 않은 경우 경고창 띄우기.
                let alert: UIAlertController
                alert = UIAlertController(title: "알림", message: "이름을 입력해주세요.", preferredStyle: .alert)
                
                let okAction: UIAlertAction
                okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        UserInfo.shared.name = self.nameField.text              // 싱글톤 객체에 접근하여 이름 저장
        
        self.performSegue(withIdentifier: "PresentTest", sender: nil)   // 세그 실행
    }
    
}

