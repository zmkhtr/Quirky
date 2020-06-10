//
//  ViewController.swift
//  Quirky
//
//  Created by Azam Mukhtar on 08/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageLilin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gif = UIImage.gifImageWithName("candle")
        imageLilin.image = gif
    }


}

