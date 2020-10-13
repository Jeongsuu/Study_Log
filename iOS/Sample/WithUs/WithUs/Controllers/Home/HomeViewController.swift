//
//  HomeViewController.swift
//  WithUs
//
//  Created by Yeojaeng on 2020/10/14.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")

        // 로그인 상태가 아닌 경우
        if !isLoggedIn {
            let loginVC = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false, completion: nil)
        }
    }

}
