//
//  ViewController.swift
//  WithUs
//
//  Created by Yeojaeng on 2020/10/13.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {

    let imageView = UIImageView().then {
        $0.image = UIImage(systemName: "message.circle")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.height / 2
    }

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
        $0.placeholder = "Password"
        $0.returnKeyType = .done
        $0.isSecureTextEntry = true
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
    }

    let registerButton = UIButton().then {
        $0.setTitle("REGISTER", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.layer.cornerRadius = 10
    }

    let loginButton = UIButton().then {
        $0.setTitle("LOGIN", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupUI()

        self.emailTextField.delegate = self
        self.pwTextField.delegate = self
        self.loginButton.addTarget(self,
                                   action: #selector(didTapLoginButton),
                                   for: .touchUpInside)
        self.registerButton.addTarget(self,
                                      action: #selector(didTapRegisterButton),
                                      for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func addSubView() {
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(pwTextField)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        self.title = ""

        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.width.height.equalTo(150)
        }

        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        pwTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        }

        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(pwTextField.snp.bottom).offset(50)
            make.leading.equalTo(pwTextField.snp.leading)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.top)
            make.trailing.equalTo(pwTextField.snp.trailing)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
    }

    
    @objc private func didTapLoginButton() {
        // validation check
    }
    
    
    /// Goto ReigsterVC
    @objc private func didTapRegisterButton() {
        print(#function)
        let registerVC = RegisterViewController()
        registerVC.title = "REGISTER"
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            pwTextField.becomeFirstResponder()
        } else if textField == pwTextField {
            pwTextField.resignFirstResponder()
            didTapLoginButton()
        }

        return true
    }
}

#if DEBUG
// opt + cmd + enter : open preview window
// opt + cmd + p : build preview
import SwiftUI
    struct ViewControllerRepresentable: UIViewControllerRepresentable {
        func updateUIViewController(_ uiView: UIViewController, context: Context) {
            // leave this empty
        }
        @available(iOS 13.0.0, *)
        func makeUIViewController(context: Context) -> UIViewController {
            // replace VC want to see
            LoginViewController()
        }
    }
    @available(iOS 13.0, *)
    struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
    }
#endif
