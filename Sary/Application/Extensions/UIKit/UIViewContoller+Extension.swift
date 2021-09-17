//
//  UIViewController+Extension.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit
import SwiftMessages

extension UIViewController{
    private func showNoInternetView() {
//        let controller = NoNetworkView()
//        controller.modalPresentationStyle = .overFullScreen
//        controller.modalTransitionStyle = .coverVertical
//        present(controller, animated: true)
    }

    func networkError(networkError: NSError?) -> Bool {
        if networkError?.code == -1009 || networkError?.code == 13{
            showNoInternetView()
            return true
        }else{
            alert(.error, title: nil, body: networkError?.localizedDescription)
            logError(networkError)
            return false
        }
    }

    func didFailWithError(_ error: String) {
        alert(.error, title: nil, body: error)
        logError(error)
    }
    
    func didFailWithNetworkError(_ error: NSError) -> Bool {
        networkError(networkError: error)
    }
    
    func didFailWithError(_ error: NSError) {
        alert(.error, title: nil, body: error.localizedDescription)
        logError(error)
    }

    func alert(_ type: AlertType,
               title: String?,
               body: String?,
               completion: (() -> Void)? = nil) {
        switch type {
        case .validation(let style, let actions, let tint):
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
            if let title = title{
                let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
                alert.setValue(titleAttrString, forKey: "attributedTitle")
            }
            if let message = body{
                let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
                alert.setValue(messageAttrString, forKey: "attributedMessage")
            }
            
            actions.forEach { (action) in
                alert.addAction(action)
            }
            // Accessing buttons tintcolor :
            alert.view.tintColor = tint
            // presinting the alert controller ...
            present(alert, animated: true, completion: nil)
        case .error, .info, .success, .warning:
            // Accessing alert view backgroundColor :
            DispatchQueue.main.async {
                let view = MessageView.viewFromNib(layout: .cardView)
                view.configureTheme(type.theme)
                var config = SwiftMessages.Config()
                view.button?.isHidden = true
                if let completion = completion{
                    config.eventListeners.append() { event in
                        if case .didHide = event {
                            completion()
                        }
                    }
                }
                if let icon = type.icon?.rawValue{
                    view.configureContent(title: title ?? type.title, body: body ?? type.body, iconText: icon)
                }else{
                    view.configureContent(title: title ?? type.title, body: body ?? type.body)
                }
                view.titleLabel?.font = .bold(12)
                view.bodyLabel?.font = .regular(12)
                SwiftMessages.show(config: config, view: view)
            }
        }
    }

    func loading(_ start: Bool) {
        if start{
            view.addSubview(loadingView)
            loadingView.layer.zPosition = 1
            loadingView.anchorToEdges(view: view)
            loadingView.start()
        }else{
            loadingView.stop()
        }
    }
}
