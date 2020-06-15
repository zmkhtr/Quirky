//
//  BottleController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 13/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit

class BottleController: UIViewController {
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    
    @IBOutlet weak var bottleImage: UIImageView!
    
    var initialCenterPoint = CGPoint()
    var timer : Timer?
    
    var timeStart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottleShakeAble()
        
        changeSoundIconYellow(soundIcon: buttonSound)
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
    }
    
    func makeBottleShakeAble(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleShake(_:)))
        bottleImage.isUserInteractionEnabled = true
        bottleImage.addGestureRecognizer(panGesture)
    }
    
    @objc func handleShake(_ pan: UIPanGestureRecognizer) {
        if pan.state == .began {
            self.initialCenterPoint = bottleImage.center
        }
        
        let translation = pan.translation(in: view)
        
        if pan.state != .cancelled {
            let newCenter = CGPoint(x: initialCenterPoint.x + translation.x, y: initialCenterPoint.y + translation.y)
            bottleImage.center = newCenter
        } else {
            bottleImage.center = initialCenterPoint
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changeBottleLiquidAndGoToNextLevel()
    }
    
    func changeBottleLiquidAndGoToNextLevel(){
        bottleImage.image = #imageLiteral(resourceName: "bottle_combine")
        
        createWinDialog(message: "Shake..Shake..Shake..", segueIdentifier: "toLevelFour")
        stopCountUpTimer(timer: timer!, time: timeStart)
        //        performSegue(withIdentifier: "toLevelFour", sender: nil)
    }
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
        changeSoundIconYellow(soundIcon: buttonSound)
    }
    
    
    @IBAction func showHint(_ sender: UIButton) {
        createHintDialog(hintMessage: "Combine the liquid")
    }
    
    @IBAction func endGame(_ sender: UIButton) {
           createExitDialog()
       }
}
