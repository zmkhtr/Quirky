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
    
    func startCountUpTimer(label : UILabel, timer: inout Timer?){
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(count > -1) {
                count = count + 1
                let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: count)
                label.text = "\(h)h \(m)m \(s)s"
            }
        }
    }
    func stopCountUpTimer(timer: Timer){
        timer.invalidate()
    }
    
    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
  
}
protocol timerStop {
      func onTimerStop()
}
