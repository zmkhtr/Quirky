//
//  ViewControllerExtension.swift
//  Quirky
//
//  Created by Azam Mukhtar on 12/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation

extension UIViewController {
    
    
    func createHintDialog(message : String){
        let alert = UIAlertController(title: "Hint", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func muteUnmute(){
        
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func playBgMusic(){
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.isOtherAudioPlaying {
            _ = try? audioSession.setCategory(AVAudioSession.Category.ambient, options: AVAudioSession.CategoryOptions.mixWithOthers)
        }
    }
    
    func startCountUpTimer(label : UILabel, timer: inout Timer?, timeStart : Int){
        var count = timeStart
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(count > -1) {
                count = count + 1
                let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: count)
                label.text = "\(h)h \(m)m \(s)s"
                MiniDatabase.setUserTime(userTime: MiniDatabase.getUserTime() + count)
            }
        }
    }
    func stopCountUpTimer(timer: Timer, time : Int){
        timer.invalidate()
    }
    
    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    func decreaseVolume(image : UIImageView, volume : inout Int){
        volume -= 1
        
        if (volume <= 0){
            volume = 0
        }
        
        switch volume {
        case 3:
            image.image = #imageLiteral(resourceName: "sound_three")
        case 2:
            image.image = #imageLiteral(resourceName: "sound_two")
        case 1:
            image.image = #imageLiteral(resourceName: "sound_one")
        case 0:
            image.image = #imageLiteral(resourceName: "sound_mute")
        default:
            image.image = #imageLiteral(resourceName: "sound_three")
        }
    }
    
    func increaseVolume(image : UIImageView, volume : inout Int){
        volume += 1
        
        if (volume >= 3){
            volume = 3
        }
        
        
        switch volume {
        case 3:
            image.image = #imageLiteral(resourceName: "sound_three")
        case 2:
            image.image = #imageLiteral(resourceName: "sound_two")
        case 1:
            image.image = #imageLiteral(resourceName: "sound_one")
        case 0:
            image.image = #imageLiteral(resourceName: "sound_mute")
        default:
            image.image = #imageLiteral(resourceName: "sound_three")
        }
    }
    
    func createWinDialog(message : String, segueIdentifier : String){
        let alertController = UIAlertController(title: "You Win !", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Go to Next Level", style: .default) { (action:UIAlertAction) in
            self.performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func createExitDialog(){
        let alertController = UIAlertController(title: "End Game", message: "Are you sure want to end the game and back to main menu?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Continue Game", style: .default) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let close = UIAlertAction(title: "Quit", style: .cancel) { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "unwindToMainScreen", sender: nil)
        }
        
        alertController.addAction(action)
        alertController.addAction(close)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createHintDialog(hintMessage : String){
        let alertController = UIAlertController(title: "Hint", message: hintMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func changeSoundIconYellow(soundIcon : UIButton){
        let musicPlayer:AVAudioPlayer = AVAudioPlayer()
        if (MiniDatabase.isSoundOn()) {
            soundIcon.setImage(#imageLiteral(resourceName: "nav_sound_mute"), for: .normal)
            MiniDatabase.setSoundPreference(isSoundOn: false)
            musicPlayer.volume = 0
        } else {
            soundIcon.setImage(#imageLiteral(resourceName: "nav_sound"), for: .normal)
            MiniDatabase.setSoundPreference(isSoundOn: true)
            musicPlayer.volume = 1
        }
    }
    
    func changeSoundIconRed(soundIcon : UIButton){
        let musicPlayer:AVAudioPlayer = AVAudioPlayer()
        if (MiniDatabase.isSoundOn()) {
            soundIcon.setImage(#imageLiteral(resourceName: "nav_sound_merah_mute"), for: .normal)
            MiniDatabase.setSoundPreference(isSoundOn: false)
            musicPlayer.volume = 0
        } else {
            soundIcon.setImage(#imageLiteral(resourceName: "nav_sound_merah"), for: .normal)
            MiniDatabase.setSoundPreference(isSoundOn: true)
            musicPlayer.volume = 1
        }
    }
    
    
 

      
}
