//
//  RegisterViewController.swift
//  WithUs
//
//  Created by Yeojaeng on 2020/10/14.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let emailTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.placeholder = "example@example.com"
        $0.returnKeyType = .continue
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
    }
    
    let pwTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
//        $0.placeholder = "example@example.com"
        $0.returnKeyType = .continue
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
    }
    
    let nameTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
//        $0.placeholder = "example@example.com"
        $0.returnKeyType = .continue
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    private func addSubView() {
        
    }
    
    private func setupUI() {
        
    }

}
