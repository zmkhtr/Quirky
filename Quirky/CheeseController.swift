//
//  CheeseController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 13/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation

class CheeseController: UIViewController {
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    
    @IBOutlet weak var buttonCamera: UIButton!
    
    @IBOutlet weak var cheeseImage: UIImageView!
    
    var timeStart = 0
    
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfScreenshotIsTaken()
        
        if MiniDatabase.isSoundOn() == false {
                   changeSoundIconRed(soundIcon: buttonSound)
               }
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
    }
    
    
    func checkIfScreenshotIsTaken(){
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in
            self.createWinDialog(message: "Yummy Cheese", segueIdentifier: "toLevelSix")
//            self.performSegue(withIdentifier: "toLevelSix", sender: nil)
            self.stopCountUpTimer(timer: self.timer!, time: self.timeStart)
            self.playWinSound()
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
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        cheeseImage.startBlink()
        print("KESINI GG")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.cheeseImage.stopBlink()
            print("KESINI")
        })
    }
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
         changeSoundIconRed(soundIcon: buttonSound)
     }
     
     
     @IBAction func showHint(_ sender: UIButton) {
         createHintDialog(hintMessage: "Capture the cheese")
     }
    @IBAction func endGame(_ sender: UIButton) {
           createExitDialog()
       }
}

extension UIImageView {
    
    func startBlink() {
        UIView.animate(withDuration: 0.2,
                       delay:0.0,
                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                       animations: { self.alpha = 0 },
                       completion: nil)
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}
