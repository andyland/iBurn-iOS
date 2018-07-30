//
//  UserDefaults+iBurn.swift
//  iBurn
//
//  Created by Chris Ballinger on 7/30/18.
//  Copyright © 2018 Burning Man Earth. All rights reserved.
//

import Foundation

@objc
public final class UserSettings: NSObject {
    
    private struct Keys {
        static let searchSelectedDayOnlyKey = "kBRCSearchSelectedDayOnlyKey"
    }
    
    
    /** Whether or not search on event view shows results for all days */
    @objc public static var searchSelectedDayOnly: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.searchSelectedDayOnlyKey)
        }
        get {
            return UserDefaults.standard.bool(forKey: Keys.searchSelectedDayOnlyKey)
        }
    }
}