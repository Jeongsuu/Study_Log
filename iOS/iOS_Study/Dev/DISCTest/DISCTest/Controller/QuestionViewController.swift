//
//  QuestionViewController.swift
//  DISCTest
//
//  Created by Yeojaeng on 2020/05/21.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    // IB에서 설정한 버튼의 tag
    enum ButtonTag: Int {
        case d = 101
        case i, s, c
    }
    
    //MARK:- Properties
    var questionIndex: Int!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.questionIndex = self.questionIndex ?? 0
        
        if self.questionIndex < 1 {
            self.backButton.isHidden = true
        }
        
        let question: Question = Question.all[questionIndex]
        
        guard let dButton: UIButton = self.view.viewWithTag(ButtonTag.d.rawValue) as? UIButton else {return}
        dButton.setTitle(question.d, for: .normal)
        
        guard let iButton: UIButton = self.view.viewWithTag(ButtonTag.i.rawValue) as? UIButton else {return}
        iButton.setTitle(question.d, for: .normal)
        
        guard let sButton: UIButton = self.view.viewWithTag(ButtonTag.s.rawValue) as? UIButton else {return}
        sButton.setTitle(question.d, for: .normal)
        
        guard let cButton: UIButton = self.view.viewWithTag(ButtonTag.c.rawValue) as? UIButton else {return}
        cButton.setTitle(question.d, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpAnswerButton(_ sender: UIButton) {
        guard let tag: ButtonTag = ButtonTag(rawValue: sender.tag) else {       //응답 버튼 여부 확인
            return
        }
        
        switch tag {                    // 점수 반영
        case .d:
            UserInfo.shared.score.d += 1
        case .i:
            UserInfo.shared.score.i += 1
        case .s:
            UserInfo.shared.score.s += 1
        case .c:
            UserInfo.shared.score.c += 1
        }
        
        let nextIndex: Int = self.questionIndex + 1
        
        // 질문지가 남았냐에 따라 화면 전환
        if Question.all.count > nextIndex,
            let nextViewController: QuestionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController {
            nextViewController.questionIndex = nextIndex
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            self.performSegue(withIdentifier: "ShowResult", sender: nil)
        }
        
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
