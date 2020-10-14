//
//  RegisterViewController.swift
//  ChatAppMessenger
//
//  Created by Yeojaeng on 2020/10/13.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 3.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor

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

    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "FirstName"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()

    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "LastName"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "REGISTER"
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(didTapRegisterButton))
        registerButton.addTarget(self,
                                 action: #selector(didTapRegisterButton),
                                 for: .touchUpInside)

        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.navigationItem.rightBarButtonItem = nil
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(registerButton)

        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)

    }

    @objc func didTapChangeProfilePic() {
        print(#function)
        presentActionSheet()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds

        let size = view.width / 3
        imageView.frame = CGRect(x: (view.width - size) / 2,
                                 y: 60,
                                 width: size,
                                 height: size)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.height / 2

        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 30,
                                  width: scrollView.width - 60,
                                  height: 52)

        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)

        firstNameField.frame = CGRect(x: 30,
                                      y: passwordField.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)

        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)

        registerButton.frame = CGRect(x: 30,
                                      y: lastNameField.bottom + 30,
                                      width: scrollView.width - 60,
                                      height: 52)
    }

    /// Register new Account
    @objc private func didTapRegisterButton() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()

        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty, !password.isEmpty,
              !firstName.isEmpty, !lastName.isEmpty,
              password.count >= 6 else {
            alertRegisterError()
            return
        }

        DatabaseManager.shared.isUserExist(with: email) { [weak self] exist in
            guard let self = self else { return }
            guard !exist else {
                self.alertRegisterError(message: "이미 존재하는 email 입니다.")
                return
            }

            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {(authReesult, error) in
                guard authReesult != nil, error == nil else {
                    return
                }

                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName,
                                                                    lastName: lastName,
                                                                    email: email))

                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }

    private func alertRegisterError(message: String = "정확한 정보를 기입해주세요.") {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))

        present(alert, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {

    // when user touch enter key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapRegisterButton()
        }

        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Image",
                                            message: "Choose your Image",
                                            preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))

        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentCamera()
                                            }))

        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentPhotoPicker()
                                            }))

        present(actionSheet, animated: true, completion: nil)
    }

    func presentCamera() {
        let imagePickerC = UIImagePickerController()
        imagePickerC.sourceType = .camera
        imagePickerC.delegate = self
        imagePickerC.allowsEditing = true
        present(imagePickerC, animated: true, completion: nil)
    }

    func presentPhotoPicker() {
        let imagePickerC = UIImagePickerController()
        imagePickerC.sourceType = .photoLibrary
        imagePickerC.delegate = self
        imagePickerC.allowsEditing = true
        present(imagePickerC, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        DispatchQueue.main.async {
            self.imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
