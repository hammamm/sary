//
//  BaseView.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import UIKit
import SwiftMessages
import RxSwift
import RxCocoa

// MARK:- BASEVIEW
class BaseView: UIViewController {
    func alertView(_ type: AlertType,title: String?, body: String?, completion: (() -> Void)?) -> Void{
        alert(type, title: title, body: body)
    }
    
    let interactor = Interactor()
    
    var error: String? {
        didSet{
            alert(.error, title: nil, body: error)
            logError(error)
        }
    }
        
    func makeViewsClickable(_ views: UIView..., sender: UIViewController) -> Void {
        views.forEach { (view) in
            let viewTapped = UITapGestureRecognizer(target: sender, action: #selector(didTap(OnView:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(viewTapped)
        }
    }
    
    @objc func didTap(OnView sender: UITapGestureRecognizer) -> Void {
    }
    
    var headerTitle: String? {
        didSet{
            navigationItem.title = headerTitle
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        baseSetupForUI()
    }
        
    func baseSetupForUI() {
        tabBarController?.tabBar.tintColor = .primary
        navigationController?.navigationBar.barTintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primary,
                              NSAttributedString.Key.font: UIFont.bold(17)
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .primary
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func hideNavigationBarLine(_ hide: Bool = false) -> Void {
        let image: UIImage? = hide ? UIImage() : nil
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        navigationController?.navigationBar.layoutIfNeeded()
    }
        
    //    func setupNavigationColor() -> Void {
    //        if let navigationBar = self.navigationController?.navigationBar {
    //            let gradient = CAGradientLayer()
    //            var bounds = navigationBar.bounds
    //            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
    //            gradient.frame = bounds
    //            gradient.colors = [UIColor.primaryPink.cgColor, UIColor.primary.cgColor]
    //            gradient.startPoint = CGPoint(x: 0, y: 0)
    //            gradient.endPoint = CGPoint(x: 1, y: 0)
    //
    //            if let image = getImageFrom(gradientLayer: gradient) {
    //                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
    //            }
    //        }
    //    }
            
    deinit {
        logger((self.nibName?.description ?? "") + "  Was removed successfully from memory")
    }
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func setClearNavigaation() -> Void {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont.bold(20)]
    }
}

// MARK:- BASEVIEW: UIViewControllerTransitioningDelegate
extension BaseView: UIViewControllerTransitioningDelegate {
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
// MARK:- BASEVIEW: BaseViewProtocol
extension BaseView: BaseViewProtocol{
    func view() -> BaseView {
        self
    }
}

// MARK:- loadingView
/// UIView used as loader
///
/// - Author: Hammam Abdulaziz
var loadingView: Loader = {
    let frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    let view = Loader(frame: frame)
    //        view.tag = loadingTag
    return view
}()

// MARK:- ALERT
/// Enum for alert type
///
/// - success: success alert
/// - failure: failure alert
/// - normal: normal alert
///
/// - Author: Hammam Abdulaziz
enum AlertType {
    case success
    case error
    case warning(icon: WarningIcons)
    case info
    case validation(style: UIAlertController.Style = .alert,_ actions: [UIAlertAction], tintColor: UIColor?)
    
    var theme: Theme{
        switch self {
            case .success: return .success
            case .error: return .error
            case .info: return .info
            case .warning: return .warning
            case .validation: return .warning
        }
    }
    
    var icon: WarningIcons?{
        switch self {
            case .success, .error, .info, .validation: return nil
            case .warning(let icon): return icon
        }
    }
    
    var title: String{
        switch self {
            case .success: return "Success".localized
            case .warning: return "Warning".localized
            case .info: return "Info".localized
            case .error: return "Error".localized
            case .validation: return "Validation".localized
        }
    }
    
    var body: String{
        switch self {
            case .success: return ""
            case .info, .warning, .validation, .error: return "Something went wrong".localized
        }
    }
}

// MARK:- WarningIcons
enum WarningIcons: String {
    case think = "🤔"
    case noAction = "😶"
    case surprised = "😳"
    case looking = "🙄"
    case relax = "☺️"
    case sorry = "😔"
    case money = "🤑"
}
