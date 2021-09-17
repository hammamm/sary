//
//  UIAlertAction+Extension.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import UIKit

extension UIAlertAction{
    static func actionWithImage(title: String?, style: UIAlertAction.Style, image: UIImage, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction{
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.setValue(image, forKey: "image")
        return action
    }
}
