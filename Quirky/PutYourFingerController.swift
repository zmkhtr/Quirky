//
//  PutYourFingerController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 12/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation

class PutYourFingerController: UIViewController {
    
    @IBOutlet weak var putFingerButton: UIButton!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    var timer : Timer?

    var timerCountUp : Timer?
    var count = 3
    
    var timeStart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        let gif = UIImage.gifImageWithName("candle")
        //        imageLilin.image = gif
        initLongPressButtonListener()
        
        if MiniDatabase.isSoundOn() == false {
            changeSoundIconYellow(soundIcon: buttonSound)
        }
        startCountUpTimer(label: countUpLabel, timer: &timerCountUp, timeStart: timeStart)
    }

    
    func initTimer(){
        count = 3
        countDownLabel.text = String(count)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PutYourFingerController.updateCountDownTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountDownTimer() {
        if(count > 0) {
            count = count - 1
            countDownLabel.text = String(count)
            if (count == 0){
                playWinSound()
                createWinDialog(message: "It's kinda easy right?", segueIdentifier: "toLevelTwo")
                stopCountUpTimer(timer: timerCountUp!, time: timeStart)
            }
        }
    }
    var objPlayer: AVAudioPlayer?
    func playWinSound() {
              guard let url = Bundle.main.url(forResource: "winsound", withExtension: "mp3") else { return }

              do {
                  try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
      //            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                  try AVAudioSession.sharedInstance().setActive(true)

                  // For iOS 11
                  objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)


                  guard let aPlayer = objPlayer else { return }
                  aPlayer.play()

              } catch let error {
                  print(error.localizedDescription)
              }
          }
    
    func initLongPressButtonListener(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(long(gesture:)))
//        longPressGesture.minimumPressDuration = 0.5
        putFingerButton.addGestureRecognizer(longPressGesture)
    }
    
    @objc func long(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            print("Began")
            showHideViewWhenPressed(isHidden: true)

            initTimer()
            
        } else if gesture.state == UIGestureRecognizer.State.ended {
            print("Ended")
            showHideViewWhenPressed(isHidden: false)
            timer?.invalidate()
        }
    }
    
    func showHideViewWhenPressed(isHidden : Bool){
        buttonClose.isHidden = isHidden
        buttonHint.isHidden = isHidden
        countUpLabel.isHidden = isHidden
        buttonSound.isHidden = isHidden
        arrowImage.isHidden = isHidden
        
        if (isHidden){
            countDownLabel.isHidden = false
            titleLabel.text = "Hold on..."
            backgroundView.backgroundColor = #colorLiteral(red: 0.8117647059, green: 0.1803921569, blue: 0.1176470588, alpha: 1)
        } else {
            countDownLabel.isHidden = true
            titleLabel.text = "Put your finger here."
            backgroundView.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.4509803922, blue: 0.7803921569, alpha: 1)
        }
    }
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
        changeSoundIconYellow(soundIcon: buttonSound)
    }
    
    
    @IBAction func showHint(_ sender: UIButton) {
        createHintDialog(hintMessage: "Be Patient")
    }
    @IBAction func endGame(_ sender: UIButton) {
        createExitDialog()
    }
}

