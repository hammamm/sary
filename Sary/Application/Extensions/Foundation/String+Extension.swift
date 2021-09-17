//
//  String+Extension.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation
import  UIKit
extension String {
    
    /// Shortcut for localizing any string like: NSLocalizedString(self, comment: "")
    ///
    /// - Author: Hammam Abdulaziz
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
        
    /// localization for plurals
    /// for more details https://medium.com/@vitaliikuznetsov/plurals-localization-using-stringsdict-in-ios-a910aab8c28c
    /// - Parameter pluralCount: count of items
    /// - Returns: get the localization of plurals of that item after setting the role of languages in stringsdict file
    func localized(_ pluralCount: Int) -> String {
        let formatString : String = NSLocalizedString(self, comment: "this string format to be found in Localized.stringsdict")
        let resultString : String = String.localizedStringWithFormat(formatString, pluralCount)
        return resultString;
    }
    
    /// localization for static number inside the string, use `%lld`or `%ld` for `Int64` 64-bit integer, and `%d` for`int`, which is equivalent to `Int32`  32-bit
    /// for more details https://developer.apple.com/forums/thread/117967
    /// - Parameter staticCount: static count
    /// - Returns: localizable string with static count inside it
    func localized(with staticCount: Int) -> String {
        String.init(format: self, staticCount)
    }
    
    /// localization for static string inside the string use `%u` in original string to replace it with the static string
    /// - Parameter staticString: static string that you want to keep it inside the string
    /// - Returns: localizable string have a static string inside it
    func localized(with staticString: String) -> String {
        String.init(format: self, staticString)
    }
    
    var toDouble: Double?{
        Double(self)
    }
    
    /// Supporting PrintHelper file
    ///
    /// - Author: Hammam Abdulaziz
    var logFilePath: String {
        let pathComponents = self.components(separatedBy: "/")
        let index = pathComponents.lastIndex(of: "SetupProject")
        return pathComponents.suffix(pathComponents.count - (index ?? 0)).joined(separator: " > ")
    }
    
    var isValidEmail: Bool{
        NSPredicate(format: "SELF MATCHES %@",  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
        //        "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    }
    
    var isValidUsername: Bool{
        NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z0-9.-]{3,20}").evaluate(with: self)
    }
    
    mutating func isValidMobile() -> Bool {
        //validate saudi number: 5XXXXXXXX
        if count == 9{
            return NSPredicate(format: "SELF MATCHES %@", "50[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "51[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "53[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "54[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "55[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "56[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "57[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "58[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "59[0-9]{7}").evaluate(with: self)
        } else if count == 10{
            let valid = NSPredicate(format: "SELF MATCHES %@", "050[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "051[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "053[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "054[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "055[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "056[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "057[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "058[0-9]{7}").evaluate(with: self) ||
                NSPredicate(format: "SELF MATCHES %@", "059[0-9]{7}").evaluate(with: self)
            if valid{
                removeFirst()
            }
            return valid
        }else{
        }
        return false
    }
    
    var isValidPassword: Bool{
        NSPredicate(format: "SELF MATCHES %@", "^.{6,15}$").evaluate(with: self)
    }
    
    var isValidId: Bool{
        NSPredicate(format: "SELF MATCHES %@", "^[0-9]{10}$").evaluate(with: self)
    }
    
    var enterValidationError: String{
        "Please enter".localized + " " + self.localized
    }
    
    var chooseValidationError: String{
        "Please choose".localized + " " + self.localized
    }
}
