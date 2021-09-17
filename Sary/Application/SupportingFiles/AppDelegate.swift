//
//  AppDelegate.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeView()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func setTabBarUI(_ tabBar: UITabBarItem?, title: String?, image: UIImage?, selectedImage: UIImage?,isSetting:Bool = false) -> Void {
            tabBar?.image = image
            tabBar?.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
            tabBar?.title = title
            tabBar?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.bold(10),NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            tabBar?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.bold(12), NSAttributedString.Key.foregroundColor: UIColor.primary], for: .selected)
    }
}

