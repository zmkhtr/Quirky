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
    
    
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       checkIfScreenshotIsTaken()
       startCountUpTimer(label: countUpLabel, timer: &timer)
    }

    
    func checkIfScreenshotIsTaken(){
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in
            print("Screenshot taken!")
            self.stopCountUpTimer(timer: self.timer!)
        }
    }
    
}

extension UIImageView {
    func blink() {
            self.alpha = 0.2
            UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
        }
    func startBlink() {
        UIView.animate(withDuration: 0.1,
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
