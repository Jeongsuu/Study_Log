//
//  ViewController.swift
//  LoginPage
//
//  Created by Yeojaeng on 2020/05/13.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

// MainViewController
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK:- Properties
    
    // 백그라운드 뷰 객체 생성
    let backgroundView: UIView = {
        let theView = UIView()
        theView.backgroundColor = .white
        
        return theView
    }()
    
    // id필드 객체 생성
    let idField: UITextField = {
        let theIdField = UITextField()
        theIdField.placeholder = " 이메일을 입력해주세요"
        theIdField.keyboardType = .emailAddress
        theIdField.font = UIFont(name: "system", size: 14.0)
        theIdField.layer.borderWidth = 0.5
        theIdField.layer.cornerRadius = 5
        
        return theIdField
    }()
    
    // pw필드 객체 생성
    let pwField: UITextField = {
        let thePwField = UITextField()
        thePwField.placeholder = " 패스워드를 입력해주세요"
        thePwField.isSecureTextEntry = true
        thePwField.font = UIFont(name: "system", size: 14.0)
        thePwField.layer.borderWidth = 0.5
        thePwField.layer.cornerRadius = 5
        
        return thePwField
    }()
    
    // 로그인버튼 객체 생성
    let loginButton: UIButton = {
        let theLoginBtn = UIButton()
        theLoginBtn.setTitle("로그인", for: .normal)
        theLoginBtn.setTitleColor(.blue, for: .normal)
        theLoginBtn.titleLabel?.font = UIFont(name: "system", size: 14.0)
        theLoginBtn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)                  // Target-Action으로 @IBAction 대체
        
        return theLoginBtn
    }()
    
    //MARK:- Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        self.navigationController?.setNavigationBarHidden(true, animated: true)                 // 메인 뷰 네비게이션 바 숨기기
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.navigationItem.title = "로그인"
        
        backgroundViewConstraints()
        idFieldConstraints()
        pwFieldConstraints()
        loginButtonConstraints()
    }
    
    //MARK:- MakeConstraints
    
    func backgroundViewConstraints() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func idFieldConstraints() {
        view.addSubview(idField)
        idField.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
            
        }
    }
    
    func pwFieldConstraints() {
        view.addSubview(pwField)
        pwField.snp.makeConstraints { (make) in
            make.top.equalTo(idField).offset(30)
            make.leading.equalTo(idField)
            make.trailing.equalTo(idField)
            
        }
    }
    
    func loginButtonConstraints() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(pwField).offset(30)
            make.leading.equalTo(pwField).offset(70)
            make.size.equalTo(CGSize(width: 150, height: 50))
        }
    }
    
}

extension ViewController {
    
    //MARK:- Custom Methods
    
    
    @objc func loginButtonTapped() {
        
        guard let email: String = self.idField.text, email.isEmpty == false else {
            self.showAlert(message: "이메일을 입력해주세요", control: self.idField)
            return
        }
        
        guard let password: String = self.pwField.text, password.isEmpty == false else {
            self.showAlert(message: "패스워드를 입력해주세요", control: self.pwField)
            return
        }
        
        let SecondVC = SecondViewController()
        self.navigationController?.pushViewController(SecondVC, animated: true)
        
    }
    
    func showAlert(message: String, control toBeFirstResponder: UIControl?) {
        
        let alert: UIAlertController = UIAlertController(title: "알림",
                                                         message: message,
                                                         preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: "입력하기", style: .default) { [weak toBeFirstResponder] (action: UIAlertAction) in
            toBeFirstResponder?.becomeFirstResponder()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소",
                                                        style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let email: String = self.idField.text,
            let password: String = self.pwField.text else {
                return
        }
        
        guard let id: String = segue.identifier else { return }
        guard id == "ShowInfo" else { return }
        
        guard let infoViewController = segue.destination as? InfoViewViewController else { return }
        
        infoViewController.loginInfo = LoginInfo(email: email, password: password)
    }
    
    
}
