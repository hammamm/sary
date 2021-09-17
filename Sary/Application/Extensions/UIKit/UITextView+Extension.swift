//
//  UITextView+Extension.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

extension UITextView{
    func resize() {
        var newFrame = self.frame
        let width = newFrame.size.width
        let newSize = self.sizeThatFits(CGSize(width: width,
                                                   height: CGFloat.greatestFiniteMagnitude))
        newFrame.size = CGSize(width: width, height: newSize.height)
        self.frame = newFrame
    }
    
    func addSpace(_ amount: CGFloat) -> Void {
        self.textContainerInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
    }
}
