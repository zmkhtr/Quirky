//
//  HappyBirthdayController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 13/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation
import CoreAudio

class HappyBirthdayController: UIViewController {
    
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    
    let LEVEL_THRESHOLD: Float = -3.0
    
    @IBOutlet weak var candleImage: UIImageView!
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    
    var timer : Timer?
    
    var timeStart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCandleGif()
        listenToBlowMic()
        
         if MiniDatabase.isSoundOn() == false {
                   changeSoundIconYellow(soundIcon: buttonSound)
               }
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
    }
    
    
    
    func loadCandleGif(){
        let gif = UIImage.gifImageWithName("candle")
        candleImage.image = gif
    }
    
    func listenToBlowMic(){
        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        let url = documents.appendingPathComponent("record.caf")
        
        let recordSettings: [String: Any] = [
            AVFormatIDKey:              kAudioFormatAppleIMA4,
            AVSampleRateKey:            44100.0,
            AVNumberOfChannelsKey:      2,
            AVEncoderBitRateKey:        12800,
            AVLinearPCMBitDepthKey:     16,
            AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url, settings: recordSettings)
            
        } catch {
            return
        }
        
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()
        
        levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)
        
    }
    @objc func levelTimerCallback() {
        recorder.updateMeters()
        

        let level = recorder.averagePower(forChannel: 0)
        let isLoud = level > LEVEL_THRESHOLD
//        print("Level \(level)")
        if (isLoud){
            candleGoesOut()
            print("Mic Level \(level)")
        }
        // do whatever you want with isLoud
    }
    
    func candleGoesOut(){
        recorder.stop()
        candleImage.image = #imageLiteral(resourceName: "candle_die")
        
        playWinSound()
        createWinDialog(message: "Yuhuu.. Happy Birthday !", segueIdentifier: "toLevelThree")
        stopCountUpTimer(timer: timer!, time: timeStart)
//        performSegue(withIdentifier: "toLevelThree", sender: nil)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
          changeSoundIconYellow(soundIcon: buttonSound)
      }
      
      
      @IBAction func showHint(_ sender: UIButton) {
          createHintDialog(hintMessage: "What you usually do with birtday candle?")
      }
    
    @IBAction func endGame(_ sender: UIButton) {
           createExitDialog()
       }
}
