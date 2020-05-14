//
//  SecondViewController.swift
//  LoginPage
//
//  Created by Yeojaeng on 2020/05/14.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    let backgroundView: UIView = {
        let ret = UIView()
        ret.backgroundColor = UIColor.systemBlue
        
        return ret
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundViewConstraints()
    }
    
    func backgroundViewConstraints() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
