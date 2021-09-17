//
//  UiTextField.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

extension UITextField{
    func addSpace(_ amount: CGFloat) -> Void {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        paddingView.backgroundColor = .clear
        self.rightView = paddingView
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.contentVerticalAlignment = .center
    }
    
    /// To show validation message under the text field
    /// - Parameter type: error to show the message and success to hide it
    func validation(_ type: ValidationText) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 20))
        label.setup(textColor: .red, font: .light(15))
        label.textAlignment = .natural
        label.tag = 150
        switch type {
            case .error(let validationText):
                if let label = viewWithTag(150) as? UILabel{
                    label.text = "* " + validationText
                }else{
                    label.text = "* " + validationText
                    self.addSubview(label)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    let top = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 6)
                    let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
                    let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
                    self.addConstraints([top, leading, trailing])
                }
            case .success:
                self.viewWithTag(150)?.removeFromSuperview()
        }
    }
}

enum ValidationText {
    case error(String)
    case success
}
