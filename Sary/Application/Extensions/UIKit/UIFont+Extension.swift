//
//  UIFont+Extension.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

extension UIFont{
    static func light(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size)
    }
    
    static func regular(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        UIFont.boldSystemFont(ofSize: size)
    }
}
