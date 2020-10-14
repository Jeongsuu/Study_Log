//
//  LoginViewController.swift
//  ChatAppMessenger
//
//  Created by Yeojaeng on 2020/10/13.
//

import UIKit

import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message.circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let fbLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOGIN"
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(didTapRegisterButton))
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.fbLoginButton.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(fbLoginButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds

        let size = view.width / 3
        imageView.frame = CGRect(x: (view.width - size) / 2,
                                 y: 60,
                                 width: size,
                                 height: size)

        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 30,
                                  width: scrollView.width - 60,
                                  height: 52)

        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)

        loginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 30,
                                   width: scrollView.width - 60,
                                   height: 52)

        fbLoginButton.frame = CGRect(x: 30,
                                     y: loginButton.bottom + 30,
                                     width: scrollView.width - 60,
                                     height: 52)
    }

    /// Push RegisterVC
    @objc private func didTapRegisterButton() {
        let registerVC = RegisterViewController()
        registerVC.title = "Create Account"
        self.navigationController?.pushViewController(registerVC, animated: true)
    }

    @objc private func didTapLoginButton() {

        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertLoginError()
            return
        }

        FirebaseAuth.Auth.auth().signIn(withEmail: email,
                                        password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
            guard let result = authResult, error == nil else {
                print(#function + "Failed Login")
                return
            }
            print("Logged In user: \(result.user)")
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func alertLoginError() {
        let alert = UIAlertController(title: "Error",
                                      message: "Please answer correct infomation",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))

        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {

    // when user touch enter key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }

        return true
    }
}

extension LoginViewController: LoginButtonDelegate {

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // Non - operation
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            print("Failed to login with FB")
            return
        }

        let fbRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                   parameters: ["fields": "email, name"],
                                                   tokenString: token,
                                                   version: nil,
                                                   httpMethod: .get)

        fbRequest.start(completionHandler: { [weak self] _, result, error in
            guard let self = self else { return }
            guard let result = result as? [String: Any], error == nil else {
                print("Failed to make FB graph request")
                return
            }
            print("\(result)")

            guard let userName = result["name"] as? String, let email = result["email"] as? String else {
                print("Failed to get email and name")
                return
            }

            let nameComponents = userName.components(separatedBy: " ")
            guard nameComponents.count == 2 else { return }
            let firstName = nameComponents[0]
            let lastName = nameComponents[1]

            DatabaseManager.shared.isUserExist(with: email, completion: { exist in
                if !exist {
                    DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName,
                                                                        lastName: lastName,
                                                                        email: email))
                }
            })

            // get FIRAuthCredential from FBAuthProvider
            let firCredential = FacebookAuthProvider.credential(withAccessToken: token)

            // Signin with crendential provided by FB
            FirebaseAuth.Auth.auth().signIn(with: firCredential) {authResult, error in
                guard authResult != nil, error == nil else {
                    if let error = error {
                        print("Failed login with FB")
                        print(error)
                    }
                    return
                }
                print("Success login with FB")
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        })
    }
}
