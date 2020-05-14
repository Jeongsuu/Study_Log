//
//  InfoViewViewController.swift
//  LoginPage
//
//  Created by Yeojaeng on 2020/05/14.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit

class InfoViewViewController: UIViewController {

    //MARK:- Properties
    var loginInfo: LoginInfo?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        guard let info = self.loginInfo else { return }
        
        print(info)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.navigationItem.title = "로그인 정보"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
    }

    

}
