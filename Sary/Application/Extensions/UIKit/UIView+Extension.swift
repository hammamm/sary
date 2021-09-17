//
//  UIView+Extension.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

extension UIView{
    func setRounded() {
        layer.cornerRadius = (frame.width / 2)
        layer.masksToBounds = true
    }
    
    func set(borderColor: UIColor, width: CGFloat = 1) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = width
    }
    
    func setBottomLineBorder(_ lineColor: UIColor, height: CGFloat = 1) {
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowColor = lineColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: height)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
    
    func setupShadow(color: UIColor = .black, opacity: Float = 0.3, offset: CGSize = .zero, radius: CGFloat = 2) -> Void {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
    func setup(textColor: UIColor, backgroundColor: UIColor = .clear,font: UIFont, cornerRadius: CGFloat = 0, borderColor: UIColor? = nil, borderWidth: CGFloat = 0, placeholder: (text:String, color:UIColor)? = nil, spaceValue: CGFloat? = nil, adjustSize: Bool = true) -> Void {
        // for all views
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        
        // if the view is uiButton
        if let button = self as? UIButton{
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = font
        }
        
        // if the view is uiLabel
        if let label = self as? UILabel{
            label.textColor = textColor
            label.font = font
            if adjustSize{
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.8
            }
        }
        
        // if the view is uiTextFiled
        if let textField = self as? UITextField{
            textField.textColor = textColor
            textField.font = font
            if let placeholder = placeholder{
                textField.attributedPlaceholder = NSAttributedString(string: placeholder.text, attributes: [
                    NSAttributedString.Key.foregroundColor: placeholder.color,
                    NSAttributedString.Key.font: font
                ])
            }
            if let amount = spaceValue{
                textField.addSpace(amount)
            }
        }
    }
    
    func setGradientColors(_ type: GradientType) -> Void {
        let layer = CAGradientLayer()
        layer.colors = type.colors
        layer.locations = [0.0,1]
        layer.startPoint = type.startPoint
        layer.endPoint = type.endPoint
        layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        layer.insertSublayer(layer, at: 0)
    }
    
    /// A layout anchor representing all the edges of the view’s frame.
    ///
    /// - Parameters:
    ///   - top: top anchor of the view
    ///   - left: left anchor of the view
    ///   - bottom: bottom anchor of the view
    ///   - right: right anchor of the view
    ///   - topConstant: constant of the top anchor
    ///   - leftConstant: constant of the left anchor
    ///   - bottomConstant: constant of the bottom anchor
    ///   - rightConstant: constant of the right anchor
    ///
    /// - Author: Hammam Abdulaziz
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                topConstant: CGFloat = 0,
                leftConstant: CGFloat = 0,
                bottomConstant: CGFloat = 0,
                rightConstant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leftConstant).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
        
        if let trailing = trailing{
            trailing.constraint(equalTo: trailing, constant: -rightConstant).isActive = true
        }
    }
    
    func rotateEnglish() {
        if "lang".localized == "en"{
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
    
    func rotateArabic() {
        if "lang".localized == "ar"{
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
    
    func anchorToEdges(view: UIView, padding: CGFloat = 0) {
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
               topConstant: padding, leftConstant: padding, bottomConstant: padding, rightConstant: padding)
    }
        
    
    // ---------------------------- UIViewAnimation -------------------------------- //
    
    /// Multible of cases to animate any UIView
    ///
    /// - Author: Hammam Abdulaziz.
    enum UIViewAnimation {
        /// Will change the color and animate if the duration > 0
        case changeColor(to: UIColor, duration: TimeInterval)
        /// Will hide the view and reduce the alpha value to 0 with animation if the duration > 0
        case hideView(duruation: TimeInterval)
        /// Will show the view and increase the alpha value to 1 with animation if the duration > 0
        case showView(duruation: TimeInterval)
    }
    
    /// Implimntation for all cases in `UIViewAnimation`
    ///
    /// - Parameter animation: UIViewAnimation
    ///
    /// - Author: Hammam Abdulaziz.
    func animate(_ animation: UIViewAnimation) {
        switch animation {
            case .changeColor(let newColor, let duration):
                UIView.animate(withDuration: duration) {
                    self.backgroundColor = newColor
                }
            case .hideView(let duruation):
                UIView.animate(withDuration: duruation) {
                    self.alpha = 0
                    self.isHidden = true
                }
            case .showView(let duruation):
                UIView.animate(withDuration: duruation) {
                    self.isHidden = false
                    self.alpha = 1
                }
        }
    }
}

enum GradientType {
    case vertical(top: UIColor, bottom: UIColor)
    case horizontal(left: UIColor, right: UIColor)
    
    var colors: [CGColor]{
        switch self {
            case .vertical(let top, let bottom):
                return [top.cgColor, bottom.cgColor]
            case .horizontal(let left , let right):
                return [left.cgColor, right.cgColor]
        }
    }
    
    var startPoint: CGPoint{
        switch self {
            case .vertical:
                return CGPoint(x: 1, y: 0)
            case .horizontal:
                return CGPoint(x: 0, y: 1)
        }
    }
    
    var endPoint: CGPoint{
        switch self {
            case .vertical:
                return CGPoint(x: 1, y: 1)
            case .horizontal:
                return CGPoint(x: 1, y: 1)
        }
    }
}
