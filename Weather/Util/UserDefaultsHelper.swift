//
//  UserDefaultsHelper.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

enum Key: String {
    case coordinate
}

final class UserDefaultsHelper {
    static let standard = UserDefaultsHelper()
    private init() {}
    
    let userDefaults = UserDefaults.standard
    
    var coordinate: [String: Any]? {
        get {
            return userDefaults.dictionary(forKey: Key.coordinate.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.coordinate.rawValue)
        }
    }
}

