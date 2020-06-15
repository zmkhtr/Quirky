//
//  DarkBrightController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 15/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit

class DarkBrightController: UIViewController {
    
    let noteCenter = NotificationCenter.default
    let proxCenter = NotificationCenter.default
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    
    @IBOutlet weak var darkView: UIView!
    
    var timer : Timer?
    
    var timeStart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brightnessListener()
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)

        activateProximitySensor()
    }
    
    
    
    func brightnessListener(){
        //        UIDevice.current.isProximityMonitoringEnabled = true
        noteCenter.addObserver(self,
                               selector: #selector(brightnessDidChange),
                               name: UIScreen.brightnessDidChangeNotification,
                               object: nil)
        
    }
    
    @objc func brightnessDidChange() {
        print("Keterangan \(UIScreen.main.brightness)")
        
        if UIScreen.main.brightness == 1.0 {
            darkView.alpha = 0
        } else if UIScreen.main.brightness == 0.0 {
            darkView.alpha = 1
        } else {
            darkView.alpha = UIScreen.main.brightness
        }
    }
    
    
    func activateProximitySensor() {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            proxCenter.addObserver(self, selector: #selector(proximityChanged(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
    }
    
    @objc func proximityChanged(notification: NSNotification) {
        print("detected!aa")
        if (UIScreen.main.brightness == 1.0) {
            createWinDialog(message: "Greate ! you made this far", segueIdentifier: "toLevelNine")
            self.stopCountUpTimer(timer: timer!, time: timeStart)
            UIScreen.main.brightness = 0.5
        }
    }
    
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
        changeSoundIconYellow(soundIcon: buttonSound)
    }
    
    
    @IBAction func showHint(_ sender: UIButton) {
        createHintDialog(hintMessage: "My eyes...!")
    }
    @IBAction func endGame(_ sender: UIButton) {
           createExitDialog()
       }
}
