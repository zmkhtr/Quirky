//
//  TooLoudController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 14/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation

class TooLoudController: UIViewController {
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    
    @IBOutlet weak var speakerImage: UIImageView!
    
    var volume = 3
    var timer : Timer?
    
    var timeStart = 0
    
    //    var outputVolumeObserve: NSKeyValueObservation?
    //    let audioSession = AVAudioSession.sharedInstance()
    //
    //    func listenVolumeButton() {
    //        do {
    //            try audioSession.setActive(true)
    //        } catch {}
    //
    //        outputVolumeObserve = audioSession.observe(\.outputVolume) { (audioSession, changes) in
    //            /// TODOs
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MiniDatabase.isSoundOn() == false {
                   changeSoundIconYellow(soundIcon: buttonSound)
               }
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
        
    }
    
    @IBAction func volumeDown(_ sender: UIButton) {
        decreaseVolume(image: speakerImage, volume: &volume)
    }
    
    @IBAction func volumwUp(_ sender: UIButton) {
        increaseVolume(image: speakerImage, volume: &volume)
    }
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
        //        changeSoundIconYellow(soundIcon: buttonSound)
        buttonSound.setImage(#imageLiteral(resourceName: "nav_sound_mute"), for: .normal)
        MiniDatabase.setSoundPreference(isSoundOn: false)
        createWinDialog(message: "Huff... you save my ear", segueIdentifier: "toLevelSeven")
        playWinSound()
        self.stopCountUpTimer(timer: timer!, time: timeStart)
        
    }
    
    
    @IBAction func showHint(_ sender: UIButton) {
        createHintDialog(hintMessage: "Silent please !")
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
