//
//  Navigatore.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

//typealias PanView = UIViewController & PanModalPresentable

enum NavigatoreView {
    case register
    
//    var panView: (UIViewController & PanModalPresentable)?{
//        switch self {
//            case .register: return RegisterView()
//        }
//    }
//
    var view: UIViewController{
        switch self {
            case .register: return RegisterView()
        }
    }
}

enum NavigatoreType {
    case push(animated: Bool)
    case present(animated: Bool, presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle)
    case window
    case pan
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
                    appDelegate.setTheAppRoot()
                }
            case .pan:
                if let view = controller.panView{
                    self.presentPanModal(view)
                }else{
                    present(controller.view, animated: true, completion: nil)
                }
        }
    }
}
