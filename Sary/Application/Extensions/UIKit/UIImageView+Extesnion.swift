//
//  UIImageView+Extesnion.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

extension UIImageView {
    func load(with imageUrl: String?, tintColor: UIColor? = nil, activityStyle: UIActivityIndicatorView.Style = .medium, defaultImage: UIImage? = nil) {
        let activityIndicator = UIActivityIndicatorView(style: activityStyle)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }

        guard let urlString = imageUrl, let url = URL(string: urlString) else {
            image = defaultImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                logger(error)
                self.image = defaultImage
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                if let tintColor = tintColor{
                    self.setTint(tintColor)
                }
                self.image = image
            })

        }).resume()
    }
    
    func setTint(_ color: UIColor) -> Void {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
