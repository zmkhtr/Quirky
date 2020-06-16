//
//  ViewController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 08/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var startLabel: UILabel!

    let text = "Tap anywhere to Start"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserDefault()
        hideNavigationBar()
        setAnywhereClickableAndBlinking()
        playAudioFile()
    }
  var objPlayer: AVAudioPlayer?
//    do {
//        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//        print("Playback OK")
//        try AVAudioSession.sharedInstance().setActive(true)
//        print("Session is Active")
//    } catch {
//        print(error)
//    }
    func playAudioFile() {
        guard let url = Bundle.main.url(forResource: "bgsound", withExtension: "mp3") else { return }

        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//                 print("Playback OK")
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            // For iOS 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)


            guard let aPlayer = objPlayer else { return }
            aPlayer.numberOfLoops =  -1
            aPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func setUserDefault(){
        MiniDatabase.setSoundPreference(isSoundOn: true)
        MiniDatabase.setUserTime(userTime: 0)
    }
    
    func setAnywhereClickableAndBlinking(){
        startLabel.text = text
//        startLabel.startBlink()
        startLabel.isUserInteractionEnabled = true
        startLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let anywhereRange = (text as NSString).range(of: "anywhere")
        
        if gesture.didTapAttributedTextInLabel(label: startLabel, inRange: anywhereRange) {
            print("Tapped Anywhere")

            performSegue(withIdentifier: "toLevelOne", sender: nil)
        } else {
            print("Tapped none")
        }
    }
    
    @IBAction func unwindToMainScreen( _ seg: UIStoryboardSegue) {
        print("Unwind")
    }
}

extension UILabel {

    func startBlink() {
        UIView.animate(withDuration: 0.5,
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

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

