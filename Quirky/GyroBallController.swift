//
//  GyroBallController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 13/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import CoreMotion

class GyroBallController: UIViewController {
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSound: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    
    @IBOutlet weak var centerHoleImage: UIImageView!
    @IBOutlet weak var ballImage: UIImageView!
    
    var motionManager = CMMotionManager()
    var circleCentre : CGPoint!
    var newCircleCentre : CGPoint!
    
    var holeCentre : CGPoint!
    var timer : Timer?
    
    var timeStart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        circleCentre = self.ballImage.center
        newCircleCentre = self.ballImage.center
        
        holeCentre = self.centerHoleImage.center

        changeSoundIconRed(soundIcon: buttonSound)
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setGyroscope()
    }
    
    func setGyroscope(){
        motionManager.gyroUpdateInterval = 0.01
        
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                
                self.newCircleCentre.x = (CGFloat(myData.acceleration.x) * -10)
                self.newCircleCentre.y = (CGFloat(myData.acceleration.y) * 10)
                
                
                if abs(self.newCircleCentre.x) + abs(self.newCircleCentre.y) < 1.0 {
                    self.newCircleCentre = .zero
                }
                
                self.circleCentre = CGPoint(x: self.circleCentre.x + self.newCircleCentre.x, y: self.circleCentre.y + self.newCircleCentre.y)
                
                self.circleCentre.x = max(self.ballImage.frame.size.width*0.5, min(self.circleCentre.x, self.view.bounds.width - self.ballImage.frame.size.width*0.5))
                self.circleCentre.y = max(self.ballImage.frame.size.height*0.5, min(self.circleCentre.y, self.view.bounds.height - self.ballImage.frame.size.height*0.5))
                
                
                self.ballImage.center = self.circleCentre
                
                self.stopBallWhenInsideTheHole()
                
            }
            
        }
    }
    
    func stopBallWhenInsideTheHole(){
        let holeRangeX = Int(self.centerHoleImage.center.x - 30)...Int(self.centerHoleImage.center.x + 30)
        let holeRangeY = Int(self.centerHoleImage.center.y - 30)...Int(self.centerHoleImage.center.y + 30)
        if holeRangeX ~= Int(self.ballImage.center.x) && holeRangeY ~= Int(self.ballImage.center.y) {
            print("CENTER")
            self.toNextLevel()
            self.ballImage.center = self.holeCentre
            self.motionManager.stopAccelerometerUpdates()
        }
    }
    
    func toNextLevel(){
        stopCountUpTimer(timer: timer!, time: timeStart)
        createWinDialog(message: "Ball in the hole !!!", segueIdentifier: "toLevelFive")
//        performSegue(withIdentifier: "toLevelFive", sender: nil)
    }
    
    @IBAction func changeSoundPreferences(_ sender: UIButton) {
          changeSoundIconRed(soundIcon: buttonSound)
      }
      
      
      @IBAction func showHint(_ sender: UIButton) {
          createHintDialog(hintMessage: "Balance in all things")
      }
    
    @IBAction func endGame(_ sender: UIButton) {
           createExitDialog()
       }
}


