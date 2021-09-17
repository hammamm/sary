//
//  Authenticator.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

class Authenticator: NSObject {
    
    static var shared = Authenticator()
    private override init() {}
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.UserDefaults.token)
        }
        set {
            if let newValue = newValue{
                UserDefaults.standard.set(newValue, forKey: Keys.UserDefaults.token)
            }else{
                UserDefaults.standard.removeObject(forKey: Keys.UserDefaults.token)
            }
        }
    }
    var currentLanguage: String? {
        get {
            UserDefaults.standard.array(forKey: Keys.UserDefaults.currentLanguage)?.first as? String
        }
        set {
            if let newValue = newValue{
                UserDefaults.standard.set([newValue], forKey: Keys.UserDefaults.currentLanguage)
            }else{
                UserDefaults.standard.removeObject(forKey: Keys.UserDefaults.currentLanguage)
            }
        }
    }
}
