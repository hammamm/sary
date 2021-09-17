//
//  Navigatore.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

enum NavigatoreView {
    case register
    
    var view: UIViewController{
        switch self {
            case .register: return UIViewController()
        }
    }
}

enum NavigatoreType {
    case push(animated: Bool)
    case present(animated: Bool, presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle)
    case window
}

extension UIViewController{
    func navigate(to controller: NavigatoreView, type: NavigatoreType) -> Void {
        switch type {
            case .push(let animated):
                navigationController?.pushViewController(controller.view, animated: true) ?? present(controller.view, animated: animated, completion: nil)
            case .present(let animated, let presentaionStyle, let transitionStyle):
                let view = controller.view
                view.modalPresentationStyle = presentaionStyle
                view.modalTransitionStyle = transitionStyle
                present(view, animated: animated, completion: nil)
            case .window:
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
//                    appDelegate.setTheAppRoot()
                }
        }
    }
}
