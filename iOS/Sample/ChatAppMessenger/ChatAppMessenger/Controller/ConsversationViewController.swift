//
//  ViewController.swift
//  ChatAppMessenger
//
//  Created by Yeojaeng on 2020/10/13.
//

import UIKit
import FirebaseAuth

class ConsversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }

    // Authentication Use-Case
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            let navigation = UINavigationController(rootViewController: loginVC)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: false)
        }
    }
}
