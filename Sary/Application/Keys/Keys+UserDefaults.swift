//
//  Keys+UserDefaults.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

/*--------------------------------------------------------------------------------*/
/// Add every UserDefaults key here to organize our work and to avoid duplications.
/*--------------------------------------------------------------------------------*/

import Foundation

extension Keys {
    
    /// NameSpacing the constants we use in the defaults system.
    struct UserDefaults {
        static let token = "token"
        static let currentLanguage = "AppleLanguages"
    }
}
