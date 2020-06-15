//
//  MiniDatabase.swift
//  Quirky
//
//  Created by Azam Mukhtar on 15/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import Foundation

let SOUND_KEY = "SOUND_KEY"
let TIME_KEY = "TIME_KEY"

class MiniDatabase {
    
    static func setSoundPreference(isSoundOn : Bool){
        UserDefaults.standard.set(isSoundOn, forKey: SOUND_KEY)
    }
    
    static func isSoundOn() -> Bool {
        return UserDefaults.standard.bool(forKey: SOUND_KEY)
    }
    
    static func setUserTime(userTime : Int){
        UserDefaults.standard.set(userTime, forKey: TIME_KEY)
    }
    
    static func getUserTime() -> Int {
        return UserDefaults.standard.integer(forKey: TIME_KEY)
    }
}
