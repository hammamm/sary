//
//  Globals.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

var IS_ENGLISH: Bool{
    (Authenticator.shared.currentLanguage?.contains("en") ?? false)
}

var LANGUAGE_SIDE: AppSide{
    IS_ENGLISH ? .LTR : .RTL
}

var IS_LTR : Bool{
    LANGUAGE_SIDE == .LTR
}

typealias Completion = (() -> Void)

func setupViews(views: UIView...,textColor: UIColor, backgroundColor: UIColor = .clear,font: UIFont, cornerRadius: CGFloat = 0, borderColor: UIColor? = nil, borderWidth: CGFloat = 0, placeholder: (text:String, color:UIColor)? = nil, spaceValue: CGFloat? = nil, adjustSize: Bool = true) -> Void {
    views.forEach { (view) in
        view.setup(textColor: textColor, backgroundColor: backgroundColor, font: font, cornerRadius: cornerRadius, borderColor: borderColor, borderWidth: borderWidth, placeholder: placeholder, spaceValue: spaceValue, adjustSize: adjustSize)
    }
}

func setupCorner (views:UIView...,cornerRides:CGFloat = 10) {
    views.forEach { view in
        view.layer.cornerRadius = cornerRides
    }
}

/// cases  of the language side of the app is it LTR or RTL
enum AppSide {
    case LTR
    case RTL
}

enum Lang: String {
    case ar
    case en
}
