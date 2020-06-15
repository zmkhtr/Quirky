//
//  EndController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 15/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit

class EndController: UIViewController {
    
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var buyUseSomeCoffeeButton: UIButton!
    
     
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setEndTimeLabel()
    }
    
    func setEndTimeLabel(){
        let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds:  MiniDatabase.getUserTime())
        endTimeLabel.text = "\(h)h \(m)m \(s)s"
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        image = takeScreenshot()
        let activityVC = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func tryAgainAction(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMainScreen", sender: self)
    }
    
    @IBAction func buyUseSomeCoffeeAction(_ sender: UIButton) {
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
          var screenshotImage :UIImage?
          let layer = UIApplication.shared.keyWindow!.layer
          let scale = UIScreen.main.scale
          UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
          guard let context = UIGraphicsGetCurrentContext() else {return nil}
          layer.render(in:context)
          screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          if let image = screenshotImage, shouldSave {
              UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
          }
          return screenshotImage
      }
}
