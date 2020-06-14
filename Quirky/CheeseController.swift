//
//  CheeseController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 13/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit

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
        
        
        startCountUpTimer(label: countUpLabel, timer: &timer, timeStart: timeStart)
    }
    
    
    func checkIfScreenshotIsTaken(){
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in
            self.performSegue(withIdentifier: "toLevelSix", sender: nil)
            self.stopCountUpTimer(timer: self.timer!)
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
