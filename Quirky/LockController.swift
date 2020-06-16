//
//  LockController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 15/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation

class LockController: UIViewController {
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    
    @IBOutlet weak var padlockButton: UIButton!
    
    var isLocked = false
    var timer : Timer?
    
    var timeStart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
        if MiniDatabase.isSoundOn() == false {
                   changeSoundIconRed(soundIcon: buttonSound)
               }
        enterBackground()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
        changeSoundIconRed(soundIcon: buttonSound)
    }
    
    
    @IBAction func padlockPressed(_ sender: UIButton) {
        if isLocked == true {
            padlockButton.setImage(#imageLiteral(resourceName: "padlock_unlocked"), for: .normal)
            isLocked = false
        } else {
            padlockButton.setImage(#imageLiteral(resourceName: "padlock_locked"), for: .normal)
            isLocked = true
        }
    }
    
    @IBAction func showHint(_ sender: UIButton) {
        createHintDialog(hintMessage: "Are you sure it's already locked?")
    }
    
    func enterBackground(){
        NotificationCenter.default.addObserver(forName:UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { (_) in
            let isDisplayStatusLocked = UserDefaults.standard
            if let lock = isDisplayStatusLocked.value(forKey: "isDisplayStatusLocked"){
                // user locked screen
                if(lock as! Bool){
                    // do anything you want here
                    print("Lock button pressed.")
                }
                    // user pressed home button
                else{
                    // do anything you want here
                    print("Home button pressed.")
                }
            }
            
            NotificationCenter.default.addObserver(forName:UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { (_) in
                print("Back to foreground.")
                //restore lock screen setting
                let isDisplayStatusLocked = UserDefaults.standard
                isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
                isDisplayStatusLocked.synchronize()
                self.createWinDialogEnd(message: "You completed the game !", segueIdentifier: "toLevelEnd")
                self.stopCountUpTimer(timer: self.timer!, time: self.timeStart)
                self.playWinSound()
            }
        }
        
    }
    //
    //    private func DidUserPressLockButton() -> Bool {
    //        let oldBrightness = UIScreen.main.brightness
    //        UIScreen.main.brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01))
    //        return oldBrightness != UIScreen.main.brightness
    //    }
    
    func createWinDialogEnd(message : String, segueIdentifier : String){
        let alertController = UIAlertController(title: "You Doing Awesome !", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Next", style: .default) { (action:UIAlertAction) in
            self.performSegue(withIdentifier: segueIdentifier, sender: nil)
            NotificationCenter.default.removeObserver(self)
        }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func endGame(_ sender: UIButton) {
        createExitDialog()
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
}
