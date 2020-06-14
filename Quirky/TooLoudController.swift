//
//  TooLoudController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 14/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
//import AVFoundation

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
        
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
    }
    
    @IBAction func volumeDown(_ sender: UIButton) {
        decreaseVolume(image: speakerImage, volume: &volume)
    }
    
    @IBAction func volumwUp(_ sender: UIButton) {
        increaseVolume(image: speakerImage, volume: &volume)
    }
    
}
