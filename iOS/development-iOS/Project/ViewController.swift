//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Yeojaeng on 2020/03/30.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit
import AVFoundation                                                     // for AVAudioPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate {         // AVAudioPlayerDelegate 프로토콜 채택
    
    // MARK:- Properties
    var player: AVAudioPlayer!                                          // AVAudioPlayer 인스턴스 생성
    var timer: Timer!                                                   // Timer 인스턴스 생성
    
    // MARK: IBOutlets
    @IBOutlet var playPauseButton: UIButton!                            // reference를 위한 IBOutelt 변수 선언
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    
    // MARK: - Methods
    // MARK: Custom Method
    func initializePlayer() {                                           // 플레이어 초기화 메서드
            
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "Jasmine")    // guard문의 조건이 참일 경우 pass
            else {
                print("음원 파일 에셋을 가져올 수 없습니다.")
                return
        }
        
        do {                                                                // 예외사항 처리를 위해 do~catch & try 문 이용
            try self.player = AVAudioPlayer(data: soundAsset.data)          // AVAudioPlayer 인스턴스 생성
            self.player.delegate = self                                     // AVAUdioPlayer의 델리게이트 는 ViewController
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지: \(error.localizedDescription)")
        }
        
        self.progressSlider.minimumValue = 0                                // UISlider 최소값 초기화
        self.progressSlider.maximumValue = Float(self.player.duration)      // UISlider 최대값을 player의 프로퍼티 duration으로 초기화
        self.progressSlider.value = Float(self.player.currentTime)          // UISlider의 값을 player의 프로퍼티 currentTime으로 초기화
        
    }
    
    func updateTimeLabelText(time: TimeInterval) {                          //레이블 업데이트 메서드
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld : %02ld : %02ld ", minute, second, milisecond)     // 지정 포맷에 따라 시간 출력
        
        self.timeLabel.text = timeText
    }
    
    //타이머를 만들고 수행할 메서드
    func makeAndFireTimer() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer:Timer) in
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        
        self.timer.fire()
    }
    
    
    func invalidateTimer() {        // 타이머를 해제해 줄 메서드
        self.timer.invalidate()     // 타이머 기능 정지
        self.timer = nil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializePlayer()             // 플레이어 초기화 메서드 실행
    }
//                                            어떤 인스턴스가 이 메서드를 호출했는지
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        // 누르면 재생 시작
        sender.isSelected = !sender.isSelected      // UIButton 초기값 설정
        
        if sender.isSelected {
            self.player?.play()
            print("play")
        } else {
            self.player?.pause()
            print("pause")
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()         // 버튼이 재생으로 바뀌면 타이머 실행
        } else {
            self.makeAndFireTimer()         // 버튼이 일시정지로 바뀌면 타이머 실행
        }
        
        print("button tapped")
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
        print("slider value changed")
    }
    
    // MARK: AVAudioPlayerDelegate
    // Responding to an Audio Decoding Error
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error: Error = error else {                                   // guard 조건이 참이면 그냥 치나가고, 틀리면 else문 진행
            print("오디오 플레이어 디코드 에러 발생")
            return
        }
        // let error:Error = error 일 경우 진행
        let message: String = "오디오 플레이어 에러 발생 \(error.localizedDescription)"
        
        // Creating an Alert Controller
        // alert을 발생시키기 위해 UIAlertController 클래스의 인스턴스를 alert 이라는 이름으로 생성한다.
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // An Action that can be taken when the user taps a button in an alert.
        // 유저가 띄워진 경고창에서 버튼을 클릭했을때의 액션을 위함
        // Creating an Alert Action
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in                   //closure 사용
            
            // UIViewController.dismiss(animated: Bool, completion: ( () -> Void)?)
            // Dismisses the view controller that was presented modally by the view controller.
            self.dismiss(animated: true, completion: nil)       // oK버튼 클릭시 경고창 내리기.
        }
        
        // UIAlertController.addAction(UIAlertAction)
        // Attaches an action objejct to the alert or action sheet.
        
        alert.addAction(okAction)                               // Action 더하기
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // Responding to Sound Playback Completion
    // func audioPlayDidFinishPlaying(AVAudioPlayer, successfully: Bool)
    // Called when a sound has finished playing. -> 노래가 끝나면 호출되는 함수.
    
    //MARK:- audioPlayerDidFinishisPlaying
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }
    
}

